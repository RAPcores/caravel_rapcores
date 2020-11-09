#! /usr/bin/env bash

export PDK_ROOT=`pwd`/pdk_root
export OPENLANE_ROOT=`pwd`/openlane
echo $PDK_ROOT
echo $OPENLANE_ROOT
git clone ../caravel
cd caravel/openlane
make user_project_wrapper OPENLANE_IMAGE_NAME=openlane:rc5
