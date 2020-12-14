#! /usr/bin/env bash

make uncompress
git submodule init
git submodule update
export OPENLANE_ROOT=/home/steve/Ultimachine/openlane
export PDK_ROOT=/home/steve/Ultimachine/openlane/pdk_root
echo $PDK_ROOT
echo $OPENLANE_ROOT
cd openlane
make user_project_wrapper OPENLANE_IMAGE_NAME=openlane:rc5 2>&1 | tee monowrapper.log
#cd ../
#make ship
