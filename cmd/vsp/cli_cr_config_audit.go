package main

import (
	"context"
	"encoding/json"
	"fmt"
	"html"
	"os"
	"sort"
	"strings"
	"time"

	"github.com/oisee/vibing-steampunk/pkg/adt"
	"github.com/oisee/vibing-steampunk/pkg/graph"
	"github.com/spf13/cobra"
)

func nowNano() int64 { return time.Now().UnixNano() }

var crConfigAuditCmd = &cobra.Command{
	Use:   "cr-config-audit <cr-id>",
	Short: "Audit alignment between code and customizing data within a CR",
	Long: `Check that code objects in a Change Request's workbench transports line
up with the customizing table rows carried by the CR's customizing transports.

Reports three buckets:
  MISSING — code reads a table, no customizing row for it in any TR of the CR
  ORPHAN  — customizing row transported, no code in the CR references that table
  COVERED — both sides present

Uses CROSS / WBCROSSGT / E071K as the source of truth — never regex.

Requires transport_attribute to be configured (.vsp.json or SAP_TRANSPORT_ATTRIBUTE env).

Examples:
  vsp cr-config-audit JIRA-12345
  vsp cr-config-audit JIRA-12345 --details
  vsp cr-config-audit JIRA-12345 --format json`,
	Args: cobra.ExactArgs(1),
	RunE: runCRConfigAudit,
}

func init() {
	crConfigAuditCmd.Flags().Bool("details", false, "Show every code reference and every customizing row")
	crConfigAuditCmd.Flags().String("format", "text", "Output format: text, json, md, or html")
	crConfigAuditCmd.Flags().String("report", "", "Write report to file: html, md, json, or filename.{html,md,json}")
	rootCmd.AddCommand(crConfigAuditCmd)
}

func runCRConfigAudit(cmd *cobra.Command, args []string) error {
	params, err := resolveSystemParams(cmd)
	if err != nil {
		return err
	}
	client, err := getClient(params)
	if err != nil {
		return err
	}

	crID := strings.TrimSpace(args[0])
	attr := params.TransportAttribute
	if attr == "" {
		return fmt.Errorf("transport_attribute not configured. Set SAP_TRANSPORT_ATTRIBUTE or transport_attribute in .vsp.json")
	}

	ctx := context.Background()

	trList, err := resolveCRTransports(ctx, client, crID, attr)
	if err != nil {
		return err
	}
	if len(trList) == 0 {
		fmt.Printf("No transports found for CR %s\n", crID)
		return nil
	}
	fmt.Fprintf(os.Stderr, "Resolved %d transports for CR %s (attribute: %s)\n", len(trList), crID, attr)

	split, err := splitTransportsByFunction(ctx, client, trList)
	if err != nil {
		return err
	}
	split.CRID = crID
	fmt.Fprintf(os.Stderr, "Split: %d workbench, %d customizing, %d other\n",
		len(split.WorkbenchTRs), len(split.CustomizingTRs), len(split.OtherTRs))

	codeTables, deletedRefs, err := collectCodeTables(ctx, client, split.WorkbenchTRs)
	if err != nil {
		return err
	}
	fmt.Fprintf(os.Stderr, "Code-side: %d unique tables referenced\n", len(codeTables))
	if len(deletedRefs) > 0 {
		fmt.Fprintf(os.Stderr, "Deleted/stale refs in transports: %d\n", len(deletedRefs))
	}

	// Customizing data can live in both Workbench and Customizing TRs —
	// the user explicitly noted this. Walk E071K across the whole CR.
	allTRs := append([]string{}, trList...)
	custTables, err := collectCustTables(ctx, client, allTRs)
	if err != nil {
		return err
	}
	fmt.Fprintf(os.Stderr, "Data-side: %d unique tables with transported rows\n", len(custTables))

	report := &graph.CRConfigAuditReport{
		CRID:       crID,
		Transports: *split,
		CodeTables: codeTables,
		CustTables: custTables,
	}

	graph.FinalizeCRConfigAuditReport(report)

	return outputCRConfigAudit(cmd, report)
}

// outputCRConfigAudit resolves --report / --format / --details flags and
// dispatches to the right renderer. When --report names a file (or a bare
// format like "html"), stdout is redirected to that file.
func outputCRConfigAudit(cmd *cobra.Command, report *graph.CRConfigAuditReport) error {
	format, _ := cmd.Flags().GetString("format")
	reportFlag, _ := cmd.Flags().GetString("report")
	details, _ := cmd.Flags().GetBool("details")

	if reportFlag != "" {
		switch {
		case strings.HasSuffix(reportFlag, ".html"):
			format = "html"
		case strings.HasSuffix(reportFlag, ".md"):
			format = "md"
		case strings.HasSuffix(reportFlag, ".json"):
			format = "json"
		case reportFlag == "html" || reportFlag == "md" || reportFlag == "json":
			format = reportFlag
			reportFlag = "cr-config-audit-" + report.CRID + "." + format
		default:
			return fmt.Errorf("unsupported --report value %q (want html, md, json, or filename.{html,md,json})", reportFlag)
		}
		f, err := os.Create(reportFlag)
		if err != nil {
			return fmt.Errorf("creating report file: %w", err)
		}
		defer f.Close()
		origStdout := os.Stdout
		os.Stdout = f
		defer func() { os.Stdout = origStdout }()
	}

	switch format {
	case "json":
		data, _ := json.MarshalIndent(report, "", "  ")
		fmt.Println(string(data))
	case "md":
		printCRConfigAuditMarkdown(report, details)
	case "html":
		printCRConfigAuditHTML(report, details)
	default:
		printCRConfigAuditText(report, details)
	}

	if reportFlag != "" {
		fmt.Fprintf(os.Stderr, "Report saved to %s\n", reportFlag)
	}
	return nil
}

