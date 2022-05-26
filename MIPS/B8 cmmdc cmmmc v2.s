#Calculeaza cmmdc a 2 nr. citite de la tastatura.
#Algoritm:
#while(b!=0)
#	r = a%b
#	a = b
#	b = r
#cmmdc<-a
	.data
msg_citire_a:
	.asciiz "a = "
msg_citire_b:
	.asciiz "b = "
msg_afisare_cmmdc:
	.asciiz "cmmdc = "
	.text
	.globl main
main:

	li $v0, 4  #e echivalent cu puts mesaj_citire_a
	la $a0, msg_citire_a
	syscall
	
	li $v0, 5  #e echivalent cu geti $v0 ,citeste a
	syscall
	
	move $t0, $v0		#$t0<-a
	
	li $v0, 4 #e echivalent cu puts mesaj_citire_b
	la $a0, msg_citire_b
	syscall
	
	li $v0, 5 #e echivalent cu geti $v0 , citeste b
	syscall
	move $t1, $v0		#$t1<-b

repeta:
	div $t0, $t1
	move $t0, $t1		#a<-b
	mfhi $t1		#b<-r
	bnez $t1, repeta
	
	
	
	li $v0, 4  #e echivalent cu puts mesaj_afisare_cmmdc
	la $a0, msg_afisare_cmmdc
	syscall
	
	
	li $v0, 1 		#puti $vo 
	move $a0, $t0
	syscall

sfarsit:
	done
