`timescale 1ns / 1ps

module topmodule (
    input clk,        // System clock input
    input btn,        // Zebra crossing signal input
    output reg [15:0] led,  // Road and zebra crossing LEDs
    output reg [6:0] segment,  // 7-segment display
    output reg [3:0] an,        // 7-segment display anodes
    output reg dp           // 7-segment display decimal point
);

    wire divider_clock;  // Output from the divider module

    // Instantiate divider module
    divider clk_div (
        .clock(clk),
        .clock_out(divider_clock)
    );

    // Instantiate TrafficLightController module
    traffic traffic_ctrl (
        .btn(btn),
        .clk(divider_clock),
        .led(led),
        .segment(segment),
        .an(an[1:0]),  // Select only the first two anodes
        .dp(dp)
    );

endmodule