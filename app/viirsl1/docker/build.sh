#!/bin/bash
dtstr=$(date +%Y%m%d)
docker build \
  -t gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/viirsl1:v3.1.0 \
  -t gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/viirsl1:v3.1.0-${dtstr} \
  -f docker/Dockerfile \
  .
