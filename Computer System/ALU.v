module ALU(A,B,ALUcontrol,result,flags);

   input [31:0] A;
   input [31:0] B;
   input [3:0] 	ALUcontrol;
   output [31:0] result;
   output [3:0] flags;

   wire [31:0] sum_B;
   wire [31:0] sum;
   wire        cout;

   wire [31:0] AND;
   wire [31:0] OR;
   wire [31:0] XOR;

   wire [31:0] SLL;
   wire [31:0] SRL;
   wire [31:0] SRA;

   wire [31:0] LESS;
   wire [31:0] uLESS;

   wire [31:0] AND_OR_out;
   wire [31:0] SUM_out;
   wire [31:0] XOR_LESS_SLL_SRL_out;
   wire [31:0] SRA_uLESS_out;

   wire [31:0] y;

   // Add and Subtract
   assign sum_B = ALUcontrol[0] ? ~B : B;
   assign {cout, sum} =  A + sum_B + ALUcontrol[0];

   // AND OR XOR
   assign AND = A & B;
   assign OR = A | B;
   assign XOR = A ^ B;

   // Shifts
   assign SLL = A << B[4:0];
   assign SRL = A >> B[4:0];
   assign SRA = $signed(A) >>> B[4:0];

   // Set unsigned less than or signed LESS than

   assign LESS[0] = (sum[31] ^ flags[3]);
   assign LESS[31:1] = 31'b0;
   assign uLESS[31:0] = {31'b0, ~cout};
   

   // Flags | 0 = Zero | 1 = Negative | 2 = Carry | 3 = Overflow |

   assign flags[0] = ~result[0] &~result[1] & ~result[2] & ~result[3] & ~result[4] & ~result[5] & ~result[6] & ~result[7] & ~result[8] 
   & ~result[9] & ~result[10] & ~result[11] & ~result[12] & ~result[13] & ~result[14] & ~result[15] & ~result[16] & ~result[17] 
   & ~result[18] & ~result[19] & ~result[20] & ~result[21] & ~result[22] & ~result[23] & ~result[24] & ~result[25] & ~result[26] 
   & ~result[27] & ~result[28] & ~result[29] & ~result[30] & ~result[31];
   
   assign flags[1] = result[31];
   assign flags[2] =  (~ALUcontrol[3] & ~ALUcontrol[2] & ~ALUcontrol[1]) | (~ALUcontrol[3] & ~ALUcontrol[1] & ALUcontrol[0]) | 
   (~ALUcontrol[2] & ~ALUcontrol[1] & ALUcontrol[0]) ? cout : 1'b0;
   assign flags[3] = ((~ALUcontrol[3] & ~ALUcontrol[2] & ~ALUcontrol[1]) | (~ALUcontrol[3] & ~ALUcontrol[1] & ALUcontrol[0]) | 
   (~ALUcontrol[2] & ~ALUcontrol[1] & ALUcontrol[0])) & (A[31] ^ sum[31]) & (~(A[31] ^ B[31] ^ ALUcontrol[0]));

   // Combine into result

   mux2 #(.WIDTH(32)) AND_OR_mux(AND, OR, ALUcontrol[0], AND_OR_out);
   
   mux2 #(.WIDTH(32)) SUM_mux(sum, AND_OR_out, ALUcontrol[1], SUM_out);

   mux4 #(.WIDTH(32)) XOR_LESS_SLL_SRL_mux(XOR, LESS, SLL, SRL, ALUcontrol[1:0], XOR_LESS_SLL_SRL_out);

   mux2 #(.WIDTH(32)) SRA_uLESS_mux(SRA, uLESS, ALUcontrol[0], SRA_uLESS_out);

   mux3 #(.WIDTH(32)) result_mux(SUM_out, XOR_LESS_SLL_SRL_out, SRA_uLESS_out, ALUcontrol[3:2], y);

   assign result = y;

endmodule

