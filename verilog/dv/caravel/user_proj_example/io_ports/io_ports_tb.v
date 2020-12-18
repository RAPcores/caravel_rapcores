`default_nettype none

`timescale 1 ns / 1 ps

//`define USE_POWER_PINS

`ifdef GL
  `include "gl/rapcores.v"
`else
  `include "rapcores.v"
  `include "defines.v"
  `include "mpw_one_defines.v"
  `include "macro_params.v"
  `include "constants.v"
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
  `include "hbridge_coil.v"
  `include "pwm_duty.v"
`endif

`include "caravel.v"
`include "spiflash.v"

module io_ports_tb;
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
			repeat (4000) @(posedge clock);
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


    reg                 step;
    reg                 dir;
    reg                 enable_in;
    wire        [12:0]  target_current1;
    wire        [12:0]  target_current2;
    wire signed  [12:0]  current1;
    wire signed  [12:0]  current2;

	wire analog_out1;
	wire analog_out2;
    reg             analog_cmp1;
    reg             analog_cmp2;
    reg     [40:0]  step_clock;
    reg     [20:0]  cnt;
    reg     [12:0]  current_abs1;
    reg     [12:0]  current_abs2;
    wire            phase_a1_l;
    wire            phase_a2_l;
    wire            phase_b1_l;
    wire            phase_b2_l;
    wire            phase_a1_h;
    wire            phase_a2_h;
    wire            phase_b1_h;
    wire            phase_b2_h;
	wire 			resetn;

//	assign CHARGEPUMP		= mprj_io[15];
	assign analog_out1		= mprj_io[27];
	assign analog_out2		= mprj_io[28];
	assign phase_a1_l			= mprj_io[23];
	assign phase_a2_l			= mprj_io[19];
	assign phase_b1_l			= mprj_io[16];
	assign phase_b2_l			= mprj_io[20];
	assign phase_a1_h		= mprj_io[21];
	assign phase_a2_h		= mprj_io[18];
	assign phase_b1_h		= mprj_io[14];
	assign phase_b2_h		= mprj_io[17];
//	assign BUFFER_DTR		= mprj_io[37];
//	assign MOVE_DONE		= mprj_io[24];
//	assign CIPO				= mprj_io[36];
//	assign STEPOUTPUT		= mprj_io[30];
//	assign DIROUTPUT		= mprj_io[31];
	assign mprj_io[25]		= analog_cmp1;
	assign mprj_io[26]		= analog_cmp2;
//	assign mprj_io[18]		= ENC_B;
//	assign mprj_io[19]		= ENC_A;
//	assign mprj_io[29]		= HALT;
//	assign mprj_io[35]		= SCK;
//	assign mprj_io[34]		= CS;
//	assign mprj_io[22]		= COPI;
	assign mprj_io[32]		= step;
	assign mprj_io[33]		= dir;
	assign resetn = RSTB;

    always @(posedge clock) begin
        if (!resetn) begin
            cnt <= 0;
            analog_cmp1 <= 1;
            analog_cmp2 <= 1;
            step <= 1;
            step_clock <= 40'b0;
        end
        else begin
            cnt <= cnt + 1;
            enable_in <= 1;
            if (current1[12] == 1'b1) begin
                current_abs1 = -current1;
            end
            else begin
                current_abs1 = current1;
            end
            if (current2[12] == 1'b1) begin
                current_abs2 = -current2;
            end
            else begin
                current_abs2 = current2;
            end
            step_clock <= step_clock + 1;
            step <= step_clock[10];
            analog_cmp1 <= (current_abs1[11:0] >= target_current1[11:0]); // compare unsigned
            analog_cmp2 <= (current_abs2[11:0] >= target_current2[11:0]);
            if (cnt <= 20'hC400) begin
                dir <= 1;
            end
            else
                dir <= 0;
        end
    end

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

    pwm_duty duty1(
        .clk(clock),
        .resetn(resetn),
        .pwm(analog_out1),
        .duty(target_current1)
    );
    pwm_duty duty2(
        .clk(clock),
        .resetn(resetn),
        .pwm(analog_out2),
        .duty(target_current2)
    );
    hbridge_coil hbridge_coil1(
        .clk(clock),
        .resetn(resetn),
        .low_1(phase_a1_l),
        .high_1(phase_a1_h),
        .low_2(phase_a2_l),
        .high_2(phase_a2_h),
        .current(current1),
        .polarity_invert_config(1'b0)
    );
    hbridge_coil hbridge_coil2(
        .clk(clock),
        .resetn(resetn),
        .low_1(phase_b1_l),
        .high_1(phase_b1_h),
        .low_2(phase_b2_l),
        .high_2(phase_b2_h),
        .current(current2),
        .polarity_invert_config(1'b0)
    );
endmodule
`default_nettype wire
