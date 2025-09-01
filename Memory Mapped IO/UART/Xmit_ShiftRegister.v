module Xmit_ShiftRegister (Load, Shift, Clock, Din, SerOut);

   input Load;
   input Shift;
   input Clock;
   input [7:0] Din;
   output      SerOut;

   reg [7:0] register;

   always @(posedge(Clock)) begin

   if (Load == 1)
      register <= Din;
   else if(Shift == 1)
      register <= register >> 1;
   else
      register <= register;

   end

assign SerOut = register[0];


endmodule
