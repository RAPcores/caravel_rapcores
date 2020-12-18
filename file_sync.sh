#!/bin/bash
# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0
# To use: sh apply_caravel.sh <target_project_path> <template_caravel_path>
git checkout mpw-one-b gds/
git checkout mpw-one-b lef/
git checkout mpw-one-b mag/
git checkout mpw-one-b def/
git checkout mpw-one-b maglef/
git checkout mpw-one-b ngspice/
git checkout mpw-one-b scripts/
git checkout mpw-one-b spi/
git checkout mpw-one-b utils/
git checkout mpw-one-b verilog/stubs/
git checkout mpw-one-b verilog/dv/wb_utests
git checkout mpw-one-b verilog/dv/dummy_slave.v
find verilog/rtl/* -type f ! -name "user_project_wrapper.v" ! -name "user_proj_example.v" ! -name "rapcores.v" -exec git checkout mpw-one-b {} \;
find verilog/gl/* -type f ! -name "user_project_wrapper.v" ! -name "user_proj_example.v" ! -name "rapcores.v" -exec git checkout mpw-one-b {} \;
