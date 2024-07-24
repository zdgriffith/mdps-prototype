#!/bin/bash
rm -rf outputs
exec cwltool \
  --cachedir=./cache \
  --parallel \
  --outdir=./outputs \
  --log-dir=./outputs \
  process6m.workflow.cwl \
  process6m-test.inputs.yaml
