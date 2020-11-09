#! /usr/bin/env bash

# build openlane
mkdir -p pdk_root
export PDK_ROOT=`pwd`/pdk_root
git clone https://github.com/efabless/openlane.git --branch develop
cd openlane
make
cd docker_build
make merge
cd ../..
