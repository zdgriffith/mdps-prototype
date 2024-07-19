#!/bin/bash

docker build \
  -t gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/viirs_l1bscale:20230719-1 \
  --build-arg=version=20230719-1 \
  -f docker/Dockerfile \
  .
