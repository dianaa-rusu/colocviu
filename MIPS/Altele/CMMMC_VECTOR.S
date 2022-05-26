.data
	introduN: .asciiz "cate numere are vectorul : "
	introduNumbere: .asciiz "introdu numerele"
	.align 4
	numere: .space 100
	
.text
	la $a0,introduN
	li $v0,4
	syscall
	
	li $v0,5
	syscall
	move $t1,$v0 #t1=contor
	
	
	li $t2,0 # contor cate numere am citit 
	la $a2,numere # adresa vector
	
citeste:
	li $v0,5
	syscall
	move $a3,$v0
	sw $a3,($a2)
	addi $t2,$t2,1
	addi $a2,$a2,4
	blt $t2,$t1,citeste
	
#   CMMDC	
#	while(a!=b)
#    {
#        if(a>b)
#            a=a-b;
#        else
#            b=b-a;
#    }

	li $a3,1 # produsul numerelor
	move $t7,$t1
	
	la $a2,numere
	lw $t0,($a2)
	mul $a3,$a3,$t0
	addi $a2,$a2,4
	lw $t1,($a2)
	mul $a3,$a3,$t1
	addi $t7,$t7,-2
	
	bne $t0,$t1,repeta
	
cmmdc:
	
	addi $a2,$a2,4
	addi $t7,$t7,-1
	bltz $t7,cmmmc
	lw $t1,($a2)
	mul $a3,$a3,$t1
	
repeta:
	bgt $t0,$t1,caz_1
	sub $t1,$t1,$t0
continua:
	bne $t0,$t1,repeta
	j cmmdc
	
caz_1:
	sub $t0,$t0,$t1
	j continua

cmmmc:
	
	move $a0,$a3
	li $v0,1
	syscall


	div $a3,$t0
	mflo $a0
	li $v0,1
	syscall
	

	
	