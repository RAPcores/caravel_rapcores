#! /usr/bin/env bash

# build openlane
mkdir -p pdk_root
export PDK_ROOT=`pwd`/pdk_root
git submodule init
cd openlane_repo
make
cd docker_build
make merge
cd ../..
chmod +x openlane_repo/scripts/*
