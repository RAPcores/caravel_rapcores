set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) user_project_wrapper
set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg

set ::env(PDN_CFG) $script_dir/pdn.tcl
set ::env(FP_PDN_CORE_RING) 1
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 2920 3520"

set ::env(DESIGN_IS_CORE) 1
#set ::env(SYNTH_READ_BLACKBOX_LIB) 1

set ::unit 2.4
set ::env(FP_IO_VEXTEND) [expr 2*$::unit]
set ::env(FP_IO_HEXTEND) [expr 2*$::unit]
set ::env(FP_IO_VLENGTH) $::unit
set ::env(FP_IO_HLENGTH) $::unit

set ::env(FP_IO_VTHICKNESS_MULT) 4
set ::env(FP_IO_HTHICKNESS_MULT) 4

set ::env(CLOCK_PORT) "wb_clk_i"
set ::env(CLOCK_PERIOD) "15"

set ::env(CLOCK_PORT) "user_clock2"
set ::env(CLOCK_NET) "mprj.clk"

set ::env(CLOCK_PERIOD) "10"

set ::env(PL_OPENPHYSYN_OPTIMIZATIONS) 0
set ::env(DIODE_INSERTION_STRATEGY) 3

set ::env(ROUTING_CORES) 6

# Need to fix a FastRoute bug for this to work, but it's good
# for a sense of "isolation"
set ::env(MAGIC_ZEROIZE_ORIGIN) 0
set ::env(MAGIC_WRITE_FULL_LEF) 1

set ::env(VERILOG_FILES) "\
    $script_dir/../../verilog/rtl/defines.v \
    $script_dir/../../verilog/rtl/user_project_wrapper.v"

set ::env(VERILOG_FILES_BLACKBOX) "\
    $script_dir/../../verilog/rtl/defines.v \
    $script_dir/../../rapcore_caravel_defines.v \
    $script_dir/../../rapcores/src/macro_params.v \
    $script_dir/../../rapcores/src/constants.v \
    $script_dir/../../verilog/rtl/rapcore_caravel.v"

set ::env(EXTRA_LEFS) "\
	$script_dir/../../lef/rapcore.lef"

set ::env(EXTRA_GDS_FILES) "\
	$script_dir/../../gds/rapcore.gds"

#set ::env(GLB_RT_OBS) "met4 1150 1700 1690 2240"

