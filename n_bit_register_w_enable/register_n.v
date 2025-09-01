module register_n
  #(parameter WIDTH = 8)
   (reset,clock,enable,D,Q);

   input reset;
   input clock;
   input enable;
   input [WIDTH-1:0] D;
   output reg [WIDTH-1:0] Q;
   
always @(posedge(clock), posedge(reset))
begin
  if (reset)
    Q <= 0;
  else if (enable)
    Q <= D;
  else
    Q <= Q;
end

endmodule
