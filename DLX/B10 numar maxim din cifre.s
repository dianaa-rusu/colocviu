	.data
Nr:
	.asciiz "Dati numarul "
Eroare:
	.asciiz "\nDati un nr > 0! "
Max:
	.asciiz "Numarul maxim format din cifrele numarului este: %d"
	.align 2
ParaEroare:
	.word Eroare
ParaMax:
	.word Max
N:
	.space 4
Cifre:
	.space 100
	.text
	.global main
main:
	addi r1,r0,Nr
	jal InputUnsigned
	
	add r2,r0,r1 ;r2<-numar
	
	sle r15,r2,r0
	bnez r15,err
	
	addi r3,r0,Cifre ;r3<-adresa de inceput unde se vor stoca cifrele
	addi r4,r0,10 ;r4<-10
	addi r8,r0,0 ;r8<-0 nr de cifre
loop:
	divu r5,r2,r4 ;r5<n/10
	multu r6,r5,r4
	subu r7,r2,r6
	sw (r3),r7
	addi r3,r3,4
	add r2,r0,r5
	addi r8,r8,1
	bnez r2,loop
	
	jal SortareCifre
	
;-------Formare Numar---------
	addi r3,r0,Cifre
	addi r2,r0,0 ;numarul care va fi format
	addi r5,r0,10
repeta:
	lw r4,(r3)
	multu r2,r2,r5
	add r2,r2,r4
	addi r8,r8,-1
	addi r3,r3,4
	bnez r8,repeta
	
	sw N,r2
	addi r14,r0,ParaMax
	trap 5
	
sfarist:
	trap 0
err:
	addi r14,r0,ParaEroare
	trap 5
	j main
SortareCifre:
	addi r4,r0,1 ;r4<-1 (k)
for1:
	addi r5,r0,0 ;i<-0
	addi r3,r0,Cifre
for2:
	lw r6,(r3)
	lw r7,4(r3)
	slt r15,r6,r7
	beqz r15,next
interschimbare:
	sw (r3),r7
	sw 4(r3),r6
next:
	addi r3,r3,4
	addi r5,r5,1
	addi r7,r8,-1
	slt r15,r5,r7
	bnez r15,for2
	
	addi r4,r4,1
	slt r15,r4,r8
	bnez r15,for1
	
	jr r31	
	