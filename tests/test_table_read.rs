use anyhow::Result;

use pg_dumpster::table_read::{self, Format, ReadTableOptions};
use pg_dumpster::test_utils::case::{TestCase, get_test_case_by_name};
use pg_dumpster::test_utils::snapshot::TableComparator;

#[test]
fn limit_10_csv_matches_snapshot() -> Result<()> {
    let tc = get_test_case_by_name("limit_10");
    let out = run_read(
        &tc,
        "disclosure.fec_fitem_sched_a_1975_1976",
        "output.csv",
        Format::Csv,
    )?;
    tc.snapshot("disclosure.fec_fitem_sched_a_1975_1976.csv")
        .assert_matches(
            &out,
            TableComparator::new(Format::Csv).with_id_column("sub_id"),
        )?;
    Ok(())
}

#[test]
fn limit_10_parquet_matches_snapshot() -> Result<()> {
    let tc = get_test_case_by_name("limit_10");
    let out = run_read(
        &tc,
        "disclosure.fec_fitem_sched_a_1975_1976",
        "output.parquet",
        Format::Parquet,
    )?;
    tc.snapshot("disclosure.fec_fitem_sched_a_1975_1976.csv")
        .assert_matches(
            &out,
            TableComparator::new(Format::Parquet).with_id_column("sub_id"),
        )?;
    Ok(())
}

#[test]
fn limit_10_tsv_raw_matches_snapshot() -> Result<()> {
    let tc = get_test_case_by_name("limit_10");
    let out = run_read(
        &tc,
        "disclosure.fec_fitem_sched_a_1975_1976",
        "output.tsv",
        Format::TsvRaw,
    )?;
    tc.snapshot("disclosure.fec_fitem_sched_a_1975_1976.tsv")
        .assert_matches(
            &out,
            TableComparator::new(Format::TsvRaw).with_id_column("sub_id"),
        )?;
    Ok(())
}

#[test]
fn escaping_csv_matches_snapshot() -> Result<()> {
    let tc = get_test_case_by_name("escaping");
    let out = run_read(&tc, "escaping.values", "escaping.csv", Format::Csv)?;
    tc.snapshot("escaping.values.csv")
        .assert_matches(&out, TableComparator::new(Format::Csv))?;
    Ok(())
}

#[test]
fn escaping_parquet_matches_snapshot() -> Result<()> {
    let tc = get_test_case_by_name("escaping");
    let out = run_read(&tc, "escaping.values", "escaping.parquet", Format::Parquet)?;
    tc.snapshot("escaping.values.csv")
        .assert_matches(&out, TableComparator::new(Format::Parquet))?;
    Ok(())
}

#[test]
fn escaping_tsv_raw_matches_snapshot() -> Result<()> {
    let tc = get_test_case_by_name("escaping");
    let out = run_read(&tc, "escaping.values", "escaping.tsv", Format::TsvRaw)?;
    tc.snapshot("escaping.values.tsv")
        .assert_matches(&out, TableComparator::new(Format::TsvRaw))?;
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
        format: Some(format),
    };
    table_read::read_table(tc.src_dump().to_str().unwrap(), opts)?;
    Ok(out)
}
