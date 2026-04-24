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




































EXPERIMENT 2:

1.	Prepare project.v, project_tb.v and constraints.sdc files. These files should be Xcelium, Genus, Innovus and Conformal compatible.
2.	Use this command for Part B of experiment in terminal:
a.	xrun project.v project_tb.v -timescale 1ns/1ps -access +rwc -gui
Select the ‘_tb” option on the left side of GUI.
Right click and choose ‘Send to Waveform Window’
Press Run button and ‘=’ button if not sized correctly.
3.	For Part A:
a.	xrun project.v -access +rwc -gui
Select the ‘_tb” option on the left side of GUI.
Right click and choose ‘Send to Waveform Window’.
//////////////////

EXPERIMENT 3:

1.	Prepare project.v and constraints.sdc files. 
2.	Enter genus in terminal.
3.	Type the following commands in order:
read_lib /install/FOUNDRY/digital/180nm/dig/lib/slow.lib
read_hdl project.v
elaborate project
read_sdc constraints.sdc
syn_gen
syn_map
syn_opt
report_area > area.rpt
report_power > power.rpt
report_timing > timing.rpt
write_hdl > project_synth.v
write_sdc > project_synth.sdc
exit
4.	After this, there should be area.rpt, power.rpt, timing.rpt, project_synth.v and project_synth.sdc in your directory.

 
EXPERIMENT 4:

1.	Prepare project_synth.v and project_synth.sdc files. 
2.	Type innovus in terminal. After GUI opens, click Import Design in File…
3.	Choose your project_synth.v in your Verilog block.
4.	Select LEF in the 2nd block and choose all.lef. You can find this by going back in the directories. -> /install/FOUNDRY/digital/180nm/dig/lef/all.lef
5.	Ignore the 3rd block. In the 4th block, Power Net: VDD and Ground Net: VSS.
6.	Select Create Analysis Configuration…
7.	Right Click Library Sets and select New.
	Name it max_timing. Press the '>>’ button. In Timing Library,
Navigate to find the /install/FOUNDRY/digital/180nm/dig/lib/slow.lib file. 
Add it and close the window.
Repeat the same steps for min_timing and select fast.lib(in same directory as slow.lib).
8.	Right click Delay Corners and Select New.
Name it max_timing(at top). Select max_timing in the Library Set. Close.
Do the same for min_delay and choose min_timing instead.
9.	Right click the Constraints > New > Name it top > Add SDC file > the .sdc for synthesis.
10.	Right click Analysis Views > Name it setup > top > Delay Corner: max_delay.
11.	Repeat the step and name it hold. Choose top and Delay Corner as min_delay.
12.	Right click Setup Views and select setup. 
13.	Right click Hold Views and select hold.
14.	Save&Close. (OPTIONAL)Save with any name you want(add .view after your name).
15.	Save. (OPTIONAL)Save with any name you want(add .globals after your name).
16.	Close. The file should open on its own.
17.	Floorplan > Specify Floorplan.
The parameters are project specific, so either use AI or use any values you want.
18.	File > Save Design > Select Innovus > Save as floorplan.enc
19.	Power > Power Planning > Add Ring.
Nets: VDD VSS
Top and Bottom: Metal5(H)
Left and Right: Metal6(V)
Offset to Center
The Width and Spacing are project specific, but you can keep it 1.8 and press Update for default values. Press OK
20.	Power > Power Planning > Add Strip.
	Nets: VDD VSS
	Metal5 and Vertical(custom width or default values are okay as well).
	Set Pattern > Number of sets > 3(can be custom as well). Press OK.
21.	Route > Special Route > Only add Nets > VDD VSS > OK.
22.	File > Save Design > Select Innovus > Save as powerplan.enc
23.	Place >Physical Cell > Add End Cap > FILL2 > OK.
24.	Place > Physical Cell > Add Well Tap > FILL2 > OK.
25.	File > Save Design > Select Innovus > Save as preplacement.enc 
EXPERIMENT 5

1.	Prepare project.v, project_tb.v and project_synth.v files. 
2.	Open terminal and type lec -gui
3.	In the TCL Command Window:
read library /install/FOUNDRY/digital/180nm/RC_Libs/libraries/lib/STDCELL/slow.lib -liberty -both
read design project.v -golden -verilog
read design project_synth.v -revised -verilog
set system mode lec
add compared points -all
compare 
4.	Exit Conformal after taking a screenshot of output and GUI Window.
5.	In the same terminal, enter the command from below,
sed -E 's/(DFFTRX1|INVXL|INVX1|NAND2X1|AND2X2|OAI2BB2XL|OAI21XL|AOI2BB1XL)/\1M/g' project_synth.v > project_synth_fixed.v
Your project might have extra Gates that require changes beyond the gates we include in the command. Use Gemini to check the gates to change the project_synth.v file.
6.	Run this command below:
	xrun project_tb.v project_synth_fixed.v -v
/install/FOUNDRY/digital/180nm/RC_Libs/libraries/verilog/tsmc13_m.v -timescale 1ns/1ps -access +rwc -gui
7.	Run the same steps from Experiment 2 to use Xcelium.
8.	Check if simulation from Experiment 2 is the same as the one here.

 
EXPERIMENT 6

