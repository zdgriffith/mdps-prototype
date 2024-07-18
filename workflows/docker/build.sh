#!/bin/bash
set -e
docker build -t gitlab.ssec.wisc.edu:5555/sips/mdps-prototype -f docker/Dockerfile .
docker build -t gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/preprocess -f preprocess/docker/Dockerfile .
