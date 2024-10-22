#!/bin/bash
set -e

# build our container
bash ./workflows/viirsl1/docker/build.sh

# remove any results from previous run
rm -fr tmp/
mkdir -p tmp/workdir
export TMPDIR=tmp/workdir

time cwltool \
  --outdir=tmp/outputs/ \
  --log-dir=tmp/logs/ \
  --no-warning \
  workflows/viirsl1/viirsl1.workflow.cwl \
  workflows/viirsl1/viirsl1.inputs-local.yaml |& tee tmp/log
