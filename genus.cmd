# Cadence Genus(TM) Synthesis Solution, Version 21.14-s082_1, built Jun 23 2022 14:32:08

# Date: Thu Apr 09 13:43:18 2026
# Host: vesit.ves.ac.in (x86_64 w/Linux 4.18.0-425.19.2.el8_7.x86_64) (10cores*16cpus*1physical cpu*Intel(R) Core(TM) i5-14400 20480KB)
# OS:   Red Hat Enterprise Linux release 8.7 (Ootpa)

read_lib /install/FOUNDRY/digital/180nm/dig/lib/slow.lib
read_hdl pwm.v
elaborate pwm_gen
syn_gen
syn_map
syn_opt
report area
report power
report gates
report timing -unconstrained
gui_show
write_hdl > pwm_synth.v
write_sdc > pwm_synth.sdc
exit
