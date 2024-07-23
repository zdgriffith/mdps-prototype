#!/bin/bash

version=1.2.17
if [[ ! -d viirsmend  ]]; then
  (
    git clone git@gitlab.ssec.wisc.edu:sips/viirsmend
    cd viirsmend
    git checkout ${version}
  )
fi

if [[ $(cd viirsmend && git describe) != ${version} ]]; then
  echo "current repo version is not ${version}"
  exit 1
fi
docker build \
  -t gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/viirsmend:${version} \
  -f docker/Dockerfile \
  .
