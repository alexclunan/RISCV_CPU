`timescale 1 ns / 1 ns

module testbench;

   reg Reset;
   reg Clock;
   reg WR;
   reg [31:0] Din;
   wire TxRDY;
   wire TxD;

   UART_Xmit dut(.Reset(Reset),.Clock(Clock),.WR(WR),.Din(Din),
		 .TxRDY(TxRDY),.TxD(TxD));
   
   initial begin

      // Reset the transmitter
      WR = 0;
      Din = 8'b00000000;
      Reset = 1;
      #5;
      Reset = 0;
      #5;

      // First, wait until the transmitter is ready.
      while (TxRDY == 0)
	begin
	   #1;
	end
      
      // Load the data into the transmit buffer (even parity)
      Din = 8'b10011101; // D7-D0
      #5;
      WR = 1;
      #5;
      WR = 0;

      // Now, wait for the data to be transmitted.
      while (TxRDY == 1) // wait until transmission begins
	begin
	   #1;
	end
      while (TxRDY == 0) // wait until transmission completes
	begin
	   #1;
	end
       
      // Load the data into the transmit buffer (odd parity)
      Din = 8'b10011001; // D7-D0
      #5;
      WR = 1;
      #5;
      WR = 0;

      // Now, wait for the data to be transmitted.
      while (TxRDY == 1) // wait until transmission begins
	begin
	   #1;
	end
      while (TxRDY == 0) // wait until transmission completes
	begin
	   #1;
	end
       
    end // initial begin

   always
     begin
      Clock = 1; #10; Clock = 0; #10;
     end
   

endmodule
