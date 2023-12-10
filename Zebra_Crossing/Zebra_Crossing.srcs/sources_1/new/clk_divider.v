`timescale 1ns / 1ps

module counter (
    input wire clock_in,
    input wire sw,
    output reg [3:0] q
);
    reg [3:0] counter;

    always @(posedge clock_in) begin
        if (sw == 1'b1) begin
            // Reset the counter to 0 when switch is ON
            counter <= 4'b0000;
        end else if (counter == 4'b1001) begin
            // Reset the counter to 0 when it reaches 9
            counter <= 4'b0000;
        end else begin
            // Increment the counter on each rising edge of the clock
            counter <= counter + 1;
        end

        // Assign led here
        q <= counter;
    end

endmodule