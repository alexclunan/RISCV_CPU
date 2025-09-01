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
   reg sel_tb;
   wire [7:0] y_tb;

   mux2 dut(.d0(d0_tb),.d1(d1_tb),.sel(sel_tb),.y(y_tb));
   	defparam	dut.WIDTH = 8;
   
   initial begin
       
      // Initialize input.
      d0_tb = 8'h0f;
      d1_tb = 8'hf0;
      
      // Select d0
      sel_tb = 0;
      #10;
      `assert(y_tb, 8'h0f,"y","sel = 0", "Select d0","%x")
       
      // Select d1
      sel_tb = 1;
      #10;
      `assert(y_tb, 8'hf0,"y","sel = 1", "Select d1","%x")
       
      `info("End of tests")
       
   end

endmodule
