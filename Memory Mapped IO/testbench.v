// Copyright (C) 2020  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"
// CREATED		"Fri Oct 20 12:52:45 2023"

module testbench(
);



wire	[31:0] Addr;
wire	CE_SR;
wire	CE_UART;
wire	clock;
wire	MemWrite;
wire	RAM_CS;
wire	RAM_WE;
wire	[31:0] ReadData;
wire	reset;
wire	ROM_CS;
wire	Tx2Rx;
wire	UART_RD;
wire	UART_WR;
wire	[31:0] WriteData;





address_decoder	b2v_inst(
	.MemWrite(MemWrite),
	.Addr(Addr),
	.RAM_CS(RAM_CS),
	.RAM_WE(RAM_WE),
	.ROM_CS(ROM_CS),
	.UART_WR(UART_WR),
	.UART_RD(UART_RD),
	.CE_SR(CE_SR),
	.CE_UART(CE_UART));

RAM_memory	b2v_RAM_0(
	.clock(clock),
	.CS(RAM_CS),
	.WE(RAM_WE),
	.Addr(Addr[11:0]),
	.WD(WriteData),
	.RD(ReadData));


reset_clock	b2v_reset_clock_0(
	.reset(reset),
	.clock(clock));


cpu	b2v_RISCV(
	.reset(reset),
	.clock(clock),
	.ReadData(ReadData),
	.MemWrite(MemWrite),
	.Addr(Addr),
	.WriteData(WriteData));


ROM_memory	b2v_ROM_0(
	.CS(ROM_CS),
	.Addr(Addr[12:0]),
	.RD(ReadData));
	defparam	b2v_ROM_0.filename = "riscvtest.txt";

UART	b2v_UART_0(
	.Reset(reset),
	.WR(UART_WR),
	.Clock(clock),
	.RxD(Tx2Rx),
	.RD(UART_RD),
	.CE_SR(CE_SR),
	.CE_UART(CE_UART),
	.WriteData(WriteData),
	.TxD(Tx2Rx),
	.ReadData(ReadData));

endmodule
