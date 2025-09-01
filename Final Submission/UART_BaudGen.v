module UART_BaudGen (Reset, Clock, BaudClock, BaudClock16);
  
   input Clock;		// System clock
   input Reset;		// System reset
   output BaudClock;    // Baud clock
   output BaudClock16;	// Baud clock x 16

   reg [4:0] BaudCount;

   always @(posedge(Clock), posedge(Reset)) begin
      if (Reset == 1)
         BaudCount <= 5'b0;
      else
         BaudCount <= BaudCount + 5'b1;
   end

   assign BaudClock = BaudCount[4];
   assign BaudClock16 = BaudCount[0];


endmodule
