package abaplint

import (
	"os"
	"path/filepath"
	"testing"
)

func TestLinter_Basic(t *testing.T) {
	l := NewLinter()
	issues := l.Run("test.abap", `REPORT ztest.
DATA lv_x TYPE i.
lv_x = 42.
.
COMPUTE lv_x = lv_x + 1.
IF lv_x EQ 10.
ENDIF.`)

	for _, iss := range issues {
		t.Logf("  [%s] r%d:c%d %s (%s)", iss.Key, iss.Row, iss.Col, iss.Message, iss.Severity)
	}

	// Should find: empty_statement (the lone .), obsolete_statement (COMPUTE), preferred_compare_operator (EQ)
	found := map[string]bool{}
	for _, iss := range issues {
		found[iss.Key] = true
	}
	for _, key := range []string{"empty_statement", "obsolete_statement", "preferred_compare_operator"} {
		if !found[key] {
			t.Errorf("expected issue from rule %q", key)
		}
	}
}

func TestLinter_LineLength(t *testing.T) {
	l := &Linter{Rules: []Rule{&LineLengthRule{MaxLength: 20}}}
	issues := l.Run("test.abap", "DATA lv_very_long_variable_name TYPE string.")

	if len(issues) == 0 {
		t.Fatal("expected line_length issue")
	}
	if issues[0].Key != "line_length" {
		t.Errorf("expected line_length, got %s", issues[0].Key)
	}
}

func TestLinter_NamingConventions(t *testing.T) {
	l := &Linter{Rules: []Rule{&LocalVariableNamesRule{ExpectedData: `^[Ll][Vv]_\w+$`}}}
	source := `METHOD do_something.
  DATA lv_good TYPE i.
  DATA bad_name TYPE i.
ENDMETHOD.`
	issues := l.Run("test.abap", source)

	if len(issues) != 1 {
		t.Fatalf("expected 1 naming issue, got %d", len(issues))
	}
	if issues[0].Row == 0 {
		t.Error("issue should have a row number")
	}
	t.Logf("issue: %s at r%d", issues[0].Message, issues[0].Row)
}

func TestLinter_ObsoleteStatement(t *testing.T) {
	l := &Linter{Rules: []Rule{&ObsoleteStatementRule{
		Compute: true, Add: true, Move: true, Refresh: true,
	}}}
	source := `COMPUTE lv_x = 42.
ADD 1 TO lv_x.
MOVE lv_y TO lv_x.
REFRESH lt_table.
lv_x = 42.`
	issues := l.Run("test.abap", source)

	if len(issues) != 4 {
		t.Fatalf("expected 4 obsolete issues, got %d", len(issues))
	}
	for _, iss := range issues {
		t.Logf("  %s: %s", iss.Key, iss.Message)
	}
}

func TestLinter_MaxOneStatement(t *testing.T) {
	l := &Linter{Rules: []Rule{&MaxOneStatementRule{}}}
	source := "DATA lv_x TYPE i. DATA lv_y TYPE i."
	issues := l.Run("test.abap", source)

	if len(issues) == 0 {
		t.Fatal("expected max_one_statement issue")
	}
}

// TestLinter_RealCorpus runs the linter on real ABAP files and reports findings.
func TestLinter_RealCorpus(t *testing.T) {
	l := NewLinter()
	dirs := []string{"../../embedded/abap", "../../abap-adt-api/testdata/src"}

	totalIssues := 0
	ruleCount := map[string]int{}

	for _, dir := range dirs {
		files, _ := filepath.Glob(filepath.Join(dir, "*.abap"))
		for _, f := range files {
			data, err := os.ReadFile(f)
			if err != nil {
				continue
			}
			issues := l.Run(filepath.Base(f), string(data))
			totalIssues += len(issues)
			for _, iss := range issues {
				ruleCount[iss.Key]++
			}
		}
	}

	t.Logf("=== LINTER CORPUS RESULTS ===")
	t.Logf("Total issues: %d", totalIssues)
	for key, count := range ruleCount {
		t.Logf("  %-30s %d", key, count)
	}
}

func BenchmarkLinter(b *testing.B) {
	data, err := os.ReadFile("../../embedded/abap/zcl_vsp_apc_handler.clas.abap")
	if err != nil {
		b.Skipf("file not found: %v", err)
	}
	source := string(data)
	l := NewLinter()

	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		l.Run("test.abap", source)
	}
}
