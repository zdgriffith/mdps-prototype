#!/bin/bash
rm -rf outputs
exec cwltool \
  --leave-outputs \
  --parallel \
  --outdir=./outputs \
  --log-dir=./outputs \
  process6m.workflow.cwl \
  process6m-test.inputs.yaml
