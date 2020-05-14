
module assertion_fsm(
  input in,clk,reset,mealy_out,
  input [3:0]mealy_ps,mealy_ns);
  
  property async_reset;
    @(posedge clk) !reset |-> mealy_ps[0];
  endproperty
  
  property in_idle_input_one;
    @(posedge clk)
    disable iff(!reset)
    (mealy_ps[0] && in) |=> mealy_ps[1];
  endproperty
  
  property in_idle_input_zero;
    @(posedge clk)
    disable iff(!reset)
    (mealy_ps[0] && !in) |=> $stable(mealy_ps);
  endproperty
  
  property in_a_input_one;
     @(posedge clk)
    disable iff(!reset)
    (mealy_ps[1] && in) |=> mealy_ps[2];
  endproperty
  
  property in_a_input_zero;
     @(posedge clk)
    disable iff(!reset)
    (mealy_ps[1] && !in) |=> mealy_ps[0];
  endproperty
  
  property in_b_input_one;
     @(posedge clk)
    disable iff(!reset)
    (mealy_ps[2] && in) |=> $stable(mealy_ps);
  endproperty
  
  property in_b_input_zero;
     @(posedge clk)
    disable iff(!reset)
    (mealy_ps[2] && !in) |=> mealy_ps[3];
  endproperty
  
  property in_c_input_one;
     @(posedge clk)
    disable iff(!reset)
    (mealy_ps[3] && in) |=> (mealy_ps[1] |-> mealy_out);
  endproperty
  
  property in_c_input_zero;
     @(posedge clk)
    disable iff(!reset)
    (mealy_ps[3] && !in) |=> $stable(mealy_ps);
  endproperty
  
  property output_one;
    @(posedge clk)
    disable iff(!reset)
    mealy_out |-> (mealy_ps[3] && in);
  endproperty
           
  
  assert property(async_reset);
  assert property(in_idle_input_one);
  assert property(in_idle_input_zero);
  assert property(in_a_input_one);
  assert property(in_a_input_zero);
  assert property(in_b_input_one);
  assert property(in_b_input_zero);
  assert property(in_c_input_one);
  assert property(in_c_input_zero);
  assert property(output_one);
        
endmodule
