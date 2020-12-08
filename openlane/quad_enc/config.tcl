set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) quad_enc

set ::env(VERILOG_FILES) "\
        $script_dir/../../rapcores/src/quad_enc.v"

set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_PERIOD) "16"

set ::env(FP_SIZING) absolute
#set ::env(DIE_AREA) "0 0 160 340"
set ::env(DIE_AREA) "0 0 300 150"
set ::env(DESIGN_IS_CORE) 0
set ::env(GLB_RT_MAXLAYER) 5
set ::env(GLB_RT_MINLAYER) 2
#set ::env(GLB_RT_OBS) "met5 0 0 1000 1000"
#set ::env(DIODE_INSERTION_STRATEGY) 3

set ::env(PL_BASIC_PLACEMENT) 1
#set ::env(FP_CORE_UTIL) "50"
#set ::env(PL_TARGET_DENSITY) "0.42"
set ::env(FP_CORE_UTIL) "23"
set ::env(PL_TARGET_DENSITY) "0.26"
