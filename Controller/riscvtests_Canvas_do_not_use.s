# This program should written for data at 0x2000 and text at 0 using RARS.
	.text
_start:	call main	# reset entry point for GNU

	.section	.text.load_register_values,"ax",@progbits
	.globl	load_register_values
load_register_values:
# When this function is called, all registers will be assigned a
# value equal to the register number. One exception is x1, which
# contains the return address to return from this function.
	# x31 = x1 = return address
	# store x1 = 1
	# x2 = x1 + x1 = 2
	# x3 = x2 OR 1 (immediate) = 3
	# x4 = x3 + 1 (immediate ) = 4
	# x6 = x4 + x2 = 6
	# x5 = x6 - 1 = 5
	# x7 = x4 OR 3 (immediate) = 7
	# x10 = x7 + 3 (immediate) = 10
	# x8 = x0 - x2 = -2
	# x8 = x10 + x8 = 8
	# x9 = x10 + (-1) (immediate) = 9
	# x27 = x7 + 20 (immediate) = 27 (binary ...00011011)
	# x15 = x9 + x6 = 15             (binary ...00001111)
	# x11 = x15 AND x27 = 11
# Now perform bit manipulations using identifiable strings
	# x16 = x0 - x1 = -1 = ffffffff
	# x16 = x16 - x1 = -2 = fffffffe		
	# x17 = x16 >> x1 (= 1) for (0111....1111) = 7ffffff
	# x18 = x16 AND x17 = (0111...1110) = 7ffffffe
	# x19 = x18 XOR x16 = 800000000
	# x20 = x15 << 28 for (1111...0000) = f0000000
	# x21 = x17 >> x8 (arithmetic) = 007fffff
	# x23 = x19 >> 8 (arithmetic immediate) = ff800000
	# x22 = x21 OR x23 = ffffffff
# resume filling registers with register values (i.e., 12 in x12, etc.)
	# x12 = x17 AND 12 (immediate) = 12
	# x13 = x17 >> 29 (immediate) = 3
	# x13 = x13 << x2 = 12
	# x13 = x13 + x1 = 13
	# x14 = x18 >> x27 (arithmetic) = 15
	# x14 = x14 - x1 = 14
	# Test slti: x16 = x15 < 16 (immediate) = 1
	# x16 = x16 + x15 = 16
	# Test sltiu: x17 = x16 < 16 (immediate) = 0
	# x17 = x16 + x1 = 17
	# Test slt: x18 = x18 < x19 = 0
	# x18 = x17 + x1 = 18
	# Test sltu: x19 = x19 < x20 = 1
	# x19 = x19 + x18 = 19
	# Test slti: x20 = x21 < 1 (immediate) = 0
	# x20 = x19 + x1 = 20
	# x22 = x22 + 1 (immediate) = 0
	# Test sltiu: x21 = x22 < 1 (immediate) = 1
	# x21 = x21 + x20 = 21
	# Test slt: x22 = x22 < x1 = 1
	# x22 = x22 + x21 = 22
	# Test sltu: x23 = x23 < x0 = 0
	# x23 = x22 + x1 = 23
	# x24 = x6 << x2 = 24
	# x25 = x27 + (-2) (immediate) = 25
	# x26 = x24 + x2 = 26
	# x28 = x14 << 1 (immediate) = 28
	# x1 = x31 + x0, restore return address to x1
	# x31 = x28 OR 3 (immediate) = 31
	# x29 = x31 + (-2) (immediate) = 29
	# x30 = x31 >> 1 (immediate) = 15
	# x30 = x30 << 1 (immediate) = 30
	ret

	.section	.text.test_load_store,"ax",@progbits
	.globl	test_load_store
test_load_store:
# When this function is called, all registers should contain a
# value equal to the register number. One exception is x1, which
# contains the return address to return from this function. Also,
# x6 will not contain 6 since it is used when this function is called.
	addi	x31, x0, 2	# x31 = x0 + 2 (immediate)
	slli	x31, x31, 12	# x31 = x31 << 12 (immediate) = 0x2000 = RAM[0], start of RAM
	addi	x6, x0, 6	# x6 = x0 + 6 (immediate), store 6 in x6
	# store byte 0 of x1 at RAM[1]
	# store half-word 0 of x2 at RAM[2]
	# store word x3 at RAM[3]
	# store byte 0 of x4 at RAM[4]
	# store half-word 0 of x5 at RAM[5]
	# store word of x6 at RAM[6]
	# store byte 0 of x7 at RAM[7]
	# store half-word 0 x8 at RAM[8]
	# store word of x9 at RAM[9]
	# store byte 0 of x10 at RAM[10]
	# store half-word 0 of x11 at RAM[11]
	# store word of x12 at RAM[12]
	# store byte 0 of x13 at RAM[13]
	# store half-word 0 of x14 at RAM[14]
	# store word of x15 at RAM[15]
	# store byte 0 of x16 at RAM[16]
	# store half-word 0 of x17 at RAM[17]
	# store word of x18 at RAM[18]
	# store byte 0 of x19 at RAM[19]
	# store half-word 0 of x20 at RAM[20]
	# store word of x21 at RAM[21]
	# store byte 0 of x22 at RAM[22]
	# store half-word 0 of x23 at RAM[23]
	# store word of x24 at RAM[24]
	# store byte 0 of x25 at RAM[25]
	# store half-word 0 of x26 at RAM[26]
	# store word of x27 at RAM[27]
	# store byte 0 of x28 at RAM[28]
	# store half-word 0 of x29 at RAM[29]
	# store word of x30 at RAM[30]
	# store word of x31 at RAM[31]
