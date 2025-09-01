module Xmit_mux3(d0,d1,d2,sel,y);

   input d0;
   input d1;
   input d2;
   input [1:0]	     sel;
   output y;   


mux3 #(.WIDTH(1)) mux3_0(.d0(d0), .d1(d1), .d2(d2), .sel(sel), .y(y)); 

endmodule
