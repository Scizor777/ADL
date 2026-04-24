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
















































Exp 5
Conformal Terminal
lec -gui
read library /install/FOUNDRY/digital/180nm/RC_Libs/libraries/lib/STDCELL/slow.lib -liberty
-both
read design pwm.v -golden -verilog
read design pwm_synth.v -revised -verilog
set system mode lec
add compared points -all
Compare
Terminal
sed -E
's/(DFFTRX1|INVXL|INVX1|NAND2XL|AND2X1|OAI21XL|OAI221XL|OAI222XL|OAI2BB1XL|OA
I2BB2XL|AOI22XL|AOI2BB1XL)/\1M/g' pwm_synth.v > pwm_synth_fixed.v
xrun pwm_tb.v pwm_synth_fixed.v -v
/install/FOUNDRY/digital/180nm/RC_Libs/libraries/verilog/tsmc13_m.v -timescale 1ns/1ps
-access +rwc -gui
Send to waveform

Exp 6-7
Source command
Innovus
File - restore design - choose innovus - preplacement.enc
File - restore design - choose innovus - placement.enc
File - restore design - choose innovus - cts.enc
File - restore design - choose innovus - route.enc

Exp 8
Keep the last exps ongoing. Run these commands below when innovus is on
Type command > verify_drc
Type command > verifyGeometry
Type command > verify_antenna
Type command > verifyConnectivity

Exp 9
Run this is normal terminal after doing source /install command
sed -E
's/(DFFTRX1|INVXL|INVX1|NAND2XL|AND2X1|OAI21XL|OAI221XL|OAI222XL|OAI2BB1XL|OA
I2BB2XL|AOI22XL|AOI2BB1XL)/\1M/g' project_postroute.v > project_postroute_fixed.v

sed -E
's/(DFFTRX1|INVXL|INVX1|NAND2XL|AND2X1|OAI21XL|OAI221XL|OAI222XL|OAI2BB1XL|OA
I2BB2XL|AOI22XL|AOI2BB1XL)/\1M/g' project_postroute.sdf > project_postroute_fixed.sdf
xrun -timescale 1ns/1ps pwm_tb.v project_postroute_fixed.v -v
/install/FOUNDRY/digital/180nm/RC_Libs/libraries/verilog/tsmc13_m.v -access +rwc -gui

Exp 10
Start innovus
File - restore design - choose innovus - route.enc
setAnalysisMode -analysisType onChipVariation
set_power_pads -net VDD -auto_voltage_source_creation true
set_power_pads -net VSS -auto_voltage_source_creation true
report_power -outfile pwm_gen_power.rpt
File > Save > GDS/OASIS…
Inside GDS window
Output file: pwm_gen.gds
Map file: cell_map.txt
Library Name: DesignLib
Structure Name: pwm_gen
Select Merge file checkbox-
/install/FOUNDRY/digital/180nm/RC_Libs/libraries/gds/STDCELL/tsmc13_m.gds2
Press ok
Alternatively do this command in terminal
streamOut pwm_gen.gds -mapFile cell_map.txt -merge
/install/FOUNDRY/digital/180nm/RC_Libs/libraries/gds/STDCELL/tsmc13_m.gds2 -units 2000
-structureName pwm_gen