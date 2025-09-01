module Rcv_Controller(Reset, Clock, StartDetect, RD, Idle, Shift, Parity, Stop, RxRDY);
   input Reset;
   input Clock;
   input StartDetect;
   input RD; // read signal for Dout
   output reg Idle;
   output reg Shift;
   output reg Parity;
   output reg Stop;
   output reg RxRDY;

   reg [1:0] CurrentState, NextState;
   reg [3:0] Count;

   parameter RcvIdle = 2'd0, RcvShift = 2'd1, RcvParity = 2'd2, RcvStop = 2'd3;

always @(posedge(Reset), posedge(RD), posedge(Stop)) begin
   if (Reset == 1 || RD == 1) 
      RxRDY <= 1'b0;
   else begin
      if (Stop == 1)
         RxRDY <= 1'b1;
      else 
         RxRDY <= RxRDY;
   end
end


always @(posedge(Clock), posedge(Reset), posedge(StartDetect)) begin
   if (Reset == 1 || StartDetect == 1) 
      Count <= 4'b0;
   else if (CurrentState == RcvShift)
      Count <= Count + 4'b1;
   else
      Count <= 0;
end

always @(posedge(Clock)) begin
   CurrentState <= NextState;
end

always @(*) begin
  case(CurrentState)
      RcvIdle: begin
         if (StartDetect == 1)
            NextState <= RcvShift;
         else
            NextState <= RcvIdle;

         Idle     <= 1;
         Shift    <= 0;
         Parity   <= 0;
         Stop     <= 0;
      end

      RcvShift: begin
         if (Count == 7)
            NextState <= RcvParity;
         else 
            NextState <= RcvShift;

         Idle     <= 0;
         Shift    <= 1;
         Parity   <= 0;
         Stop     <= 0;
      end

      RcvParity: begin

         NextState <= RcvStop;

         Idle     <= 0;
         Shift    <= 0;
         Parity   <= 1;
         Stop     <= 0;
      end

      RcvStop: begin

         NextState <= RcvIdle;

         Idle     <= 0;
         Shift    <= 0;
         Parity   <= 0;
         Stop     <= 1;
      end


      default: begin
         if (StartDetect == 1)
            NextState <= RcvShift;
         else
            NextState <= RcvIdle;

         Idle     <= 1;
         Shift    <= 0;
         Parity   <= 0;
         Stop     <= 0;

      end
   endcase

end



   
endmodule
