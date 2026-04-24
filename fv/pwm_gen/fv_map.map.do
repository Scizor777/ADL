
//input ports
add mapped point clk clk -type PI PI
add mapped point reset reset -type PI PI
add mapped point duty[7] duty[7] -type PI PI
add mapped point duty[6] duty[6] -type PI PI
add mapped point duty[5] duty[5] -type PI PI
add mapped point duty[4] duty[4] -type PI PI
add mapped point duty[3] duty[3] -type PI PI
add mapped point duty[2] duty[2] -type PI PI
add mapped point duty[1] duty[1] -type PI PI
add mapped point duty[0] duty[0] -type PI PI

//output ports
add mapped point pwm_out pwm_out -type PO PO

//inout ports




//Sequential Pins
add mapped point pwm_out/q pwm_out_reg/Q -type DFF DFF
add mapped point counter[6]/q counter_reg[6]/Q -type DFF DFF
add mapped point counter[7]/q counter_reg[7]/Q -type DFF DFF
add mapped point counter[5]/q counter_reg[5]/Q -type DFF DFF
add mapped point counter[4]/q counter_reg[4]/Q -type DFF DFF
add mapped point counter[3]/q counter_reg[3]/Q -type DFF DFF
add mapped point counter[2]/q counter_reg[2]/Q -type DFF DFF
add mapped point counter[1]/q counter_reg[1]/Q -type DFF DFF
add mapped point counter[0]/q counter_reg[0]/Q -type DFF DFF



//Black Boxes



//Empty Modules as Blackboxes
