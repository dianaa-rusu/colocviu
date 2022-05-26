.data
	mesajIntroN: .asciiz "Introduceti n: "
	mesajIntroNr: .asciiz "Introduceti n numere: "
	mesajNegativ: .asciiz "N negativ. Reintroduceti n"
	mesajAfisare: .asciiz "Rezultat= "
	.align 4
	numere: .space 100
	
.text

.globl main
main:
	puts mesajIntroN
	geti $t0			#n
	la $t2, numere		#aducem adresa lui numere
	bltz $t0, negativ	#verificam ca n sa fie pozitiv
	puts mesajIntroNr
	
	li $t1, 0			#contor vector
for_introducere:
	geti $t3			#citim un nr
	sw $t3, ($t2)		#punem ce citim in adresa din t2 #t3 il punem la adr lui t2
	addi $t2, $t2, 4	#incrementam adresa
	addi $t1, $t1, 1	#incrementam contorul
	blt $t1, $t0, for_introducere
	
li $t4, 0				#rezultat
li $t1, 0				#contor vector = i
la $t2, numere			#punem adresa lui numere (din nou)
li $t6, 5				#punem 5 in t6
for_parcurgere:
	lw $t5, ($t2)		#punem numarul de la adresa t2 in t5
	while:
		div $t5, $t6
		mfhi $t7
		bnez $t7, incrementare
		addi $t4, $t4, 1
		mflo $t5
		j while
		
	incrementare:
		addi $t1, $t1, 1
		addi $t2, $t2, 4
		blt $t1, $t0, for_parcurgere
		
puts mesajAfisare
puti $t4
	
	done
negativ:
	puts mesajNegativ
	j main
	