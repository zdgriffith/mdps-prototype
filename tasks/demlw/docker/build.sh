#!/bin/bash
set -eu

demlw_dst=$PWD/docker/demlw-static
demlw_src=/mnt/software/support/demlw-static/0.2017.11.07/
if [[ ! -d $demlw_dst ]]; then 
  mkdir -p $demlw_dst 
  for fpath in $demlw_src/*.hdf; do 
    echo compressing ${fpath}
    hrepack -t '*:GZIP 5' -i ${fpath} -o ${demlw_dst}/$(basename $fpath) 
  done
  for fn in README SOURCE lw-cache.npy; do 
    cp $demlw_src/$fn $demlw_dst
  done
fi

version=1.0.7
docker build \
  -t gitlab.ssec.wisc.edu:5555/sips/mdps-prototype/demlw:${version} \
  -f docker/Dockerfile \
  .
