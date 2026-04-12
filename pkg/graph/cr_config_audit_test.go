package graph

import "testing"

func TestFinalizeCRConfigAuditReport_AllBuckets(t *testing.T) {
	r := &CRConfigAuditReport{
		CRID: "JIRA-999",
		Transports: CRTransportSplit{
			CRID:           "JIRA-999",
			WorkbenchTRs:   []string{"DEVK900001", "DEVK900002"},
			CustomizingTRs: []string{"DEVK900010"},
		},
		CodeTables: map[string][]TableCodeRef{
			// Covered: read by code AND transported.
			"ZFOO_CUST": {{Table: "ZFOO_CUST", FromObject: "CLAS:ZCL_A", FromInclude: "ZCL_A", Source: "WBCROSSGT"}},
			// Missing: custom table read by code, nothing transported.
			"ZBAR_CUST": {{Table: "ZBAR_CUST", FromObject: "PROG:ZREPORT", FromInclude: "ZREPORT", Source: "CROSS"}},
			// StandardReads: SAP standard read by code.
			"MARA":      {{Table: "MARA", FromObject: "CLAS:ZCL_A", FromInclude: "ZCL_A", Source: "WBCROSSGT"}},
			"T000":      {{Table: "T000", FromObject: "CLAS:ZCL_A", FromInclude: "ZCL_A", Source: "WBCROSSGT"}},
		},
		CustTables: map[string][]TableCustRow{
			// Covered side.
			"ZFOO_CUST": {
				{Table: "ZFOO_CUST", TRKORR: "DEVK900010", TabKey: "100X", ObjFunc: "I"},
				{Table: "ZFOO_CUST", TRKORR: "DEVK900010", TabKey: "100Y", ObjFunc: "U"},
			},
			// Orphan: transported, no code reads it.
			"ZBAZ_UNUSED": {
				{Table: "ZBAZ_UNUSED", TRKORR: "DEVK900010", TabKey: "100Z", ObjFunc: "I"},
			},
		},
	}

	FinalizeCRConfigAuditReport(r)

	if got, want := r.Summary.Covered, 1; got != want {
		t.Errorf("Covered count = %d, want %d", got, want)
	}
	if got, want := r.Summary.Missing, 1; got != want {
		t.Errorf("Missing count = %d, want %d", got, want)
	}
	if got, want := r.Summary.Orphan, 1; got != want {
		t.Errorf("Orphan count = %d, want %d", got, want)
	}
	if got, want := len(r.StandardReads), 2; got != want {
		t.Errorf("StandardReads count = %d, want %d", got, want)
	}
	if got, want := r.Summary.TablesCustomRead, 2; got != want {
		t.Errorf("TablesCustomRead = %d, want %d", got, want)
	}
	if got, want := r.Summary.TablesStandardRead, 2; got != want {
		t.Errorf("TablesStandardRead = %d, want %d", got, want)
	}
	if r.Summary.Aligned {
		t.Error("Aligned = true, want false (Missing and Orphan both non-zero)")
	}

	// Spot-check the Covered entry brings both sides together.
	if len(r.Covered) != 1 || r.Covered[0].Table != "ZFOO_CUST" {
		t.Fatalf("Covered = %#v", r.Covered)
	}
	if got := len(r.Covered[0].CodeRefs); got != 1 {
		t.Errorf("Covered[0].CodeRefs = %d, want 1", got)
	}
	if got := len(r.Covered[0].CustRows); got != 2 {
		t.Errorf("Covered[0].CustRows = %d, want 2", got)
	}

	// Spot-check that Missing contains only the custom table, not MARA/T000.
	if len(r.Missing) != 1 || r.Missing[0].Table != "ZBAR_CUST" {
		t.Fatalf("Missing = %#v (MARA/T000 must not appear here)", r.Missing)
	}

	// Spot-check Orphan.
	if len(r.Orphan) != 1 || r.Orphan[0].Table != "ZBAZ_UNUSED" {
		t.Fatalf("Orphan = %#v", r.Orphan)
	}
}

func TestFinalizeCRConfigAuditReport_AllAligned(t *testing.T) {
	r := &CRConfigAuditReport{
		CRID: "JIRA-1000",
		CodeTables: map[string][]TableCodeRef{
			"ZONLY_CUSTOM": {{Table: "ZONLY_CUSTOM", FromObject: "CLAS:ZCL_X"}},
		},
		CustTables: map[string][]TableCustRow{
			"ZONLY_CUSTOM": {{Table: "ZONLY_CUSTOM", TRKORR: "DEVK900100", TabKey: "KEY1"}},
		},
	}
	FinalizeCRConfigAuditReport(r)
	if !r.Summary.Aligned {
		t.Errorf("expected Aligned=true, got Missing=%d Orphan=%d", r.Summary.Missing, r.Summary.Orphan)
	}
	if r.Summary.Covered != 1 {
		t.Errorf("Covered = %d, want 1", r.Summary.Covered)
	}
}

func TestFinalizeCRConfigAuditReport_CustomIgnoredWhenOnlyStandardRead(t *testing.T) {
	// Edge case: code only reads SAP standard, no custom reads, no transports.
	// Must report aligned with zero Missing even though Covered is zero.
	r := &CRConfigAuditReport{
		CRID: "JIRA-1001",
		CodeTables: map[string][]TableCodeRef{
			"MARA": {{Table: "MARA", FromObject: "PROG:ZTEST"}},
		},
	}
	FinalizeCRConfigAuditReport(r)
	if !r.Summary.Aligned {
		t.Errorf("expected Aligned=true, got Missing=%d", r.Summary.Missing)
	}
	if len(r.StandardReads) != 1 {
		t.Errorf("StandardReads = %d, want 1", len(r.StandardReads))
	}
}
