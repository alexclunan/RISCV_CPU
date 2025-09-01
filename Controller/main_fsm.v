module main_fsm(reset,clock,op,
	       ALUSrcA,ALUSrcB,ResultSrc,AdrSrc,
	       IRWrite,PCUpdate,RegWrite, MemWrite,
               ALUOp,Branch);

   input reset;
   input clock;
   input [6:0] op;
   output reg [1:0] ALUSrcA;
   output reg [1:0] ALUSrcB;
   output reg [1:0] ResultSrc;
   output reg	AdrSrc;
   output reg	IRWrite;
   output reg	PCUpdate;
   output reg	RegWrite;
   output reg	MemWrite;
   output reg [1:0] ALUOp;
   output reg	Branch;

   parameter FETCH = 4'd0, DECODE = 1, MEMADR = 2, MEMREAD = 3, MEMWB = 4,
     MEMWRITE = 5, EXECUTER = 6, ALUWB = 7, EXECUTEI = 8, JAL = 9,
     BEQ = 10, LUI = 11, JALR = 12, JALRWB = 13, AUIPC = 14;
   
   reg [3:0] 	state, nextstate;
  
   // current state
   always @(posedge reset, posedge clock)
     begin
	if (reset == 1)
	  state <= FETCH;
	else
	  state <= nextstate;
     end
  
   // next state logic
   always @(state,op)
     case(state)
       FETCH: nextstate <= DECODE;
       DECODE: begin// Decode the opcode, op, to determine the next state
	        case(op)
            7'b0000011 : nextstate <= MEMADR;
            7'b0010011 : nextstate <= EXECUTEI;
            7'b0010111 : nextstate <= AUIPC;
            7'b0100011 : nextstate <= MEMADR;
            7'b0110011 : nextstate <= EXECUTER;
            7'b0110111 : nextstate <= LUI;
            7'b1100011 : nextstate <= BEQ;
            7'b1100111 : nextstate <= JALR;
            7'b1101111 : nextstate <= JAL;
            default    : nextstate <= FETCH;
          endcase
          end
       MEMADR: nextstate <= op[5] ? MEMWRITE : MEMREAD;
       MEMREAD:   nextstate <= MEMWB;  
       EXECUTER:  nextstate <= ALUWB;
       EXECUTEI:  nextstate <= ALUWB;
       JAL:       nextstate <= ALUWB;
       LUI:       nextstate <= ALUWB;
       JALR:      nextstate <= JALRWB;
       AUIPC:     nextstate <= ALUWB;
       default:   nextstate <= FETCH;
     endcase
    

   // output logic
   // assign ALUSrcA, ALUSrcB, ResultSrc, AdrSrc, IRWrite, PCUpdate, RegWrite, MemWrite, ALUOp, Branch
   always @(state)
     case(state)
       FETCH: begin 
        ALUSrcA <= 2'b00;
        ALUSrcB <= 2'b10;
        ResultSrc <= 2'b10;
        AdrSrc <= 1'b0;
        IRWrite <= 1'b1;
        PCUpdate <= 1'b1;
        RegWrite <= 1'b0;
        MemWrite  <= 1'b0;
        ALUOp <= 2'b00;
        Branch <= 1'b0;
       end
       DECODE: begin 
        ALUSrcA <= 2'b01;
        ALUSrcB <= 2'b01;
        ResultSrc <= 2'b00;
        AdrSrc <= 1'b0;
        IRWrite <= 1'b0;
        PCUpdate <= 1'b0;
        RegWrite <= 1'b0;
        MemWrite  <= 1'b0;
        ALUOp <= 2'b00;
        Branch <= 1'b0;
       end

       MEMADR: begin 
        ALUSrcA <= 2'b10;
        ALUSrcB <= 2'b01;
        ResultSrc <= 2'b00;
        AdrSrc <= 1'b0;
        IRWrite <= 1'b0;
        PCUpdate <= 1'b0;
        RegWrite <= 1'b0;
        MemWrite  <= 1'b0;
        ALUOp <= 2'b00;
        Branch <= 1'b0;
       end
       MEMREAD: begin 
        ALUSrcA <= 2'b00;
        ALUSrcB <= 2'b00;
        ResultSrc <= 2'b00;
        AdrSrc <= 1'b1;
        IRWrite <= 1'b0;
        PCUpdate <= 1'b0;
        RegWrite <= 1'b0;
        MemWrite  <= 1'b0;
        ALUOp <= 2'b00;
        Branch <= 1'b0;
       end
       MEMWB: begin 
        ALUSrcA <= 2'b00;
        ALUSrcB <= 2'b00;
        ResultSrc <= 2'b01;
        AdrSrc <= 1'b0;
        IRWrite <= 1'b0;
        PCUpdate <= 1'b0;
        RegWrite <= 1'b1;
        MemWrite  <= 1'b0;
        ALUOp <= 2'b00;
        Branch <= 1'b0;
       end
       MEMWRITE: begin 
        ALUSrcA <= 2'b00;
        ALUSrcB <= 2'b00;
        ResultSrc <= 2'b00;
        AdrSrc <= 1'b1;
        IRWrite <= 1'b0;
        PCUpdate <= 1'b0;
        RegWrite <= 1'b0;
        MemWrite  <= 1'b1;
        ALUOp <= 2'b00;
        Branch <= 1'b0;
       end
       EXECUTER: begin 
        ALUSrcA <= 2'b10;
        ALUSrcB <= 2'b00;
        ResultSrc <= 2'b00;
        AdrSrc <= 1'b0;
        IRWrite <= 1'b0;
        PCUpdate <= 1'b0;
        RegWrite <= 1'b0;
        MemWrite  <= 1'b0;
        ALUOp <= 2'b10;
        Branch <= 1'b0;
       end
       ALUWB: begin 
        ALUSrcA <= 2'b00;
        ALUSrcB <= 2'b00;
        ResultSrc <= 2'b00;
        AdrSrc <= 1'b0;
        IRWrite <= 1'b0;
        PCUpdate <= 1'b0;
        RegWrite <= 1'b1;
        MemWrite  <= 1'b0;
        ALUOp <= 2'b00;
        Branch <= 1'b0;
       end
       EXECUTEI: begin 
        ALUSrcA <= 2'b10;
        ALUSrcB <= 2'b01;
        ResultSrc <= 2'b00;
        AdrSrc <= 1'b0;
        IRWrite <= 1'b0;
        PCUpdate <= 1'b0;
        RegWrite <= 1'b0;
        MemWrite  <= 1'b0;
        ALUOp <= 2'b10;
        Branch <= 1'b0;
       end
       JAL: begin 
        ALUSrcA <= 2'b01;
        ALUSrcB <= 2'b10;
        ResultSrc <= 2'b00;
        AdrSrc <= 1'b0;
        IRWrite <= 1'b0;
        PCUpdate <= 1'b1;
        RegWrite <= 1'b0;
        MemWrite  <= 1'b0;
        ALUOp <= 2'b00;
        Branch <= 1'b0;
       end
       BEQ: begin 
        ALUSrcA <= 2'b10;
        ALUSrcB <= 2'b00;
        ResultSrc <= 2'b00;
        AdrSrc <= 1'b0;
        IRWrite <= 1'b0;
        PCUpdate <= 1'b0;
        RegWrite <= 1'b0;
        MemWrite  <= 1'b0;
        ALUOp <= 2'b01;
        Branch <= 1'b1;
       end
       LUI: begin 
        ALUSrcA <= 2'b11;
        ALUSrcB <= 2'b01;
        ResultSrc <= 2'b00;
        AdrSrc <= 1'b0;
        IRWrite <= 1'b0;
        PCUpdate <= 1'b0;
        RegWrite <= 1'b0;
        MemWrite  <= 1'b0;
        ALUOp <= 2'b00;
        Branch <= 1'b0;
       end
       JALR: begin 
        ALUSrcA <= 2'b10;
        ALUSrcB <= 2'b01;
        ResultSrc <= 2'b10;
        AdrSrc <= 1'b0;
        IRWrite <= 1'b0;
        PCUpdate <= 1'b1;
        RegWrite <= 1'b0;
        MemWrite  <= 1'b0;
        ALUOp <= 2'b00;
        Branch <= 1'b0;
       end
       JALRWB: begin 
        ALUSrcA <= 2'b01;
        ALUSrcB <= 2'b10;
        ResultSrc <= 2'b10;
        AdrSrc <= 1'b0;
        IRWrite <= 1'b0;
        PCUpdate <= 1'b0;
        RegWrite <= 1'b1;
        MemWrite  <= 1'b0;
        ALUOp <= 2'b00;
        Branch <= 1'b0;
       end
       AUIPC: begin 
        ALUSrcA <= 2'b01;
        ALUSrcB <= 2'b01;
        ResultSrc <= 2'b00;
        AdrSrc <= 1'b0;
        IRWrite <= 1'b0;
        PCUpdate <= 1'b0;
        RegWrite <= 1'b0;
        MemWrite  <= 1'b0;
        ALUOp <= 2'b00;
        Branch <= 1'b0;
       end
       default: begin 
        ALUSrcA <= 2'bxx;
        ALUSrcB <= 2'bxx;
        ResultSrc <= 2'bxx;
        AdrSrc <= 1'bx;
        IRWrite <= 1'bx;
        PCUpdate <= 1'bx;
        RegWrite <= 1'bx;
        MemWrite  <= 1'bx;
        ALUOp <= 2'bxx;
        Branch <= 1'bx;
       end
     endcase
          
endmodule