// resolveCRTransports walks E070A by transport attribute, plus child tasks via
// E070.STRKORR, and returns the full de-duplicated list of TRKORRs for the CR.
func resolveCRTransports(ctx context.Context, client *adt.Client, crID, attr string) ([]string, error) {
	attrQuery := fmt.Sprintf(
		"SELECT TRKORR FROM E070A WHERE ATTRIBUTE = '%s' AND REFERENCE = '%s'",
		attr, crID)
	attrResult, err := client.RunQuery(ctx, attrQuery, 500)
	if err != nil {
		return nil, fmt.Errorf("E070A query failed: %w", err)
	}

	trSet := make(map[string]bool)
	var trList []string
	for _, row := range attrResult.Rows {
		tr := strings.TrimSpace(fmt.Sprintf("%v", row["TRKORR"]))
		if tr != "" && !trSet[tr] {
			trSet[tr] = true
			trList = append(trList, tr)
		}
	}
	if len(trList) == 0 {
		return nil, nil
	}

	// Child tasks. IN clause batched to 5 items (SAP freestyle 255-char limit).
	childRows, err := runChunkedINQuery(ctx, client,
		"SELECT TRKORR FROM E070 WHERE STRKORR IN (%s)", trList)
	if err != nil {
		// Non-fatal: continue with the parent requests we already have.
		fmt.Fprintf(os.Stderr, "WARN: child-task resolution failed: %v\n", err)
	}
	for _, row := range childRows {
		tr := strings.TrimSpace(fmt.Sprintf("%v", row["TRKORR"]))
		if tr != "" && !trSet[tr] {
			trSet[tr] = true
			trList = append(trList, tr)
		}
	}
	return trList, nil
}

// collectCodeTables walks every source-bearing dev object in the workbench TRs
// and queries CROSS / WBCROSSGT for its symbol references, then cross-checks
// each referenced name against DD02L to keep only actual DDIC tables and
// views. Result is a map table → list of call-site refs. No regex, no
// source-text scanning — CROSS and WBCROSSGT are the authoritative sources
// for "does this include touch this symbol?" and DD02L is the authoritative
// source for "is this symbol a DDIC table?".
//
// Note: WBCROSSGT OTYPE='TY' mixes table, class, interface, type element,
// and structure references — SAP does not distinguish them at the WBCROSSGT
// level. We collect them all then filter by DD02L presence. Likewise
// CROSS.TYPE='S' mixes tables and structures. DD02L with TABCLASS filter is
// the truth source for what's actually a table or view.
func collectCodeTables(ctx context.Context, client *adt.Client, wbTRs []string) (map[string][]graph.TableCodeRef, []CRDeletedRef, error) {
	result := make(map[string][]graph.TableCodeRef)
	if len(wbTRs) == 0 {
		return result, nil, nil
	}

	// Step 1: resolve E071 parent objects for the WB transports. The shared
	// helper handles both R3TR and LIMU entries, collapses LIMU subcomponents
	// (METH/CPRI/REPS/...) to their parent object, and cross-checks TADIR so
	// deleted or missing entries land in deletedRefs instead of producing
	// 404s on source fetch downstream.
	liveObjs, deletedRefs, err := collectCRDevObjects(ctx, client, wbTRs)
	if err != nil {
		return nil, nil, err
	}

	type devObj struct {
		objType string
		objName string
	}
	objSet := map[devObj]bool{}
	for _, o := range liveObjs {
		// Only source-bearing object types go forward into the cross-ref scan.
		// DDLS joins the list because CDS sources read customizing tables.
		switch o.ObjectType {
		case "CLAS", "PROG", "INTF", "FUGR", "DDLS":
			objSet[devObj{o.ObjectType, o.ObjectName}] = true
		}
	}

	if len(objSet) == 0 {
		return result, deletedRefs, nil
	}
	total := len(objSet)
	fmt.Fprintf(os.Stderr, "Scanning %d code objects for symbol references...\n", total)

	// Step 2: for each object, query its symbol refs. Dedup by
	// (symbol, fromInclude) so repeated references from the same include
	// collapse into a single entry. Keep the raw map keyed by symbol name
	// for now — DD02L cross-check happens next.
	type dedupKey struct{ symbol, include string }
	seen := map[dedupKey]bool{}

	rawRefs := make(map[string][]graph.TableCodeRef)
	prog := newProgress(total, 2)
	done := 0
	for obj := range objSet {
		fromObject := obj.objType + ":" + obj.objName
		prog.tick(done, obj.objName)
		refs := queryCodeRefsForObject(ctx, client, obj.objName, obj.objType)
		for _, r := range refs {
			if !plausibleTableName(r.Table) {
				continue
			}
			key := dedupKey{r.Table, r.FromInclude}
			if seen[key] {
				continue
			}
			seen[key] = true
			r.FromObject = fromObject
			rawRefs[r.Table] = append(rawRefs[r.Table], r)
		}
		done++
	}
	prog.done(done)
	fmt.Fprintf(os.Stderr, "Collected %d unique symbols from cross-refs; filtering via DD02L...\n", len(rawRefs))

	// Step 3: cross-check unique symbols against DD02L to keep only DDIC
	// tables and views. TABCLASS filter:
	//   TRANSP / POOL / CLUSTER — physical tables that store customizing
	//   VIEW                     — database views that read customizing
	// INTTAB / APPEND are structure types — not storage, not customizing.
	symbols := make([]string, 0, len(rawRefs))
	for s := range rawRefs {
		symbols = append(symbols, s)
	}
	tableSet, err := filterDDICTables(ctx, client, symbols)
	if err != nil {
		return nil, nil, err
	}
	for t, refs := range rawRefs {
		if tableSet[t] {
			result[t] = refs
		}
	}
	return result, deletedRefs, nil
}

