module register_n_tri
   (reset,clock,enable,OE,D,Q);

   input reset;
   input clock;
   input enable;
   input OE; // output enable
   input [31:0] D;
   output [31:0] Q;

   reg [31:0] register;

   always @(posedge(clock), posedge(reset)) begin
      if(reset == 1)
         register <= 32'b0;
      else begin
         if(enable == 1)
            register <= D;
         else
            register <= register;
      end
   end

   assign Q = OE ? register : 32'bz;
   
endmodule
