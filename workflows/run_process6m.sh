#!/bin/bash
exec cwltool \
  --parallel \
  --outdir=./outputs \
  --log-dir=./outputs \
  process6m.workflow.cwl \
  process6m-test.inputs.yaml
