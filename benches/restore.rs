use std::time::Duration;

use criterion::{Criterion, SamplingMode, criterion_group, criterion_main};
use pg_dumpster::{
    table_read,
    test_utils::case::{TestCase, get_test_case_by_name},
};

fn bench_case(c: &mut Criterion, case: TestCase, table_name: &str) {
    let mut group = c.benchmark_group("restore");

    // This takes the max of these limits, so this ends up doing 10 samples, each 2.5sec, so ~30sec
    group.sampling_mode(SamplingMode::Flat);
    group.sample_size(10);
    group.measurement_time(Duration::from_secs(1));

    let out_path = case.working_dir().join("output.csv");
    let opts = table_read::ReadTableOptions {
        table_name: table_name.to_string(),
        output: Some(out_path),
        format: Some(table_read::Format::Csv),
    };

    group.bench_function(case.name.clone(), |b| {
        b.iter(|| {
            table_read::read_table(case.src_dump().to_str().unwrap(), opts.clone()).unwrap();
        });
    });

    group.finish();
}

fn bench_limit_10(c: &mut Criterion) {
    bench_case(
        c,
        get_test_case_by_name("limit_10"),
        "disclosure.fec_fitem_sched_a_1975_1976",
    );
}

#[allow(non_snake_case)]
fn bench_sched_b_full(c: &mut Criterion) {
    bench_case(
        c,
        get_test_case_by_name("sched_b_full"),
        "disclosure.fec_fitem_sched_b_2021_2022",
    );
}

criterion_group!(benches, bench_limit_10, bench_sched_b_full);
criterion_main!(benches);
