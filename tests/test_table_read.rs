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
        engine: table_read::Engine::Arrow,
    };
    table_read::read_table(test_case.src_dump().to_str().unwrap(), opts)?;
    Ok(())
}
