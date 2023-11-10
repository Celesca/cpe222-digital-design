`timescale 1ns / 1ps

module ALU(
    input [3:0] ALU_control,
    input [3:0] Ain,
    input [3:0] Bin,
    output reg [3:0] ACC_out,
    output reg V, Z, C,
    input clk
);

    always @(posedge clk) begin
        case (ALU_control)
            4'b0000: ACC_out <= Ain + Bin;  // Addition
            4'b0001: ACC_out <= Ain - Bin;  // Subtraction
            4'b0010: ACC_out <= Ain & Bin;  // Bitwise AND
            4'b0011: ACC_out <= Ain | Bin;  // Bitwise OR
            4'b0100: ACC_out <= Ain ^ Bin;  // Bitwise XOR
            4'b0101: ACC_out <= ~Ain;       // Bitwise NOT (inverted Ain)
            4'b0110: ACC_out <= Ain << 1;    // Shift left (logical)
            4'b0111: ACC_out <= Ain >> 1;    // Shift right (logical)
            4'b1000: ACC_out <= Ain >>> 1;   // Shift right (arithmetic)
            4'b1001: ACC_out <= Ain + 1;     // Increment
            default: ACC_out <= 4'b0000;     // Default to zero for undefined control values
        endcase

        // Set flags
        V <= (ACC_out == 4'b1111) ? 1 : 0;  // Overflow flag
        Z <= (ACC_out == 4'b0000) ? 1 : 0;  // Zero flag
        C <= (ACC_out[3] & Bin[3]) | (Bin[3] & ~Ain[3]) | (~Ain[3] & ACC_out[3]);  // Carry flag
    end

endmodule