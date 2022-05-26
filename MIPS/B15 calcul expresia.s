#x_1^n+x_2^n=(x_1+x_2)(x_1^(n-1)+x_2^(n-1)) - x_1*x_2(x_1^(n-2)+x_2^(n-2))
#(x_1+x_2)^2-2x_1x_2=x_1^2+x_2^2

.data
mesaj1: .asciiz "Baga a: "
mesaj2: .asciiz "Baga b: "
mesaj3: .asciiz "Baga c: "
mesaj4: .asciiz "Baga n: "
.align 4

.globl main

.text
main:

	puts mesaj1
	geti $t0 #a
	puts mesaj2
	geti $t1 #b
	puts mesaj3
	geti $t2 #c
	puts mesaj4
	geti $t3 #n
	
	div $t1, $t0
	mflo $t4
	mul $t4, $t4, -1 # S_1= -b/a
	
	div $t2, $t0
	mflo $t5 # P = c/a
	
	mul $t6, $t4, $t4
	mul $t7, $t5, -2
	add $t8, $t6, $t7 # S2= x_1^2+ x_2^2
	
	jal suma
	puti $s7
	done
	
	#s7=result
	#t3=n
suma:
	addi $sp, $sp, -12
	sw $s0, ($sp)
	sw $s2, 4($sp)
	sw $ra, 8($sp)
	move $s0, $t3 #n
	
	mul $s4, $t4, $t8
	mul $s5, $t5, $t4
	sub $s7, $s4, $s5 #S3
	
	beq $s0, 3, exitq # n<=3 ? exitq : continue
	
	addi $t3, $s0, -1 # n-1
	jal suma
	move $s2, $s7 # s2=suma(n-1)
	
	
	addi $t3, $s0, -2 # n-2
	jal suma #suma (n-2)
	
	
	mul $s4, $t4, $s2 #S_1 * S_(n-1)
	mul $s5, $t5, $s7 #P * S_(n-2)
	sub $s7, $s4, $s5 
	
exitq:
	lw $ra, 8($sp)
	lw $s2, 4($sp)
	lw $s0, ($sp)
	addi $sp, $sp, 12
	jr $ra
	
	
	