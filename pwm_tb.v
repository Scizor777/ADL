`timescale 1ns/1ps

module pwm_tb;
    // Signals to connect to our PWM module
    reg clk;
    reg reset;
    reg [7:0] duty;
    wire pwm_out;

    // Instantiate the PWM generator (The Unit Under Test) 
    // This MUST match the module name in your project_postroute_fixed.v
    pwm_gen uut (
        .clk(clk),
        .reset(reset),
        .duty(duty),
        .pwm_out(pwm_out)
    );

    // Clock generation: Toggles every 5ns for a 10ns period
    always #5 clk = ~clk;

    initial begin
        // --- EXPERIMENT 9 ADDITION START ---
        // This links the SDF delays to the uut instance inside pwm_tb
        $sdf_annotate("project_postroute_fixed.sdf", pwm_tb.uut);
        // --- EXPERIMENT 9 ADDITION END ---

        // Initial values
        clk = 0;
        reset = 1;
        duty = 8'h80; // 50% Duty Cycle

        // Release Reset after 20ns
        #20 reset = 0;

        // Let it run for 3000ns to see the full cycle
        #3000;
        
        $finish; // Stop the simulation automatically
    end
endmodule
