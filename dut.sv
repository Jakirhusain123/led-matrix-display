`timescale 1ns/1ps
module dut (
    input  logic        clk,
    input  logic        rst,

    input  logic [63:0] display_data,
    input  logic [3:0]  brightness,

    output logic [7:0]  row,
    output logic [7:0]  col
);

  logic [2:0] scan_count;
  logic [3:0] pwm_count;

  always_ff @(posedge clk) begin

    if (rst) begin
      scan_count <= 3'd0;
      pwm_count  <= 4'd0;
    end

    else begin

      if (scan_count == 3'd7) begin
        scan_count <= 3'd0;
      end

      else begin
        scan_count <= scan_count + 3'd1;
      end

      if (pwm_count == 4'd15) begin
        pwm_count <= 4'd0;
      end

      else begin
        pwm_count <= pwm_count + 4'd1;
      end

    end

  end


  always_comb begin

    // Default outputs
    row = 8'b0000_0000;
    col = 8'b0000_0000;

    // Row decoder
    case (scan_count)

      3'd0: row = 8'b0000_0001;
      3'd1: row = 8'b0000_0010;
      3'd2: row = 8'b0000_0100;
      3'd3: row = 8'b0000_1000;
      3'd4: row = 8'b0001_0000;
      3'd5: row = 8'b0010_0000;
      3'd6: row = 8'b0100_0000;
      3'd7: row = 8'b1000_0000;

      default: row = 8'b0000_0000;

    endcase


    // Brightness control
    if (pwm_count < brightness) begin

      case (scan_count)

        3'd0: col = display_data[7:0];
        3'd1: col = display_data[15:8];
        3'd2: col = display_data[23:16];
        3'd3: col = display_data[31:24];
        3'd4: col = display_data[39:32];
        3'd5: col = display_data[47:40];
        3'd6: col = display_data[55:48];
        3'd7: col = display_data[63:56];

        default: col = 8'b0;

      endcase

    end

    else begin
      col = 8'b0000_0000;
    end

  end

endmodule
