interface led_if(input logic clk);

  logic        rst;
  logic [63:0] display_data;
  logic [3:0]  brightness;
  logic [7:0]  row;
  logic [7:0]  col;

  // Clocking block for Driver
  clocking drv_cb @(posedge clk);
    default input #1ns output #1ns;
    output rst;
    output display_data;
    output brightness;
  endclocking

  // Clocking block for Monitor
  clocking mon_cb @(posedge clk);
    default input #1ns output #1ns;
    input rst;
    input display_data;
    input brightness;
    input row;
    input col;
  endclocking

  // Modports
  modport DRV (clocking drv_cb, input clk);
  modport MON (clocking mon_cb, input clk);

endinterface
