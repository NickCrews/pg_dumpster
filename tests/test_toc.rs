use anyhow::Result;
use std::fs;

use pg_dumpster::test_utils::case::{TestCase, get_test_case_by_name};
use pg_dumpster::test_utils::snapshot::JsonComparator;
use pg_dumpster::toc::cmd_toc;

fn write_toc_to_file(tc: &TestCase, out_name: &str) -> Result<std::path::PathBuf> {
    let out_path = tc.working_dir().join(out_name);
    let mut file = fs::File::create(&out_path)?;
    cmd_toc(tc.src_dump().to_str().unwrap(), &mut file)?;
    Ok(out_path)
}

#[test]
fn toc_basic_matches_snapshot() -> Result<()> {
    let tc = get_test_case_by_name("toc_basic");
    let out = write_toc_to_file(&tc, "toc.json")?;
    tc.snapshot("toc.json").assert_matches(&out, JsonComparator)?;
    Ok(())
}

#[test]
fn escaping_toc_matches_snapshot() -> Result<()> {
    let tc = get_test_case_by_name("escaping");
    let out = write_toc_to_file(&tc, "toc.json")?;
    tc.snapshot("toc.json").assert_matches(&out, JsonComparator)?;
    Ok(())
}
