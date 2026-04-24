use crate::test_utils::snapshot::Snapshot;
use std::fs;
use std::path::{Path, PathBuf};

pub fn find_test_cases() -> Vec<TestCase> {
    let root = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    let fixtures_dir = root.join("fixtures");
    let mut test_cases = Vec::new();
    for entry in fs::read_dir(fixtures_dir).expect("failed to read fixtures directory") {
        let entry = entry.expect("failed to read fixture directory entry");
        if entry
            .file_type()
            .expect("failed to get fixture directory entry type")
            .is_dir()
        {
            test_cases.push(TestCase::new(&entry.file_name().to_string_lossy()));
        }
    }
    test_cases
}

pub fn get_test_case_by_name(name: &str) -> TestCase {
    let test_cases = find_test_cases();
    test_cases
        .into_iter()
        .find(|tc| tc.name == name)
        .expect(&format!("test case with name {} not found", name))
}

pub struct TestCase {
    pub name: String,
    pub dir: PathBuf,
}

impl TestCase {
    pub fn new(name: &str) -> Self {
        let root = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
        let dir = root
            .join("fixtures")
            .join(name)
            .canonicalize()
            .expect("test case directory does not exist");
        Self {
            name: name.to_string(),
            dir,
        }
    }

    /// Resolve the source dump for this test case.
    ///
    /// Preference order:
    /// 1. A committed `src.dump` next to the fixture (used as-is).
    /// 2. A `src.sql` plain-SQL fixture, converted to `src.gen.dump` via
    ///    `scripts/gen_dump.sh` (a docker-backed postgres round-trip).
    ///    Regenerated when the cached dump is missing or older than the
    ///    source SQL or the generator script.
    /// 3. A `src.sh` script that produces `src.gen.dump` itself. Regenerated
    ///    only when the cached dump is absent.
    pub fn src_dump(&self) -> PathBuf {
        let committed = self.dir.join("src.dump");
        if committed.exists() {
            return committed;
        }

        let src_sql = self.dir.join("src.sql");
        if src_sql.exists() {
            return self.ensure_gen_dump_from_sql(&src_sql);
        }

        let src_sh = self.dir.join("src.sh");
        assert!(
            src_sh.exists(),
            "test case is missing src.dump, src.sql, and src.sh"
        );
        self.ensure_gen_dump_from_sh(&src_sh)
    }

    fn ensure_gen_dump_from_sql(&self, src_sql: &Path) -> PathBuf {
        let out_path = self.dir.join("src.gen.dump");
        let gen_script = PathBuf::from(env!("CARGO_MANIFEST_DIR"))
            .join("scripts")
            .join("gen_dump.sh");
        assert!(
            gen_script.exists(),
            "gen_dump.sh not found at {}",
            gen_script.display()
        );

        if !is_stale(&out_path, &[src_sql, &gen_script]) {
            return out_path;
        }

        eprintln!(
            "[test_utils] regenerating {} from {}",
            out_path.display(),
            src_sql.display()
        );
        let status = std::process::Command::new(&gen_script)
            .arg(src_sql)
            .arg(&out_path)
            .status()
            .unwrap_or_else(|e| panic!("failed to spawn {}: {e}", gen_script.display()));
        assert!(
            status.success(),
            "gen_dump.sh failed with status {}",
            status
        );
        assert!(
            out_path.exists(),
            "gen_dump.sh did not produce {}",
            out_path.display()
        );
        out_path
    }

    fn ensure_gen_dump_from_sh(&self, src_sh: &Path) -> PathBuf {
        let out_path = self.dir.join("src.gen.dump");
        if out_path.exists() {
            return out_path;
        }
        let output = std::process::Command::new("sh")
            .arg(src_sh)
            .arg(out_path.to_string_lossy().into_owned())
            .output()
            .expect("failed to run src.sh");
        assert!(output.status.success(), "failed to run src.sh");
        assert!(
            out_path.exists(),
            "src.sh did not produce expected output file"
        );
        out_path
    }

    pub fn export_expected_dir(&self) -> Option<PathBuf> {
        let path = self.dir.join("export_expected");
        if path.exists() { Some(path) } else { None }
    }

    pub fn working_dir(&self) -> PathBuf {
        let working_dir = self.dir.join("working");
        fs::create_dir_all(&working_dir).unwrap();
        working_dir
    }

    /// eg `case.snapshot("disclosure.fec_fitem_sched_a_1975_1976.tsv")` resolves to
    /// `fixtures/<this case>/snapshots/disclosure.fec_fitem_sched_a_1975_1976.tsv`
    pub fn snapshot(&self, path_name: &str) -> Snapshot {
        Snapshot::new(self, path_name)
    }
}

/// Returns true when `out` does not exist or is older than any of `inputs`.
fn is_stale(out: &Path, inputs: &[&Path]) -> bool {
    let out_mtime = match fs::metadata(out).and_then(|m| m.modified()) {
        Ok(t) => t,
        Err(_) => return true,
    };
    inputs.iter().any(
        |input| match fs::metadata(input).and_then(|m| m.modified()) {
            Ok(input_mtime) => input_mtime > out_mtime,
            // If we can't stat an input, be conservative and regenerate.
            Err(_) => true,
        },
    )
}
