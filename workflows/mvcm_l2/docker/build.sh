#!/bin/bash
#
tag=latest
if [[ -n $1 ]]; then
  tag=$1
fi

OISST2BIN_DELIVERY=20230619-1
MVCM_DELIVERY=20201008-1
L1BSCALE_DELIVERY=20230719-1

function install_mvcm_delivery() {
  local dpath=workflows/mvcm_l2/deliveries/mvcm/
  echo "Installing MVCM into ${dpath}"
  mkdir -p $dpath
  rsync -a /mnt/deliveredcode/deliveries/mvcm/${MVCM_DELIVERY}/dist/ ${dpath} 
}

function install_oisst2bin_delivery() {
  local dpath=workflows/mvcm_l2/deliveries/oisst2bin/
  echo "Installing oisst2bin into ${dpath}"
  mkdir -p ${dpath}
  rsync -a /mnt/deliveredcode/deliveries/oisst_nc2bin/${OISST2BIN_DELIVERY}/ ${dpath}
}

function install_l1bscale_delivery() {
  local dpath=workflows/mvcm_l2/deliveries/l1bscale/
  echo "Installing L1BSCALE into ${dpath}"
  mkdir -p $dpath
  rsync -a /mnt/deliveredcode/deliveries/viirs_l1bscale/${L1BSCALE_DELIVERY}/dist/ ${dpath} 
}

test -d workflows/mvcm_l2/deliveries/mvcm || install_mvcm_delivery
test -d workflows/mvcm_l2/deliveries/oisst2bin || install_oisst2bin_delivery
test -d workflows/mvcm_l2/deliveries/l1bscale || install_l1bscale_delivery

docker build \
  --build-arg=basever=${tag} \
  -t gitlab.ssec.wisc.edu:5555/sips/mdps-images/mvcm_l2:${tag} \
  -f workflows/mvcm_l2/docker/Dockerfile \
  workflows/mvcm_l2
