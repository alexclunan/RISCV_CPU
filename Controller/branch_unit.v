module branch_unit(Branch,flags,funct3,taken);

   input [3:0] flags;
   input [2:0] funct3;
   input Branch;
   output taken;

   assign taken = (Branch != 0) && (
       (funct3 == 3'b000 && flags[0] == 1) ||  // beq
       (funct3 == 3'b001 && flags[0] == 0) ||  // bne
       (funct3 == 3'b100 && ((flags[1] == 1 && flags[3] == 0) || (flags[1] == 0 && flags[3] == 1))) || // blt
       (funct3 == 3'b101 && ((flags[1] == 0 && flags[3] == 1) || (flags[1] == 1 && flags[3] == 0))) || // bge
       (funct3 == 3'b110 && flags[2] == 0) ||  // bltu
       (funct3 == 3'b111 && flags[2] == 1)     // bgeu
   );
   
endmodule
