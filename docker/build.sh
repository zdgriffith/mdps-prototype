#!/bin/bash
tag=latest
if [[ -n $1 ]]; then
  tag=$1
fi
docker build -t gitlab.ssec.wisc.edu:5555/sips/mdps-images/base:${tag} -f docker/Dockerfile.base .
docker build -t gitlab.ssec.wisc.edu:5555/sips/mdps-images/l0split:${tag} -f workflows/l0split/docker/Dockerfile .

