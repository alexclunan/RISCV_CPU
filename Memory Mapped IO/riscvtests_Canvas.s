# This program should written for data at 0x2000 and text at 0 using RARS.
	.text
_start:	call main	# reset entry point for GNU

	.section	.text.write_hello_world,"ax",@progbits
	.globl	write_hello_world
write_hello_world:
	addi	x31, x0, 2	# x31 = x0 + 2 (immediate)
	slli	x31, x31, 12	# x31 = x31 << 12 (immediate) = 0x2000 = RAM[0], start of RAM
	# Load String into Registers
	li x20, 0x48
	li x3, 0x65
	li x4, 0x6C
	li x5, 0x6C
	li x6, 0x6F
	li x7, 0x2C
	li x8, 0x20
	li x9, 0x57
	li x10, 0x6F
	li x11, 0x72
	li x12, 0x6C
	li x13, 0x64
	li x23, 0x21
	li x24, 0x0
	# Writes String into memory
	sh x20, 8(x31)# store half-word 0 of x2 at RAM[2]
	sw x3, 12(x31)# store word x3 at RAM[3]
	sb x4, 16(x31)# store byte 0 of x4 at RAM[4]
	sh x5, 20(x31)# store half-word 0 of x5 at RAM[5]
	sw x6, 24(x31)# store word of x6 at RAM[6]
	sb x7, 28(x31)# store byte 0 of x7 at RAM[7]
	sh x8, 32(x31)# store half-word 0 x8 at RAM[8]
	sw x9, 36(x31)# store word of x9 at RAM[9]
	sb x10, 40(x31)# store byte 0 of x10 at RAM[10]
	sh x11, 44(x31)# store half-word 0 of x11 at RAM[11]
	sw x12, 48(x31)# store word of x12 at RAM[12]
	sb x13, 52(x31)# store byte 0 of x13 at RAM[13]
	sb x23, 56(x31)# store byte 0 of x13 at RAM[14]
	sb x24, 60(x31)# store byte 0 of x13 at RAM[15]
	li x14, 14 # Number of characters Remaining to be Sent
	# UART
	li x15, 0x3000 # UART Recieve/Transmit Address
	li x16, 0x3004 # UART Status Register Address
	li x17, 0x2008 # Address for what character to send
	li x21, 0x0 # Address for what character to send
	uart_start:
	lw x18, (x16) # Load status register value
	andi x21, x18, 2 # Mask the status register to find bit 1
	# addi x18, x18, 1 # for testing, remove
	andi x18, x18, 1 # Mask the status register to find bit 0
	bnez x21, uart_receive # Check if recieve is ready (bit 1 = 1)
	blez x18, uart_start # Check if transmit is ready (bit 0 = 1) if not ready, jump to start
	lw x19, (x17) # Load character into register
	sw x19, (x15) # Write character To UART Tx
	# In a non-test program I would do error checking here
	addi x17, x17, 4 # Set read address to next character
	addi x14, x14 -1 # Subtract 1 from the number of characters remaining to be sent 
	bnez x14, uart_start # Check if all characters were sent, jump back to to top if not all characters were sent
	ret
	uart_receive:
	lw x22, (x15) # read from UART address
	j uart_start
	
	

	.section	.text.main,"ax",@progbits
	.globl	main
main:
	call write_hello_world

end:	beq 	x0, x0, end	# infinite loop
