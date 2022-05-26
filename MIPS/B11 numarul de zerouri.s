#Citeste un vector cu n componente de la tastatura.
#Se se afle nr. cifrelor de 0 cu care se termina numarul
#format din produsul componentelor vectorului fara a 
#calcula produsul
	.data
msg_citire_n:
	.asciiz "n = "
msg_citire_vector:
	.asciiz "Introduceti vectorul: "
msg_afisare_nr_0:
	.asciiz "Produsul are urm nr. de 0: "
	.align 4
n:
	.space 4
vector:
	.space 100
nr_div_2:
	.space 4
nr_div_5:
	.space 4

	.text
	.globl main
main:
	li $v0, 4
	la $a0, msg_citire_n
	syscall
	li $v0, 5
	syscall
	move $t1, $v0		#$t1<-ct. nr.
	la $t3, n		
	sw $t1, ($t3)
	li $v0, 4
	la $a0, msg_citire_vector
	syscall	

	li $t2, 0		#tine minte nr. div 2
	li $t5, 0		#tine minte nr. div 5
	la $t3, vector		#$t3<-adresa de baza a vectorului
citeste:
	li $v0, 5
	syscall
	sw $v0, ($t3)	

	#verifica nr. de 2 si de 5
	li $t4, 2		#$t4<-div 2
numara_div_2:
	div $v0, $t4
	mfhi $t6		#$t6<-restul
	mflo $v0		#$a0<-$a0/2
	bnez $t6, continua
se_divide_cu_2:
	addi $t2, $t2, 1	#creste nr div 2
	bnez $v0, numara_div_2	#cat timp nr != 0	

continua:
	lw $v0, ($t3)
	li $t4, 5		#$t4<-div 5
numara_div_5:
	div $v0, $t4
	mfhi $t6		#$t6<-restul
	mflo $v0		#$a0<-$a0/5
	bnez $t6, continua2
se_divide_cu_5:
	addi $t5, $t5, 1	#creste nr div 5
	bnez $v0, numara_div_5	#cat timp nr != 0	

continua2:
	addi $t3, $t3, 4
	addi $t1, $t1, -1
	bgtz $t1, citeste

	la $t0, nr_div_2
	sw $t2, ($t0)
	la $t0, nr_div_5
	sw $t5, ($t0)

	la $a0, msg_afisare_nr_0
	li $v0, 4
	syscall
	sub $t3, $t2, $t5
	blez $t3, min_e_2
min_e_5:
	la $t0, nr_div_5
	lw $a0, ($t0)
	li $v0, 1
	syscall 
	j sfarsit
min_e_2:
	la $t0, nr_div_2
	lw $a0, ($t0)
	li $v0, 1
	syscall

sfarsit:
	done
