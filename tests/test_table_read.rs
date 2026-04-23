use anyhow::Result;

use pg_dumpster::table_read;
use pg_dumpster::test_utils::case::get_test_case_by_name;

#[test]
fn e2e_100() -> Result<()> {
    run_test("limit_100")
}

fn run_test(name: &str) -> Result<()> {
    let test_case = get_test_case_by_name(name);
    let out_path = test_case.working_dir().join("output.csv");
    let opts = table_read::ReadTableOptions {
        table_name: "disclosure.fec_fitem_sched_a_1975_1976".to_string(),
        output: Some(out_path),
        format: table_read::Format::Csv,
    };
    table_read::read_table(test_case.src_dump().to_str().unwrap(), opts)?;
    Ok(())
}

/// Round-trip a fixture written as a plain .sql file through docker postgres →
/// pg_dump -Fc → pg_dumpster, and verify that COPY's text-format escapes
/// (\t, \n, \r, \\, \N) survive the custom-format data block unmodified.
#[test]
fn escaping_preserves_copy_escapes_in_tsv_raw() -> Result<()> {
    let test_case = get_test_case_by_name("escaping");
    let out_path = test_case.working_dir().join("escaping.tsv");
    let opts = table_read::ReadTableOptions {
        table_name: "escaping.values".to_string(),
        output: Some(out_path.clone()),
        format: table_read::Format::TsvRaw,
    };
    table_read::read_table(test_case.src_dump().to_str().unwrap(), opts)?;

    let actual = std::fs::read_to_string(&out_path)?;
    let mut lines: Vec<&str> = actual.lines().collect();
    assert_eq!(
        lines.first().copied(),
        Some("id\tlabel\tpayload"),
        "header mismatch; full output:\n{actual}"
    );
    // pg_dump emits rows in heap-scan order; sort the data lines by id for a
    // deterministic comparison.
    let header = lines.remove(0);
    lines.sort_by_key(|l| {
        l.split('\t')
            .next()
            .and_then(|s| s.parse::<i32>().ok())
            .unwrap_or(i32::MAX)
    });

    let expected_rows = [
        "1\tplain\thello world",
        "2\ttab\ta\\tb\\tc",
        "3\tnewline\tline1\\nline2",
        "4\tbackslash\tpath\\\\to\\\\file",
        "5\tnull\t\\N",
        "6\tcarriage-return\tfirst\\rsecond",
        "7\tunicode\tcafé — 日本語",
    ];
    assert_eq!(lines.len(), expected_rows.len(), "row count mismatch");
    for (got, expected) in lines.iter().zip(expected_rows.iter()) {
        assert_eq!(got, expected);
    }
    assert_eq!(header, "id\tlabel\tpayload");
    Ok(())
}
