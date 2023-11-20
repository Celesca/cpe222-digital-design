`timescale 1ns / 1ps

module counter (
    input wire clk, // Clock input
    input wire rst, // Reset input
    output wire reg_out // Output signal
);

reg [23:0] count; // 24-bit counter for 1 Hz frequency

always @(posedge clk or posedge rst) begin
    if (rst) begin
        count <= 24'b0; // Reset the counter
    end else begin
        count <= count + 1; // Increment the counter
    end
end

assign reg_out = count[23]; // Output the most significant bit of the counter

endmodule