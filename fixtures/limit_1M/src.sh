#!/bin/bash
# assumes first arg is the location to write the dump to, e.g. `./src/test_utils/case/src.dump`
DST=$1

cargo run --release --bin make_mock_dump -- \
    "https://cg-519a459a-0ea3-42c2-b7bc-fa1143481f74.s3-us-gov-west-1.amazonaws.com/bulk-downloads/data-dump/schedules/fec_fitem_sched_a.dump" \
    "$DST" \
    --row-limit 1000000;