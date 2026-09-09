# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.14-s082_1 on Tue Aug 25 09:42:27 IST 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design dut

create_clock -name "clk" -period 5.0 -waveform {0.0 2.5} [get_ports clk]
set_clock_transition 0.5 [get_clocks clk]
set_clock_gating_check -setup 0.0 
set_wire_load_mode "enclosed"
set_clock_uncertainty -setup 0.05 [get_ports clk]
set_clock_uncertainty -hold 0.05 [get_ports clk]