// collectCustTables walks E071K for every TR in the CR (both workbench and
// customizing — tables-as-data can travel in either) and returns a map from
// affected-table name to the list of transported rows. OBJNAME is used as
// the table identifier: for direct TABU entries it equals MASTERNAME, for
// view transports (CDAT/VDAT) it's the underlying base table, which is what
// application code actually SELECTs from.
func collectCustTables(ctx context.Context, client *adt.Client, allTRs []string) (map[string][]graph.TableCustRow, error) {
	result := make(map[string][]graph.TableCustRow)
	if len(allTRs) == 0 {
		return result, nil
	}
	rows, err := runChunkedINQuery(ctx, client,
		"SELECT TRKORR, OBJNAME, TABKEY, OBJFUNC FROM E071K WHERE OBJECT = 'TABU' AND TRKORR IN (%s)", allTRs)
	if err != nil {
		return nil, fmt.Errorf("E071K query failed: %w", err)
	}
	for _, row := range rows {
		tr := strings.TrimSpace(fmt.Sprintf("%v", row["TRKORR"]))
		obj := strings.ToUpper(strings.TrimSpace(fmt.Sprintf("%v", row["OBJNAME"])))
		key := fmt.Sprintf("%v", row["TABKEY"])
		fn := strings.ToUpper(strings.TrimSpace(fmt.Sprintf("%v", row["OBJFUNC"])))
		if obj == "" {
			continue
		}
		result[obj] = append(result[obj], graph.TableCustRow{
			Table:   obj,
			TRKORR:  tr,
			TabKey:  key,
			ObjFunc: fn,
		})
	}
	return result, nil
}

// ddicTableCache is a process-wide cache of "is this a DDIC table or view".
// Populated on first use via one bulk DD02L query; subsequent calls are O(1).
// DD02L is effectively static across a CLI invocation (the system doesn't
// ship tables while we run), so in-memory caching is always correct here.
// Persistent cross-invocation caching is the user's --cache-dd02l flag path
// (v1.1 TODO).
var ddicTableCache struct {
	loaded bool
	set    map[string]bool
}

// filterDDICTables keeps only names that correspond to real DDIC tables or
// views (TABCLASS in TRANSP/POOL/CLUSTER/VIEW). Internally it hydrates
// ddicTableCache once per process by pulling the full list of qualifying
// tables from DD02L in a single query — much cheaper than the previous
// per-name batched lookup (269 round-trips → 1).
//
// The bulk query is split by namespace prefix (Z/Y for custom, everything
// else for SAP standard) so each response stays comfortably within ADT
// transfer limits while the IN clause stays empty (literal length is zero).
func filterDDICTables(ctx context.Context, client *adt.Client, names []string) (map[string]bool, error) {
	out := make(map[string]bool)
	if len(names) == 0 {
		return out, nil
	}
	if !ddicTableCache.loaded {
		if err := hydrateDDICTableCache(ctx, client); err != nil {
			return nil, err
		}
	}
	for _, n := range names {
		u := strings.ToUpper(n)
		if ddicTableCache.set[u] {
			out[u] = true
		}
	}
	return out, nil
}

