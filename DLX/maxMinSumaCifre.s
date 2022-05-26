.data

mesaj1: .asciiz "Introduceti un nr: "
testNrNegativ: .asciiz "Nr introdus este negativ: "

.align 2
nrNegativ: .word testNrNegativ

.text
.global main

main:

	addi r2,r1,mesaj1
	jal InputUnsigned
	addi r3,r0,0
	slt r3, r2, 0
	bnez r3, et_negativ
	add  r3, r0, r0     
    	add  r6, r0, 10     
    	add  r4, r1, r0      
    	add  r8, r0, 0       
    	add  r9, r0, 9  
loop:
	add r7,r4,r0
	div r4, r4, r6
	multu r5, r4, r6
	sub r5, r7, r5
	add r3, r3, r5
	sgt r1, r5, r8
	bnez r1, maxim
maxim:
	slt r1,r5,r9
	bnez r1, minim
minim:
	bnez r4, loop
	j mem
et_maxim:
	xor r8,r8,r8
	or r8,r8,r5
	j maxim
et_minim:
	xor r9,r9,r9
	or r9,r9,r5
	j minim
mem:
	xor r1,r1,r1
	ori r1,r1,#0x1500
	sw 0(r1),r3
	sw 4(r1), r8
	sw 8(r1),r9
	j final
et_negativ:
	addi r14, r0, nrNegativ
	trap 5
	j main
final:
	trap 0