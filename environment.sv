class environment;

  generator  gen;
  driver     drv;
  monitor    mon;
  scoreboard scb;

  mailbox #(transaction) gen2drv;
  mailbox #(transaction) mon2scb;

  virtual led_if vif;

  function new(virtual led_if vif);
    this.vif = vif;
    gen2drv  = new();
    mon2scb  = new();

    gen = new(gen2drv);
    drv = new(vif, gen2drv);
    mon = new(vif, mon2scb);
    scb = new(mon2scb);
  endfunction

  task pre_test();
    drv.reset();
  endtask

  task test_run();
    fork
      gen.main();
      drv.main();
      mon.main();
      scb.main();
    join_any
  endtask

  task post_test();
    wait(gen.ended.triggered);
    // 2000 cycles ensures full PWM cycles (16 clocks each) occur across all 8 rows
    repeat (2000) @(vif.mon_cb);
  endtask

  task run();
    pre_test();
    test_run();
    post_test();
    $finish;
  endtask

endclass