1.	Open the preplacement.enc by doing the below steps:
a.	Enter innovus in a terminal.
b.	File > Restore Design > Select Innovus > Select the preplacement.enc
2.	In the terminal, press enter to use the innovus command window. Type the below command:
	setDesignMode -process 180
3.	Go back to Innovus GUI.
4.	Place > Place Standard Cells > Run Full Placement > Mode > Enable IO Pins and press OK.
5.	If you cannot see any wires, press the Physical View in the top right area to enable it.
6.	Press any wire and press Q. Check if the status is Routed. If not, there are errors in your current design stage. Refer to Gemini to remove these errors.
7.	Timing > Report Timing > Pre-CTS > setup > OK. Check Terminal for the report.
8.	File > Save Design > Select Innovus > Save as placement.enc
9.	Clock > Select the only option > OK. Take ss of the Clock Tree.
10.	Timing > Report Timing > Post-CTS > setup > OK. Check Terminal for the report.
11.	Timing > Report Timing > Post-CTS > hold > OK. Check Terminal for the report.
12.	ECO > Optimise Design > Post-CTS > Hold(Deselect setup) > OK. Check the terminal if there are any violating paths.
13.	File > Save Design > Select Innovus > Save as cts.enc
14.	Open your project directory. There should be a timingReport Folder.
15.	Inside that, there should be a counter_postCTS.summary.gz. Double click and a new file is created.
16.	Rename this file as STA.rpt

EXPERIMENT 7

1.	In the same cts.enc file, continue this experiment.
2.	ECO > Optimization > Optimize Design > Post-Place > OK
3.	Route > Nanoroute > Route > Enable ‘Timing Driven’ > OK
4.	Tools > Set Mode > Specify Analysis Mode > Enable “Onchip Variation” > OK
5.	Timing > Report Timing > Post-Route > setup > OK. Check Terminal for the report.
6.	Timing > Report Timing > Post-Route > hold > OK. Check Terminal for the report.
7.	Place > Physical Cells > Add Filler > Select all FILL and Add > OK
8.	File > Save Design > Select Innovus > Save as route.enc
9.	File > Save… > Netlist > Save as project_postroute.v
10.	Type this command in innovus command window 
write_sdf project_postroute.sdf

EXPERIMENT 8

1.	Continue in the same file. Open the innovus command window.
2.	Type command > verify_drc            ………… If there are violations fix them by using Gemini.
3.	Type command > verifyGeometry   ………… Same as DRC.
4.	Type command > verify_antenna    ………… Same as DRC.
EXPERIMENT 9

1.	Run these two commands 
sed -E 's/(DFFTRX1|INVXL|INVX1|NAND2X1|AND2X2|OAI2BB2XL|OAI21XL|AOI2BB1XL)/\1M/g' project_postroute.v > project_postroute_fixed.v
sed -E 's/(DFFTRX1|INVXL|INVX1|NAND2X1|AND2X2|OAI2BB2XL|OAI21XL|AOI2BB1XL)/\1M/g' project_postroute.sdf > project_postroute_fixed.sdf
2.	Edit the testbench file by adding: 
initial begin
    $sdf_annotate("project_postroute_fixed.sdf", top_instance_name.uut);
end
3.	Top_instance_name.uut is the name of your testbench’s module name
4.	Use Xcelium for simulation:
xrun -timescale 1ns/1ps project_tb.v project_postroute_fixed.v -v /install/FOUNDRY/digital/180nm/RC_Libs/libraries/verilog/tsmc13_m.v -access +rwc -gui
5.	Run the same steps from Experiment 2 to use Xcelium.
6.	Check if simulation from Experiment 2 is the same as the one here.


EXPERIMENT 10

1.	Set Analysis Mode: Switch the tool to recognize post-route parasitic data.  setAnalysisMode -analysisType onChipVariation
2.	Define Power Sources: Manually assign the voltage sources to the VDD and VSS nets.
set_power_pads -net VDD -auto_voltage_source_creation true
set_power_pads -net VSS -auto_voltage_source_creation true
3.	Generate Power Report: Execute the power calculation engine and save the output to a text file.
report_power -outfile counter_power.rpt

4.	File > Save > GDS/OASIS... > Set Format to GDSII > Output File: counter.gds
5.	Browse to 180nm/pdk/ > Library Files: Add your standard cell .gds files > OK.
6.	If no Library is found, make a new file named cell_map.txt
7.	Paste this in it:
# Format: MAP <DesignCellName> <LibraryCellName>
MAP DFFTRX1 	DFFTRX1M
MAP INVXL   	INVXLM
MAP INVX1   	INVX1M
MAP NAND2X1 	NAND2X1M
MAP AND2X2  	AND2X2M
MAP OAI2BB2XL   OAI2BB2XLM
MAP OAI21XL 	OAI21XLM
MAP AOI2BB1XL   AOI2BB1XLM
MAP FILL1   	FILL1M
MAP FILL2   	FILL2M
MAP FILL4   	FILL4M
MAP FILL8   	FILL8M
8.	Then save it.
9.	Select the cell_map.txt in it and set the following:
 

10.	In the merge file, select /install/FOUNDRY/digital/180nm/RC_Libs/libraries/gds/STDCELL/tsmc13_m.gds2
11.	Click OK
12.	Indication for successful ASIC Design : "Stream out completed successfully." and 
"Total number of cells streamed out: 16" in Terminal