// hydrateDDICTableCache bulk-fetches the DD02L table/view universe in a few
// queries. Custom-namespace tables (Z/Y) are typically < 10k rows total on
// a customer system; SAP-standard tables are much larger but we split the
// fetch by the DDIC name ranges SAP itself uses to keep each response small.
func hydrateDDICTableCache(ctx context.Context, client *adt.Client) error {
	if ddicTableCache.loaded {
		return nil
	}
	ddicTableCache.set = make(map[string]bool, 50000)

	// Partitioning: each slice is a DD02L WHERE-suffix. Custom Z/Y first
	// (cheap), then SAP standard split by initial letter to keep each
	// response bounded. A4LOCAL='A' means the active version; inactive
	// definitions would only add noise.
	//
	// Using per-partition queries with no IN clause dodges the 255-char
	// literal limit entirely while still letting us parallelise later if
	// needed. For now, sequential is fine.
	partitions := []string{
		"TABNAME LIKE 'Z%'",
		"TABNAME LIKE 'Y%'",
		"TABNAME LIKE '/%'", // namespaced: /BIC/, /NOV/, /BEV1/, …
		"TABNAME < 'E' AND TABNAME NOT LIKE 'Z%' AND TABNAME NOT LIKE 'Y%' AND TABNAME NOT LIKE '/%'",
		"TABNAME >= 'E' AND TABNAME < 'M'",
		"TABNAME >= 'M' AND TABNAME < 'S'",
		"TABNAME >= 'S' AND TABNAME < 'Z'",
	}

	fmt.Fprintf(os.Stderr, "Hydrating DD02L table cache (%d partitions)...\n", len(partitions))
	prog := newProgress(len(partitions), 1)
	for i, where := range partitions {
		prog.tick(i, "DD02L partition")
		query := fmt.Sprintf(
			"SELECT TABNAME FROM DD02L WHERE AS4LOCAL = 'A' AND TABCLASS IN ('TRANSP','VIEW','POOL','CLUSTER') AND %s",
			where)
		res, err := client.RunQuery(ctx, query, 200000)
		if err != nil {
			return fmt.Errorf("DD02L bulk query failed on partition %q: %w", where, err)
		}
		if res == nil {
			continue
		}
		for _, row := range res.Rows {
			tab := strings.ToUpper(strings.TrimSpace(fmt.Sprintf("%v", row["TABNAME"])))
			if tab != "" {
				ddicTableCache.set[tab] = true
			}
		}
	}
	prog.done(len(partitions))
	ddicTableCache.loaded = true
	fmt.Fprintf(os.Stderr, "DD02L cache: %d tables/views loaded\n", len(ddicTableCache.set))
	return nil
}

func printCRConfigAuditMarkdown(r *graph.CRConfigAuditReport, details bool) {
	status := "ALIGNED"
	if !r.Summary.Aligned {
		status = "NOT ALIGNED"
	}
	fmt.Printf("# CR %s — Code ↔ Customizing Alignment Audit\n\n", r.CRID)
	fmt.Printf("**Status:** %s\n\n", status)
	fmt.Printf("## Transports\n\n")
	fmt.Printf("- Workbench TRs (%d): %s\n", len(r.Transports.WorkbenchTRs), strings.Join(r.Transports.WorkbenchTRs, ", "))
	fmt.Printf("- Customizing TRs (%d): %s\n", len(r.Transports.CustomizingTRs), strings.Join(r.Transports.CustomizingTRs, ", "))
	if len(r.Transports.OtherTRs) > 0 {
		fmt.Println("- Other TRs:")
		for _, o := range r.Transports.OtherTRs {
			fmt.Printf("  - `%s` [%s]\n", o.TR, o.Function)
		}
	}
	fmt.Println()

	fmt.Printf("## Summary\n\n")
	fmt.Println("| Metric | Value |")
	fmt.Println("|---|---|")
	fmt.Printf("| Tables read by code | %d (custom %d, SAP standard %d) |\n",
		r.Summary.TablesReadByCode, r.Summary.TablesCustomRead, r.Summary.TablesStandardRead)
	fmt.Printf("| Tables with transported data | %d |\n", r.Summary.TablesInCustTRs)
	fmt.Printf("| Covered | %d |\n", r.Summary.Covered)
	fmt.Printf("| Missing | %d |\n", r.Summary.Missing)
	fmt.Printf("| Orphan | %d |\n", r.Summary.Orphan)
	fmt.Println()

	if len(r.Missing) > 0 {
		fmt.Printf("## MISSING — custom tables read by code, not in any CR transport\n\n")
		for _, e := range r.Missing {
			fmt.Printf("### `%s`\n\n", e.Table)
			if details && len(e.CodeRefs) > 0 {
				for _, ref := range e.CodeRefs {
					fmt.Printf("- `%s` in `%s` (%s)\n", ref.FromObject, ref.FromInclude, ref.Source)
				}
				fmt.Println()
			}
		}
	}

	if len(r.Orphan) > 0 {
		fmt.Printf("## ORPHAN — transported rows not read by any code in CR\n\n")
		fmt.Println("| Table | Rows |")
		fmt.Println("|---|---|")
		for _, e := range r.Orphan {
			fmt.Printf("| `%s` | %d |\n", e.Table, len(e.CustRows))
		}
		fmt.Println()
		if details {
			for _, e := range r.Orphan {
				fmt.Printf("### `%s`\n\n", e.Table)
				for _, row := range e.CustRows {
					fmt.Printf("- `%s` `%s` `%s`\n", row.TRKORR, row.ObjFunc, row.TabKey)
				}
				fmt.Println()
			}
		}
	}

	if len(r.Covered) > 0 {
		fmt.Printf("## COVERED — tables read by code AND transported\n\n")
		fmt.Println("| Table | Rows | Code refs |")
		fmt.Println("|---|---|---|")
		for _, e := range r.Covered {
			fmt.Printf("| `%s` | %d | %d |\n", e.Table, len(e.CustRows), len(e.CodeRefs))
		}
		fmt.Println()
		if details {
			for _, e := range r.Covered {
				fmt.Printf("### `%s`\n\n", e.Table)
				fmt.Printf("**Transported rows:**\n\n")
				for _, row := range e.CustRows {
					fmt.Printf("- `%s` `%s` `%s`\n", row.TRKORR, row.ObjFunc, row.TabKey)
				}
				fmt.Printf("\n**Code references:**\n\n")
				for _, ref := range e.CodeRefs {
					fmt.Printf("- `%s` in `%s` (%s)\n", ref.FromObject, ref.FromInclude, ref.Source)
				}
				fmt.Println()
			}
		}
	}

	if details && len(r.StandardReads) > 0 {
		fmt.Printf("## SAP standard tables read (%d, informational)\n\n", len(r.StandardReads))
		var names []string
		for _, e := range r.StandardReads {
			names = append(names, "`"+e.Table+"`")
		}
		fmt.Println(strings.Join(names, ", "))
	}
}

