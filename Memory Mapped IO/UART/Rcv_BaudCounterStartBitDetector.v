module Rcv_BaudCounterStartBitDetector(Reset, Clock, RxD, Idle, Shift, StartDetect, BaudClock);
   input Reset;
   input Clock;
   input RxD;
   input Idle;
   input Shift;
   output reg StartDetect;
   output BaudClock;

   parameter S0 = 2'd0, S1  = 2'd1, S2   = 2'd2, S3 = 2'd3;

   reg [3:0] Count;
   reg [1:0] CurrentState, NextState;

   assign BaudClock = Count[3];


always @(posedge(Clock)) begin
   if (Reset == 1) 
      Count <= 4'b0;
   else if (CurrentState == S0)
      Count <= 0;
   else
      Count <= Count + 4'b1;
   
   CurrentState <= NextState;
 
end

always @(*) begin
  case(CurrentState)
      S0: begin
         if (RxD == 0)
            NextState <= S1;
         else
            NextState <= S0;
         StartDetect <= 0;
      end

      S1: begin
         if (RxD == 1)
            NextState <= S0;
         else if (Count == 6)
            NextState <= S2;
         else 
            NextState <= S1;

         StartDetect <= 0;
      end

      S2: begin
         if (Shift == 1)
            NextState <= S3;
         else 
            NextState <= S2;

         StartDetect <= 1;
      end

      S3: begin
         if (Idle == 1)
            NextState <= S0;
         else 
            NextState <= S3;

         StartDetect <= 0;
      end


      default: begin
         if (RxD == 0)
            NextState <= S1;
         else
            NextState <= S0;
         StartDetect <= 0;

      end
   endcase

end


endmodule
