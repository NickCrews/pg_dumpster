use std::time::Duration;

use criterion::{Criterion, SamplingMode, criterion_group, criterion_main};
use pg_dumpster::{
    table_read,
    test_utils::case::{TestCase, get_test_case_by_name},
};

fn bench_case(c: &mut Criterion, case: TestCase) {
    let mut group = c.benchmark_group("restore");

    // This takes the max of these limits, so this ends up doing 10 samples, each 2.5sec, so ~30sec
    group.sampling_mode(SamplingMode::Flat);
    group.sample_size(10);
    group.measurement_time(Duration::from_secs(1));

    let out_path = case.working_dir().join("output.csv");
    let opts = table_read::ReadTableOptions {
        table_name: "disclosure.fec_fitem_sched_a_1975_1976".to_string(),
        output: Some(out_path),
        format: table_read::Format::Csv,
        engine: table_read::Engine::Arrow,
    };

    group.bench_function(case.name.clone(), |b| {
        b.iter(|| {
            table_read::read_table(case.src_dump().to_str().unwrap(), opts.clone()).unwrap();
        });
    });

    group.finish();
}

fn bench_limit_100(c: &mut Criterion) {
    bench_case(c, get_test_case_by_name("limit_100"));
}

#[allow(non_snake_case)]
fn bench_limit_1M(c: &mut Criterion) {
    bench_case(c, get_test_case_by_name("limit_1M"));
}

criterion_group!(benches, bench_limit_100, bench_limit_1M);
criterion_main!(benches);