func printCRConfigAuditHTML(r *graph.CRConfigAuditReport, details bool) {
	esc := html.EscapeString
	statusClass := "PASS"
	status := "ALIGNED"
	if !r.Summary.Aligned {
		status = "NOT ALIGNED"
		statusClass = "FAIL"
	}

	fmt.Printf(`<!DOCTYPE html>
<html><head><meta charset="UTF-8">
<title>CR %s — Code/Customizing Audit</title>
<style>
  body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; max-width: 1100px; margin: 2em auto; padding: 0 1em; color: #333; }
  h1 { border-bottom: 2px solid #ddd; padding-bottom: 0.3em; }
  h2 { margin-top: 2em; color: #555; border-bottom: 1px solid #eee; padding-bottom: 0.2em; }
  h3 { margin-top: 1.2em; color: #444; font-family: monospace; font-size: 1em; }
  table { border-collapse: collapse; width: 100%%; margin: 1em 0; }
  th, td { border: 1px solid #ddd; padding: 6px 10px; text-align: left; font-size: 0.9em; }
  th { background: #f5f5f5; }
  td.num, th.num { text-align: right; }
  .PASS { color: #2e7d32; font-weight: bold; }
  .FAIL { color: #c62828; font-weight: bold; }
  .summary { display: flex; gap: 1em; flex-wrap: wrap; margin: 1em 0; }
  .summary .box { background: #f9f9f9; border: 1px solid #ddd; border-radius: 6px; padding: 0.6em 1em; min-width: 7em; }
  .summary .num { font-size: 1.4em; font-weight: bold; display: block; }
  .summary .label { font-size: 0.8em; color: #666; }
  .summary .miss .num { color: #c62828; }
  .summary .orph .num { color: #ef6c00; }
  .summary .cov .num  { color: #2e7d32; }
  code, .mono { font-family: 'SFMono-Regular', Consolas, monospace; font-size: 0.88em; }
  .tr-list { color: #666; font-size: 0.85em; }
  details { margin: 0.5em 0; }
  details summary { cursor: pointer; font-weight: 500; }
  .standard-reads { color: #888; font-size: 0.85em; }
</style>
</head><body>
`, esc(r.CRID))

	fmt.Printf("<h1>CR %s — Code ↔ Customizing Alignment Audit</h1>\n", esc(r.CRID))
	fmt.Printf("<p>Status: <span class=\"%s\">%s</span></p>\n", statusClass, status)

	fmt.Println("<h2>Transports</h2>")
	if len(r.Transports.WorkbenchTRs) > 0 {
		fmt.Printf("<p><strong>Workbench (%d):</strong> <span class=\"tr-list mono\">%s</span></p>\n",
			len(r.Transports.WorkbenchTRs), esc(strings.Join(r.Transports.WorkbenchTRs, ", ")))
	}
	if len(r.Transports.CustomizingTRs) > 0 {
		fmt.Printf("<p><strong>Customizing (%d):</strong> <span class=\"tr-list mono\">%s</span></p>\n",
			len(r.Transports.CustomizingTRs), esc(strings.Join(r.Transports.CustomizingTRs, ", ")))
	}
	for _, o := range r.Transports.OtherTRs {
		fmt.Printf("<p><strong>Other [%s]:</strong> <code>%s</code></p>\n", esc(o.Function), esc(o.TR))
	}

	fmt.Println("<h2>Summary</h2>")
	fmt.Println(`<div class="summary">`)
	fmt.Printf(`<div class="box"><span class="num">%d</span><span class="label">Tables read by code</span></div>`, r.Summary.TablesReadByCode)
	fmt.Printf(`<div class="box"><span class="num">%d</span><span class="label">Custom reads</span></div>`, r.Summary.TablesCustomRead)
	fmt.Printf(`<div class="box"><span class="num">%d</span><span class="label">SAP-std reads</span></div>`, r.Summary.TablesStandardRead)
	fmt.Printf(`<div class="box"><span class="num">%d</span><span class="label">Tables transported</span></div>`, r.Summary.TablesInCustTRs)
	fmt.Printf(`<div class="box cov"><span class="num">%d</span><span class="label">Covered</span></div>`, r.Summary.Covered)
	fmt.Printf(`<div class="box miss"><span class="num">%d</span><span class="label">Missing</span></div>`, r.Summary.Missing)
	fmt.Printf(`<div class="box orph"><span class="num">%d</span><span class="label">Orphan</span></div>`, r.Summary.Orphan)
	fmt.Println(`</div>`)

	if len(r.Missing) > 0 {
		fmt.Println(`<h2 id="missing">MISSING — custom tables read by code, no transport</h2>`)
		fmt.Println(`<table><tr><th>Table</th><th class="num">Code refs</th></tr>`)
		for _, e := range r.Missing {
			fmt.Printf(`<tr><td><code>%s</code></td><td class="num">%d</td></tr>`, esc(e.Table), len(e.CodeRefs))
			fmt.Println()
		}
		fmt.Println(`</table>`)
		if details {
			for _, e := range r.Missing {
				fmt.Printf(`<details><summary><code>%s</code> — %d code refs</summary><ul>`, esc(e.Table), len(e.CodeRefs))
				for _, ref := range e.CodeRefs {
					fmt.Printf(`<li><code>%s</code> in <code>%s</code> <span class="tr-list">(%s)</span></li>`,
						esc(ref.FromObject), esc(ref.FromInclude), esc(ref.Source))
				}
				fmt.Println(`</ul></details>`)
			}
		}
	}

	if len(r.Orphan) > 0 {
		fmt.Println(`<h2 id="orphan">ORPHAN — transported rows not read by any code in CR</h2>`)
		fmt.Println(`<table><tr><th>Table</th><th class="num">Rows</th></tr>`)
		for _, e := range r.Orphan {
			fmt.Printf(`<tr><td><code>%s</code></td><td class="num">%d</td></tr>`, esc(e.Table), len(e.CustRows))
			fmt.Println()
		}
		fmt.Println(`</table>`)
		if details {
			for _, e := range r.Orphan {
				fmt.Printf(`<details><summary><code>%s</code> — %d rows</summary><table><tr><th>TR</th><th>Op</th><th>TABKEY</th></tr>`,
					esc(e.Table), len(e.CustRows))
				for _, row := range e.CustRows {
					fmt.Printf(`<tr><td><code>%s</code></td><td>%s</td><td><code>%s</code></td></tr>`,
						esc(row.TRKORR), esc(row.ObjFunc), esc(row.TabKey))
					fmt.Println()
				}
				fmt.Println(`</table></details>`)
			}
		}
	}

	if len(r.Covered) > 0 {
		fmt.Println(`<h2 id="covered">COVERED — tables both read and transported</h2>`)
		fmt.Println(`<table><tr><th>Table</th><th class="num">Rows</th><th class="num">Code refs</th></tr>`)
		for _, e := range r.Covered {
			fmt.Printf(`<tr><td><code>%s</code></td><td class="num">%d</td><td class="num">%d</td></tr>`,
				esc(e.Table), len(e.CustRows), len(e.CodeRefs))
			fmt.Println()
		}
		fmt.Println(`</table>`)
		if details {
			for _, e := range r.Covered {
				fmt.Printf(`<details><summary><code>%s</code> — %d rows, %d refs</summary>`,
					esc(e.Table), len(e.CustRows), len(e.CodeRefs))
				fmt.Println(`<h4>Transported rows</h4><table><tr><th>TR</th><th>Op</th><th>TABKEY</th></tr>`)
				for _, row := range e.CustRows {
					fmt.Printf(`<tr><td><code>%s</code></td><td>%s</td><td><code>%s</code></td></tr>`,
						esc(row.TRKORR), esc(row.ObjFunc), esc(row.TabKey))
					fmt.Println()
				}
				fmt.Println(`</table><h4>Code references</h4><ul>`)
				for _, ref := range e.CodeRefs {
					fmt.Printf(`<li><code>%s</code> in <code>%s</code> <span class="tr-list">(%s)</span></li>`,
						esc(ref.FromObject), esc(ref.FromInclude), esc(ref.Source))
				}
				fmt.Println(`</ul></details>`)
			}
		}
	}

	if details && len(r.StandardReads) > 0 {
		fmt.Printf(`<h2>SAP standard tables read (%d, informational)</h2><p class="standard-reads mono">`, len(r.StandardReads))
		names := make([]string, 0, len(r.StandardReads))
		for _, e := range r.StandardReads {
			names = append(names, esc(e.Table))
		}
		fmt.Printf("%s</p>\n", strings.Join(names, ", "))
	}

	fmt.Println(`</body></html>`)
}

