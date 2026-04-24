`timescale 1ns/1ps

module pwm_gen (
    input wire clk,      
    input wire reset,     
    input wire [7:0] duty, 
    output reg pwm_out    
);

    reg [7:0] counter; 


    always @(posedge clk) begin
        if (reset) begin
            counter <= 8'b0; 
        end else begin
            counter <= counter + 1'b1; 
        end
    end


    always @(posedge clk) begin
        if (reset) begin
            pwm_out <= 1'b0;
        end else begin
            pwm_out <= (counter < duty) ? 1'b1 : 1'b0;
        end
    end

endmodule