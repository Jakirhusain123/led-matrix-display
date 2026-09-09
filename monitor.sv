class monitor;

    virtual led_matrix_if vif;

    mailbox #(transaction) mon2scb;


    function new(
        virtual led_matrix_if vif,
        mailbox #(transaction) mon2scb
    );

        this.vif     = vif;
        this.mon2scb = mon2scb;

    endfunction


    task run();

        transaction tr;

        forever begin

            @(posedge vif.clk);

            if (!vif.rst) begin

                tr = new();

                tr.expected_row = vif.row;
                tr.expected_col = vif.col;

                mon2scb.put(tr);

                $display(
                    "MONITOR: ROW=%08b COL=%08b",
                    vif.row,
                    vif.col
                );

            end

        end

    endtask

endclass
