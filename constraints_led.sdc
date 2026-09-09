create_clock -name clk -period 5 -waveform {0 2.5} [get_ports "clk"]
set_clock_transition -rise 0.5 [get_clocks "clk"]
set_clock_transition -fall 0.5 [get_clocks "clk"]
set_clock_uncertainty 0.05 [get_ports "clk"]
set_input_delay -max 2[get_ports "display_data"] -clock [get_clocks "clk"]
set_input_delay -max 2[get_ports "brightness"] -clock [get_clocks "clk"]

set_output_delay -max 2[get_ports "row"] -clock [get_clocks "clk"]
set_output_delay -max 2[get_ports "col"] -clock [get_clocks "clk"]
