`timescale 1 ns / 1 ns

module testbench;

   reg Reset;
   reg Clock;
   reg RxD;
   reg RD;
   wire [31:0] Dout;
   wire RxRDY;
   wire RxParityErr;

   integer i;

   UART_Rcv dut(.Reset(Reset),.Clock(Clock),.RxD(RxD),.RD(RD),
		 .RxParityErr(RxParityErr),.RxRDY(RxRDY),.Dout(Dout));
   
   initial begin
      // Reset the receiver
      RD = 0; Clock = 0; RxD = 1; // idle value
      Reset = 1;
      #5;
      Reset = 0;
      #5;

      // Begin shifting in serial data
      // Stop bit (0), Din[7:0] = 10011101, parity = 1
      RxD = 0; // stop bit
      for (i = 0; i <16; i = i + 1)
	begin
	   Clock = 1; #10; Clock = 0; #10;
	end
      RxD = 1; // Dout[0]
      for (i = 0; i <16; i = i + 1)
	begin
	   Clock = 1; #10; Clock = 0; #10;
	end
      RxD = 0; // Dout[1]
      for (i = 0; i <16; i = i + 1)
	begin
	   Clock = 1; #10; Clock = 0; #10;
	end
      RxD = 1; // Dout[2]
      for (i = 0; i <16; i = i + 1)
	begin
	   Clock = 1; #10; Clock = 0; #10;
	end
      RxD = 1; // Dout[3]
      for (i = 0; i <16; i = i + 1)
	begin
	   Clock = 1; #10; Clock = 0; #10;
	end
      RxD = 1; // Dout[4]
      for (i = 0; i <16; i = i + 1)
	begin
	   Clock = 1; #10; Clock = 0; #10;
	end
      RxD = 0; // Dout[5]
      for (i = 0; i <16; i = i + 1)
	begin
	   Clock = 1; #10; Clock = 0; #10;
	end
      RxD = 0; // Dout[6]
      for (i = 0; i <16; i = i + 1)
	begin
	   Clock = 1; #10; Clock = 0; #10;
	end
      RxD = 1; // Dout[7]
      for (i = 0; i <16; i = i + 1)
	begin
	   Clock = 1; #10; Clock = 0; #10;
	end
      RxD = 1; // parity
      for (i = 0; i <16; i = i + 1)
	begin
	   Clock = 1; #10; Clock = 0; #10;
	end

      // Now, wait for RxRDY to indicate data is available.
      while (RxRDY == 0)
	begin
	   #1;
	end
      
      // Read Dout to reset receiver.
      RD = 1; #10; RD = 0; #10;

      // RxD in idle state.
      RxD = 1;
      for (i = 0; i <16; i = i + 1)
	begin
	   Clock = 1; #10; Clock = 0; #10;
	end

      // Stop bit (0), Din[7:0] = 10011001, parity = 0
      RxD = 0; // stop bit
      for (i = 0; i <16; i = i + 1)
	begin
	   Clock = 1; #10; Clock = 0; #10;
	end
      RxD = 1; // Dout[0]
      for (i = 0; i <16; i = i + 1)
	begin
	   Clock = 1; #10; Clock = 0; #10;
	end
      RxD = 0; // Dout[1]
      for (i = 0; i <16; i = i + 1)
	begin
	   Clock = 1; #10; Clock = 0; #10;
	end
      RxD = 0; // Dout[2]
      for (i = 0; i <16; i = i + 1)
	begin
	   Clock = 1; #10; Clock = 0; #10;
	end
      RxD = 1; // Dout[3]
      for (i = 0; i <16; i = i + 1)
	begin
	   Clock = 1; #10; Clock = 0; #10;
	end
      RxD = 1; // Dout[4]
      for (i = 0; i <16; i = i + 1)
	begin
	   Clock = 1; #10; Clock = 0; #10;
	end
      RxD = 0; // Dout[5]
      for (i = 0; i <16; i = i + 1)
	begin
	   Clock = 1; #10; Clock = 0; #10;
	end
      RxD = 0; // Dout[6]
      for (i = 0; i <16; i = i + 1)
	begin
	   Clock = 1; #10; Clock = 0; #10;
	end
      RxD = 1; // Dout[7]
      for (i = 0; i <16; i = i + 1)
	begin
	   Clock = 1; #10; Clock = 0; #10;
	end
      RxD = 0; // parity
      for (i = 0; i <16; i = i + 1)
	begin
	   Clock = 1; #10; Clock = 0; #10;
	end

      // Now, wait for RxRDY to indicate data is available.
      while (RxRDY == 0)
	begin
	   #1;
	end
      
      // Read Dout to reset receiver. RxD in idle state.
      RD = 1; #10; RD = 0; #10;

    end // initial begin

endmodule
