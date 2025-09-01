module sign_extend
  #(parameter WIDTH = 8, SIGNS = 24)
  (a,SignExt);

   input [WIDTH-1:0] a;
   output [WIDTH+SIGNS-1:0] SignExt;



assign SignExt[WIDTH+SIGNS-1:WIDTH] = a[WIDTH-1];
assign SignExt[WIDTH-1:0] = a;

endmodule
