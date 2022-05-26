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
	
	
# Avem toate cifrele in vector
# trebuie sa facem media aritmetica
# while(n!=0){
#  sum+=v[i];
#  i+=4
#  n-=1;
#}

	la $a3,cifre # in a3 am vectorul
	li $t0,0 # in t0 am suma 
	# in $t5 am n
calcul_sum:	
	lw $t2,($a3) # iau elementul curent
	add $t0,$t0,$t2 # sum+=v[i]
	addi $t5,$t5,-1 #n-=1
	beqz $t5,average # verific daca n=0 , daca da ies din while si merg pe average
	addi $a3,$a3,4 # i+=4 , trec pe urmatorul elementul
	j calcul_sum
	
	
	
average:	
	# in $t0 avem suma
	la $a2,n
	lw $t1,($a2)
	#in $t1 avem numarul de elemente 
	div $t0,$t1
	mflo $t0 # in $t0 am media aritmetica , adica catul impartirii $t0 la $t1
	
	move $a0,$t0
	li $v0,1
	syscall
	
# Cate numere sunt mai mari decat media si cate sunt mai mici
# while (n!=0){
#  aduc elementul din memorie
#  v[i]> ma ? 
#   daca da incremenetez ct1(contur pentru nr mai mari )
#   daca nu incremenetez ct2(contur pentru nr mai mici )
#   n--;
#   i++ (pointez spre urmatorul element)
# }


	la $a2,n
	lw $t1,($a2)
	# in #t1 am n 
	li $t2,0 # contor numere mai mari 
	li $t3,0 # contor numere mai mici 
	#$t0 avem media aritmetica
	la $a1,cifre
	
verifica:	
	lw $t4,($a1)
	bgt $t4,$t0,mai_mare
    blt $t4,$t0,mai_mic
continua:
	addi $a1,$a1,4
	addi $t1,$t1,-1
	bnez $t1,verifica
	j afisare
	
mai_mare:
	
	addi $t2,$t2,1
	j continua

mai_mic:
	addi $t3,$t3,1
	j continua

afisare:
	move $a0,$t2
	li $v0,1
	syscall
	move $a0,$t3
	li $v0,1
	syscall
	

	
	



	

