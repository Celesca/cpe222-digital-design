`timescale 1ns / 1ps

module traffic(
    input wire clk,  // Clock signal
    input wire btn,  // Button input for zebra crossing signal
    output wire [6:0] segment,  // 7-segment display for countdown
    output reg [2:0] roadLED,  // Road LEDs (0: Red, 1: Yellow, 2: Green)
    output reg [2:0] zebraLED  // Zebra LEDs (0: Red, 1: Yellow, 2: Green)
);

    reg [4:0] counter;
    reg [2:0] state;

    // State machine
    always @(posedge clk) begin
        case (state)
            3'b000: begin  // S0 state
                roadLED <= 3'b100;  // Red
                zebraLED <= 3'b001; // Green
                if (btn) begin
                    state <= 3'b001;  // Move to S1 state on button press
                    counter <= 20;
                end
            end
            3'b001: begin  // S1 state
                roadLED <= 3'b001; // Green
                zebraLED <= 3'b001; // Green
                if (counter > 0) begin
                    counter <= counter - 1;
                end else begin
                    state <= 3'b010;  // Move to S2 state
                    counter <= 3;
                end
            end
            3'b010: begin  // S2 state
                roadLED <= 3'b010; // Yellow
                zebraLED <= 3'b001; // Green
                if (counter > 0) begin
                    counter <= counter - 1;
                end else begin
                    state <= 3'b011;  // Move to S3 state
                    counter <= 15;
                end
            end
            3'b011: begin  // S3 state
                roadLED <= 3'b100;  // Red
                zebraLED <= 3'b010; // Yellow
                if (counter > 0) begin
                    counter <= counter - 1;
                end else begin
                    state <= 3'b100;  // Move to S4 state
                    counter <= 3;
                end
            end
            3'b100: begin  // S4 state
                roadLED <= 3'b100;  // Red
                zebraLED <= 3'b010; // Yellow
                if (counter > 0) begin
                    counter <= counter - 1;
                end else begin
                    state <= 3'b000;  // Move back to S0 state
                end
            end
            default: state <= 3'b000;
        endcase
    end

    // Output countdown values to 7-segment display
    assign segment = counter;

endmodule