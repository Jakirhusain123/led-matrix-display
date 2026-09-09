program test(led_if vif);

  import tb_pkg::*; 

  environment env;

  initial begin
    env = new(vif);
    // 100 transactions are more than enough when REFRESH_DIV is overridden in top.sv
    env.gen.repeat_count = 100; 
    env.run();
  end

endprogram
