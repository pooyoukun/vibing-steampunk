package main

import (
	"testing"
)

// TestExtractCodeLiterals_KnownCallFullKey covers the canonical v2a-min
// case: a CALL FUNCTION to a registered customizing FM with every
// business-key parameter supplied as a string literal.
func TestExtractCodeLiterals_KnownCallFullKey(t *testing.T) {
	// Synthetic ABAP fixture modelled on the R15 post-import miss: code
	// asks APPL_LOG_INIT for (OBJECT='ZTEST_LOG', SUBOBJECT='EVENT'). All
	// identifiers are test-only — no customer names anywhere.
	source := `
REPORT ztest_value_extractor.
DATA lv_handle TYPE balloghndl.
CALL FUNCTION 'APPL_LOG_INIT'
  EXPORTING
    object     = 'ZTEST_LOG'
    sub_object = 'EVENT'
  IMPORTING
    log_handle = lv_handle.
`
	got := extractCodeLiterals("PROG:ZTEST_VALUE_EXTRACTOR", source)
	if len(got) != 1 {
		t.Fatalf("expected 1 call site, got %d: %+v", len(got), got)
	}
	c := got[0]
	if c.Target != "BALSUB" {
		t.Errorf("Target = %q, want BALSUB", c.Target)
	}
	if c.Fields["OBJECT"] != "ZTEST_LOG" {
		t.Errorf("Fields[OBJECT] = %q, want ZTEST_LOG", c.Fields["OBJECT"])
	}
	if c.Fields["SUBOBJECT"] != "EVENT" {
		t.Errorf("Fields[SUBOBJECT] = %q, want EVENT", c.Fields["SUBOBJECT"])
	}
	if c.IncompleteKey {
		t.Error("IncompleteKey = true, want false for full-key call")
	}
	if c.Kind != "known_call" {
		t.Errorf("Kind = %q, want known_call", c.Kind)
	}
	if c.Via != "CALL_FUNCTION:APPL_LOG_INIT" {
		t.Errorf("Via = %q, want CALL_FUNCTION:APPL_LOG_INIT", c.Via)
	}
}

// TestExtractCodeLiterals_PartialKey covers the case where the code
// supplies only a subset of the registered business key fields. The
// extractor must still produce a finding but flag IncompleteKey=true so
// the matcher and the report can treat it as "less confident".
func TestExtractCodeLiterals_PartialKey(t *testing.T) {
	source := `
CALL FUNCTION 'APPL_LOG_INIT'
  EXPORTING
    object = 'ZTEST_LOG'.
`
	got := extractCodeLiterals("PROG:ZTEST", source)
	if len(got) != 1 {
		t.Fatalf("expected 1 call site, got %d", len(got))
	}
	if !got[0].IncompleteKey {
		t.Error("IncompleteKey = false, want true (missing sub_object)")
	}
	if got[0].Fields["OBJECT"] != "ZTEST_LOG" {
		t.Errorf("OBJECT = %q, want ZTEST_LOG", got[0].Fields["OBJECT"])
	}
}

// TestExtractCodeLiterals_DynamicFMSkipped covers the "runtime-computed
// FM name" shape. We intentionally drop these — no literal, no lookup.
func TestExtractCodeLiterals_DynamicFMSkipped(t *testing.T) {
	source := `
DATA lv_fm TYPE string VALUE 'APPL_LOG_INIT'.
CALL FUNCTION lv_fm
  EXPORTING
    object = 'ZTEST'
    sub_object = 'EVENT'.
`
	got := extractCodeLiterals("PROG:ZTEST", source)
	if len(got) != 0 {
		t.Errorf("expected 0 findings for dynamic FM, got %d: %+v", len(got), got)
	}
}

// TestExtractCodeLiterals_UnregisteredFMIgnored makes sure the extractor
// stays silent on CALL FUNCTION to an FM we do not track.
func TestExtractCodeLiterals_UnregisteredFMIgnored(t *testing.T) {
	source := `
CALL FUNCTION 'ZZZ_NOT_IN_REGISTRY'
  EXPORTING
    object = 'ZTEST_LOG'
    sub_object = 'EVENT'.
`
	got := extractCodeLiterals("PROG:ZTEST", source)
	if len(got) != 0 {
		t.Errorf("expected 0 findings for unregistered FM, got %d", len(got))
	}
}

