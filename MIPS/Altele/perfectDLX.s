; dlx
;se citeste un nr natural N > 1 de la tastatura si se face testul pentru >1 prin intermediul modulului inputs se face citirea
;sa se afle daca numarul este perfect 
	.data
msg_citire:
	.asciiz "Introduceti un nr n>1: "
msg_afisare:
	.asciiz "Numarul este perfect!\n"
msg_afisare_nu:
	.asciiz "Numarul nu este perfect!\n"
	.align 4
para_afisare_perfect:
	.word msg_afisare
para_afisare_nu:
	.word msg_afisare_nu
val:
	.space 4
.text
.global main
main:
	addi r1, r0, msg_citire
	jal InputUnsigned
	addi r2, r1, 0	; r2 = n
	addi r12, r1, 0
	sle r3, r1, 1
	addi r4, r4, 1		; r4 = suma div
	bnez r3, main
	addi r5, r5, 2
	addi r7, r7, 2
	sub r9, r2, r7
divizori:
	seq r8, r5, r9
	bnez r8, check
	add r10, r2, r0
	div r2, r2, r5
	multu r11, r2, r5
	sub r11, r10, r11 ;r11 = rest
	bnez r11, nu_se_divide
se_divide:
	add r4, r4, r5 
	addi r5, r5, 1
	j divizori
nu_se_divide:
	addi r5, r5, 1
	j divizori
check:
	seq r10, r12, r4
	bnez r10, perfect
nu_perfect:
	sw val, r2
	addi r14, r0, para_afisare_nu
	trap 5
	j sfarsit
perfect:
	sw val, r2
	addi r14, r0, para_afisare_perfect
	trap 5
	j sfarsit
sfarsit:
trap 0