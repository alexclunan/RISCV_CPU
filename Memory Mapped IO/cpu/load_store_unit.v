module load_store_unit(funct3,LoadType,StoreType);

   input [2:0] funct3;
   output reg [2:0] LoadType;
   output reg [1:0] StoreType;

   always @* begin
      case(funct3)
         3'b010 : begin 
            LoadType <= 3'b000;
            StoreType <= 2'b00; end
         3'b100 : begin
            LoadType <= 001;
            StoreType <= 2'bxx; end
         3'b000 : begin
            LoadType <= 3'b010;
            StoreType <= 2'b01; end
         3'b101 : begin
            LoadType <= 3'b100;
            StoreType <= 2'bxx; end
         3'b001 : begin
            LoadType <= 3'b101;
            StoreType <= 2'b10; end
         default : begin 
            LoadType <= 3'bxxx;
            StoreType <= 2'bxx; end
      endcase
   end
   
endmodule
