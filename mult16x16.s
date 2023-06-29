# Operands to multiply
.data
a: .word 0xBAD
b: .word 0xFEED

.text
main:   # Load data from memory
	la      t3, a
        lw      t3, 0(t3)
        la      t4, b
        lw      t4, 0(t4)
        
        # t6 will contain the result
        add	t6, x0, x0

        # Mask for 16x8=24 multiply
        ori	t0, x0, 0xff
        slli	t0, t0, 8
        ori	t0, t0, 0xff
        slli	t0, t0, 8
        ori	t0, t0, 0xff
        
####################
# Start of your code

# Use the code below for 16x8 multiplication
#   mul		<PROD>, <FACTOR1>, <FACTOR2>
#   and		<PROD>, <PROD>, t0

#lower 8 bits
andi t1, t4, 0xff # Extract the lower 8 bits of the second number
mul t5, t3, t1    # Multiply the first number with the lower 8 bits of the second number
and t5, t5, t0    # Mask the result

add t1, x0, x0    # t1 = 0

#upper 8 bits
srli t1, t4, 8    # Shift the second number to the right by 8 bits to extract the upper 8 bits
mul t2, t3, t1    # Multiply the first number with the upper 8 bits of the second number
and t2, t2, t0    # Mask the result

slli t2, t2, 8    # Shift the second part product to the left by 8 bits
add t6, t5, t2    # add two parts to get the final result

# End of your code
####################
		
finish: addi    a0, x0, 1
        addi    a1, t6, 0
        ecall # print integer ecall
        addi    a0, x0, 10
        ecall # terminate ecall


