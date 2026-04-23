use anyhow::Result;

use pg_dumpster::table_read::{self, Format, ReadTableOptions};
use pg_dumpster::test_utils::case::{TestCase, get_test_case_by_name};
use pg_dumpster::test_utils::snapshot::Snapshot;

#[test]
fn limit_100_csv_matches_snapshot() -> Result<()> {
    let tc = get_test_case_by_name("limit_100");
    let out = run_read(
        &tc,
        "disclosure.fec_fitem_sched_a_1975_1976",
        "output.csv",
        Format::Csv,
    )?;
    Snapshot::new(&tc, "disclosure.fec_fitem_sched_a_1975_1976")
        .with_id_column("sub_id")
        .assert_matches(&out, Format::Csv)?;
    Ok(())
}

#[test]
fn limit_100_parquet_matches_snapshot() -> Result<()> {
    let tc = get_test_case_by_name("limit_100");
    let out = run_read(
        &tc,
        "disclosure.fec_fitem_sched_a_1975_1976",
        "output.parquet",
        Format::Parquet,
    )?;
    Snapshot::new(&tc, "disclosure.fec_fitem_sched_a_1975_1976")
        .with_id_column("sub_id")
        .assert_matches(&out, Format::Parquet)?;
    Ok(())
}

#[test]
fn escaping_csv_matches_snapshot() -> Result<()> {
    let tc = get_test_case_by_name("escaping");
    let out = run_read(&tc, "escaping.values", "escaping.csv", Format::Csv)?;
    Snapshot::new(&tc, "escaping.values").assert_matches(&out, Format::Csv)?;
    Ok(())
}

#[test]
fn escaping_parquet_matches_snapshot() -> Result<()> {
    let tc = get_test_case_by_name("escaping");
    let out = run_read(&tc, "escaping.values", "escaping.parquet", Format::Parquet)?;
    Snapshot::new(&tc, "escaping.values").assert_matches(&out, Format::Parquet)?;
    Ok(())
}

/// Round-trip a fixture written as a plain .sql file through docker postgres →
/// pg_dump -Fc → pg_dumpster, and verify that COPY's text-format escapes
/// (\t, \n, \r, \\, \N) survive the custom-format data block unmodified.
#[test]
fn escaping_preserves_copy_escapes_in_tsv_raw() -> Result<()> {
    let tc = get_test_case_by_name("escaping");
    let out_path = tc.working_dir().join("escaping.tsv");
    let opts = ReadTableOptions {
        table_name: "escaping.values".to_string(),
        output: Some(out_path.clone()),
        format: Format::TsvRaw,
    };
    table_read::read_table(tc.src_dump().to_str().unwrap(), opts)?;

    let actual = std::fs::read_to_string(&out_path)?;
    let mut lines: Vec<&str> = actual.lines().collect();
    assert_eq!(
        lines.first().copied(),
        Some("id\tpayload"),
        "header mismatch; full output:\n{actual}"
    );
    // pg_dump emits rows in heap-scan order; sort the data lines by id for a
    // deterministic comparison.
    let header = lines.remove(0);
    
    let mut expected_rows = [
        "backslash\tpath\\\\to\\\\file",
        "carriage-return\tfirst\\rsecond",
        "newline\tline1\\nline2",
        "null\t\\N",
        "plain\thello world",
        "tab\ta\\tb\\tc",
        "unicode\tcafé — 日本語",
    ];
    lines.sort();
    expected_rows.sort();
    assert_eq!(lines.len(), expected_rows.len(), "row count mismatch");
    for (got, expected) in lines.iter().zip(expected_rows.iter()) {
        assert_eq!(got, expected);
    }
    assert_eq!(header, "id\tpayload");
    Ok(())
}

fn run_read(
    tc: &TestCase,
    table_name: &str,
    out_file: &str,
    format: Format,
) -> Result<std::path::PathBuf> {
    let out = tc.working_dir().join(out_file);
    let opts = ReadTableOptions {
        table_name: table_name.to_string(),
        output: Some(out.clone()),
        format,
    };
    table_read::read_table(tc.src_dump().to_str().unwrap(), opts)?;
    Ok(out)
}
