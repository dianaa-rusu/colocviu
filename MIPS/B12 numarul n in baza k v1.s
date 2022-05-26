#n=t0,baza=t1,p10=t2,nouln=t3,n%baza=t4,p10*t4=t5
.data 
	sir1: .asciiz "dati n:"
	sir2: .asciiz "dati baza:"
	sir3: .asciiz "n in baza noua este:"
	errorsir: .asciiz "n nu este pozitiv"
.text 
	li $t6,0
	puts sir1
	geti $t0
	sle $t7,$t0,$t6
	bnez $t7, sfarsit
	
	puts sir2
	geti $t1
	li $t2,1
	li $t3,0
	li $t8,10
loop:
	div $t0,$t1
	mfhi $t4
	mflo $t0
	mul $t5,$t2,$t4
	add $t3,$t3,$t5
	mul $t2,$t2,$t8
bnez $t0,loop

puts  sir3
puti $t3
done

sfarsit:
	puts errorsir
	done
