#!/bin/bash
set -e

# remove any results from previous run
rm -fr tmp/

# TMPDIR is used for running stages of our workflow
mkdir -p tmp/workdir
export TMPDIR=tmp/workdir

# sync over the l0split workflow such that we can modify it to use local files
mkdir tmp/workflow
rsync -av workflows/mvcm tmp/workflows/

# edit the unity S3 urls to be local HTTPS urls
sed -i "s,s3://.*__1,https://sipsdev.ssec.wisc.edu/~zgriffith/mdps-inputs," tmp/workflows/mvcm/catalog.json

# also need to specify HTTP on our inputs.yaml
echo "download_type: HTTP" >>tmp/workflows/mvcm/mvcm.inputs.yaml

time cwltool \
  --outdir=tmp/outputs/ \
  --log-dir=tmp/logs/ \
  --no-warning \
  tmp/workflows/mvcm/mvcm.workflow.cwl \
  tmp/workflows/mvcm/mvcm.inputs.yaml |& tee tmp/log
