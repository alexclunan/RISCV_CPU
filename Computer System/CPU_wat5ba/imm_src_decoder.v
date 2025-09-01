module imm_src_decoder (op,ImmSrc);

   input [6:0] op;
   output reg [2:0] ImmSrc;

   always @(op) begin
    case(op)
        3   : ImmSrc <= 3'b000;
        19  : ImmSrc <= 3'b000;
        103 : ImmSrc <= 3'b000;
        35  : ImmSrc <= 3'b001;
        99  : ImmSrc <= 3'b010;
        111 : ImmSrc <= 3'b011;
        23  : ImmSrc <= 3'b100;
        55  : ImmSrc <= 3'b100;
        default : ImmSrc <= 3'bxxx;
    endcase
   end
   
endmodule
