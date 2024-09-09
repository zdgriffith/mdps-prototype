#!/bin/bash
docker build -t gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/base -f docker/Dockerfile.base .
docker build -t gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/l0split -f workflows/l0split/docker/Dockerfile .

