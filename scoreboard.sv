class scoreboard;

    mailbox #(transaction) mon2scb;

    int pass_count;
    int fail_count;


    function new(
        mailbox #(transaction) mon2scb
    );

        this.mon2scb = mon2scb;

        pass_count = 0;
        fail_count = 0;

    endfunction


    function bit valid_row(
        input logic [7:0] row_value
    );

        case (row_value)

            8'b0000_0001,
            8'b0000_0010,
            8'b0000_0100,
            8'b0000_1000,
            8'b0001_0000,
            8'b0010_0000,
            8'b0100_0000,
            8'b1000_0000:

                return 1'b1;

            default:

                return 1'b0;

        endcase

    endfunction


    task run();

        transaction tr;

        forever begin

            mon2scb.get(tr);

            if (valid_row(tr.expected_row)) begin

                pass_count++;

            end
            else begin

                fail_count++;

                $error(
                    "SCOREBOARD ERROR: Invalid ROW = %08b",
                    tr.expected_row
                );

            end

        end

    endtask


    function void report();

        $display("");
        $display("==============================================");
        $display("           SCOREBOARD REPORT");
        $display("==============================================");

        $display("PASS COUNT = %0d", pass_count);
        $display("FAIL COUNT = %0d", fail_count);

        if (fail_count == 0)
            $display("RESULT     = PASS");
        else
            $display("RESULT     = FAIL");

        $display("==============================================");

    endfunction

endclass
