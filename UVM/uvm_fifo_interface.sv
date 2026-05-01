
interface uvm_fifo(input bit wclk, rclk, wrst, rrst);
parameter Depth=512, Data_Width=8, Addr_Width=9;
logic winc, rinc;
logic [Addr_Width:0] rptr_s, wptr_s, wr_addr, wptr,rd_addr, rptr;
bit full, empty;
logic [Data_Width-1:0] data_in,data_out;
logic  [Data_Width-1:0] wr_data_q[$],rd_data;
logic half_empty;
logic half_full;

/********** assertions *********/

assert property (@(posedge rclk)
 disable iff (!rrst)
 (rptr == wptr) |-> empty
) else $error("FIFO empty signal error at time %t", $time);


assert property (@(posedge wclk)
disable iff (!wrst)
  (wptr + 1 == rptr) |=> full
) else $error("FIFO full signal error at time %t", $time);
  
  
 assert property (@(posedge wclk)
disable iff (!wrst)
                  winc |-> !($isunknown(data_in))
) else $error("FIFO data_in signal error at time %t", $time);
   
  
assert property (@(posedge rclk)
 disable iff (!rrst)
 rinc |-> !($isunknown(data_out))
 ) else $error("FIFO data_out signal error at time %t", $time);

assert property (@(posedge wclk)
                 disable iff (!wrst)
                 (!wrst |-> (wptr == 0))
) else $error("Write pointer reset error at time %t", $time);

  assert property (@(posedge rclk)
                   disable iff (!rrst)
                   (!rrst |-> (rptr == 0))
) else $error("Write pointer reset error at time %t", $time);
endinterface 





   /// synchronous FIFO Assertions

   1. empty condition
   2. full condition
   3. no write on full.
   4. No read on Empty
   5. Data valid on write
   6. Data valid on Read
   7. Pointer Increment write 
   8. Pointer Increment read
   9. Reset Behaviour

   Empty condition:
   assert property(@(posedge clk) disable iff(!rst_n) (wptr == rtpr) |-> empty);

   Full Condition:
   assert property(@(posedge clk) disable iff(!rst_n) ((wptr + 1) == rptr |-> full);
 
   No write on full:
   assert property(@(posedge clk) disable iff (!rst_n) full |-> !winc);

   No read on Empty:
   assert property(@(posedge clk) disable iff(!rst_n) empty |-> !rinc);

   Data Valid on Read
   assert property(@(posedge clk) disable iff(!rst_n) rinc |-> !$isunknown(data_out));

   Pointer Increment(write)
   assert property(@(posedge clk) disable iff(!rst_n) (win && !full) |-> (wptr == $past(wptr) + 1));

   Pointer increment (read)
  assert property(@(posedge clk) disable iff(!rst_n) |-> (wptr == 0 && rtpr == 0 && empty && !full));

   Reset Behavior
   assert property (@(posedge clk) !rst_n |-> (wptr == 0 && rptr));


    // Asynchronous FIFO Assertion.
    1. Gray code check
    2. Write pointer increment
    3. Read pointer increment
    4. Full Condition
    5. Empty Condition
    6. No write on full
    7. No read on empty
    8. synchronizer stability(2 flop sync idea)
    9. Reset write Domain
    10. Reset Read Domain
    11. Data valid checks
    
    

    






































   
