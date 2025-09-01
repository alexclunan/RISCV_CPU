module ALU_decoder(opb5,funct3,funct7b5,ALUOp,ALUControl);

   input opb5;
   input [2:0] funct3;
   input       funct7b5;
   input [1:0] ALUOp;
   output reg [3:0] ALUControl;

   wire [4:0] inputs;

   assign inputs = {opb5, funct3, funct7b5};

   always @(opb5, funct3, funct7b5, ALUOp, inputs) begin
      // Add
      if (ALUOp == 2'b00)
         ALUControl <= 4'b0000;
      // Subtract
      else if (ALUOp == 2'b01)
         ALUControl <= 4'b0001;
      
      else if (ALUOp == 2'b10) begin
         case(inputs)
            // addi rd, rs1, imm
            5'b00000 : ALUControl <= 4'b0000;
            5'b00001 : ALUControl <= 4'b0000;
            // add rd, rs1, rs2
            5'b10000 : ALUControl <= 4'b0000;
            // sub rd, rs1, rs2
            5'b10001 : ALUControl <= 4'b0001;
            // slli rd, rs1, uimm or sll rd, rs1, rs2 
            5'b00010 : ALUControl <= 4'b0110;
            5'b10010 : ALUControl <= 4'b0110;

            // slti rd, rs1, imm
            5'b00100 : ALUControl <= 4'b0101;
            5'b00101 : ALUControl <= 4'b0101;
            // slt rd, rs1, rs2
            5'b10100 : ALUControl <= 4'b0101;
            // sltiu rd, rs1, imm 
            5'b00110 : ALUControl <= 4'b1001;
            5'b00111 : ALUControl <= 4'b1001;
            // sltu rd, rs1, rs2
            5'b10110 : ALUControl <= 4'b1001;
            // xor rd, rs1, rs2
            5'b11000 : ALUControl <= 4'b0100;
            // xori rd, rs1, imm
            5'b01000 : ALUControl <= 4'b0100;
            5'b01001 : ALUControl <= 4'b0100;
            // srl rd, rs1, rs2, srli rd, rs1, uimm
            5'b01010 : ALUControl <= 4'b0111;
            5'b11010 : ALUControl <= 4'b0111;

            // srai rd, rs1, uimm, sra rd, rs1, rs2
            5'b01011 : ALUControl <= 4'b1000;
            5'b11011 : ALUControl <= 4'b1000;

            // or rd, rs1, rs2
            5'b11100 : ALUControl <= 4'b0011;
            // ori rd, rs1, imm
            5'b01100 : ALUControl <= 4'b0011;
            5'b01101 : ALUControl <= 4'b0011;
            // and rd, rs1, rs2
            5'b11110 : ALUControl <= 4'b0010;
            // andi rd, rs1, imm 
            5'b01110 : ALUControl <= 4'b0010;
            5'b01111 : ALUControl <= 4'b0010;
            default  : ALUControl <= 4'bxxxx;
         endcase
      end else 
          ALUControl <= 4'b0000;
   end

   
endmodule
