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

   reg [7:0] d0_tb;
   reg [7:0] d1_tb;
   reg [7:0] d2_tb;
   reg [7:0] d3_tb;
   reg [1:0] sel_tb;
   wire [7:0] y_tb;

   mux4 dut(.d0(d0_tb),.d1(d1_tb),.d2(d2_tb),.d3(d3_tb),.sel(sel_tb),.y(y_tb));
   	defparam	dut.WIDTH = 8;
   
   initial begin
       
      // Initialize input.
      d0_tb = 8'h03;
      d1_tb = 8'h0c;
      d2_tb = 8'h30;
      d3_tb = 8'hc0;
      
      // Select d0
      sel_tb = 2'b00;
      #10;
      `assert(y_tb, 8'h03,"y","sel = 00", "Select d0","%x")
       
      // Select d1
      sel_tb = 2'b01;
      #10;
      `assert(y_tb, 8'h0c,"y","sel = 01", "Select d1","%x")
       
      // Select d2
      sel_tb = 2'b10;
      #10;
      `assert(y_tb, 8'h30,"y","sel = 10", "Select d2","%x")
       
      // Select d3
      sel_tb = 2'b11;
      #10;
      `assert(y_tb, 8'hc0,"y","sel = 11", "Select d3","%x")
       
      `info("End of tests")
       
   end

endmodule
