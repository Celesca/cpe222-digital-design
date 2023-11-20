`timescale 1ns / 1ps

module top_module;

  reg Clk;
  reg Reset, C;
  reg TL, TS;
  wire ST, HG, HY, HR, FG, FY, FR;

  // Instantiate the counter module
  counter clk_counter (
    .clk(Clk),
    .rst(Reset),
    .reg_out()
  );

  // Instantiate the traffic module
  traffic uut (
    .Clk(Clk),
    .Reset(Reset),
    .C(C),
    .TL(TL),
    .TS(TS),
    .ST(ST),
    .HG(HG),
    .HY(HY),
    .HR(HR),
    .FG(FG),
    .FY(FY),
    .FR(FR)
  );

endmodule
