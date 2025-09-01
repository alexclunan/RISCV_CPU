module write_data(Addr,rd2,ReadData,StoreType,WriteData);

   input wire [31:0] Addr;
   input wire [31:0] rd2;
   input wire [31:0] ReadData;
   input wire [1:0] 	StoreType;
   output wire [31:0] WriteData;

   wire [31:0] storeb0;
   wire [31:0] storeb1;
   wire [31:0] storeb2;
   wire [31:0] storeb3;

   wire [31:0] SelectByte;

   wire [31:0] storeh0;
   wire [31:0] storeh1;

   wire [31:0] store_half;

   wire [31:0] store_byte_word;

   assign storeb0[31:8] = ReadData[31:8];
   assign storeb0[7:0] = rd2[7:0]; 

   assign storeb1[31:16] = ReadData[31:16];
   assign storeb1[15:8] = rd2[15:8];
   assign storeb1[7:0] = ReadData[7:0]; 

   assign storeb2[31:24] = ReadData[31:24];
   assign storeb2[23:16] = rd2[23:16];
   assign storeb2[15:0] = ReadData[15:0]; 

   assign storeb3[31:24] = rd2[31:24];
   assign storeb3[23:0] = ReadData[23:0]; 

   mux4 #(.WIDTH(32)) SelectByteMux(.d0(storeb0), .d1(storeb1), .d2(storeb2), .d3(storeb3), .sel(Addr[1:0]), .y(SelectByte)); 

   assign storeh0[31:16] = ReadData[31:16];
   assign storeh0[15:0] = rd2[15:0]; 

   assign storeh1[31:16] = rd2[31:16];
   assign storeh1[15:0] = ReadData[15:0];

   mux2 #(.WIDTH(32)) SelectHalfMux(.d0(storeh0), .d1(storeh1), .sel(Addr[1]), .y(store_half));

   mux2 #(.WIDTH(32)) ByteWordSelectMux(.d0(rd2), .d1(SelectByte), .sel(StoreType[0]), .y(store_byte_word));

   mux2 #(.WIDTH(32)) WriteDataMux(.d0(store_byte_word), .d1(store_half), .sel(StoreType[1]), .y(WriteData));


endmodule
