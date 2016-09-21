#!/bin/bash

set -eux
BUILD_FOR=${BUILD_FOR:-ubuntu}

function build_deb_pkg {
  case $1 in
    ubuntu)
      sudo docker build -t kvm_deb .
      sudo docker run -v $WORKSPACE:/opt/kvmfornfv -t  kvm_deb \
                      /opt/kvmfornfv/ci/build_deb/build_debs_docker.sh
    ;;
    *) echo "Not supported system"; exit 1;;
  esac
}

for system in $BUILD_FOR
do
  build_deb_pkg $system
done