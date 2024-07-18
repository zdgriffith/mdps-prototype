#!/bin/bash
set -e
docker build -t gitlab.ssec.wisc.edu:5555/sips/mdps-prototype -f docker/Dockerfile .

for name in search prepreprocess; do
	docker build -t gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/${name} -f preprocess/docker/Dockerfile .
done
