set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) chargepump

set ::env(VERILOG_FILES) "\
        $script_dir/../../rapcores/src/microstepper/chargepump.v"

set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_PERIOD) "10"

set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 80 80"
set ::env(DESIGN_IS_CORE) 0

set ::env(GLB_RT_MAXLAYER) 5
set ::env(GLB_RT_OBS) "met5 0 0 80 80"
set ::env(DIODE_INSERTION_STRATEGY) 3

#set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg

set ::env(PL_BASIC_PLACEMENT) 1
set ::env(FP_CORE_UTIL) "50"
set ::env(PL_TARGET_DENSITY) "0.55"
