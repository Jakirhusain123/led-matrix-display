module led_matrix_controller (

    input  logic        clk,
    input  logic        rst,

    input  logic [63:0] display_data,
    input  logic [3:0]  brightness,

    output logic [7:0]  row,
    output logic [7:0]  col

);

/////////////////////////////////////////////////////////////
// Internal Signals
/////////////////////////////////////////////////////////////

logic [2:0] current_row;
logic [3:0] pwm_counter;
logic [15:0] refresh_counter;

parameter REFRESH_DIV = 16'd5000;

/////////////////////////////////////////////////////////////
// Refresh Timer
/////////////////////////////////////////////////////////////

always_ff @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        refresh_counter <= 16'd0;
        current_row <= 3'd0;
    end
    else
    begin
        if(refresh_counter == REFRESH_DIV)
        begin
            refresh_counter <= 16'd0;

            if(current_row == 3'd7)
                current_row <= 3'd0;
            else
                current_row <= current_row + 1;
        end
        else
            refresh_counter <= refresh_counter + 1;
    end
end

/////////////////////////////////////////////////////////////
// PWM Brightness Counter
/////////////////////////////////////////////////////////////

always_ff @(posedge clk or posedge rst)
begin
    if(rst)
        pwm_counter <= 4'd0;
    else
        pwm_counter <= pwm_counter + 1;
end

/////////////////////////////////////////////////////////////
// Row Decoder
/////////////////////////////////////////////////////////////

always_comb
begin

    row = 8'b11111111;

    case(current_row)

        3'd0 : row = 8'b11111110;
        3'd1 : row = 8'b11111101;
        3'd2 : row = 8'b11111011;
        3'd3 : row = 8'b11110111;
        3'd4 : row = 8'b11101111;
        3'd5 : row = 8'b11011111;
        3'd6 : row = 8'b10111111;
        3'd7 : row = 8'b01111111;

    endcase

end

/////////////////////////////////////////////////////////////
// Column Driver
/////////////////////////////////////////////////////////////

always_comb
begin

    case(current_row)

        3'd0 : col = display_data[7:0];
        3'd1 : col = display_data[15:8];
        3'd2 : col = display_data[23:16];
        3'd3 : col = display_data[31:24];
        3'd4 : col = display_data[39:32];
        3'd5 : col = display_data[47:40];
        3'd6 : col = display_data[55:48];
        3'd7 : col = display_data[63:56];

        default : col = 8'h00;

    endcase

    // PWM Brightness Control
    if(pwm_counter >= brightness)
        col = 8'h00;

end

endmodule
