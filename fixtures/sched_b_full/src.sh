#!/bin/bash
# first arg is the location to write the dump to. Defaults to src.gen.dump in the same directory as this script.
HERE=$(dirname "$0")
DEFAULT_DST="$HERE/src.gen.dump"
DST="${1:-$DEFAULT_DST}"

curl -L "https://cg-519a459a-0ea3-42c2-b7bc-fa1143481f74.s3-us-gov-west-1.amazonaws.com/bulk-downloads/data-dump/schedules/fec_fitem_sched_b.dump" \
    -o "$DST"