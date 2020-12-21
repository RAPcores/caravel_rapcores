`default_nettype none

`timescale 1 ns / 1 ps

`include "defines.v"
`include "mpw_one_defines.v"
`include "macro_params.v"
`include "constants.v"

`include "caravel.v"
`include "spiflash.v"

`ifdef PROJ_GL
  `include "rapcores.lvs.powered.v"
`else
	`include "quad_enc.v"
	`include "spi.v"
	`include "dda_timer.v"
	`include "spi_state_machine.v"
	`include "microstepper/chargepump.v"
	`include "microstepper/microstepper_control.v"
	`include "microstepper/mytimer_8.v"
	`include "microstepper/mytimer_10.v"
	`include "microstepper/microstep_counter.v"
	`include "microstepper/cosine.v"
	`include "microstepper/analog_out.v"
	`include "microstepper/microstepper_top.v"
	`include "rapcore.v"
	`include "rapcores.v"
`endif

`include "hbridge_coil.v"
`include "pwm_duty.v"
`include "rapcore_harness_tb.v"

module io_ports_tb;
	reg clock;
	reg RSTB;
	reg CSB;
	reg boot_done;
	reg power1, power2;
	reg power3, power4;

    wire gpio;
	wire [37:0] mprj_io;
	wire [7:0] mprj_io_0;

	assign mprj_io_0 = mprj_io[9:5];
	//assign mprj_io[3] = (CSB == 1'b1) ? 1'b1 : 1'bz;
	assign _3_HK_CSB = (CSB == 1'b1) ? 1'b1 : 1'bz;
	assign mprj_io = { _0_JTAG_IO, _1_HK_SDO, _2_HK_SDI, _3_HK_CSB, _4_HK_SCK, _5_RX, _6_TX, _7_IRQ, _8_UNUSED1, _9_UNUSED2, _10_ENOUTPUT, _11_ENINPUT, _12_ENC_B, _13_ENC_A, _14_PHASE_B1_H, _15_CHARGEPUMP, _16_PHASE_B1, _17_PHASE_B2_H, _18_PHASE_A2_H, _19_PHASE_A2, _20_PHASE_B2, _21_PHASE_A1_H, _22_COPI, _23_PHASE_A1, _24_MOVE_DONE, _25_analog_cmp1, _26_analog_cmp2, _27_analog_out1, _28_analog_out2, _29_HALT, _30_STEPOUTPUT, _31_DIROUTPUT, _32_STEPINPUT, _33_DIRINPUT, _34_CS, _35_SCK, _36_CIPO, _37_BUFFER_DTR };

	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.

	always #12.5 clock <= (clock === 1'b0);

	initial begin
		clock = 0;
	end

	initial begin
		$dumpfile("io_ports.vcd");
		$dumpvars(0, io_ports_tb);

		// Repeat cycles of 1000 clock edges as needed to complete testbench
		repeat (25) begin
			repeat (4000) @(posedge clock);
			// $display("+1000 cycles");
		end
		$display("%c[1;31m",27);
		`ifdef PROJ_GL
			$display("Monitor: Timeout, Test Mega-Project IO Ports  (PROJ_GL) Passed");
		`else
			$display("Monitor: Timeout, Test Mega-Project IO Ports  (RTL) Passed");
		`endif
		$display("%c[0m",27);
		$finish;
	end

	initial begin
		// Observe Output pins [9:5]
		wait(mprj_io_0 == 5'h01);
		wait(mprj_io_0 == 5'h02);
		wait(mprj_io_0 == 5'h03);
		wait(mprj_io_0 == 5'h04);
		wait(mprj_io_0 == 5'h05);
		wait(mprj_io_0 == 5'h06);
		wait(mprj_io_0 == 5'h07);
		wait(mprj_io_0 == 5'h08);
		wait(mprj_io_0 == 5'h09);
		wait(mprj_io_0 == 5'h0A);
		wait(mprj_io_0 == 5'h1F);
		wait(mprj_io_0 == 5'h00);
		`ifdef PROJ_GL
			$display("Monitor: Test 1 Mega-Project IO (RTL) Passed");
		`else
			$display("Monitor: Test 1 Mega-Project IO (RTL) Passed");
		`endif
		$finish;
	end

	// Power-up sequence
	initial begin
		RSTB <= 1'b0;
		boot_done = 1'b0;
		#2000;
		RSTB <= 1'b1;	    // Release reset
		#170000;
		CSB = 1'b0;		// CSB can be released
		#320000;
		boot_done = 1'b1;
	end

	initial begin		// Power-up sequence
		power1 <= 1'b0;
		power2 <= 1'b0;
		power3 <= 1'b0;
		power4 <= 1'b0;
		#100;
		power1 <= 1'b1;
		#100;
		power2 <= 1'b1;
		#100;
		power3 <= 1'b1;
		#100;
		power4 <= 1'b1;
	end

	always @(mprj_io) begin
		#1 $display("MPRJ-IO state = %b ", mprj_io[37:0]);
	end

	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;

	wire VDD3V3 = power1;
	wire VDD1V8 = power2;
	wire USER_VDD3V3 = power3;
	wire USER_VDD1V8 = power4;
	wire VSS = 1'b0;
	
	reg step = 0;
	wire step_sig = step;
	always #50000 step <= boot_done ? ~step : 1'b0;

	wire _0_JTAG_IO, _1_HK_SDO, _2_HK_SDI, _3_HK_CSB, _4_HK_SCK, _5_RX, _6_TX, _7_IRQ, _8_UNUSED1, _9_UNUSED2, _10_ENOUTPUT, _11_ENINPUT, _12_ENC_B, _13_ENC_A, _14_PHASE_B1_H, _15_CHARGEPUMP, _16_PHASE_B1, _17_PHASE_B2_H, _18_PHASE_A2_H, _19_PHASE_A2, _20_PHASE_B2, _21_PHASE_A1_H, _22_COPI, _23_PHASE_A1, _24_MOVE_DONE, _25_analog_cmp1, _26_analog_cmp2, _27_analog_out1, _28_analog_out2, _29_HALT, _30_STEPOUTPUT, _31_DIROUTPUT, _32_STEPINPUT, _33_DIRINPUT, _34_CS, _35_SCK, _36_CIPO, _37_BUFFER_DTR;


	assign _32_STEPINPUT = step;
	wire fake_step_input;
	wire harness_resetn_output;


    reg                 dir;
    reg                 enable_in;
    wire        [12:0]  target_current1;
    wire        [12:0]  target_current2;
    wire signed  [12:0]  current1;
    wire signed  [12:0]  current2;

	//assign resetn = RSTB;

  rapcore_harness harness0 (
    .CLK(clock),
    .resetn_in(harness_resetn_output),
	.BOOT_DONE_IN(boot_done),

	.CHARGEPUMP(_15_CHARGEPUMP),
	.analog_cmp1(_25_analog_cmp1),
	.analog_out1(_27_analog_out1),
	.analog_cmp2(_26_analog_cmp2),
	.analog_out2(_28_analog_out2),
	.PHASE_A1(_23_PHASE_A1),
	.PHASE_A2(_19_PHASE_A2),
	.PHASE_B1(_16_PHASE_B1),
	.PHASE_B2(_20_PHASE_B2),
	.PHASE_A1_H(_21_PHASE_A1_H),
	.PHASE_A2_H(_18_PHASE_A2_H),
	.PHASE_B1_H(_14_PHASE_B1_H),
	.PHASE_B2_H(_17_PHASE_B2_H),
	.ENC_B(_12_ENC_B),
	.ENC_A(_13_ENC_A),
	.BUFFER_DTR(_37_BUFFER_DTR),
	.MOVE_DONE(_24_MOVE_DONE),
	.HALT(_29_HALT),
	.SCK(_35_SCK),
	.CS(_34_CS),
	.COPI(_22_COPI),
	.CIPO(_36_CIPO),
	.STEPOUTPUT(_30_STEPOUTPUT),
	.DIROUTPUT(_31_DIROUTPUT),
	.STEPINPUT(fake_step_input),
	.DIRINPUT(_33_DIRINPUT),
	.ENINPUT(_11_ENINPUT),
	.ENOUTPUT(_10_ENOUTPUT)
  );

	caravel uut (
		.vddio	  (VDD3V3),
		.vssio	  (VSS),
		.vdda	  (VDD3V3),
		.vssa	  (VSS),
		.vccd	  (VDD1V8),
		.vssd	  (VSS),
		.vdda1    (USER_VDD3V3),
		.vdda2    (USER_VDD3V3),
		.vssa1	  (VSS),
		.vssa2	  (VSS),
		.vccd1	  (USER_VDD1V8),
		.vccd2	  (USER_VDD1V8),
		.vssd1	  (VSS),
		.vssd2	  (VSS),
		.clock	  (clock),
		.gpio     (gpio),
    .mprj_io  ( { 
      			_0_JTAG_IO,
			_1_HK_SDO,
			_2_HK_SDI,
			_3_HK_CSB,
			_4_HK_SCK,
			_5_RX,
			_6_TX,
			_7_IRQ,
			_8_UNUSED1,
			_9_UNUSED2,
			_10_ENOUTPUT,
			_11_ENINPUT,
			_12_ENC_B,
			_13_ENC_A,
			_14_PHASE_B1_H,
			_15_CHARGEPUMP,
			_16_PHASE_B1,
			_17_PHASE_B2_H,
			_18_PHASE_A2_H,
			_19_PHASE_A2,
			_20_PHASE_B2,
			_21_PHASE_A1_H,
			_22_COPI,
			_23_PHASE_A1,
			_24_MOVE_DONE,
			_25_analog_cmp1,
			_26_analog_cmp2,
			_27_analog_out1,
			_28_analog_out2,
			_29_HALT,
			_30_STEPOUTPUT,
			_31_DIROUTPUT,
			_32_STEPINPUT,
			_33_DIRINPUT,
			_34_CS,
			_35_SCK,
			_36_CIPO,
			_37_BUFFER_DTR
			} ),
		.flash_csb(flash_csb),
		.flash_clk(flash_clk),
		.flash_io0(flash_io0),
		.flash_io1(flash_io1),
		.resetb	  (RSTB)
	);


	spiflash #(
		.FILENAME("io_ports.hex")
	) spiflash (
		.csb(flash_csb),
		.clk(flash_clk),
		.io0(flash_io0),
		.io1(flash_io1),
		.io2(),			// not used
		.io3()			// not used
	);

endmodule
`default_nettype wire
