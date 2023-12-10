`timescale 1ns / 1ps

module divider(
    input clock,
    output clock_out
    );
    reg elapsed;
    reg [27:0] state; 
    always @ (posedge clock)
    if (state == 100000000) state <= 0;
        else state <= state +1;
    always @(state)
    if (state == 100000000) elapsed = 1;
    else elapsed = 0;
    assign clock_out = elapsed;
endmodule
