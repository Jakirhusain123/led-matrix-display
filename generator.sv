class generator;

    mailbox #(transaction) gen2drv;

    transaction tr;


    function new(mailbox #(transaction) gen2drv);

        this.gen2drv = gen2drv;

    endfunction


    // =========================================================
    // SEND PATTERN
    // =========================================================

    task send_pattern(
        input logic [63:0] pattern,
        input logic [3:0]  bright,
        input logic [15:0] refresh
    );

        tr = new();

        tr.display_data = pattern;
        tr.brightness   = bright;
        tr.refresh_div  = refresh;

        gen2drv.put(tr);

        tr.display("GENERATOR");

    endtask


    // =========================================================
    // RUN
    // =========================================================

    task run();


        // =====================================================
        // DISPLAY DATA TOGGLE TEST
        // =====================================================

        send_pattern(
            64'h0000_0000_0000_0000,
            4'd15,
            16'd5
        );

        send_pattern(
            64'hFFFF_FFFF_FFFF_FFFF,
            4'd15,
            16'd5
        );

        send_pattern(
            64'hAAAA_AAAA_AAAA_AAAA,
            4'd15,
            16'd5
        );

        send_pattern(
            64'h5555_5555_5555_5555,
            4'd15,
            16'd5
        );

        send_pattern(
            64'h0000_0000_FFFF_FFFF,
            4'd15,
            16'd5
        );

        send_pattern(
            64'hFFFF_FFFF_0000_0000,
            4'd15,
            16'd5
        );

        send_pattern(
            64'h0123_4567_89AB_CDEF,
            4'd15,
            16'd5
        );

        send_pattern(
            64'hFEDC_BA98_7654_3210,
            4'd15,
            16'd5
        );


        // =====================================================
        // BRIGHTNESS TOGGLE TEST
        // =====================================================

        send_pattern(
            64'hFFFF_FFFF_FFFF_FFFF,
            4'd0,
            16'd5
        );

        send_pattern(
            64'hFFFF_FFFF_FFFF_FFFF,
            4'd1,
            16'd5
        );

        send_pattern(
            64'hFFFF_FFFF_FFFF_FFFF,
            4'd4,
            16'd5
        );

        send_pattern(
            64'hFFFF_FFFF_FFFF_FFFF,
            4'd5,
            16'd5
        );

        send_pattern(
            64'hFFFF_FFFF_FFFF_FFFF,
            4'd8,
            16'd5
        );

        send_pattern(
            64'hFFFF_FFFF_FFFF_FFFF,
            4'd11,
            16'd5
        );

        send_pattern(
            64'hFFFF_FFFF_FFFF_FFFF,
            4'd12,
            16'd5
        );

        send_pattern(
            64'hFFFF_FFFF_FFFF_FFFF,
            4'd15,
            16'd5
        );


        // =====================================================
        // REFRESH DIVIDER TOGGLE TEST
        // =====================================================

        send_pattern(
            64'hAAAAAAAAAAAAAAAA,
            4'd8,
            16'd0
        );

        send_pattern(
            64'h5555555555555555,
            4'd8,
            16'd1
        );

        send_pattern(
            64'hAAAAAAAAAAAAAAAA,
            4'd8,
            16'd2
        );

        send_pattern(
            64'h5555555555555555,
            4'd8,
            16'd5
        );

        send_pattern(
            64'hAAAAAAAAAAAAAAAA,
            4'd8,
            16'd10
        );


        // =====================================================
        // ALL ROWS
        // =====================================================

        send_pattern(
            64'h0000_0000_0000_00FF,
            4'd15,
            16'd1
        );

        send_pattern(
            64'h0000_0000_0000_FF00,
            4'd15,
            16'd1
        );

        send_pattern(
            64'h0000_0000_00FF_0000,
            4'd15,
            16'd1
        );

        send_pattern(
            64'h0000_0000_FF00_0000,
            4'd15,
            16'd1
        );

        send_pattern(
            64'h0000_00FF_0000_0000,
            4'd15,
            16'd1
        );

        send_pattern(
            64'h0000_FF00_0000_0000,
            4'd15,
            16'd1
        );

        send_pattern(
            64'h00FF_0000_0000_0000,
            4'd15,
            16'd1
        );

        send_pattern(
            64'hFF00_0000_0000_0000,
            4'd15,
            16'd1
        );


        // =====================================================
        // *** IMPORTANT ***
        // FULL 16-BIT REFRESH COUNTER TEST
        // =====================================================

        tr = new();

        tr.display_data = 64'hFFFF_FFFF_FFFF_FFFF;

        tr.brightness   = 4'd15;

        tr.refresh_div  = 16'hFFFF;

        gen2drv.put(tr);

        tr.display("FULL_16BIT_COUNTER_TEST");


        // =====================================================
        // RETURN TO FAST SCANNING
        // =====================================================

        send_pattern(
            64'hA5A5_5A5A_A5A5_5A5A,
            4'd8,
            16'd1
        );


        // =====================================================
        // RANDOM TESTS
        // =====================================================

        repeat (20) begin

            tr = new();

            if (!tr.randomize())
                $error("Randomization failed");

            gen2drv.put(tr);

            tr.display("RANDOM");

        end

    endtask

endclass
