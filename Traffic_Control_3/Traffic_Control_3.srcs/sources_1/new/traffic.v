`timescale 1ns / 1ps

module traffic(
    input ST, // Input signal for starting timing interval
    input Clk, // Clock signal
    input Reset, // Reset signal
    input C, // Vehicle detection on the farm road
    input TL, // Long time interval expired
    input TS, // Short time interval expired
    output reg HG, HY, HR, // Highway lights: Green, Yellow, Red
    output reg FG, FY, FR // Farm road lights: Green, Yellow, Red
    
);

    // Enumerated states
    parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011;
    
    // State and next_state variables
    reg [2:0] state, next_state;
    
    // Output state for timing (ST)
    reg next_ST;
    
always @(C or TL or TS or state) begin
    case (state)
        S0: begin
            if (!(TL && C)) begin
                next_state = S0; next_ST = 0;
            end
            else if (TL || C) begin
                next_state = S1; next_ST = 1;
            end
        end
        
        S1: begin
            if (TL && C) begin
                next_state = S1; next_ST = 0;
            end
            else if (TS) begin
                next_state = S2; next_ST = 1;
            end
        end
        
        S2: begin
            if (!(TL || ~C)) begin
                next_state = S2; next_ST = 0;
            end
            else if (TL || ~C) begin
                next_state = S3; next_ST = 1;
            end
        end
        
        S3: begin
            if (!TS) begin
                next_state = S3; next_ST = 0;
            end
            else if (TS) begin
                // Introduce a small delay before transitioning to S0
                if (next_ST == 0) begin
                    next_ST = 1;
                end
                else begin
                    next_state = S0; next_ST = 1;
                end
            end
        end
    endcase
end
    
    always @(posedge Clk) begin
        if (Reset) begin
            state <= S0;
            next_ST <= 0;
        end
        else begin
            state <= next_state;
            next_ST <= next_ST; // No change in timing signal until explicitly set
        end
    end
    
    // Output logic for highway and farm road lights
    always @(state) begin
        case (state)
            S0: begin
                HG <= 1; HY <= 0; HR <= 0;
                FG <= 0; FY <= 0; FR <= 1;

            end
            
            S1: begin
                HG <= 0; HY <= 1; HR <= 0;
                FG <= 0; FY <= 0; FR <= 1;

            end
            
            S2: begin
                HG <= 0; HY <= 0; HR <= 1;
                FG <= 1; FY <= 0; FR <= 0;

           end
            
            S3: begin
                HG <= 0; HY <= 0; HR <= 1;
                FG <= 0; FY <= 1; FR <= 0;

            end
        endcase
    end
    
endmodule