`define assert(actual, expected, outputName, inputs, description, type) \
if (actual == expected) begin \
	$display("\nPASSED"); \
end \
else begin \
	$display("\nFAILED"); \
end \
$display("ACTUAL ", type, actual); \
$display("EXPECTED ", type, expected); \
$display("TESTED SIGNAL NAME %s", outputName); \
$display("INPUTS %s", inputs); \
if (description) begin \
	$display("DESCRIPTION %s", description); \
end \
$write("TIME "); \
$display($realtime);

`define info(message) \
$display("INFO %s", message); \
$write("TIME "); \
$display($realtime);

`timescale 1 ns / 1 ns

module testbench;

   reg [31:0] Addr;
   reg [31:0] rd2;
   reg [1:0] StoreType;
   reg [31:0] ReadData;
   wire [31:0] WriteData;

   write_data dut(.Addr(Addr),
		  .rd2(rd2),
		 .ReadData(ReadData),
		 .StoreType(StoreType),
		 .WriteData(WriteData)
		 );
   
    initial begin
       
       // Initialize input - data read from memory.
       ReadData = 32'ha5b4c3d2;
       rd2 = 32'hffffffff;
       Addr = 32'h00000000;
       #10;

       // Write the 32-bit word
       StoreType = 2'b00;
       #10;
       `assert(WriteData, 32'hffffffff,"WriteData","rd2 = 32'hffffffff", "Write 32-bit word in rd2","%x")
       
       // Write the byte 0
       Addr = 32'h00000000;
       StoreType = 2'b01;
       #10;
       `assert(WriteData, 32'ha5b4c3ff,"WriteData","ReadData = 32'ha5b4c3d2, rd2 = 32'hffffffff", "Write byte 0 of rd2","%x")
       
       // Write the byte 1
       Addr = 32'h00000001;
       StoreType = 2'b01;
       #10;
       `assert(WriteData, 32'ha5b4ffd2,"WriteData","ReadData = 32'ha5b4c3d2, rd2 = 32'hffffffff", "Write byte 1 of rd2","%x")
       
       // Write the byte 2
       Addr = 32'h00000002;
       StoreType = 2'b01;
       #10;
       `assert(WriteData, 32'ha5ffc3d2,"WriteData","ReadData = 32'ha5b4c3d2, rd2 = 32'hffffffff", "Write byte 2 of rd2","%x")
       
       // Write the byte 3
       Addr = 32'h00000003;
       StoreType = 2'b01;
       #10;
       `assert(WriteData, 32'hffb4c3d2,"WriteData","ReadData = 32'ha5b4c3d2, rd2 = 32'hffffffff", "Write byte 3 of rd2","%x")
       
       // Write half word 0
       Addr = 32'h00000000;
       StoreType = 2'b10;
       #10;
       `assert(WriteData, 32'ha5b4ffff,"WriteData","ReadData = 32'ha5b4c3d2, rd2 = 32'hffffffff", "Write half word 0 of rd2","%x")
       
       // Read half word 1
       Addr = 32'h00000002;
       StoreType = 2'b10;
       #10;
       `assert(WriteData, 32'hffffc3d2,"WriteData","ReadData = 32'ha5b4c3d2, rd2 = 32'hffffffff", "Write half word 1 of rd2","%x")
       
    end

endmodule
