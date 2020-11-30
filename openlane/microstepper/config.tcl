set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) microstepper_top

set ::env(PDN_CFG) $script_dir/pdn.tcl
set ::env(_SPACING) 1.6
set ::env(_WIDTH) 3

set power_domains [list {vccd1 vssd1} {vccd2 vssd2} {vdda1 vssa1} {vdda2 vssa2}]

set ::env(_VDD_NET_NAME) vccd1
set ::env(_GND_NET_NAME) vssd1
set ::env(_V_OFFSET) 14
set ::env(_H_OFFSET) $::env(_V_OFFSET)
set ::env(_V_PITCH) 180
set ::env(_H_PITCH) 180
set ::env(_V_PDN_OFFSET) 0
set ::env(_H_PDN_OFFSET) 0

set ::env(STD_CELL_LIBRARY) "sky130_fd_sc_hvl"

set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_PERIOD) "15"

set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 1500 1500"
set ::env(DESIGN_IS_CORE) 0

#set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg

set ::env(PL_BASIC_PLACEMENT) 1
set ::env(FP_CORE_UTIL) "40"
set ::env(PL_TARGET_DENSITY) "0.42"

set ::env(VERILOG_FILES) "\
        $script_dir/../../rapcores/src/microstepper/microstepper_top.v \
        $script_dir/../../rapcores/src/microstepper/microstep_counter.v \
        $script_dir/../../rapcores/src/microstepper/cosine.v \
        $script_dir/../../rapcores/src/microstepper/mytimer.v"

set ::env(VERILOG_FILES_BLACKBOX) "\
	$script_dir/../../rapcores/src/microstepper/analog_out.v \
        $script_dir/../../rapcores/src/microstepper/chargepump.v"

set ::env(EXTRA_LEFS) "\
	$script_dir/../../lef/analog_out.lef \
	$script_dir/../../lef/chargepump.lef"

set ::env(EXTRA_GDS_FILES) "\
	$script_dir/../../gds/analog_out.gds \
	$script_dir/../../gds/chargepump.gds"

