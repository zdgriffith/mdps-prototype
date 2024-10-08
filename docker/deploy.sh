#!/bin/bash
set -e
tag=$(git rev-parse --short HEAD)
./docker/build.sh ${tag}
docker push gitlab.ssec.wisc.edu:5555/sips/mdps-images/base:${tag}
docker push gitlab.ssec.wisc.edu:5555/sips/mdps-images/l0split:${tag}
docker push gitlab.ssec.wisc.edu:5555/sips/mdps-images/mvcm_l2:${tag}
