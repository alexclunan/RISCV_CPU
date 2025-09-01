module Rcv_ParityCheck(Reset, Clock, Compute, Check, RxD, RxParityErr);
   input Reset;
   input Clock;
   input Compute;
   input Check;
   input RxD;
   output reg RxParityErr;

   reg new_parity;

   always @(posedge(Clock), posedge(Reset)) begin

      if (Reset == 1) begin
         RxParityErr <= 0;
         new_parity <= 0;
      end else begin
         if (Compute == 1)
            new_parity <= new_parity ^ RxD;
         if (Check == 1 && (new_parity != RxD))
            RxParityErr <= 1;

      end
   end
   
endmodule
