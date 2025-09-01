module Xmit_Controller (Reset, Clock, WR, Idle, Start, Shift, Parity, Stop, TxRDY);

   input Reset;
   input Clock;
   input WR;
   output reg Idle;
   output reg Start;
   output reg Shift;
   output reg Parity;
   output reg Stop;
   output reg TxRDY;

   reg [2:0] Count;
   reg [2:0] CurrentState, NextState;


   parameter TidleS = 0, TstartS = 1, TshiftS = 2, TparityS = 3, TstopS = 4;


always @(posedge(Reset), posedge(WR), posedge(Idle)) begin
   if (Reset == 1) 
      TxRDY <= 1'b1;
   else begin
      if (WR == 1)
         TxRDY <= 1'b0;
      else if (CurrentState == TidleS)
         TxRDY <= 1'b1;
      else 
         TxRDY <= TxRDY;
   end
end

always @(posedge(Clock), posedge(Reset)) begin
   if (Reset == 1) 
      Count <= 3'b0;
   else if (CurrentState == TshiftS)
      Count <= Count + 3'b1;
      
   else 
      Count <= Count;
   
   
end

always @(posedge(Clock)) begin
   CurrentState <= NextState;
end

always @(*) begin
  case(CurrentState)
      TidleS: begin
         if (TxRDY == 0)
            NextState <= TstartS;
         else
            NextState <= TidleS;

         Idle     <= 1;
         Start    <= 0;
         Shift    <= 0;
         Parity   <= 0;
         Stop     <= 0;
      end

      TstartS: begin
         NextState <= TshiftS;

         Idle     <= 0;
         Start    <= 1;
         Shift    <= 0;
         Parity   <= 0;
         Stop     <= 0;
      end

      TshiftS: begin
         if (Count == 7)
            NextState <= TparityS;
         else
            NextState <= TshiftS;

         Idle     <= 0;
         Start    <= 0;
         Shift    <= 1;
         Parity   <= 0;
         Stop     <= 0;
      end

      TparityS: begin
         
         NextState <= TstopS;

         Idle     <= 0;
         Start    <= 0;
         Shift    <= 0;
         Parity   <= 1;
         Stop     <= 0;
      end

      TstopS: begin
         
         NextState <= TidleS;

         Idle     <= 0;
         Start    <= 0;
         Shift    <= 0;
         Parity   <= 0;
         Stop     <= 1;
      end
      default: begin
         if (TxRDY == 0)
            NextState <= TstartS;
         else
            NextState <= TidleS;

         Idle     <= 1;
         Start    <= 0;
         Shift    <= 0;
         Parity   <= 0;
         Stop     <= 0;
      end
   endcase

end


endmodule