// progress prints a rate-limited status line to stderr. Rate-limited so we
// do not flood the log on fast loops, but tight enough on slow loops that
// the user always sees something moving.
type progress struct {
	total       int
	lastPrintNS int64
	intervalNS  int64
}

func newProgress(total int, intervalSeconds int) *progress {
	return &progress{total: total, intervalNS: int64(intervalSeconds) * 1_000_000_000}
}

func (p *progress) tick(current int, label string) {
	if p.total <= 0 {
		return
	}
	nowNS := nowNano()
	if p.lastPrintNS != 0 && nowNS-p.lastPrintNS < p.intervalNS {
		return
	}
	p.lastPrintNS = nowNS
	pct := (current * 100) / p.total
	fmt.Fprintf(os.Stderr, "  [%3d%%] %d/%d  %s\n", pct, current, p.total, label)
}

func (p *progress) done(current int) {
	if p.total <= 0 {
		return
	}
	fmt.Fprintf(os.Stderr, "  [100%%] %d/%d done\n", current, p.total)
}

// queryCodeRefsForObject pulls symbol references from WBCROSSGT (for OO code)
// and CROSS (for procedural code). Returns every reference regardless of
// whether the target is actually a table — DD02L cross-check happens at the
// caller. Names with `\component` suffix are stripped to the base symbol.
func queryCodeRefsForObject(ctx context.Context, client *adt.Client, name, objType string) []graph.TableCodeRef {
	var out []graph.TableCodeRef
	nameUp := strings.ToUpper(name)

	// WBCROSSGT OTYPE='TY' — type references, which include DDIC tables
	// alongside classes/interfaces/data elements. Filter out later via DD02L.
	wbQuery := fmt.Sprintf(
		"SELECT INCLUDE, NAME FROM WBCROSSGT WHERE OTYPE = 'TY' AND INCLUDE LIKE '%s%%'",
		nameUp)
	if wbResult, err := client.RunQuery(ctx, wbQuery, 500); err == nil && wbResult != nil {
		for _, row := range wbResult.Rows {
			inc := strings.ToUpper(strings.TrimSpace(fmt.Sprintf("%v", row["INCLUDE"])))
			sym := strings.ToUpper(strings.TrimSpace(fmt.Sprintf("%v", row["NAME"])))
			sym = stripComponentSuffix(sym)
			if sym == "" || sym == nameUp {
				continue
			}
			out = append(out, graph.TableCodeRef{
				Table:       sym,
				FromInclude: inc,
				RefKind:     "WBGT_TY",
				Source:      "WBCROSSGT",
			})
		}
	}

	// CROSS.TYPE='S' — structure/table references for classic procedural code
	// (programs and function group includes). For FUGR the physical includes
	// are L<FG>TOP, L<FG>U01, etc., so we also probe that pattern.
	crossIncludes := []string{nameUp + "%"}
	if objType == "FUGR" {
		crossIncludes = append(crossIncludes, "L"+nameUp+"%")
	}
	for _, pattern := range crossIncludes {
		crossQuery := fmt.Sprintf(
			"SELECT INCLUDE, NAME FROM CROSS WHERE TYPE = 'S' AND INCLUDE LIKE '%s'",
			pattern)
		if crossResult, err := client.RunQuery(ctx, crossQuery, 500); err == nil && crossResult != nil {
			for _, row := range crossResult.Rows {
				inc := strings.ToUpper(strings.TrimSpace(fmt.Sprintf("%v", row["INCLUDE"])))
				sym := strings.ToUpper(strings.TrimSpace(fmt.Sprintf("%v", row["NAME"])))
				sym = stripComponentSuffix(sym)
				if sym == "" || sym == nameUp {
					continue
				}
				out = append(out, graph.TableCodeRef{
					Table:       sym,
					FromInclude: inc,
					RefKind:     "CROSS_S",
					Source:      "CROSS",
				})
			}
		}
	}
	return out
}

