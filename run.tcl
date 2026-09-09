read_libs slow_vdd1v0_basicCells.lib
read_hdl -sv dut.sv
elaborate
read_sdc constraints_led.sdc
syn_generic
gui_show
syn_map
syn_opt
write_hdl > led_netlist.v
write_sdc > led_constraint_tool.sdc
report_area > led_area.txt
report_power > led_power.txt
report_timing > led_timing.txt
