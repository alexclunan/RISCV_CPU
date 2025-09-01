module mux3
  #(parameter WIDTH = 8)
   (d0,d1,d2,sel,y);

   input [WIDTH-1:0] d0;
   input [WIDTH-1:0] d1;
   input [WIDTH-1:0] d2;
   input [1:0]	     sel;
   output wire [WIDTH-1:0] y;   
   wire [WIDTH-1:0] mux2_0_out;

  mux2 #(.WIDTH(WIDTH)) mux2_0(.d0(d0), .d1(d1), .sel(sel[0]), .y(mux2_0_out));
  mux2 #(.WIDTH(WIDTH)) mux2_1(.d0(mux2_0_out), .d1(d2), .sel(sel[1]), .y(y));



endmodule
