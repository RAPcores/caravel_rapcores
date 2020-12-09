set script_dir [file dirname [file normalize [info script]]]

set ::env(_VDD_NET_NAME) vccd1
set ::env(_GND_NET_NAME) vssd1

set ::env(DESIGN_NAME) rapcore

set ::env(VERILOG_FILES) "\
        $script_dir/../../verilog/rtl/defines.v \
        $script_dir/../../rapcore_caravel_defines.v \
        $script_dir/../../rapcores/src/macro_params.v \
        $script_dir/../../rapcores/src/constants.v \
        $script_dir/../../rapcores/src/rapcore.v"

set ::env(VERILOG_FILES_BLACKBOX) "\
        $script_dir/../../rapcore_caravel_defines.v \
        $script_dir/../../rapcores/src/macro_params.v \
        $script_dir/../../rapcores/src/constants.v \
        $script_dir/../../rapcores/src/microstepper/microstepper_top.v \
        $script_dir/../../rapcores/src/quad_enc.v \
	$script_dir/../../rapcores/src/spi_state_machine.v"

set ::env(CLOCK_PORT) "CLK"
set ::env(CLOCK_PERIOD) "15"

set ::env(FP_SIZING) absolute
#set ::env(DIE_AREA) "0 0 380 300" microstepper
#set ::env(DIE_AREA) "0 0 540 540" += 920 840 spi_state_machine
#set ::env(DIE_AREA) "0 0 300 150" quad enc
set ::env(DIE_AREA) "0 0 840 1140"

set ::env(MACRO_PLACEMENT_CFG) $script_dir/macro_placement.cfg

# use the empty wrapper to help pin placement
#set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg
#set ::env(FP_CONTEXT_DEF) $script_dir/../user_project_wrapper_empty/runs/user_project_wrapper_empty/tmp/floorplan/ioPlacer.def
#set ::env(FP_CONTEXT_LEF) $script_dir/../user_project_wrapper_empty/runs/user_project_wrapper_empty/tmp/merged_unpadded.lef

# Some config for hardening
set ::env(DESIGN_IS_CORE) 0
set ::env(GLB_RT_MAXLAYER) 5

# Diodes to fix violations
#set ::env(DIODE_INSERTION_STRATEGY) 3

# We try to set the die size instead
#set ::env(PL_BASIC_PLACEMENT) 40
#set ::env(PL_BASIC_PLACEMENT) 40
set ::env(PL_TARGET_DENSITY) 0.41

# Routing
# -------

# Go fast
set ::env(ROUTING_CORES) 6
set ::env(GLB_RT_ALLOW_CONGESTION) 1

# block met5 with obstruction
set ::env(GLB_RT_OBS) "met5 0 0 2920 3520"

set verilog_root $script_dir/../../rapcores/src
set lef_root $script_dir/../../lef
set gds_root $script_dir/../../gds

set ::env(EXTRA_LEFS) "\
	$lef_root/microstepper.lef \
	$lef_root/quad_enc.lef \
	$lef_root/spi_state_machine.lef"

set ::env(EXTRA_GDS_FILES) "\
	$gds_root/microstepper.gds \
	$gds_root/quad_enc.gds \
	$gds_root/spi_state_machine.gds"
