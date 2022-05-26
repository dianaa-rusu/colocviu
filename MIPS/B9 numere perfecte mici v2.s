#Scrieti un program care citeste de la tastatura un nr n si verifica daca este perfect.

#int n, d, s=1;
#    cin>>n;
#    for(d=2;d<=n/2;d++)
#        if(n%d==0)
#            s=s+d;
#    if(n==s)
#        cout<<"numarul "<<n<<"este perfect";
#    else
#        cout<<"numarul "<<n<<"nu este perfect";
	
	.data
msg1:
	.asciiz "Dati un numar:"
msg2:
	.asciiz "Numarul este perfect!\n"
msg3:
	.asciiz "Numarul nu este perfect!\n"
	.align 4
divizori:
	.space 100
n:
	.word 6
	
	.text
	.globl main
main:
	li $v0, 4		#print string
	la $a0, msg1
	syscall
	
	li $v0, 5		#v0=n
	syscall
	move $t3, $v0	#t3=n		

	li $t0, 1		#t0=1=suma		
	li $t1, 2		#t1=2=d
	div $t3, $t1
	mflo $t4		#t4=n/2
for:
	bgt $t1, $t4, if 
	div $t3, $t1		#n/d
	mfhi $t5			#t5=restul
	beqz $t5, suma		#if n%d==0 sari la suma++
	addi $t1, $t1, 1	#d++
	j for

suma:
	add	$t0, $t0, $t1	#suma++
	addi $t1, $t1, 1	#d++
	j for

if:
	beq $t0, $t3, perfect	#daca n=suma => nr e perfect
	
nu_perfect:
	li $v0, 4
	la $a0, msg3
	syscall
	j sfarsit

perfect:
	li $v0, 4
	la $a0, msg2
	syscall

sfarsit:
	done
