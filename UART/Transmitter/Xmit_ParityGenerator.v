module Xmit_ParityGenerator (Reset, Clock, Din, Enable, Parity);

   input Reset;
   input Clock;
   input Din;
   input Enable;
   output reg Parity;


always @(posedge(Clock), posedge(Reset)) begin
   if (Reset == 1)
      Parity <= 0;
   else if(Enable == 1) 
      Parity <= Parity ^ Din;
   else 
      Parity <= Parity;

end


endmodule
