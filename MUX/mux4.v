module MUXES
  #(parameter WIDTH = 64)
   (d0,d1,d2,d3,sel,y);

   input [WIDTH-1:0] d0;
   input [WIDTH-1:0] d1;
   input [WIDTH-1:0] d2;
   input [WIDTH-1:0] d3;
   input [1:0]	     sel;
   output  [WIDTH-1:0] y;   
   wire  [WIDTH-1:0] mux2_0_out;
   wire  [WIDTH-1:0] mux2_1_out;
  
  mux2 #(.WIDTH(WIDTH)) mux2_0(.d0(d0), .d1(d2), .sel(sel[1]), .y(mux2_0_out));
  mux2 #(.WIDTH(WIDTH)) mux2_1(.d0(d1), .d1(d3), .sel(sel[1]), .y(mux2_1_out));

  mux2 #(.WIDTH(WIDTH)) mux2_2(.d0(mux2_0_out), .d1(mux2_1_out), .sel(sel[0]), .y(y));

endmodule
