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
    inout wire vdda1,	// User area 1 3.3V supply
    inout wire vdda2,	// User area 2 3.3V supply
    inout wire vssa1,	// User area 1 analog ground
    inout wire vssa2,	// User area 2 analog ground
    inout wire vccd1,	// User area 1 1.8V supply
    inout wire vccd2,	// User area 2 1.8v supply
    inout wire vssd1,	// User area 1 digital ground
    inout wire vssd2,	// User area 2 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wire wb_clk_i,
    input wire wb_rst_i,
    input wire wbs_stb_i,
    input wire wbs_cyc_i,
    input wire wbs_we_i,
    input wire [3:0] wbs_sel_i,
    input wire [31:0] wbs_dat_i,
    input wire [31:0] wbs_adr_i,
    output wire wbs_ack_o,
    output wire [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  wire [127:0] la_data_in,
    output wire [127:0] la_data_out,
    input  wire [127:0] la_oen,

    // IOs
    input  wire [`MPRJ_IO_PADS-1:0] io_in,
    output wire [`MPRJ_IO_PADS-1:0] io_out,
    output wire [`MPRJ_IO_PADS-1:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7.
    inout wire [`MPRJ_IO_PADS-8:0] analog_io,

    // Independent clock (on independent integer divider)
    input wire user_clock2
);


    assign io_oeb[15] = vssd1;    // CHARGEPUMP
    assign io_oeb[25] = vccd1;    // analog_cmp1
    assign io_oeb[27] = vssd1;    // analog_out1
    assign io_oeb[26] = vccd1;    // analog_cmp2
    assign io_oeb[28] = vssd1;    // analog_out2
    assign io_oeb[23] = vssd1;    // PHASE_A1
    assign io_oeb[19] = vssd1;    // PHASE_A2
    assign io_oeb[16] = vssd1;    // PHASE_B1
    assign io_oeb[20] = vssd1;    // PHASE_B2
    assign io_oeb[21] = vssd1;    // PHASE_A1_H
    assign io_oeb[18] = vssd1;    // PHASE_A2_H
    assign io_oeb[14] = vssd1;    // PHASE_B1_H
    assign io_oeb[17] = vssd1;    // PHASE_B2_H
    assign io_oeb[18] = vccd1;    // ENC_B
    assign io_oeb[19] = vccd1;    // ENC_A
    assign io_oeb[12] = vssd1;    // BUFFER_DTR
    assign io_oeb[24] = vssd1;    // MOVE_DONE
    assign io_oeb[29] = vccd1;    // HALT
    assign io_oeb[10] = vccd1;    // SCK
    assign io_oeb[9] = vccd1;     // CS
    assign io_oeb[8] = vccd1;     // COPI
    assign io_oeb[11] = vssd1;    // CIPO
    assign io_oeb[30] = vssd1;    // STEPOUTPUT
    assign io_oeb[31] = vssd1;    // DIROUTPUT
    assign io_oeb[32] = vccd1;    // STEPINPUT
    assign io_oeb[33] = vccd1;    // DIRINPUT
    // unused
    assign io_oeb[0] = vccd1;    // JTAG I/O
    assign io_oeb[1] = vccd1;    // SDO
    assign io_oeb[2] = vccd1;    // SDI
    assign io_oeb[3] = vccd1;    // CSB
    assign io_oeb[4] = vccd1;    // SCK
    assign io_oeb[5] = vccd1;    // Rx
    assign io_oeb[6] = vccd1;    // Tx
    assign io_oeb[7] = vccd1;    // IRQ
    assign io_oeb[13] = vccd1;
    assign io_oeb[22] = vccd1;
    assign io_oeb[34] = vccd1;
    assign io_oeb[35] = vccd1;
    assign io_oeb[36] = vccd1;
    assign io_oeb[37] = vccd1;

    /*--------------------------------------*/
    /* User project is instantiated  here   */
    /*--------------------------------------*/

    rapcore rapcore0 (
        //power
        .vccd1(vccd1),	// User area 1 1.8V supply
        //.vccd2(vccd2),	// User area 2 1.8v supply
        .vssd1(vssd1),	// User area 1 digital ground
        //.vssd2(vssd2),	// User area 2 digital ground


        // IO Pads
        .CLK(wb_clk_i),
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
        .CIPO(io_out[11]),
        .STEPOUTPUT(io_out[30]),
        .DIROUTPUT(io_out[31]),
        .STEPINPUT(io_in[32]),
        .DIRINPUT(io_in[33]),
        .resetn_in(~wb_rst_i)
    );

endmodule	// user_project_wrapper
`ifdef SIM
(* blackbox *)
module rapcore(
  output BUFFER_DTR,
  output CHARGEPUMP,
  output CIPO,
  input CLK,
  input COPI,
  input CS,
  input DIRINPUT,
  output DIROUTPUT,
  input ENC_A,
  input ENC_B,
  input ENINPUT,
  output ENOUTPUT,
  input HALT,
  output MOVE_DONE,
  output PHASE_A1,
  output PHASE_A1_H,
  output PHASE_A2,
  output PHASE_A2_H,
  output PHASE_B1,
  output PHASE_B1_H,
  output PHASE_B2,
  output PHASE_B2_H,
  input analog_cmp1,
  input analog_cmp2,
  output analog_out1,
  output analog_out2,
  input SCK,
  input STEPINPUT,
  output STEPOUTPUT,
  input resetn_in,
  input vccd1,
  //input vccd2,
  input vssd1);
  //input vssd2

endmodule
`endif

`default_nettype wire
