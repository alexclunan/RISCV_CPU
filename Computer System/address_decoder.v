module address_decoder (MemWrite,Addr,RAM_CS,RAM_WE,ROM_CS);

   input MemWrite;
   input [31:0] Addr;
   output reg	RAM_CS;
   output reg	RAM_WE;
   output reg	ROM_CS;

   // The memory map has non-volatile ROM (32 bits wide) from 
   // address 0x00000000 to 0x00001FFF:
   // Bit number
   // 3    2    2    1    1    1    0    0
   // 1    7    3    9    5    1    7    3
   // 0000 0000 0000 0000 0001 1111 1111 1111 = 0x00001FFF

   // The memory map has volatile RAM memory from
   // address 0x00002000 to address 0x000002FFF:
   // Bit number
   // 3    2    2    1    1    1    0    0
   // 1    7    3    9    5    1    7    3
   // 0000 0000 0000 0000 0010 0000 0000 0000 = 0x00002000
   // 0000 0000 0000 0000 0010 1111 1111 1111 = 0x00002FFF

   always @* begin
      if ((Addr >= 32'h0) && (Addr < 32'h2000)) begin
         ROM_CS <= 1;
         RAM_CS <= 0;
         RAM_WE <= 0;
      end else if ((Addr >= 32'h2000) && (Addr < 32'h3000)) begin
         ROM_CS <= 0;
         RAM_CS <= 1;
            if (MemWrite == 0)
               RAM_WE <= 0;
            else
               RAM_WE <= 1;
      end else begin
         ROM_CS <= 0;
         RAM_CS <= 0;
         RAM_WE <= 0;
      end
   end

endmodule