// stripComponentSuffix removes the `\TY:component` or `\component` suffix that
// WBCROSSGT attaches when a reference points at a subcomponent of a type —
// e.g. `ZEXAMPLE_STRUCT\TY:FIELD` becomes `ZEXAMPLE_STRUCT`. The base name is
// what matches DD02L.
func stripComponentSuffix(name string) string {
	if idx := strings.Index(name, "\\"); idx >= 0 {
		return name[:idx]
	}
	return name
}

// plausibleTableName filters names that can possibly be DDIC tables before
// hitting DD02L. DDIC TABNAME is CHAR(30) max and contains only A-Z, 0-9,
// /, _. Class includes use `=` fillers and exceed 30 chars, programs can be
// up to 40 chars, etc. — all are rejected here to keep DD02L happy.
func plausibleTableName(name string) bool {
	if name == "" || len(name) > 30 {
		return false
	}
	for _, r := range name {
		switch {
		case r >= 'A' && r <= 'Z':
		case r >= '0' && r <= '9':
		case r == '_' || r == '/':
		default:
			return false
		}
	}
	return true
}

// runChunkedINQuery runs a query whose %s placeholder is the IN-clause body,
// batched to 5 values per call to respect the SAP freestyle 255-char literal
// limit. Returns the union of all result rows; first hard error short-circuits.
func runChunkedINQuery(ctx context.Context, client *adt.Client, tmpl string, values []string) ([]map[string]any, error) {
	const batchSize = 5
	var all []map[string]any
	for i := 0; i < len(values); i += batchSize {
		end := i + batchSize
		if end > len(values) {
			end = len(values)
		}
		batch := values[i:end]
		quoted := make([]string, len(batch))
		for j, v := range batch {
			quoted[j] = "'" + v + "'"
		}
		query := fmt.Sprintf(tmpl, strings.Join(quoted, ","))
		res, err := client.RunQuery(ctx, query, 500)
		if err != nil {
			return all, err
		}
		if res != nil {
			all = append(all, res.Rows...)
		}
	}
	return all, nil
}

