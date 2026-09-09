`timescale 1ns/1ps

module dut (
    input  logic        clk,
    input  logic        rst,

    input  logic [63:0] display_data,
    input  logic [3:0]  brightness,
    input  logic [15:0] refresh_div,

    output logic [7:0]  row,
    output logic [7:0]  col
);

    // =========================================================
    // INTERNAL REGISTERS
    // =========================================================

    logic [6:0]  scan_pwm_counter;
    logic [15:0] refresh_counter;

    logic [7:0] current_row_data;


    // =========================================================
    // ROW DATA SELECTION
    // =========================================================

    always_comb begin

        case (scan_pwm_counter[6:4])

            3'd0: current_row_data = display_data[7:0];

            3'd1: current_row_data = display_data[15:8];

            3'd2: current_row_data = display_data[23:16];

            3'd3: current_row_data = display_data[31:24];

            3'd4: current_row_data = display_data[39:32];

            3'd5: current_row_data = display_data[47:40];

            3'd6: current_row_data = display_data[55:48];

            3'd7: current_row_data = display_data[63:56];

            default:
                current_row_data = 8'h00;

        endcase

    end


    // =========================================================
    // ROW SCANNER
    // =========================================================

    always_comb begin

        if (rst) begin

            row = 8'h00;

        end
        else begin

            case (scan_pwm_counter[6:4])

                3'd0: row = 8'b0000_0001;

                3'd1: row = 8'b0000_0010;

                3'd2: row = 8'b0000_0100;

                3'd3: row = 8'b0000_1000;

                3'd4: row = 8'b0001_0000;

                3'd5: row = 8'b0010_0000;

                3'd6: row = 8'b0100_0000;

                3'd7: row = 8'b1000_0000;

                default:
                    row = 8'h00;

            endcase

        end

    end


    // =========================================================
    // BRIGHTNESS / PWM
    // =========================================================

    always_comb begin

        if (rst)

            col = 8'h00;

        else if (brightness == 4'd0)

            col = 8'h00;

        else if (brightness == 4'd15)

            col = current_row_data;

        else if (scan_pwm_counter[3:0] < brightness)

            col = current_row_data;

        else

            col = 8'h00;

    end


    // =========================================================
    // REFRESH + SCANNING
    // =========================================================

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            refresh_counter  <= 16'd0;
            scan_pwm_counter <= 7'd0;

        end
        else begin

            if (refresh_div == 16'd0) begin

                refresh_counter <= 16'd0;

                if (scan_pwm_counter == 7'd127)

                    scan_pwm_counter <= 7'd0;

                else

                    scan_pwm_counter <= scan_pwm_counter + 7'd1;

            end

            else if (refresh_counter >= refresh_div - 1'b1) begin

                refresh_counter <= 16'd0;

                if (scan_pwm_counter == 7'd127)

                    scan_pwm_counter <= 7'd0;

                else

                    scan_pwm_counter <= scan_pwm_counter + 7'd1;

            end

            else begin

                refresh_counter <= refresh_counter + 16'd1;

            end

        end

    end

endmodule
