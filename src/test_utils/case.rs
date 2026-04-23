use std::fs;
use std::path::{PathBuf};

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

    pub fn src_dump(&self) -> PathBuf {
        let committed = self.dir.join("src.dump");
        // if that exists, return that. Otherwise, run src.sh to generate it and return the generated file
        if committed.exists() {
            committed
        } else {
            let src_sh = self.dir.join("src.sh");
            assert!(src_sh.exists(), "test case is missing src.dump and src.sh");
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
}
