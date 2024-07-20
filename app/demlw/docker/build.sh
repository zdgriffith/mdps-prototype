#!/bin/bash

version=1.0.7
if [[ ! -d demlw  ]]; then
  (
    git clone git@gitlab.ssec.wisc.edu:sips/demlw
    cd demlw
    git checkout ${version}
  )
fi

if [[ $(cd demlw && git describe) != ${version} ]]; then
  echo "current repo version is not ${version}"
  exit 1
fi
docker build \
  -t gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/demlw:${version} \
  -f docker/Dockerfile \
  .