// splitTransportsByFunction queries E070.TRFUNCTION and partitions the TR list
// into Workbench (K/S) and Customizing (W). Anything else is reported as Other
// so the user can see unusual function codes (like C/R/E) instead of silently
// dropping them.
func splitTransportsByFunction(ctx context.Context, client *adt.Client, trList []string) (*graph.CRTransportSplit, error) {
	split := &graph.CRTransportSplit{}
	if len(trList) == 0 {
		return split, nil
	}

	rows, err := runChunkedINQuery(ctx, client,
		"SELECT TRKORR, TRFUNCTION FROM E070 WHERE TRKORR IN (%s)", trList)
	if err != nil {
		return nil, fmt.Errorf("E070 TRFUNCTION query failed: %w", err)
	}

	for _, row := range rows {
		tr := strings.TrimSpace(fmt.Sprintf("%v", row["TRKORR"]))
		fn := strings.ToUpper(strings.TrimSpace(fmt.Sprintf("%v", row["TRFUNCTION"])))
		if tr == "" {
			continue
		}
		switch fn {
		case "K", "S", "T":
			// K = Workbench request, S = Development/correction, T = task (workbench task)
			split.WorkbenchTRs = append(split.WorkbenchTRs, tr)
		case "W", "Q":
			// W = Customizing request, Q = Customizing task
			split.CustomizingTRs = append(split.CustomizingTRs, tr)
		default:
			split.OtherTRs = append(split.OtherTRs, graph.CRTransportOther{TR: tr, Function: fn})
		}
	}
	sort.Strings(split.WorkbenchTRs)
	sort.Strings(split.CustomizingTRs)
	sort.Slice(split.OtherTRs, func(i, j int) bool {
		return split.OtherTRs[i].TR < split.OtherTRs[j].TR
	})
	return split, nil
}

func printCRConfigAuditText(r *graph.CRConfigAuditReport, details bool) {
	fmt.Printf("CR %s — Code ↔ Customizing Alignment Audit\n", r.CRID)
	fmt.Printf("Workbench TRs: %d | Customizing TRs: %d", len(r.Transports.WorkbenchTRs), len(r.Transports.CustomizingTRs))
	if len(r.Transports.OtherTRs) > 0 {
		fmt.Printf(" | Other: %d", len(r.Transports.OtherTRs))
	}
	fmt.Println()

	if len(r.Transports.WorkbenchTRs) > 0 {
		fmt.Printf("  Workbench:   %s\n", strings.Join(r.Transports.WorkbenchTRs, ", "))
	}
	if len(r.Transports.CustomizingTRs) > 0 {
		fmt.Printf("  Customizing: %s\n", strings.Join(r.Transports.CustomizingTRs, ", "))
	}
	for _, o := range r.Transports.OtherTRs {
		fmt.Printf("  Other [%s]: %s\n", o.Function, o.TR)
	}

	fmt.Printf("Tables read by code: %d (custom: %d, SAP standard: %d)  |  Tables with transported data: %d\n",
		r.Summary.TablesReadByCode, r.Summary.TablesCustomRead, r.Summary.TablesStandardRead, r.Summary.TablesInCustTRs)

	status := "ALIGNED"
	if !r.Summary.Aligned {
		status = "NOT ALIGNED"
	}
	fmt.Printf("  Covered: %d   Missing: %d   Orphan: %d   →  %s\n\n",
		r.Summary.Covered, r.Summary.Missing, r.Summary.Orphan, status)

	if len(r.Missing) > 0 {
		fmt.Println("MISSING — custom tables read by code, not in any CR transport:")
		for _, e := range r.Missing {
			fmt.Printf("  %s\n", e.Table)
			if details {
				for _, ref := range e.CodeRefs {
					fmt.Printf("    ← %s  (%s, %s)\n", ref.FromObject, ref.FromInclude, ref.Source)
				}
			}
		}
		fmt.Println()
	}

	if len(r.Orphan) > 0 {
		fmt.Println("ORPHAN — transported rows for tables no code in CR references:")
		for _, e := range r.Orphan {
			fmt.Printf("  %-25s  %d rows\n", e.Table, len(e.CustRows))
			if details {
				for _, row := range e.CustRows {
					fmt.Printf("    %s  %s  TABKEY=%s\n", row.TRKORR, row.ObjFunc, row.TabKey)
				}
			}
		}
		fmt.Println()
	}

	if len(r.Covered) > 0 {
		fmt.Println("COVERED — tables both read by code AND transported:")
		for _, e := range r.Covered {
			fmt.Printf("  %-25s  %d rows,  %d code refs\n", e.Table, len(e.CustRows), len(e.CodeRefs))
			if details {
				for _, row := range e.CustRows {
					fmt.Printf("    [data] %s  %s  TABKEY=%s\n", row.TRKORR, row.ObjFunc, row.TabKey)
				}
				for _, ref := range e.CodeRefs {
					fmt.Printf("    [code] ← %s  (%s, %s)\n", ref.FromObject, ref.FromInclude, ref.Source)
				}
			}
		}
		fmt.Println()
	}

	if details && len(r.StandardReads) > 0 {
		fmt.Printf("SAP standard tables read by code (%d, informational):\n", len(r.StandardReads))
		names := make([]string, 0, len(r.StandardReads))
		for _, e := range r.StandardReads {
			names = append(names, e.Table)
		}
		// Print in columns of ~6 per line for compactness.
		for i := 0; i < len(names); i += 6 {
			end := i + 6
			if end > len(names) {
				end = len(names)
			}
			fmt.Printf("  %s\n", strings.Join(names[i:end], ", "))
		}
	}
}
