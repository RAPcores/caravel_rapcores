#! /usr/bin/env bash

cd ../open_mpw_precheck/dependencies
#sh build-docker.sh
cd ..
export TARGET_PATH=/home/steve/Ultimachine/caravel_rapcores2
export PDK_ROOT=/home/steve/Ultimachine/openlane/pdk_root
docker run -it -v $(pwd):/usr/local/bin \
    -u $(id -u $USER):$(id -g $USER) -v $TARGET_PATH:$TARGET_PATH \
    open_mpw_prechecker:latest python3 open_mpw_prechecker.py -t $TARGET_PATH -p /home/steve/Ultimachine/openlane/pdk_root
