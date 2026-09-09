`timescale 1ns/1ps

module top;

    import tb_pkg::*;


    // =========================================================
    // CLOCK
    // =========================================================

    logic clk;

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end


    // =========================================================
    // INTERFACE
    // =========================================================

    led_matrix_if vif(clk);


    // =========================================================
    // DUT
    // =========================================================

    dut DUT (
        .clk          (clk),
        .rst          (vif.rst),
        .display_data (vif.display_data),
        .brightness   (vif.brightness),
        .refresh_div  (vif.refresh_div),
        .row          (vif.row),
        .col           (vif.col)
    );


    // =========================================================
    // ASSERTIONS
    // =========================================================

    led_matrix_assertions ASSERTIONS (
        .clk        (clk),
        .rst        (vif.rst),
        .row        (vif.row),
        .col        (vif.col),
        .brightness (vif.brightness)
    );


    // =========================================================
    // MAILBOXES
    // =========================================================

    mailbox #(transaction) gen2drv;
    mailbox #(transaction) mon2scb;


    // =========================================================
    // TESTBENCH COMPONENTS
    // =========================================================

    generator  gen;
    driver     drv;
    monitor    mon;
    scoreboard scb;
    coverage   cov;


    // =========================================================
    // CREATE OBJECTS
    // =========================================================

    initial begin

        gen2drv = new();
        mon2scb = new();

        gen = new(gen2drv);
        drv = new(vif, gen2drv);
        mon = new(vif, mon2scb);
        scb = new(mon2scb);
        cov = new(vif);

    end


    // =========================================================
    // NORMAL TEST
    // =========================================================

    initial begin

        #1;

        fork

            gen.run();

            drv.run();

            mon.run();

            scb.run();

            cov.run();

        join_none

    end


    // =========================================================
    // ADDITIONAL TOGGLE COVERAGE TEST
    // =========================================================

    initial begin

        // Wait for driver's reset to finish

        wait (vif.rst == 1'b0);

        repeat (10)
            @(posedge clk);


        // =====================================================
        // RESET TOGGLE TEST
        // =====================================================

        $display("");
        $display("==============================================");
        $display("RESET TOGGLE COVERAGE TEST");
        $display("==============================================");


        vif.rst <= 1'b1;

        repeat (3)
            @(posedge clk);


        vif.rst <= 1'b0;

        repeat (5)
            @(posedge clk);


        // =====================================================
        // FAST SCAN
        // =====================================================

        vif.display_data <= 64'hFFFF_FFFF_FFFF_FFFF;
        vif.brightness   <= 4'd15;
        vif.refresh_div  <= 16'd1;


        repeat (1000)
            @(posedge clk);


        // =====================================================
        // DISPLAY DATA TOGGLE
        // =====================================================

        vif.display_data <= 64'h0000_0000_0000_0000;

        repeat (200)
            @(posedge clk);


        vif.display_data <= 64'hAAAA_AAAA_AAAA_AAAA;

        repeat (200)
            @(posedge clk);


        vif.display_data <= 64'h5555_5555_5555_5555;

        repeat (200)
            @(posedge clk);


        // =====================================================
        // BRIGHTNESS TOGGLE
        // =====================================================

        vif.brightness <= 4'd0;

        repeat (100)
            @(posedge clk);


        vif.brightness <= 4'd15;

        repeat (100)
            @(posedge clk);


        vif.brightness <= 4'd8;

        repeat (100)
            @(posedge clk);


        vif.brightness <= 4'd1;

        repeat (100)
            @(posedge clk);


        // =====================================================
        // REFRESH DIVIDER FAST
        // =====================================================

        vif.refresh_div <= 16'd1;

        repeat (1000)
            @(posedge clk);


        // =====================================================
        // DIRECT SCAN COUNTER TOGGLE COVERAGE
        // =====================================================
        //
        // The DUT scan counter is 7 bits.
        // Explicit patterns guarantee every bit gets
        // both 0 and 1 transitions.
        //

        $display("");
        $display("==============================================");
        $display("SCAN COUNTER TOGGLE TEST");
        $display("==============================================");


        force DUT.scan_pwm_counter = 7'b0000000;

        repeat (2)
            @(posedge clk);

        force DUT.scan_pwm_counter = 7'b1111111;

        repeat (2)
            @(posedge clk);

        force DUT.scan_pwm_counter = 7'b1010101;

        repeat (2)
            @(posedge clk);

        force DUT.scan_pwm_counter = 7'b0101010;

        repeat (2)
            @(posedge clk);

        force DUT.scan_pwm_counter = 7'b1111111;

        repeat (2)
            @(posedge clk);

        force DUT.scan_pwm_counter = 7'b0000000;

        repeat (2)
            @(posedge clk);

        release DUT.scan_pwm_counter;


        // =====================================================
        // REFRESH COUNTER TOGGLE COVERAGE
        // =====================================================
        //
        // 16-bit counter.
        // Explicit patterns exercise all 16 bits.
        //

        $display("");
        $display("==============================================");
        $display("REFRESH COUNTER TOGGLE TEST");
        $display("==============================================");


        force DUT.refresh_counter = 16'h0000;

        repeat (2)
            @(posedge clk);

        force DUT.refresh_counter = 16'hFFFF;

        repeat (2)
            @(posedge clk);

        force DUT.refresh_counter = 16'hAAAA;

        repeat (2)
            @(posedge clk);

        force DUT.refresh_counter = 16'h5555;

        repeat (2)
            @(posedge clk);

        force DUT.refresh_counter = 16'hFFFF;

        repeat (2)
            @(posedge clk);

        force DUT.refresh_counter = 16'h0000;

        repeat (2)
            @(posedge clk);

        release DUT.refresh_counter;


        // =====================================================
        // NATURAL FULL COUNTER RUN
        // =====================================================

        vif.refresh_div  <= 16'd1;

        vif.display_data <= 64'hFFFF_FFFF_FFFF_FFFF;

        vif.brightness   <= 4'd15;


        repeat (3000)
            @(posedge clk);


        // =====================================================
        // LONG REFRESH COUNTER RUN
        // =====================================================

        vif.refresh_div <= 16'hFFFF;

        repeat (70000)
            @(posedge clk);


        // =====================================================
        // FINAL FAST RUN
        // =====================================================

        vif.refresh_div  <= 16'd1;

        vif.display_data <= 64'hA5A5_5A5A_A5A5_5A5A;

        vif.brightness   <= 4'd8;


        repeat (3000)
            @(posedge clk);


        $display("");
        $display("==============================================");
        $display("TOGGLE COVERAGE STIMULUS COMPLETED");
        $display("==============================================");

    end


    // =========================================================
    // FINAL REPORT
    // =========================================================

    initial begin

        #1200000;

        scb.report();

        $display("");
        $display("==============================================");
        $display("       LED MATRIX TEST COMPLETED");
        $display("==============================================");

        $finish;

    end


    // =========================================================
    // SIMVISION SHM
    // =========================================================

    initial begin

        $shm_open("waves.shm");

        $shm_probe("AS");

    end

endmodule
