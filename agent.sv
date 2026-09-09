class agent;
  generator  gen;
  driver     drv;
  monitor    mon;
  mailbox #(transaction) gen2drv;
  mailbox #(transaction) mon2scb;

  function new(virtual led_if vif, mailbox #(transaction) mon2scb);
    gen2drv = new();
    this.mon2scb = mon2scb;

    gen = new(gen2drv);
    drv = new(vif, gen2drv);
    mon = new(vif, mon2scb);
  endfunction

  task run();
    fork
      gen.main(); // Changed from gen.run()
      drv.main(); // Changed from drv.run()
      mon.main(); // Changed from mon.run()
    join_any
  endtask
endclass
