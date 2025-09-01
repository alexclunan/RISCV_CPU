module Rcv_ShiftRegister(Reset, Clock, Shift, SerIn, OE, Dout);
   input Reset;
   input Clock;
   input Shift;
   input SerIn;
   input OE; // output enable
   output [31:0] Dout;

   reg [7:0] register;

   always @(posedge(Clock), posedge(Reset)) begin

      if (Reset == 1)
         register <= 8'b0;
      else if (Shift == 1) begin
         register[6:0] <= register[7:0] >> 1;
         register[7] <= SerIn;
      end else
         register <= register;
   end

   assign Dout = OE ? {24'b0, register} : 32'bZ;

endmodule
