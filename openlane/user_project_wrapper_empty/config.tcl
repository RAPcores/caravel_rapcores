set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) user_project_wrapper
set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg
set ::env(FP_DEF_TEMPLATE) $script_dir/../../def/user_project_wrapper_empty.def

#set ::env(PDN_CFG) $script_dir/pdn.tcl

set ::env(SYNTH_NO_FLAT) 1
set ::env(SYNTH_SCRIPT) $script_dir/synth.tcl
#set ::env(SYNTH_STRATEGY) 3

set ::env(FP_PDN_CORE_RING) 1
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 2920 3520"

set ::env(DESIGN_IS_CORE) 1

set ::unit 2.4
set ::env(FP_IO_VEXTEND) [expr 2*$::unit]
set ::env(FP_IO_HEXTEND) [expr 2*$::unit]
set ::env(FP_IO_VLENGTH) $::unit
set ::env(FP_IO_HLENGTH) $::unit

set ::env(FP_IO_VTHICKNESS_MULT) 4
set ::env(FP_IO_HTHICKNESS_MULT) 4

set ::env(CLOCK_PORT) "wb_clk_i"
set ::env(CLOCK_PERIOD) "15"

#set ::env(GLB_RT_ALLOW_CONGESTION) 1
#set ::env(PL_RANDOM_GLB_PLACEMENT) 1

set ::env(PL_OPENPHYSYN_OPTIMIZATIONS) 1
set ::env(DIODE_INSERTION_STRATEGY) 3

set ::env(ROUTING_CORES) 6

# Need to fix a FastRoute bug for this to work, but it's good
# for a sense of "isolation"
set ::env(MAGIC_ZEROIZE_ORIGIN) 0
set ::env(MAGIC_WRITE_FULL_LEF) 1

set ::env(LVS_INSERT_POWER_PINS) 1

#set ::env(FP_CORE_UTIL) 15
#set ::env(CELL_PAD) 4
set ::env(PL_TARGET_DENSITY) 0.02
#set ::env(PL_SKIP_INITIAL_PLACEMENT) 0
#set ::env(GLB_RT_OVERFLOW_ITERS) 300
#set ::env(GLB_RT_ADJUSTMENT) 0
#set ::env(GLB_RT_TILES) 14
#set ::env(DIODE_INSERTION_STRATEGY) 3
#set ::env(GLB_RT_MAX_DIODE_INS_ITERS) 500
set ::env(PL_RESIZER_OVERBUFFER) 1

set ::env(VERILOG_FILES) "\
    $script_dir/../../verilog/rtl/defines.v \
    $script_dir/../../rapcores/src/constants.v \
    $script_dir/../../rapcore_caravel_defines.v \
    $script_dir/../../rapcores/src/macro_params.v \
    $script_dir/../../rapcores/src/spi_state_machine.v \
    $script_dir/../../rapcores/src/dda_timer.v \
    $script_dir/../../rapcores/src/stepper.v \
    $script_dir/../../rapcores/src/spi.v \
    $script_dir/../../rapcores/src/quad_enc.v \
    $script_dir/../../rapcores/src/pwm.v \
    $script_dir/../../rapcores/src/microstepper/microstepper_control.v \
    $script_dir/../../rapcores/src/microstepper/microstepper_top.v \
    $script_dir/../../rapcores/src/microstepper/microstep_counter.v \
    $script_dir/../../rapcores/src/microstepper/cosine.v \
    $script_dir/../../rapcores/src/microstepper/analog_out.v \
    $script_dir/../../rapcores/src/microstepper/chargepump.v \
    $script_dir/../../rapcores/src/microstepper/mytimer.v \
    $script_dir/../../rapcores/src/microstepper/mytimer_8.v \
    $script_dir/../../rapcores/src/microstepper/mytimer_10.v \
    $script_dir/../../rapcores/src/rapcore.v \
    $script_dir/../../verilog/rtl/user_project_wrapper.v"
