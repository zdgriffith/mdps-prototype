#!/bin/bash

scriptdir=$(realpath $(dirname $0))

cd ${scriptdir}/..

# tag the container with $USER so as not to collide
./docker/build.sh $USER

# now that its built change back tothe test directory
cd ${scriptdir}

# remove any results from previous run
rm -fr tmp/* outputs/* logs/process/std* log

# make a tmpdir to use
mkdir -p tmp
export TMPDIR=/home/steved/code/mdps-prototype/test/tmp/

# sync over the workflow we want to test
cp -r ../workflows/l0split workflows/

# edit the docker image to be our USER one for testing
sed -i s",    dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-images/l0split:.*,    dockerPull: gitlab.ssec.wisc.edu:5555/sips/mdps-images/l0split:$USER," workflows/l0split/tasks/process.cwl

# copy over the catalog.json but remove item0 which isn the 0826SCIENCE file
# cat ../workflows/l0split/catalog.json | jq "del(.features[0])" > workflows/l0split/catalog.json
# (disabled for now since i've pared down the catalog to only contain the APID 11 input - gregq)
cat ../workflows/l0split/catalog.json > workflows/l0split/catalog.json

# additionally change the links to http urls
sed -i "s,s3://.*__1,https://sipsdev.ssec.wisc.edu/~steved," workflows/l0split/catalog.json

# also need to specify HTTP on our inputs.yaml
echo "download_type: HTTP" >> workflows/l0split/l0split.inputs.yaml

time cwltool \
    --outdir=./outputs \
    --log-dir=./logs \
    --no-warning \
    workflows/l0split/l0split.workflow.cwl \
    workflows/l0split/l0split.inputs.yaml \
    |& tee log
