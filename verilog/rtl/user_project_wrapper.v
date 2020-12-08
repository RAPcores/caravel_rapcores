`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the user project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 *-------------------------------------------------------------
 */

module user_project_wrapper #(
    parameter BITS = 32
)(
`ifdef USE_POWER_PINS
    inout vdda1,	// User area 1 3.3V supply
    inout vdda2,	// User area 2 3.3V supply
    inout vssa1,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oen,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7.
    inout [`MPRJ_IO_PADS-8:0] analog_io,

    // Independent clock (on independent integer divider)
    input   user_clock2
);

    /*--------------------------------------*/
    /* User project is instantiated  here   */
    /*--------------------------------------*/
    rapcore rapcore0 (

        // IO Pads
        .CLK(clk),
        .CHARGEPUMP(io_out[15]),
        .analog_cmp1(io_in[25]),
        .analog_out1(io_out[27]),
        .analog_cmp2(io_in[26]),
        .analog_out2(io_out[28]),
        .PHASE_A1(io_out[23]),
        .PHASE_A2(io_out[19]),
        .PHASE_B1(io_out[16]),
        .PHASE_B2(io_out[20]),
        .PHASE_A1_H(io_out[21]),
        .PHASE_A2_H(io_out[18]),
        .PHASE_B1_H(io_out[14]),
        .PHASE_B2_H(io_out[17]),
        .ENC_B(io_in[18]),
        .ENC_A(io_in[19]),
        .BUFFER_DTR(io_out[12]),
        .MOVE_DONE(io_out[24]),
        .HALT(io_in[29]),
        .SCK(io_in[10]),
        .CS(io_in[9]),
        .COPI(io_in[8]),
        .CIPO(io_out[11])
    );
    /*
    user_proj_example mprj (
    `ifdef USE_POWER_PINS
	.vdda1(vdda1),	// User area 1 3.3V power
	.vdda2(vdda2),	// User area 2 3.3V power
	.vssa1(vssa1),	// User area 1 analog ground
	.vssa2(vssa2),	// User area 2 analog ground
	.vccd1(vccd1),	// User area 1 1.8V power
	.vccd2(vccd2),	// User area 2 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
	.vssd2(vssd2),	// User area 2 digital ground
    `endif

	// MGMT core clock and reset

    	.wb_clk_i(wb_clk_i),
    	.wb_rst_i(wb_rst_i),

	// MGMT SoC Wishbone Slave

	.wbs_cyc_i(wbs_cyc_i),
	.wbs_stb_i(wbs_stb_i),
	.wbs_we_i(wbs_we_i),
	.wbs_sel_i(wbs_sel_i),
	.wbs_adr_i(wbs_adr_i),
	.wbs_dat_i(wbs_dat_i),
	.wbs_ack_o(wbs_ack_o),
	.wbs_dat_o(wbs_dat_o),

	// Logic Analyzer

	.la_data_in(la_data_in),
	.la_data_out(la_data_out),
	.la_oen (la_oen),

	// IO Pads

	.io_in (io_in),
    	.io_out(io_out),
    	.io_oeb(io_oeb)
    );
    */

endmodule	// user_project_wrapper
`default_nettype wire
