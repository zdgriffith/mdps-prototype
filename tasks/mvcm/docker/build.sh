#!/bin/bash

docker build \
  -t gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/mvcm:20230522-1 \
  --build-arg=version=20230522-1 \
  -f docker/Dockerfile \
  .
