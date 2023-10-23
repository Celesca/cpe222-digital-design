`timescale 1ns / 1ps

module decoder_tb();
reg [2:0]t_sw;
wire [7:0]t_led;
decoder dut(.sw(t_sw) , .led(t_led));
initial begin
    t_sw = 3'b000;
    #10
    t_sw = 3'b001;
    #10
    t_sw = 3'b010;
    #10
    t_sw = 3'b011;
    #10
    t_sw = 3'b100;
    #10
    t_sw = 3'b101;
    #10
    t_sw = 3'b110;
    #10
    t_sw = 3'b111;
    #10
    $finish;
  end
endmodule
