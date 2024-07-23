#!/bin/bash
version=1.0.7
docker build \
  -t gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/demlw:${version} \
  -f docker/Dockerfile \
  .
