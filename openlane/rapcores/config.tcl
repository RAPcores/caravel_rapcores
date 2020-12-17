set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) rapcores

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
        $script_dir/../../verilog/rtl/rapcores.v"

set ::env(CLOCK_PORT) "wb_clk_i"
set ::env(CLOCK_PERIOD) "15"

set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 650 650"

# use the empty wrapper to help pin placement
#set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg

# Some config for hardening
set ::env(DESIGN_IS_CORE) 0

# Diodes to fix violations
set ::env(DIODE_INSERTION_STRATEGY) 3

# We try to set the die size instead
#set ::env(PL_BASIC_PLACEMENT) 40
set ::env(PL_TARGET_DENSITY) 0.41
#set ::env(CELL_PAD) 0


# Routing
# -------

# Go fast
set ::env(ROUTING_CORES) 6
#set ::env(GLB_RT_ALLOW_CONGESTION) 1

set ::env(VDD_NETS) [list {vccd1} {vccd2} {vdda1} {vdda2}]
set ::env(GND_NETS) [list {vssd1} {vssd2} {vssa1} {vssa2}]

# block met5 with obstruction
set ::env(GLB_RT_OBS) "met5 0 0 1000 1000"
set ::env(GLB_RT_MAXLAYER) 5

set ::env(SYNTH_USE_PG_PINS_DEFINES) "USE_POWER_PINS"

# If you're going to use multiple power domains, then keep this disabled.
#set ::env(RUN_CVC) 0
