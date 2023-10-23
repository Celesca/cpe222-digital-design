`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2023 12:31:56 AM
// Design Name: 
// Module Name: top_module
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module top_module(
    input clock_in,
    input [0:0] sw,
    output [6:0] seg,
    output [3:0] an,
    output dg1
    );
    wire clock_out;
    wire [3:0] q;
    divider div(clock_in, clock_out);
    counter count(clock_out, sw[0:0], q[3:0]);
    bcdto7seg bcd(q[3:0], seg[6:0]);
    assign dg1 = 1; 
    assign an[3:0] = 4'b1110;

endmodule