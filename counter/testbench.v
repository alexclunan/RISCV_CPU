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

   reg reset, clock, s0, s1;
   wire q0, q1;

   counters dut(.reset(reset),.clock(clock),.s0(s0),.s1(s1),.q0(q0),.q1(q1));
   
   initial begin

      // Initialize input signals
      clock = 0;
      s1 = 0; s0 = 0;
       
      // Reset counter.
      reset = 1; #10;
      reset = 0; #40;

      // Test the modulo-4 up mode of the counter.
      `assert({q1,q0}, 2'b00,"(q1,q0)","(s1,s0) = 2'b00", "Modulo-4 up","%b")
      clock = 1; #50; clock = 0; #50;
      `assert({q1,q0}, 2'b01,"(q1,q0)","(s1,s0) = 2'b00", "Modulo-4 up","%b")
      clock = 1; #50; clock = 0; #50;
      `assert({q1,q0}, 2'b10,"(q1,q0)","(s1,s0) = 2'b00", "Modulo-4 up","%b")
      clock = 1; #50; clock = 0; #50;
      `assert({q1,q0}, 2'b11,"(q1,q0)","(s1,s0) = 2'b00", "Modulo-4 up","%b")
      clock = 1; #50; 
      `assert({q1,q0}, 2'b00,"(q1,q0)","(s1,s0) = 2'b00", "Modulo-4 up","%b")
       
      // Test the modulo-4 down mode of the counter.
      s1 = 0; s0 = 1; clock = 0; #50;
      clock = 1; #50; clock = 0; #50;
      `assert({q1,q0}, 2'b11,"(q1,q0)","(s1,s0) = 2'b01", "Modulo-4 down","%b")
      clock = 1; #50; clock = 0; #50;
      `assert({q1,q0}, 2'b10,"(q1,q0)","(s1,s0) = 2'b01", "Modulo-4 down","%b")
      clock = 1; #50; clock = 0; #50;
      `assert({q1,q0}, 2'b01,"(q1,q0)","(s1,s0) = 2'b01", "Modulo-4 down","%b")
      clock = 1; #50; clock = 0; #50;
      `assert({q1,q0}, 2'b00,"(q1,q0)","(s1,s0) = 2'b01", "Modulo-4 down","%b")
      clock = 1; #50; 
      `assert({q1,q0}, 2'b11,"(q1,q0)","(s1,s0) = 2'b01", "Modulo-4 down","%b")

      // Test the modulo-3 up mode of the counter.
      s1 = 1; s0 = 0; clock = 0; #50;
      clock = 1; #50; clock = 0; #50;
      `assert({q1,q0}, 2'b00,"(q1,q0)","(s1,s0) = 2'b10", "Modulo-3 up","%b")
      clock = 1; #50; clock = 0; #50;
      `assert({q1,q0}, 2'b01,"(q1,q0)","(s1,s0) = 2'b10", "Modulo-3 up","%b")
      clock = 1; #50; clock = 0; #50;
      `assert({q1,q0}, 2'b10,"(q1,q0)","(s1,s0) = 2'b10", "Modulo-3 up","%b")
      clock = 1; #50; clock = 0; #50;
      `assert({q1,q0}, 2'b00,"(q1,q0)","(s1,s0) = 2'b10", "Modulo-3 up","%b")
      clock = 1; #50; 
      `assert({q1,q0}, 2'b01,"(q1,q0)","(s1,s0) = 2'b10", "Modulo-3 up","%b")

      // Test the modulo-3 down mode of the counter.
      s1 = 1; s0 = 1; clock = 0; #50;
      clock = 1; #50; clock = 0; #50;
      `assert({q1,q0}, 2'b00,"(q1,q0)","(s1,s0) = 2'b11", "Modulo-3 down","%b")
      clock = 1; #50; clock = 0; #50;
      `assert({q1,q0}, 2'b10,"(q1,q0)","(s1,s0) = 2'b11", "Modulo-3 down","%b")
      clock = 1; #50; clock = 0; #50;
      `assert({q1,q0}, 2'b01,"(q1,q0)","(s1,s0) = 2'b11", "Modulo-3 down","%b")
      clock = 1; #50; clock = 0; #50;
      `assert({q1,q0}, 2'b00,"(q1,q0)","(s1,s0) = 2'b11", "Modulo-3 down","%b")
      clock = 1; #50; 
      `assert({q1,q0}, 2'b10,"(q1,q0)","(s1,s0) = 2'b11", "Modulo-3 down","%b")
       
   end

endmodule
