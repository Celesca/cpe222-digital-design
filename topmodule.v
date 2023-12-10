`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2023 07:16:30 PM
// Design Name: 
// Module Name: topmodule
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


module topmodule(
    input clock,
    input reset,
    input reset_p,
    input reset_s,
    input team,
    input one_p,
    input two_p,
    input three_p,
    input pause,
    input change,
    output reg [0:3] Anode_a,
    output reg [0:6] LED
    );
    wire slow_clock;
    reg [26:0] one_second_counter;
    wire one_second_enable;
    reg [15:0] displayed_number;
    reg [7:0] team_1;
    reg [7:0] team_2;
    reg [7:0] LED_BCD;
    reg [19:0] refresh_counter; 
    wire [2:0] LED_activating_counter;
    reg [5:0] seconds;
    reg [5:0] minutes;
    clk_divider DUT (.clk(clock), .reset(reset), .sclk(slow_clock )); 
    always  @(posedge clock or negedge reset)
    begin 
        if (reset==0)
            one_second_counter <= 0;
        else if (pause)
            displayed_number  = displayed_number ;
        else begin
            if(one_second_counter>=99999999) 
            one_second_counter <= 0;
            else
            one_second_counter <= one_second_counter + 1;
        end
    end 
    assign one_second_enable = (one_second_counter==99999999)?1:0; 
    
    always @(posedge clock )
    begin 
    if (reset_s) begin 
        minutes <= 12;
        seconds <= 00;
    end 
    else if (one_second_enable == 1)
        seconds <= seconds -1;
       else  if (seconds ==0) begin 
        seconds <= 59;
        minutes <= minutes - 1;
    end
    else  if (pause)
        seconds = seconds ;
    else if (minutes == 0)
        minutes <= 11;
    end
    always @(posedge clock or negedge reset)
    
    begin 
        if (reset == 0)
            refresh_counter <= 0 ;
        else 
        refresh_counter <= refresh_counter +1 ;
    end
    
    assign LED_activating_counter  = refresh_counter [19: 17];
    
    always @(*)
    if(change == 0)
    begin 
        case (LED_activating_counter )
        2'b00: begin
            Anode_a = 4'b1110; 
                LED_BCD = (team_2 / 10);
              end
        2'b01: begin
            Anode_a = 4'b1101; 
                LED_BCD = (team_2 % 10);
              end
        2'b10: begin
            Anode_a = 4'b1011; 
                LED_BCD = (team_1 / 10);
                end
        2'b11: begin
            Anode_a = 4'b0111;
                LED_BCD = (team_1 % 10);
               end
        endcase
    end
    else begin 
        case (LED_activating_counter )
        2'b00: begin
            Anode_a = 4'b1110; 
                LED_BCD = (minutes / 10);
              end
        2'b01: begin
            Anode_a = 4'b1101; 
                LED_BCD = (minutes % 10);
              end
        2'b10: begin
            Anode_a = 4'b1011; 
                LED_BCD = (seconds / 10);
                end
        2'b11: begin
            Anode_a = 4'b0111;
                LED_BCD = (seconds % 10);
               end
        endcase
    end
    
    always @(*)
    begin 
        case(LED_BCD)
       0: LED = 7'b0000001; // "0"     
       1: LED = 7'b1001111; // "1" 
       2: LED = 7'b0010010; // "2" 
       3: LED = 7'b0000110; // "3" 
       4: LED = 7'b1001100; // "4" 
       5: LED = 7'b0100100; // "5" 
       6: LED = 7'b0100000; // "6" 
       7: LED = 7'b0001111; // "7" 
       8: LED = 7'b0000000; // "8"     
       9: LED = 7'b0000100; // "9" 
       default: LED = 7'b0000001; // "0"
        endcase
    end

always @(posedge slow_clock)
begin 
    if(reset_p )begin 
    team_1 = 7'b0000000;
    team_2 = 7'b0000000;
    end
    
    if (one_p)  
        begin
        if(team)
            team_1 = team_1 + 2'b01;
            else
            team_2 = team_2 + 2'b01;
        end 
        else if (two_p) begin
            if(team)
            team_1 = team_1 + 2'b10;
            else
            team_2 = team_2 + 2'b10;
        end 
        else if (three_p) begin
            if(team)
            team_1 <= team_1 + 2'b11;
            else
            team_2 <= team_2 + 2'b11;
        end

        if(team_1 >= 7'b1100100)
            team_1 = 7'b0000000;

        if(team_2 >= 7'b1100100)
            team_2 = 7'b0000000;
    end        
endmodule
