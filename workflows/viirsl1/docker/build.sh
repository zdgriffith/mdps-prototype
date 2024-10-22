#!/bin/bash
set -e
tag=latest
if [[ -n $1 ]]; then
  tag=$1
fi

docker build -t gitlab.ssec.wisc.edu:5555/sips/viirs_l1-build/viirsl1:${tag} --build-arg=basetag=${tag} -f workflows/viirsl1/docker/Dockerfile .
