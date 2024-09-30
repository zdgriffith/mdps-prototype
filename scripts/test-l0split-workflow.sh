#!/bin/bash
set -e

scriptdir=$(realpath $(dirname $0))

# tag the container with $USER so as not to collide
./docker/build.sh

# remove any results from previous run
rm -fr tmp/

# TMPDIR is used for running stages of our workflow
mkdir -p tmp/workdir
export TMPDIR=tmp/workdir

# sync over the l0split workflow such that we can modify it to use local files
mkdir tmp/workflows
rsync -av workflows/l0split tmp/workflows/

# edit the unity S3 urls to be local HTTPS urls
sed -i "s,s3://.*__1,https://sipsdev.ssec.wisc.edu/~steved," tmp/workflows/l0split/catalog.json

# also need to specify HTTP on our inputs.yaml
echo "download_type: HTTP" >>tmp/workflows/l0split/l0split.inputs.yaml

time cwltool \
  --outdir=tmp/outputs/ \
  --log-dir=tmp/logs/ \
  --no-warning \
  tmp/workflows/l0split/l0split.workflow.cwl \
  tmp/workflows/l0split/l0split.inputs.yaml |& tee tmp/log