// TestExtractCodeLiterals_NonLiteralArgSkipped covers the case where
// the value side of EXPORTING is a variable, not a literal. The
// extractor must skip that parameter but still record the literal ones.
func TestExtractCodeLiterals_NonLiteralArgSkipped(t *testing.T) {
	source := `
DATA lv_obj TYPE string VALUE 'ZTEST'.
CALL FUNCTION 'APPL_LOG_INIT'
  EXPORTING
    object = lv_obj
    sub_object = 'EVENT'.
`
	got := extractCodeLiterals("PROG:ZTEST", source)
	if len(got) != 1 {
		t.Fatalf("expected 1 call site, got %d", len(got))
	}
	c := got[0]
	if _, ok := c.Fields["OBJECT"]; ok {
		t.Error("OBJECT should not be set — argument was a variable")
	}
	if c.Fields["SUBOBJECT"] != "EVENT" {
		t.Errorf("SUBOBJECT = %q, want EVENT", c.Fields["SUBOBJECT"])
	}
	if !c.IncompleteKey {
		t.Error("IncompleteKey = false, want true (OBJECT was not a literal)")
	}
}

// TestUnpackTabkey_BALSUBShape unpacks a synthetic TABKEY with the
// (OBJECT, SUBOBJECT) key layout used by BALSUB: client(3) + object(20)
// + subobject(20). Matches how SAP pads CHAR fields with trailing spaces.
// Built programmatically so space-counting mistakes cannot creep in.
func TestUnpackTabkey_BALSUBShape(t *testing.T) {
	fields := []ddKeyField{
		{Name: "OBJECT", Length: 20},
		{Name: "SUBOBJECT", Length: 20},
	}
	tabkey := "122" + padRight("ZTEST_LOG", 20) + padRight("EVENT", 20)
	got := unpackTabkey(tabkey, fields)
	if got["OBJECT"] != "ZTEST_LOG" {
		t.Errorf("OBJECT = %q, want ZTEST_LOG", got["OBJECT"])
	}
	if got["SUBOBJECT"] != "EVENT" {
		t.Errorf("SUBOBJECT = %q, want EVENT", got["SUBOBJECT"])
	}
}

// padRight is a tiny test helper that right-pads `s` with spaces to
// exactly `width` bytes — matches SAP CHAR column storage layout.
func padRight(s string, width int) string {
	for len(s) < width {
		s += " "
	}
	return s
}

// TestSubsetMatch covers the three cases v2a-min relies on.
func TestSubsetMatch(t *testing.T) {
	have := map[string]string{"OBJECT": "ZTEST_LOG", "SUBOBJECT": "EVENT"}
	// Full key match.
	if !subsetMatch(map[string]string{"OBJECT": "ZTEST_LOG", "SUBOBJECT": "EVENT"}, have) {
		t.Error("full-key subset should match")
	}
	// Partial key match (subset).
	if !subsetMatch(map[string]string{"OBJECT": "ZTEST_LOG"}, have) {
		t.Error("partial-key subset should match")
	}
	// Mismatch on one field.
	if subsetMatch(map[string]string{"OBJECT": "ZTEST_LOG", "SUBOBJECT": "SYNC"}, have) {
		t.Error("mismatch on SUBOBJECT should not match")
	}
	// Empty `want` never matches — guards against zero-finding slip-through.
	if subsetMatch(map[string]string{}, have) {
		t.Error("empty want should not match")
	}
}

// TestTR-EXAMPLEFixture is the end-to-end fixture proving v2a-min catches
// the production-incident class. We stage:
//
//   - one caller source doing APPL_LOG_INIT with (ZTEST, EVENT)
//   - a synthetic transported-row table containing only (ZTEST, META)
//
// and assert the matcher lands ValueMissing for the (ZTEST, EVENT) call.
func TestTR-EXAMPLEFixture(t *testing.T) {
	source := `
CALL FUNCTION 'APPL_LOG_INIT'
  EXPORTING
    object     = 'ZTEST'
    sub_object = 'EVENT'.
CALL FUNCTION 'APPL_LOG_INIT'
  EXPORTING
    object     = 'ZTEST'
    sub_object = 'META'.
`
	literals := extractCodeLiterals("PROG:ZTEST", source)
	if len(literals) != 2 {
		t.Fatalf("expected 2 literal call sites, got %d", len(literals))
	}

	// Pretend only one transported row exists: (ZTEST, META).
	fields := []ddKeyField{
		{Name: "OBJECT", Length: 20},
		{Name: "SUBOBJECT", Length: 20},
	}
	transported := []map[string]string{
		unpackTabkey("122"+padRight("ZTEST", 20)+padRight("META", 20), fields),
	}

	missing, covered := 0, 0
	for _, c := range literals {
		matched := false
		for _, row := range transported {
			if subsetMatch(c.Fields, row) {
				matched = true
				break
			}
		}
		if matched {
			covered++
		} else {
			missing++
		}
	}
	if missing != 1 {
		t.Errorf("missing = %d, want 1 — (ZTEST, EVENT) should be the missing call", missing)
	}
	if covered != 1 {
		t.Errorf("covered = %d, want 1 — (ZTEST, META) should match the transported row", covered)
	}
}
