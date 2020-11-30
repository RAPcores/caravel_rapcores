#! /usr/bin/env bash

# build openlane
mkdir -p pdk_root
export PDK_ROOT=`pwd`/pdk_root
git clone https://github.com/RAPcores/openlane.git --branch rapcore_flow openlane_repo
cd openlane_repo
make
cd docker_build
make merge
cd ../..
