module read_data(Addr,LoadType,ReadData,ReadDataOut);

   input wire [31:0] Addr;
   input wire [2:0] 	LoadType;
   input wire [31:0] ReadData;
   output wire [31:0] ReadDataOut;
   wire [7:0] ByteOut;
   wire [15:0] HalfOut;

   wire [31:0] zero_ext_byte;
   wire [31:0] sign_ext_byte;
   wire [31:0] zero_ext_half;
   wire [31:0] sign_ext_half;

   wire [31:0] ReadDataByte;
   wire [31:0] ReadDataHalf;

   /*
   LoadType:
   000: Load word
   001: Load byte (zero extend)
   010: Load byte (sign extend)
   100: Load half (zero extend)
   101: Load half (sign extend)
   */

   mux4 #(.WIDTH(8)) ByteSelectMux(.d0(ReadData[7:0]), .d1(ReadData[15:8]), .d2(ReadData[23:16]), .d3(ReadData[31:24]), .sel(Addr[1:0]), .y(ByteOut));

   mux2 #(.WIDTH(16)) HalfWordSelectMux(.d0(ReadData[15:0]), .d1(ReadData[31:16]), .sel(Addr[1]), .y(HalfOut));

   zero_extend #(.WIDTH(8), .ZEROS(24)) ZeroExtend_Byte(.a(ByteOut), .ZeroExt(zero_ext_byte));

   sign_extend #(.WIDTH(8), .SIGNS(24)) SignExtend_Byte(.a(ByteOut), .SignExt(sign_ext_byte));

   zero_extend #(.WIDTH(16), .ZEROS(16)) ZeroExtend_Half(.a(HalfOut), .ZeroExt(zero_ext_half));

   sign_extend #(.WIDTH(16), .SIGNS(16)) SignExtend_Half(.a(HalfOut), .SignExt(sign_ext_half));

   mux3 #(.WIDTH(32)) ReadDataMuxByte(.d0(ReadData), .d1(zero_ext_byte), .d2(sign_ext_byte), .sel(LoadType[1:0]), .y(ReadDataByte));

   mux2 #(.WIDTH(32)) ReadDataMuxHalf(.d0(zero_ext_half), .d1(sign_ext_half), .sel(LoadType[0]), .y(ReadDataHalf));

   mux2 #(.WIDTH(32)) ReadDataMux(.d0(ReadDataByte), .d1(ReadDataHalf), .sel(LoadType[2]), .y(ReadDataOut));

   


endmodule
