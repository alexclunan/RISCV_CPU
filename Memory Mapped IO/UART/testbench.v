`timescale 1ns / 1ns

module testbench;

   reg	Reset;
   reg	WR;
   reg	Clock;
   reg	RD;
   reg 	CE_SR;
   reg 	CE_UART;
   wire [31:0] ReadData;
   reg [31:0] WriteData;
   reg [7:0] StringData[0:13];
   reg [31:0] status_register;
   reg [31:0] received_data;
   wire 	    Txd2Rxd;
   integer 	    num_transmitted;
   integer 	    num_received;

   UART	b2v_DUT(
		.Reset(Reset),
		.WR(WR),
		.Clock(Clock),
		.RxD(Txd2Rxd),
		.RD(RD),
		.CE_SR(CE_SR),
		.CE_UART(CE_UART),
		.WriteData(WriteData),
		.TxD(Txd2Rxd),
		.ReadData(ReadData)
		);

   initial begin

      // Reset the transmitter
      StringData[0] = 8'h55; // U
      StringData[1] = 8'h41; // A
      StringData[2] = 8'h52; // R
      StringData[3] = 8'h54; // T
      StringData[4] = 8'h20; // space
      StringData[5] = 8'h56; // V
      StringData[6] = 8'h69; // i
      StringData[7] = 8'h63; // c
      StringData[8] = 8'h74; // t
      StringData[9] = 8'h6f; // o
      StringData[10] = 8'h72; // r
      StringData[11] = 8'h79; // y
      StringData[12] = 8'h21; // !
      StringData[13] = 0;
      
      WR = 0; RD = 0; CE_SR = 0; CE_UART = 0;
      WriteData = 32'h00000000;
      status_register = 32'h00000000;
      received_data = 32'h00000000;
      Reset = 1;
      #5;
      Reset = 0;
      #5;

      num_received = 0;
      num_transmitted = 0;
      while (num_received < 14)
	begin
	   // read status register
	   CE_SR = 1; // enable reading of status register
	   RD = 1;
	   #20;
	   status_register = ReadData;
	   #20;
	   CE_SR = 0;
	   RD = 0;
	   #20;

	   // if transmitter empty, transmit byte i
	   if ((status_register & 32'h00000001) == 1)
		if (num_transmitted < 14)
		  begin
		     WriteData = {24'h000000,StringData[num_transmitted]};
		     num_transmitted = num_transmitted + 1;
		     #20;
		     WR = 1; CE_UART = 1;
		     #20;
		     WR = 0; CE_UART = 0;
		     #20;
		  end
	     
	   // if receiver full, read byte num_received
	   if ((status_register & 32'h00000002) == 2)
	     begin
		RD = 1; CE_UART = 1;
		#20;
		received_data = ReadData;
		num_received = num_received + 1;
		#20;
		RD = 0; CE_UART = 0;
		#20;
	     end
	end

    end // initial begin

   always
     begin
      Clock = 1; #10; Clock = 0; #10;
     end

endmodule
