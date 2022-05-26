.data
introduTxt:
	.asciiz "introdu numarul "
space:.asciiz " \n"
.text
la $a0 , introduTxt
li $v0,4
syscall

li $v0,5
syscall

move $t5,$v0 # in t5 am contorul , adica n 
li $t8,1 # primul numar cu care incep 

check_number:

li $a1, 2 # devider
devide: 
div $t8,$a1
mfhi $a3 #in a3 am restul 
beqz $a3, final
add $a1,$a1,1 #incrementez deviderul 
bge $a1,$t8 pozitiv
j devide



pozitiv:
	
	move $t9,$t8 #pun numarul in t9 pentru ca acesta va fi modificat 
	li $t0,0 #pentru invers numar
	li $t3,10 # pentru div
	#in t8 am numarul 
	div $t8,$t3 #impart n la 10
	mflo $t8 #in a1 este catul
	mfhi $a2 # in a2 este restul
	add $t3,$t3,$a2 # in t3 pun prima cifra
    beqz $t8,check_invers_prim # daca n>0 repeta
	
repeta:
	
	div $t8,$t3 #impart n la 10
	mflo $t8 #in a1 este catul
	mfhi $a2 # in a2 este restul
	mul $t3,$t3,10 # inmultesc cu zece pentru a trece la unitatea urmatore
	add $t3,$t3,$a2 # adun noua cifra la total 
	bnez $t8,repeta # daca n>0 repeta

check_invers_prim:
	move $t8,$t3 # pun in t8 inversul pentru a-l testa

	check_invers_number:
	li $a1, 2 # devider
	devide_invers: 
	div $t8,$a1
	mfhi $a3 #in a3 am restul 
	beqz $a3, final
	add $a1,$a1,1 #incrementez deviderul 
	bge $a1,$t8 invers_prim
	j devide_invers


invers_prim:
	move $a0,$t3
	li $v0,1
	syscall
	
	la $a0,space
	li $v0,4
	syscall
	
	
final:
	

	move $t8,$t9
	addi $t8,$t8,1
	bge $t8,$t5,exit
	li $t3,0
	j check_number
	
exit: 
	 li $v0,10
	 syscall



