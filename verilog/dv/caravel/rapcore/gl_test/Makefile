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
#
# SPDX-License-Identifier: Apache-2.0

PROJ_ROOT = ../../../../..
FIRMWARE_PATH = ../..
VERILOG_PATH = ../../../..
RTL_PATH = $(VERILOG_PATH)/rtl
IP_PATH = ../../../../ip
BEHAVIOURAL_MODELS = ../../
RAPCORE_PATH = $(PROJ_ROOT)/rapcores
RAPCORE_HARNESS = $(PROJ_ROOT)/rapcores/testbench/rapcore_harness_tb.v
RAPCORE_GL = $(PROJ_ROOT)/verilog/gl/rapcore.v
RAPCORE_CONFIG = $(PROJ_ROOT)/rapcores/boards/mpw_one_defines.v
IP_PATH = ../../../../ip
BEHAVIOURAL_MODELS = ../../

PDK_PATH?=$(PDK_ROOT)/sky130A/
SKYLIBS?=$(PDK_PATH)/libs.ref/sky130_fd_sc_hd/verilog/

SIM?=GL

.SUFFIXES:

PATTERN = rapcore

all:  ${PATTERN:=.vcd}

hex:  ${PATTERN:=.hex}

%.vvp: %_tb.v
	iverilog -DFUNCTIONAL -DSIM -DGL -I $(BEHAVIOURAL_MODELS) \
	-I $(PDK_PATH) -I $(IP_PATH) -I $(RTL_PATH) $(RAPCORE_CONFIG) $(RAPCORE_HARNESS) $(RAPCORE_GL) \
	rapcore_tb.v

%.vcd: %.vvp
	vvp $<

# ---- Clean ----

clean:
	rm -f *.elf *.hex *.bin *.vvp *.vcd *.log

.PHONY: clean hex all
