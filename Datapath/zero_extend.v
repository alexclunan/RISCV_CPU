module zero_extend
  #(parameter WIDTH = 8, ZEROS = 24)
  (a,ZeroExt);

   input [WIDTH-1:0] a;
   output [WIDTH+ZEROS-1:0] ZeroExt;

assign ZeroExt[WIDTH+ZEROS-1:WIDTH] = 0;
assign ZeroExt[WIDTH-1:0] = a;


endmodule
