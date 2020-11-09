#! /usr/bin/env bash

export OPENLANE_ROOT=`pwd`/openlane
git clone https://github.com/efabless/caravel.git
cd caravel/openlane
make
