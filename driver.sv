class driver;

    virtual led_matrix_if vif;

    mailbox #(transaction) gen2drv;

    transaction tr;


    function new(
        virtual led_matrix_if vif,
        mailbox #(transaction) gen2drv
    );

        this.vif     = vif;
        this.gen2drv = gen2drv;

    endfunction


    // =========================================================
    // RESET DUT
    // =========================================================

    task reset_dut();

        vif.rst          = 1'b1;
        vif.display_data = 64'h0000_0000_0000_0000;
        vif.brightness   = 4'd0;
        vif.refresh_div  = 16'd5;

        repeat (5)
            @(posedge vif.clk);

        vif.rst = 1'b0;

        repeat (2)
            @(posedge vif.clk);

        $display("DRIVER: RESET COMPLETE");

    endtask


    // =========================================================
    // DRIVE TRANSACTION
    // =========================================================

    task drive_transaction();

        gen2drv.get(tr);


        @(posedge vif.clk);

        vif.display_data <= tr.display_data;
        vif.brightness   <= tr.brightness;
        vif.refresh_div  <= tr.refresh_div;


        $display(
            "DRIVER: DATA=%016h BRIGHTNESS=%0d REFRESH=%0d",
            tr.display_data,
            tr.brightness,
            tr.refresh_div
        );


        // =====================================================
        // SPECIAL LONG COUNTER TEST
        // =====================================================

        if (tr.refresh_div == 16'hFFFF) begin

            $display("DRIVER: LONG COUNTER TOGGLE TEST");

            repeat (70000)
                @(posedge vif.clk);

        end


        // =====================================================
        // NORMAL TEST
        // =====================================================

        else begin

            repeat (1000)
                @(posedge vif.clk);

        end

    endtask


    // =========================================================
    // RUN
    // =========================================================

    task run();

        reset_dut();

        forever begin

            drive_transaction();

        end

    endtask

endclass
