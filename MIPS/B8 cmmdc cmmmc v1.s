#Calculeaza cmmmc a 2 nr. citite de la tastatura.
#Algoritm:
#while(b!=0)
#	r = a%b
#	a = b
#	b = r
#cmmdc<-a
#cmmmc<-(a*b)/cmmdc
	.data
msg_citire_a:
	.asciiz "a = "
msg_citire_b:
	.asciiz "b = "
msg_afisare_cmmmc:
	.asciiz "cmmmc = "
	.align 4
var_a:
	.word 5
var_b:
	.word 6
cmmdc:
	.word 6
	.text
	.globl main
main:

	li $v0, 4
	la $a0, msg_citire_a
	syscall
	li $v0, 5
	syscall
	move $t0, $v0		#$t0<-a
	la $t2, var_a
	sw $t0, ($t2)	

	li $v0, 4
	la $a0, msg_citire_b
	syscall
	li $v0, 5
	syscall
	move $t1, $v0		#$t1<-b
	la $t2, var_b
	sw $t1, ($t2)

repeta:
	div $t0, $t1
	move $t0, $t1		#a<-b
	mfhi $t1		#b<-r
	bnez $t1, repeta

	la $t2, cmmdc
	sw $t0, ($t2)
	
	la $t2, var_a
	lw $t0, ($t2)
	la $t2, var_b
	lw $t1, ($t2)
	la $t2, cmmdc
	lw $t2, ($t2)
	mult $t0, $t1
	mflo $t3		#$t3<-a*b
	div $t3, $t2		#a*b/cmmdc
	mflo $t4
	mfhi $t5 	

	li $v0, 4
	la $a0, msg_afisare_cmmmc
	syscall
	li $v0, 1
	move $a0, $t4
	syscall
	putc ' '
	li $v0, 1
	move $a0, $t5
	syscall
	

sfarsit:
	done
