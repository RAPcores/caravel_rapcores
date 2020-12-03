set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) microstepper_top


#set ::env(ROUTING_CORES) 6
#set ::env(PDN_CFG) $script_dir/pdn.tcl
#set ::env(_SPACING) 1.6
#set ::env(_WIDTH) 3
#set power_domains [list {vccd1 vssd1} {vccd2 vssd2} {vdda1 vssa1} {vdda2 vssa2}]

set ::env(_VDD_NET_NAME) vccd1
set ::env(_GND_NET_NAME) vssd1
#set ::env(_V_OFFSET) 14
#set ::env(_H_OFFSET) $::env(_V_OFFSET)
#set ::env(_V_PITCH) 180
#set ::env(_H_PITCH) 180
#set ::env(_V_PDN_OFFSET) 0
#set ::env(_H_PDN_OFFSET) 0

set ::env(CLOCK_PORT) "clk"
set ::env(CLOCK_PERIOD) "10"

set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 380 300"
set ::env(DESIGN_IS_CORE) 0

#set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg
set ::env(SYNTH_READ_BLACKBOX_LIB) 1

#set ::env(PL_BASIC_PLACEMENT) 0
set ::env(GLB_RT_ALLOW_CONGESTION) 1
#set ::env(FP_CORE_UTIL) 9
#set ::env(PL_TARGET_DENSITY) 0.40
#set ::env(PL_RANDOM_GLB_PLACEMENT) 0
#set ::env(PL_SKIP_INITIAL_PLACEMENT) 0
#set ::env(CELL_PAD) 6

set ::env(GLB_RT_MAXLAYER) 5
set ::env(GLB_RT_MINLAYER) 2
set ::env(GLB_RT_OBS) "met5 0 0 1000 1000"
set ::env(CLOCK_TREE_SYNTH) 0
#set ::env(DIODE_INSERTION_STRATEGY) 0

#set ::env(FP_HORIZONTAL_HALO) 60
#set ::env(FP_VERTICAL_HALO) 60

set ::env(MACRO_PLACEMENT_CFG) $script_dir/macro_placement.cfg


set verilog_root $script_dir/../../rapcores/src/microstepper
set lef_root $script_dir/../../lef
set gds_root $script_dir/../../gds

set ::env(VERILOG_FILES) "\
	$verilog_root/microstepper_top.v"

set ::env(VERILOG_FILES_BLACKBOX) "\
	$verilog_root/microstepper_control.v \
	$verilog_root/analog_out.v \
	$verilog_root/microstep_counter.v \
	$verilog_root/mytimer_8.v \
	$verilog_root/mytimer_10.v \
	$verilog_root/cosine.v \
    $verilog_root/chargepump.v"

set ::env(EXTRA_LEFS) "\
	$lef_root/microstepper_control.lef \
	$lef_root/analog_out.lef \
	$lef_root/microstep_counter.lef \
	$lef_root/mytimer_8.lef \
	$lef_root/mytimer_10.lef \
	$lef_root/cosine.lef \
	$lef_root/chargepump.lef"

set ::env(EXTRA_GDS_FILES) "\
	$gds_root/microstepper_control.gds \
	$gds_root/analog_out.gds \
	$gds_root/microstep_counter.gds \
	$gds_root/mytimer_8.gds \
	$gds_root/mytimer_10.gds \
	$gds_root/cosine.gds \
	$gds_root/chargepump.gds"

