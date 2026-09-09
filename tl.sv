`timescale 1ns/1ps

module led_matrix_assertions (

    input logic       clk,
    input logic       rst,

    input logic [7:0] row,
    input logic [7:0] col,

    input logic [3:0] brightness

);


    // =========================================================
    // RESET ROW
    // =========================================================

    property reset_row_check;

        @(posedge clk)

        rst |-> (row == 8'h00);

    endproperty


    assert property(reset_row_check)
        else $error("ASSERTION FAILED: ROW during reset");


    // =========================================================
    // RESET COLUMN
    // =========================================================

    property reset_col_check;

        @(posedge clk)

        rst |-> (col == 8'h00);

    endproperty


    assert property(reset_col_check)
        else $error("ASSERTION FAILED: COL during reset");


    // =========================================================
    // BRIGHTNESS ZERO
    // =========================================================

    property brightness_off_check;

        @(posedge clk)

        (!rst && brightness == 4'd0)
        |-> (col == 8'h00);

    endproperty


    assert property(brightness_off_check)
        else $error(
            "ASSERTION FAILED: COL active with brightness=0"
        );


    // =========================================================
    // ONE-HOT ROW
    // =========================================================

    property row_one_hot_check;

        @(posedge clk)

        (!rst) |-> $onehot(row);

    endproperty


    assert property(row_one_hot_check)
        else $error(
            "ASSERTION FAILED: ROW is not one-hot"
        );

endmodule
