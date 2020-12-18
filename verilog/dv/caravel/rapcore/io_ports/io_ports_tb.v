// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none

`timescale 1 ns / 1 ps

`include "caravel.v"
`include "spiflash.v"

module io_ports_tb(output COPI);
	reg clock;
    reg RSTB;
	reg power1, power2;
	reg power3, power4;

    	wire gpio;
    	wire [37:0] mprj_io;
	wire [7:0] mprj_io_0;

	assign mprj_io_0 = mprj_io[7:0];

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
			repeat (1000) @(posedge clock);
			// $display("+1000 cycles");
		end
		$display("%c[1;31m",27);
		$display ("Monitor: Timeout, Test Mega-Project IO Ports (RTL) Failed");
		$display("%c[0m",27);
		$finish;
	end

	initial begin
	    // Observe Output pins [7:0]
	    wait(mprj_io_0 == 8'h01);
	    wait(mprj_io_0 == 8'h02);
	    wait(mprj_io_0 == 8'h03);
    	    wait(mprj_io_0 == 8'h04);
	    wait(mprj_io_0 == 8'h05);
            wait(mprj_io_0 == 8'h06);
	    wait(mprj_io_0 == 8'h07);
            wait(mprj_io_0 == 8'h08);
	    wait(mprj_io_0 == 8'h09);
            wait(mprj_io_0 == 8'h0A);
	    wait(mprj_io_0 == 8'hFF);
	    wait(mprj_io_0 == 8'h00);

	    $display("Monitor: Test 1 Mega-Project IO (RTL) Passed");
	    $finish;
	end

	initial begin
		RSTB <= 1'b0;
		#2000;
		RSTB <= 1'b1;	    // Release reset
	end

	initial begin		// Power-up sequence
		power1 <= 1'b0;
		power2 <= 1'b0;
		power3 <= 1'b0;
		power4 <= 1'b0;
		#200;
		power1 <= 1'b1;
		#200;
		power2 <= 1'b1;
		#200;
		power3 <= 1'b1;
		#200;
		power4 <= 1'b1;
	end

	always @(mprj_io) begin
		#1 $display("MPRJ-IO state = %b ", mprj_io[7:0]);
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
        .mprj_io  (mprj_io),
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

  `ifdef SPI_INTERFACE
    wire SCK = mprj_io[10];
    wire CS = mprj_io[9];
    wire COPI = mprj_io[8];
    wire CIPO = mprj_io[11];
  `endif
  `ifdef ULTIBRIDGE
    wire CHARGEPUMP = mprj_io[15];
    wire analog_cmp1 = mprj_io[25];
    wire analog_out1 = mprj_io[27];
    wire analog_cmp2 = mprj_io[26];
    wire analog_out2 = mprj_io[28];
    wire PHASE_A1 = mprj_io[23];  // Phase A
    wire PHASE_A2 = mprj_io[19];  // Phase A
    wire PHASE_B1 = mprj_io[16];  // Phase B
    wire PHASE_B2 = mprj_io[20];  // Phase B
    wire PHASE_A1_H = mprj_io[21];  // Phase A
    wire PHASE_A2_H = mprj_io[18];  // Phase A
    wire PHASE_B1_H = mprj_io[14];  // Phase B
    wire PHASE_B2_H = mprj_io[17];  // Phase B
  `endif
  `ifdef QUAD_ENC
    wire ENC_B;
    wire ENC_A;
  `endif
  `ifdef BUFFER_DTR
    wire BUFFER_DTR;
  `endif
  `ifdef MOVE_DONE
    wire MOVE_DONE;
  `endif
  `ifdef HALT
    wire HALT = mprj_io[29];
  `endif
  `ifdef STEPINPUT
    wire STEPINPUT;
    wire DIRINPUT;
    wire ENINPUT;
  `endif
  `ifdef STEPOUTPUT
    wire STEPOUTPUT;
    wire ENOUTPUT;
    wire DIROUTPUT;
  `endif
  `ifdef LA_IN
    wire LA_IN;
  `endif
  `ifdef LA_OUT
    wire LA_OUT;
  `endif
  `ifdef RESETN
    wire resetn_in;
  `endif
  wire CLK = clock;

  rapcore_harness harness0 (
      `ifdef LED
        .LED(LED),
      `endif
      `ifdef tinyfpgabx
        .USBPU(USBPU),  // USB pull-up resistor
      `endif
      `ifdef SPI_INTERFACE
        .SCK(SCK),
        .CS(CS),
        .COPI(COPI),
        .CIPO(CIPO),
      `endif
      `ifdef ULTIBRIDGE
        .CHARGEPUMP(CHARGEPUMP),
        .analog_cmp1(analog_cmp1),
        .analog_out1(analog_out1),
        .analog_cmp2(analog_cmp2),
        .analog_out2(analog_out2),
        .PHASE_A1(PHASE_A1),  // Phase A
        .PHASE_A2(PHASE_A2),  // Phase A
        .PHASE_B1(PHASE_B1),  // Phase B
        .PHASE_B2(PHASE_B2),  // Phase B
        .PHASE_A1_H(PHASE_A1_H),  // Phase A
        .PHASE_A2_H(PHASE_A2_H),  // Phase A
        .PHASE_B1_H(PHASE_B1_H),  // Phase B
        .PHASE_B2_H(PHASE_B2_H),  // Phase B
      `endif
      `ifdef QUAD_ENC
        .ENC_B(ENC_B),
        .ENC_A(ENC_A),
      `endif
      `ifdef BUFFER_DTR
        .BUFFER_DTR(BUFFER_DTR),
      `endif
      `ifdef MOVE_DONE
        .MOVE_DONE(MOVE_DONE),
      `endif
      `ifdef HALT
        .HALT(HALT),
      `endif
      `ifdef STEPINPUT
        .STEPINPUT(STEPINPUT),
        .DIRINPUT(DIRINPUT),
        .ENINPUT(ENINPUT),
      `endif
      `ifdef STEPOUTPUT
        .STEPOUTPUT(STEPOUTPUT),
        .ENOUTPUT(ENOUTPUT),
        .DIROUTPUT(DIROUTPUT),
      `endif
      `ifdef LA_IN
        .LA_IN(LA_IN),
      `endif
      `ifdef LA_OUT
        .LA_OUT(LA_OUT),
      `endif
      `ifdef RESETN
        .resetn_in(resetn_in),
      `endif
      .CLK(CLK)
  );

endmodule
`default_nettype wire
