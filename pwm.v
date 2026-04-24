`timescale 1ns/1ps

module pwm_gen (
    input wire clk,       // System Clock
    input wire reset,     // Synchronous reset (active high) [cite: 89]
    input wire [7:0] duty, // 8-bit Duty Cycle input
    output reg pwm_out    // The PWM pulse output [cite: 90]
);

    reg [7:0] counter; // Internal 8-bit counter

    // Counter logic following Exp 2 standard [cite: 95-103]
    always @(posedge clk) begin
        if (reset) begin
            counter <= 8'b0; // Reset counter to 0 synchronously [cite: 98]
        end else begin
            counter <= counter + 1'b1; // Increment on every clock [cite: 101]
        end
    end

    // PWM output logic (Comparator)
    always @(posedge clk) begin
        if (reset) begin
            pwm_out <= 1'b0;
        end else begin
            // If counter is less than duty, output stays HIGH
            pwm_out <= (counter < duty) ? 1'b1 : 1'b0;
        end
    end

endmodule
