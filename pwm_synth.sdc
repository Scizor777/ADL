# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.14-s082_1 on Thu Apr 09 13:58:45 IST 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design pwm_gen

set_clock_gating_check -setup 0.0 
set_wire_load_mode "enclosed"
