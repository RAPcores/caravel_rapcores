#! /usr/bin/env bash

export PDK_ROOT=`pwd`/pdk_root
export OPENLANE_ROOT=`pwd`/openlane_repo
echo $PDK_ROOT
echo $OPENLANE_ROOT
cd openlane
make rapcore OPENLANE_IMAGE_NAME=openlane:rc5
