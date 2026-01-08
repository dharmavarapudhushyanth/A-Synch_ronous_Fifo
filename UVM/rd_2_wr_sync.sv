
module rd_2_wr_sync #(parameter Addr_Width=9)(wclk,wrst,rptr,rptr_s);

input bit wclk, wrst;
  input logic [Addr_Width:0]  rptr;
  output logic [Addr_Width:0] rptr_s;

  logic [Addr_Width:0] rdptr1;
  always_ff@(posedge wclk) begin
    if(!wrst) begin
      rdptr1 <= 0;
      rptr_s <= 0;
    end
    else begin
      rdptr1 <= rptr;
      rptr_s <= rdptr1;//two clock cycles delay
    end
  end
endmodule
