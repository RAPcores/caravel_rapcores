#! /usr/bin/env bash

git clone git@github.com:efabless/open_mpw_precheck.git
cd open_mpw_precheck/dependencies
sh build-docker.sh
cd ..
export TARGET_PATH=`pwd`/..
docker run -it -v $(pwd):/usr/local/bin \
    -u $(id -u $USER):$(id -g $USER) -v $TARGET_PATH:$TARGET_PATH \
    open_mpw_prechecker:latest python3 open_mpw_prechecker.py -t $TARGET_PATH
