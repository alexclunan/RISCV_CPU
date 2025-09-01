module address_decoder (MemWrite,Addr,RAM_CS,RAM_WE,ROM_CS,UART_WR, UART_RD, CE_SR,CE_UART);

   input MemWrite;
   input [31:0] Addr;
   output reg	RAM_CS;
   output reg	RAM_WE;
   output reg	ROM_CS;
   output reg 	UART_WR;
   output reg 	UART_RD;
   output reg 	CE_UART;
   output reg 	CE_SR;


always @* begin
      // UART Read/Write
      if (Addr == 32'h00003000) begin
         CE_UART <= 1;
         CE_SR <= 0;
         if (MemWrite == 0) begin
            UART_RD <= 1;
            UART_WR <= 0;
         end else begin
            UART_RD <= 0;
            UART_WR <= 1;
         end
      // Status Register Read --> writes to RAM
      end else if (Addr == 32'h00003004) begin
         CE_UART <= 0;
         CE_SR <= 1;
         UART_RD <= 1;
         UART_WR <= 0;
      end else begin
         CE_UART <= 0;
         CE_SR <= 0;
         UART_RD <= 0;
         UART_WR <= 0;

      end if ((Addr >= 32'h0) && (Addr < 32'h2000)) begin
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
      end else if (((Addr >= 32'h3000) && (Addr < 32'h3008))) begin
         ROM_CS <= 0;
         RAM_CS <= 0;
         RAM_WE <= 0;
      end else begin
         ROM_CS <= 0;
         RAM_CS <= 0;
         RAM_WE <= 0;
      end



   end

endmodule
