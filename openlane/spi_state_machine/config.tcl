set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) spi_state_machine

set ::env(VERILOG_FILES) "\
        $script_dir/../../verilog/rtl/defines.v \
        $script_dir/../../rapcores/src/constants.v \
        $script_dir/../../rapcore_caravel_defines.v \
        $script_dir/../../rapcores/src/macro_params.v \
        $script_dir/../../rapcores/src/stepper.v \
        $script_dir/../../rapcores/src/dda_timer.v \
        $script_dir/../../rapcores/src/spi_state_machine.v \
        $script_dir/../../rapcores/src/spi.v \
        $script_dir/../../rapcores/src/quad_enc.v"

set ::env(CLOCK_PORT) "CLK"
set ::env(CLOCK_PERIOD) "15"

set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 540 540"

# use the empty wrapper to help pin placement
#set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg
#set ::env(FP_CONTEXT_DEF) $script_dir/../user_project_wrapper_empty/runs/user_project_wrapper_empty/tmp/floorplan/ioPlacer.def
#set ::env(FP_CONTEXT_LEF) $script_dir/../user_project_wrapper_empty/runs/user_project_wrapper_empty/tmp/merged_unpadded.lef

# Some config for hardening
set ::env(DESIGN_IS_CORE) 0
set ::env(GLB_RT_MAXLAYER) 5

# Diodes to fix violations
set ::env(DIODE_INSERTION_STRATEGY) 3

# We try to set the die size instead
#set ::env(PL_BASIC_PLACEMENT) 40
#set ::env(PL_TARGET_DENSITY) 0.45

# Routing
# -------

# Go fast
set ::env(ROUTING_CORES) 6
#set ::env(GLB_RT_ALLOW_CONGESTION) 1

# block met5 with obstruction
set ::env(GLB_RT_OBS) "met5 0 0 800 800"
