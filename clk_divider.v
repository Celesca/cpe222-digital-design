`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2023 07:08:43 PM
// Design Name: 
// Module Name: clk_divider
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


module clk_divider(
    input clk,
    input reset,
    output reg sclk
    );
reg [31:0] count;
always@(posedge clk or negedge reset)
begin
if(reset == 1'b0) begin
    count <= 32'd0;
sclk <= 1'b0;
end else begin
if(count == 32'd9000000) begin
    count <= 32'd0;
sclk <= ~sclk;
end else begin
    count <= count + 1;
end
end
end
endmodule

