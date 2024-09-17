#!/bin/bash
set -e

scriptdir=$(realpath $(dirname $0))

# tag the container with $USER so as not to collide
./docker/build.sh

# remove any results from previous run
rm -fr tests/*

# make a tmpdir to use
mkdir -p tests/tmp
export TMPDIR=tests/tmp

# sync over the workflow we want to test
rsync -av workflows/ tests/workflows/

# edit the docker image to be our USER one for testing
# find tests -name \*.cwl | xargs -IXX sed -i "s,l0split:.*$,l0split:$USER,g" XX

# copy over the catalog.json but remove item0 which isn the 0826SCIENCE file
# cat ../workflows/l0split/catalog.json | jq "del(.features[0])" > workflows/l0split/catalog.json
# (disabled for now since i've pared down the catalog to only contain the APID 11 input - gregq)
cp -v workflows/l0split/catalog.json tests/workflows/l0split/catalog.json

# additionally change the links to http urls
sed -i "s,s3://.*__1,https://sipsdev.ssec.wisc.edu/~steved," tests/workflows/l0split/catalog.json

# also need to specify HTTP on our inputs.yaml
echo "download_type: HTTP" >>tests/workflows/l0split/l0split.inputs.yaml

time cwltool \
  --outdir=tests/outputs/ \
  --log-dir=tests/logs/ \
  --no-warning \
  tests/workflows/l0split/l0split.workflow.cwl \
  tests/workflows/l0split/l0split.inputs.yaml |& tee tests/log