# Now, reset registers x2-x30 equal to zero before returning. Note that x1
# should not be reset to zero because it contains the return address. Also,
# x31 should not be reset to zero because it points to the start of RAM.
	ret

	.section	.text.test_branch,"ax",@progbits
	.globl	test_branch
test_branch:
	lb	x2, 0x09(x31)	# load x2 = byte 1 of RAM[2] = 0
	beq	x2,	x0,	X2		# Test x2 = 0: branch to X2 taken
	j 	failed			# jump to failed
X2:	lb	x2, 0x08(x31)	# load x2 = byte 0 of RAM[2] = 2
	beq	x2,	x0,	X2		# Test x2 = 0: branch to X2 not taken
	# load x3 = half word 1 of RAM[3] = 0
	# Test x3 != x1: branch to X3 taken
	# jump to failed
X3:	# load x3 = half word 0 of RAM[3] = 3
	# Test x3 != x3: branch to X3 not taken
	# Load x4 = byte 0 (unsigned) of RAM[4] = 4
X4:	# Test x4 < x5: branch to X4 not taken
	# Load x5 = half word 0 (unsigned) of RAM[5] = 5
	# Test x4 < x5: branch to X6 taken
	# jump to failed
X6:	# load x6 = word of RAM[6] = 6
X7:	# Test x6 < x7 (unsigned): branch to X7 not taken
	# load x7 = byte 0 of RAM[7] = 7
	# Test x6 < x7 (unsigned) branch to X8 taken
	# jump to failed
X8:	# load x8 = half word 0 of RAM[8] = 8
	# Test x8 >= x9: branch to X9 taken
	# jump to failed
X9:	# load x9 = byte 0 (unsigned) of RAM[9] = 9
	# Test x8 >= x9: branch to X9 not taken
	# load x10 = half word 0 (unsigned) of RAM[10] = 10
	# Test x10 >= x11 (unsigned): branch to X11 taken
	# jump to failed
X11:	# load x11 = word at RAM[11] = 11
	# Test x10 >= x11 (unsigned): branch to X11 not taken
	# load x12 = byte 0 at RAM[12] = 12
	# Test x12 >= x11: branch to X27 taken
X13:	# load x13 = half word 0 at RAM[13] = 13
	# load x14 = byte 0 (unsigned) at RAM[14] = 14
	# Test x13 = x14: branch to X13 not taken
	# load x15 = half word 0 (unsigned) at RAM[15] = 15
	# load x16 = word at RAM[16] = 16
	# Test x15 != x16: branch to X25 taken
X17:	# load x17 = byte 0 at RAM[17] = 17
	# load x18 = half word 0 at RAM[18] = 18
	# Test x18 < x17: branch to X17 not taken
	# load x19 = byte 0 (unsigned) at RAM[19] = 19
	# load x20 = half word 0 (unsigned) at RAM[20] = 20
	# Test x19 < x20 (unsigned): branch to X23 taken
X31:	# load x29 = byte 0 (unsigend) at RAM[29] = 29
	# Test x29 = x0: branch to failed not taken
	# jump to almost
failed:	# Test x0 = x0: branch to failed taken (infinite loop)
almost:	# jump to done
X21:	# load x21 = word at RAM[21] = 21
	# load x22 = byte 0 at RAM[22] = 22
	# Test x21 != x22: branch to X31 taken
X27:	# load x27 = byte 0 at RAM[27] = 27
	# load x28 = half word at RAM[28] = 28
	# Test x28 >= x27 (unsigned): branch to X13 taken
X25:	# load x25 = half word 0 (unsigned) at RAM[25] = 25
	# load x26 = word at RAM[26] = 26
	# Test x26 >= x25 (unsigned): branch to X17 taken
X23:	# load x23 = half word 0 at RAM[23] = 23
	# load x24 = byte 0 (unsigned) at RAM[24] = 24
	# Test x23 != x24: branch to X21 taken
done:	# load x30 = word at RAM[30] = 30
	ret

	.section	.text.main,"ax",@progbits
	.globl	main
main:
	call load_register_values
	call test_load_store
	call test_branch
end:	beq 	x0, x0, end	# infinite loop
