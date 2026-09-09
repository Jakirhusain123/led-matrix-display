`timescale 1ns/1ps

interface led_matrix_if (
    input logic clk
);

    logic        rst;

    logic [63:0] display_data;

    logic [3:0] brightness;

    logic [15:0] refresh_div;

    logic [7:0] row;

    logic [7:0] col;

endinterface
