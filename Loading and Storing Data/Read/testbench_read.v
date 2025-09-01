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
   reg [2:0] LoadType;
   reg [31:0] ReadData;
   wire [31:0] ReadDataOut;

   read_data dut(.Addr(Addr),
		 .LoadType(LoadType),
		 .ReadData(ReadData),
		 .ReadDataOut(ReadDataOut)
		 );
   
    initial begin
       
       // Initialize input - data read from memory.
       ReadData = 32'ha5b4c3d2;
       Addr = 32'h00000000;
       #10;

       // Read the 32-bit word
       LoadType = 3'b000;
       #10;
       `assert(ReadDataOut, 32'ha5b4c3d2,"ReadDataOut","ReadData = 32'ha5b4c3d2", "Read the 32-bit word","%x")
       
       // Read the byte 0, zero extend
       Addr = 32'h00000000;
       LoadType = 3'b001;
       #10;
       `assert(ReadDataOut, 32'h000000d2,"ReadDataOut","ReadData = 32'ha5b4c3d2", "Read byte 0, zero extend","%x")
       
       // Read the byte 1, zero extend
       Addr = 32'h00000001;
       LoadType = 3'b001;
       #10;
       `assert(ReadDataOut, 32'h000000c3,"ReadDataOut","ReadData = 32'ha5b4c3d2", "Read byte 1, zero extend","%x")
       
       // Read the byte 2, zero extend
       Addr = 32'h00000002;
       LoadType = 3'b001;
       #10;
       `assert(ReadDataOut, 32'h000000b4,"ReadDataOut","ReadData = 32'ha5b4c3d2", "Read byte 2, zero extend","%x")
       
       // Read the byte 3, zero extend
       Addr = 32'h00000003;
       LoadType = 3'b001;
       #10;
       `assert(ReadDataOut, 32'h000000a5,"ReadDataOut","ReadData = 32'ha5b4c3d2", "Read byte 3, zero extend","%x")
       
       // Read the byte 0, sign extend
       Addr = 32'h00000000;
       LoadType = 3'b010;
       #10;
       `assert(ReadDataOut, 32'hffffffd2,"ReadDataOut","ReadData = 32'ha5b4c3d2", "Read byte 0, sign extend","%x")
       
       // Read the byte 1, sign extend
       Addr = 32'h00000001;
       LoadType = 3'b010;
       #10;
       `assert(ReadDataOut, 32'hffffffc3,"ReadDataOut","ReadData = 32'ha5b4c3d2", "Read byte 1, sign extend","%x")
       
       // Read the byte 2, sign extend
       Addr = 32'h00000002;
       LoadType = 3'b010;
       #10;
       `assert(ReadDataOut, 32'hffffffb4,"ReadDataOut","ReadData = 32'ha5b4c3d2", "Read byte 2, sign extend","%x")
       
       // Read the byte 3, sign extend
       Addr = 32'h00000003;
       LoadType = 3'b010;
       #10;
       `assert(ReadDataOut, 32'hffffffa5,"ReadDataOut","ReadData = 32'ha5b4c3d2", "Read byte 3, sign extend","%x")
       
       // Read half word 0, zero extend
       Addr = 32'h00000000;
       LoadType = 3'b100;
       #10;
       `assert(ReadDataOut, 32'h0000c3d2,"ReadDataOut","ReadData = 32'ha5b4c3d2", "Read half word 0, zero extend","%x")
       
       // Read half word 1, zero extend
       Addr = 32'h00000002;
       LoadType = 3'b100;
       #10;
       `assert(ReadDataOut, 32'h0000a5b4,"ReadDataOut","ReadData = 32'ha5b4c3d2", "Read half word 1, zero extend","%x")
       
       // Read half word 0, sign extend
       Addr = 32'h00000000;
       LoadType = 3'b101;
       #10;
       `assert(ReadDataOut, 32'hffffc3d2,"ReadDataOut","ReadData = 32'ha5b4c3d2", "Read half word 0, sign extend","%x")
       
       // Read half word 1, sign extend
       Addr = 32'h00000002;
       LoadType = 3'b101;
       #10;
       `assert(ReadDataOut, 32'hffffa5b4,"ReadDataOut","ReadData = 32'ha5b4c3d2", "Read half word 1, sign extend","%x")

       `info("End of tests")
       
    end

endmodule
