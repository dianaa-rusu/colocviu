.data
	.align 4
	introduStr: .asciiz "introduceti numarul=  "
	numarNegativ: .asciiz "numarul trebuie sa fie pozitiv"
	sumaEsteString: .asciiz "suma este= "
	produsEsteString: .asciiz "produsul este="
	space: .asciiz"\n"
	.align 4
	n: .space 4
	.align 4
	cifre: .space 100
	.align 4
.text
	la $a0,introduStr	# afisare string introdu str
	li $v0,4
	syscall
	
	li $v0,5 #citesc numar
	syscall
	
	move $a1,$v0 # a1=n
	bgez $a1,calculCifre #daca n >=0 mergi la calcul
	
	la $a0,numarNegativ # n<0 , numar invalid , deci afisez stringul corespunzator
	li $v0,4
	syscall
	j end
	
	
	
	li $t5,0 #contor cifre
calculCifre:	
	
	
	li $t3,10 # pentru div
	la $a3,cifre
	
repeta:
	
	div $a1,$t3 #impart n la 10
	mflo $a1 #in a1 este catul
	mfhi $a2 # in a2 este restul
	sw 	 $a2,($a3) # salvez in memorie cifra
	addi $a3,$a3,4 #adun 4 pentru a trece la urmatoarea locatie din vector
	addi $t5,$t5,1 # incrementez contorul
	bnez $a1,repeta # daca n>0 repeta
	
	
	
	la $a2,n
	sw $t5,($a2)
	
	lw $t1,($a2) #in t1 am contorul
	
	la $a1,cifre #in $a1 am pointer spre vector
	li $t2,10 #minim par
	li $t3,0 #maxim impar 
	li $t7,2 # pentru a imparti
afisare:	
	lw $a0,($a1) # in a0 am numarul 
	div $a0,$t7 
	mfhi $t6 #t6 am restul
	beqz $t6,par
impar:
	ble $a0,$t3,continua
	move $t3,$a0
	j continua
par:	
	bge $a0,$t2,continua
	move $t2,$a0
	
continua:
	addi $a1,$a1,4
	addi $t1,$t1,-1
	bnez $t1,afisare
	
	move $a0,$t2
	li $v0,1
	syscall


	move $a0,$t3
	li $v0,1
	syscall
	
	
	
	