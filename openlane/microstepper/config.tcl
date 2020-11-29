set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) microstepper_top

set ::env(PDN_CFG) $script_dir/pdn.tcl

set ::env(STD_CELL_LIBRARY) "sky130_fd_sc_hvl"

set ::env(VERILOG_FILES) "\
        $script_dir/../../rapcores/src/pwm.v \
        $script_dir/../../rapcores/src/microstepper/microstepper_top.v \
        $script_dir/../../rapcores/src/microstepper/microstep_counter.v \
        $script_dir/../../rapcores/src/microstepper/cosine.v \
        $script_dir/../../rapcores/src/microstepper/analog_out.v \
        $script_dir/../../rapcores/src/microstepper/chargepump.v \
        $script_dir/../../rapcores/src/microstepper/mytimer.v"

set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_PERIOD) "15"

set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 1000 1000"
set ::env(DESIGN_IS_CORE) 0

#set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg

set ::env(PL_BASIC_PLACEMENT) 1
set ::env(FP_CORE_UTIL) "40"
set ::env(PL_TARGET_DENSITY) "0.42"
