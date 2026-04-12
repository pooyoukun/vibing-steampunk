package main

import (
	"strings"

	"github.com/oisee/vibing-steampunk/pkg/abaplint"
)

// CodeLiteralCall captures one point in the source where the code supplies
// literal values that, taken together, identify a single customizing row.
// A CALL FUNCTION 'APPL_LOG_INIT' EXPORTING object = 'ZDEMO_117' sub_object =
// 'EVENT' yields one CodeLiteralCall whose Fields map is
// {OBJECT:'ZDEMO_117', SUBOBJECT:'EVENT'}. The value-level audit then checks
// whether that exact tuple is present among the transported rows of the
// Target table.
//
// v2a-min scope (see reports/plan + feedback from second reviewer):
// only CALL FUNCTION to a registered customizing FM is recognised here.
// SELECT/UPDATE/MODIFY/DELETE and interprocedural dataflow are deliberately
// out of scope for this first pass — they add noise faster than signal
// before the CALL-FUNCTION path proves the value-level approach in
// production. Simple SELECT-on-key-fields can come in v2a.1.
type CodeLiteralCall struct {
	SourceObject   string            `json:"source_object"` // e.g. "CLAS:ZCL_FOO"
	Target         string            `json:"target"`        // table name
	Fields         map[string]string `json:"fields"`        // key field → literal (both upper-cased)
	Row            int               `json:"row"`
	Via            string            `json:"via"`             // "CALL_FUNCTION:APPL_LOG_INIT"
	Kind           string            `json:"kind"`            // "known_call" for v2a-min; "direct_select" later
	IncompleteKey  bool              `json:"incomplete_key"`  // true if code supplied fewer fields than keyFields
}

// extractCodeLiterals runs the ABAP parser on the given source and returns
// every CodeLiteralCall it can extract. For v2a-min only one statement
// shape is handled:
//
//	CALL FUNCTION '<name>' EXPORTING p1 = 'LIT' p2 = 'LIT' ...
//
// where <name> is a registered customizing FM. Dynamic FM calls
// (CALL FUNCTION lv_name) are silently skipped — we only want concrete
// literal keys, not runtime-computed ones. No regex: everything routes
// through pkg/abaplint's tokeniser and statement parser.
//
// The function is pure: it takes source plus the source object id, returns
// findings, and never talks to SAP. That keeps it unit-testable with inline
// ABAP fixtures.
func extractCodeLiterals(sourceObjectID, source string) []CodeLiteralCall {
	if strings.TrimSpace(source) == "" {
		return nil
	}
	file := abaplint.NewABAPFile(sourceObjectID, source)
	var out []CodeLiteralCall
	for _, stmt := range file.GetStatements() {
		if len(stmt.Tokens) == 0 {
			continue
		}
		if !strings.EqualFold(stmt.Tokens[0].Str, "CALL") {
			continue
		}
		if c := extractFromCallFunction(stmt, sourceObjectID); c != nil {
			out = append(out, *c)
		}
	}
	return out
}

// extractFromCallFunction inspects a CALL FUNCTION statement. Returns nil
// for anything that does not match a known customizing FM, for dynamic
// (variable-named) FM calls, and for calls that supplied zero recognised
// literal EXPORTING parameters.
//
// Partial keys (code supplied some but not all keyFields from the registry)
// still produce a CodeLiteralCall with IncompleteKey=true — the match logic
// downstream uses subset semantics, and the flag lets the report call out
// that the finding is based on less than the full business key.
func extractFromCallFunction(stmt abaplint.Statement, sourceObjectID string) *CodeLiteralCall {
	if len(stmt.Tokens) < 4 {
		return nil
	}
	if !strings.EqualFold(stmt.Tokens[1].Str, "FUNCTION") {
		return nil
	}
	nameTok := stmt.Tokens[2]
	if nameTok.Type != abaplint.TokenString {
		return nil // dynamic — no concrete FM name
	}
	fmName := strings.ToUpper(unquoteLiteral(nameTok.Str))
	kc, ok := knownCustCalls[fmName]
	if !ok {
		return nil
	}

	exportingIdx := -1
	for i, tok := range stmt.Tokens {
		if strings.EqualFold(tok.Str, "EXPORTING") {
			exportingIdx = i
			break
		}
	}
	if exportingIdx < 0 || exportingIdx+2 >= len(stmt.Tokens) {
		return nil
	}

	sectionEnd := map[string]bool{
		"IMPORTING":  true,
		"TABLES":     true,
		"CHANGING":   true,
		"EXCEPTIONS": true,
		"RECEIVING":  true,
	}

	fields := map[string]string{}
	i := exportingIdx + 1
	for i+2 < len(stmt.Tokens) {
		paramUp := strings.ToUpper(stmt.Tokens[i].Str)
		if sectionEnd[paramUp] || paramUp == "." {
			break
		}
		if stmt.Tokens[i+1].Str != "=" {
			i++
			continue
		}
		valTok := stmt.Tokens[i+2]
		if valTok.Type != abaplint.TokenString {
			// Non-literal value: skip this parameter but keep scanning.
			// The partial result still counts; IncompleteKey below marks
			// it if the end result is narrower than the registered key.
			i += 3
			continue
		}
		paramLower := strings.ToLower(stmt.Tokens[i].Str)
		literal := strings.ToUpper(unquoteLiteral(valTok.Str))
		if tableField, mapped := kc.argMap[paramLower]; mapped && literal != "" {
			fields[tableField] = literal
		}
		i += 3
	}

	if len(fields) == 0 {
		return nil
	}

	// IncompleteKey: the registry declares which business-key fields matter
	// for the lookup. If the code filled fewer of them than declared, the
	// downstream match runs in subset mode and the finding is flagged so
	// the report can explain why one code call produced several candidate
	// transport rows.
	incomplete := false
	if len(kc.keyFields) > 0 {
		for _, kf := range kc.keyFields {
			if _, ok := fields[kf]; !ok {
				incomplete = true
				break
			}
		}
	}

	return &CodeLiteralCall{
		SourceObject:  sourceObjectID,
		Target:        kc.table,
		Fields:        fields,
		Row:           nameTok.Row,
		Via:           "CALL_FUNCTION:" + fmName,
		Kind:          "known_call",
		IncompleteKey: incomplete,
	}
}

// unquoteLiteral strips the surrounding single quotes from an ABAP string
// literal token. The lexer preserves them verbatim in Token.Str for
// TokenString entries.
func unquoteLiteral(s string) string {
	if len(s) >= 2 && s[0] == '\'' && s[len(s)-1] == '\'' {
		return s[1 : len(s)-1]
	}
	return s
}
