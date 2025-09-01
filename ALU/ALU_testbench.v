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

   reg [31:0] A;
   reg [31:0] B;
   reg [3:0] ALUcontrol;
   wire [31:0] result;
   wire [3:0]  flags;

   ALU dut(.A(A),.B(B),.ALUcontrol(ALUcontrol),.result(result),.flags(flags));
   
    initial begin
       
       // Initialize input - data read from memory.
       A = 32'h00000000;
       B = 32'h00000000;
       ALUcontrol = 4'b0000;
       #10;

       // First, test A+B
       A = 32'h00000002;
       B = 32'h00000001;
       #10;
      `assert(result, 32'h00000003,"result","A = 2, B = 1", "test A+B","%x")
      `assert(flags, 4'b0000,"flags","A = 2, B = 1", "test A+B","%x")

       // Then, test A-B, result is positive (n = 0)
       A = 32'h00000002;
       B = 32'h00000001;
       ALUcontrol = 4'b0001;
       #10;
       `assert(result, 32'h00000001,"result","A = 2, B = 1", "test A-B, result is positive (n = 0)","%x")
       `assert(flags, 4'b0100,"flags","A = 2, B = 1", "test A-B","%x")
       
       // Then, test A-B, result is negative (n = 1)
       A = 32'h00000001;
       B = 32'h00000002;
       ALUcontrol = 4'b0001;
       #10;
       `assert(result, 32'hffffffff,"result","A = 1, B = 2", "test A-B, result is negative (n = 1)","%x")
       `assert(flags, 4'b0010,"flags","A = 1, B = 2", "test A-B","%x")

       // Then, test A&B
       A = 32'hffffffff;
       B = 32'h00000002;
       ALUcontrol = 4'b0010;
       #10;
       `assert(result, 32'h00000002,"result","A = -1, B = 2", "test A&B","%x")
       `assert(flags, 4'b0000,"flags","A = -1, B = 2", "test A&B","%x")

       // Then, test A|B
       A = 32'h00000002;
       B = 32'h00000001;
       ALUcontrol = 4'b0011;
       #10;
       `assert(result, 32'h00000003,"result","A = 2, B = 1", "test A|B","%x")
       `assert(flags, 4'b0000,"flags","A = 2, B = 1", "test A|B","%x")

       // Then, test A^B
       A = 32'h55555555;
       B = 32'haaaaaaaa;
       ALUcontrol = 4'b0100;
       #10;
      `assert(result, 32'hffffffff,"result","A = 0x55555555, B = 0xaaaaaaaa", "test A^B","%x")
      `assert(flags, 4'b0010,"flags","A = 0x55555555, B = 0xaaaaaaaa", "test A^B","%x")

       // Then, test set less than for A < B (signed)
       A = 32'h00000001;
       B = 32'h00000002;
       ALUcontrol = 4'b0101;
       #10;
       `assert(result, 32'h00000001,"result","A = 1, B = 2", "test set less than for A < B (signed)","%x")
       `assert(flags, 4'b0000,"flags","A = 1, B = 2", "less than A < B","%x")

       // Then, test set less than for A > B (signed)
       A = 32'h7fffffff;
       B = 32'h80000000;
       ALUcontrol = 4'b0101;
       #10;
       `assert(result, 32'h00000000,"result","A = 0x7fffffff, B = 0x80000000", "test set less than for A > B (signed)","%x")
       `assert(flags, 4'b1001,"flags","A = 0x7fffffff, B = 0x80000000", "less than A < B","%x")

       // Then, test shift logical left
       A = 32'h55555555;
       B = 32'h00000001;
       ALUcontrol = 4'b0110;
       #10;
       `assert(result, 32'haaaaaaaa,"result","A = 0x55555555, B = 1", "test shift logical left","%x")
       `assert(flags, 4'b0010,"flags","A = 0x55555555, B = 1", "SLL","%x")

       // Then, test shift logical right
       A = 32'hbbbbbbbb;
       B = 32'h00000001;
       ALUcontrol = 4'b0111;
       #10;
       `assert(result, 32'h5ddddddd,"result","A = 0xbbbbbbbb, B = 1", "test shift logical right","%x")
       `assert(flags, 4'b0000,"flags","A = 0xbbbbbbbb, B = 1", "SLR","%x")

       // Then, test shift arithmetic right
       A = 32'hfffffffe;
       B = 32'h00000001;
       ALUcontrol = 4'b1000;
       #10;
       `assert(result, 32'hffffffff,"result","A = 0xfffffffe, B = 1", "test shift arithmetic right","%x")
       `assert(flags, 4'b0010,"flags","A = 0xfffffffe, B = 1", "SAR","%x")

       // Then, test set less than for A < B (unsigned)
       A = 32'h7fffffff;
       B = 32'h80000000;
       ALUcontrol = 4'b1001;
       #10;
       `assert(result, 32'h00000001,"result","A = 0x7fffffff, B = 0x80000000", "test set less than for A < B (unsigned)","%x")
       `assert(flags, 4'b1000,"flags","A = 0x7fffffff, B = 0x80000000", "less than for A < B (unsigned)","%x")

       // Then, test set less than for A > B (unsigned)
       A = 32'h80000000;
       B = 32'h7fffffff;
       ALUcontrol = 4'b1001;
       #10;
       `assert(result, 32'h00000000,"result","A = 0x80000000, B = ", "test set less than for A > B (unsigned)","%x")
       `assert(flags, 4'b1101,"flags","A = 0x80000000, B = 0x7fffffff", "less than for A > B (unsigned)","%x")

    end

endmodule
