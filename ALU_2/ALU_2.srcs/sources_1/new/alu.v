`timescale 1ns / 1ps

module alu (
      input [3:0] ALU_control, Ain, Bin,
      output reg [3:0] ACC_out,
      output reg V, Z, C,
      input Clk
);

// Internal wires and registers
reg [3:0] ALU_out;

// ALU logic
always @* begin
    case (ALU_control)
        4'b0001: ALU_out = Ain + Bin;   // ADD 1
        4'b0010: ALU_out = Ain - Bin;   // SUBTRACT 2
        4'b0101: ALU_out = Ain & Bin;   // AND 5 
        4'b0110: ALU_out = Ain | Bin;   // OR 6
        4'b0111: ALU_out = ~Ain;   // NOT 7
        4'b1000: ALU_out = Ain << 1;    // Left shift A
        4'b1100: ALU_out = Ain >> 1;    // Right shift A
        default: ALU_out = 4'b0000;     // Default to zero
    endcase
end

// Update ACC and Flags
always @(posedge Clk) begin
    ACC_out <= ALU_out;
    V <= (ALU_out[3] == 1) ? 1 : 0;    // Set overflow flag
    Z <= (ALU_out == 4'b0000) ? 1 : 0; // Set zero flag
    C <= (ALU_out[3] & Bin[3]) ? 1 : 0; // Set carry flag
end

endmodule