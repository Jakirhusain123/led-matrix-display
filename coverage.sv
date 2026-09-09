class coverage;

    virtual led_matrix_if vif;


    covergroup led_matrix_cg;

        option.per_instance = 1;


        // =====================================================
        // BRIGHTNESS
        // =====================================================

        brightness_cp:

        coverpoint vif.brightness {

            bins off_level = {0};

            bins low_level = {[1:4]};

            bins mid_level = {[5:11]};

            bins high_level = {[12:15]};

        }


        // =====================================================
        // ROW
        // =====================================================

        row_cp:

        coverpoint vif.row {

            bins row0 = {8'b0000_0001};

            bins row1 = {8'b0000_0010};

            bins row2 = {8'b0000_0100};

            bins row3 = {8'b0000_1000};

            bins row4 = {8'b0001_0000};

            bins row5 = {8'b0010_0000};

            bins row6 = {8'b0100_0000};

            bins row7 = {8'b1000_0000};

        }


        // =====================================================
        // COLUMN
        // =====================================================

        column_cp:

        coverpoint vif.col {

            bins all_off = {8'h00};

            bins all_on  = {8'hFF};

            bins other = default;

        }


        // =====================================================
        // CROSS
        // =====================================================

        brightness_row_cross:

        cross brightness_cp, row_cp;

    endgroup


    function new(
        virtual led_matrix_if vif
    );

        this.vif = vif;

        led_matrix_cg = new();

    endfunction


    task run();

        forever begin

            @(posedge vif.clk);

            if (!vif.rst)

                led_matrix_cg.sample();

        end

    endtask

endclass
