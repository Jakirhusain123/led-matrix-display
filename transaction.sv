class transaction;

    rand bit [63:0] display_data;
    rand bit [3:0]  brightness;
    rand bit [15:0] refresh_div;

    bit [7:0] expected_row;
    bit [7:0] expected_col;


    constraint brightness_c {
        brightness inside {[0:15]};
    }


    constraint refresh_c {
        refresh_div inside {[0:10]};
    }


    function new();

        display_data = 64'h0;
        brightness   = 4'd15;
        refresh_div  = 16'd5;

    endfunction


    function void display(string name = "TRANSACTION");

        $display("--------------------------------------------");
        $display("%s", name);
        $display("DISPLAY    = %016h", display_data);
        $display("BRIGHTNESS = %0d", brightness);
        $display("REFRESH    = %0d", refresh_div);
        $display("--------------------------------------------");

    endfunction

endclass
