package graph

import "sort"

// CRTransportSplit partitions the TRs of a single Change Request by their
// E070.TRFUNCTION code. Workbench holds K/S/T, Customizing holds W/Q, and
// anything else lands in OtherTRs so the audit can surface unusual codes
// instead of silently dropping them.
type CRTransportSplit struct {
	CRID           string             `json:"cr_id"`
	WorkbenchTRs   []string           `json:"workbench_trs"`
	CustomizingTRs []string           `json:"customizing_trs"`
	OtherTRs       []CRTransportOther `json:"other_trs,omitempty"`
}

// CRTransportOther captures TRs with TRFUNCTION codes we do not classify
// (e.g. C/R/E) so the user can see them in the report and decide whether
// to treat them as workbench or customizing.
type CRTransportOther struct {
	TR       string `json:"tr"`
	Function string `json:"function"`
}

// TableCodeRef records one code→table reference discovered via CROSS /
// WBCROSSGT or the parser. Multiple refs can exist per table.
type TableCodeRef struct {
	Table       string `json:"table"`
	FromObject  string `json:"from_object"`   // e.g. "CLAS:ZCL_FOO"
	FromInclude string `json:"from_include"`  // canonical include name from cross-ref
	RefKind     string `json:"ref_kind"`      // "DA" / "TABL" / "CDS_FROM" / ...
	Source      string `json:"source"`        // "CROSS" | "WBCROSSGT" | "PARSER"
}

// TableCustRow records one customizing data row transported in a TR that
// belongs to the CR. Values come from E071K.
type TableCustRow struct {
	Table   string `json:"table"`
	TRKORR  string `json:"trkorr"`
	TabKey  string `json:"tabkey"`
	ObjFunc string `json:"objfunc"` // I = insert, U = update, D = delete
}

// CoverageEntry is one row of the final audit report. Depending on which
// bucket it lives in (Covered / Missing / Orphan) either side may be empty.
type CoverageEntry struct {
	Table         string         `json:"table"`
	DeliveryClass string         `json:"delivery_class,omitempty"`
	CodeRefs      []TableCodeRef `json:"code_refs,omitempty"`
	CustRows      []TableCustRow `json:"cust_rows,omitempty"`
}

// CRConfigAuditReport is the final, rendered audit output.
type CRConfigAuditReport struct {
	CRID       string                    `json:"cr_id"`
	Transports CRTransportSplit          `json:"transports"`
	CodeTables map[string][]TableCodeRef `json:"code_tables,omitempty"`
	CustTables map[string][]TableCustRow `json:"cust_tables,omitempty"`

	// Covered: table is both read by code AND carried in a CR transport.
	Covered []CoverageEntry `json:"covered"`
	// Missing: custom (Z/Y) table read by code but not in any CR transport —
	// the primary alarm bucket.
	Missing []CoverageEntry `json:"missing"`
	// StandardReads: SAP-standard table read by code; listed for transparency
	// but never flagged as a gap, since SAP standard doesn't travel in CRs.
	StandardReads []CoverageEntry `json:"standard_reads,omitempty"`
	// Orphan: table has rows in a CR transport but no code in the CR reads it.
	Orphan []CoverageEntry `json:"orphan"`

	Summary CRConfigAuditSummary `json:"summary"`
}

// CRConfigAuditSummary provides top-line numbers for the report.
type CRConfigAuditSummary struct {
	WorkbenchTRs      int  `json:"workbench_trs"`
	CustomizingTRs    int  `json:"customizing_trs"`
	TablesReadByCode  int  `json:"tables_read_by_code"`
	TablesCustomRead  int  `json:"tables_custom_read"`
	TablesStandardRead int `json:"tables_standard_read"`
	TablesInCustTRs   int  `json:"tables_in_cust_trs"`
	Covered           int  `json:"covered"`
	Missing           int  `json:"missing"`
	Orphan            int  `json:"orphan"`
	Aligned           bool `json:"aligned"`
}

// FinalizeCRConfigAuditReport cross-matches CodeTables against CustTables and
// populates Covered / Missing / StandardReads / Orphan buckets plus the Summary.
// Callers must have already filled CodeTables and CustTables; this is a pure
// function with no SAP dependencies so it stays cheap to unit test.
//
// A custom-namespace (Z/Y) table that code reads but no transport carries
// lands in Missing. A SAP-standard table that code reads lands in
// StandardReads (informational, never a gap). A table transported without
// code reading it lands in Orphan. A table in both ends up in Covered.
func FinalizeCRConfigAuditReport(r *CRConfigAuditReport) {
	deliveryClass := map[string]string{} // reserved for future DD02L enrichment

	codeTables := sortedKeys(r.CodeTables)
	custTables := sortedKeys(r.CustTables)

	custSet := make(map[string]bool, len(custTables))
	for _, t := range custTables {
		custSet[t] = true
	}
	codeSet := make(map[string]bool, len(codeTables))
	for _, t := range codeTables {
		codeSet[t] = true
	}

	customRead := 0
	standardRead := 0

	for _, t := range codeTables {
		entry := CoverageEntry{
			Table:         t,
			DeliveryClass: deliveryClass[t],
			CodeRefs:      r.CodeTables[t],
		}
		if custSet[t] {
			entry.CustRows = r.CustTables[t]
			r.Covered = append(r.Covered, entry)
			if IsStandardObject(t) {
				standardRead++
			} else {
				customRead++
			}
			continue
		}
		if IsStandardObject(t) {
			r.StandardReads = append(r.StandardReads, entry)
			standardRead++
		} else {
			r.Missing = append(r.Missing, entry)
			customRead++
		}
	}

	for _, t := range custTables {
		if codeSet[t] {
			continue // already handled under Covered
		}
		r.Orphan = append(r.Orphan, CoverageEntry{
			Table:         t,
			DeliveryClass: deliveryClass[t],
			CustRows:      r.CustTables[t],
		})
	}

	r.Summary = CRConfigAuditSummary{
		WorkbenchTRs:       len(r.Transports.WorkbenchTRs),
		CustomizingTRs:     len(r.Transports.CustomizingTRs),
		TablesReadByCode:   len(codeTables),
		TablesCustomRead:   customRead,
		TablesStandardRead: standardRead,
		TablesInCustTRs:    len(custTables),
		Covered:            len(r.Covered),
		Missing:            len(r.Missing),
		Orphan:             len(r.Orphan),
		Aligned:            len(r.Missing) == 0 && len(r.Orphan) == 0,
	}
}

func sortedKeys[V any](m map[string]V) []string {
	keys := make([]string, 0, len(m))
	for k := range m {
		keys = append(keys, k)
	}
	sort.Strings(keys)
	return keys
}
