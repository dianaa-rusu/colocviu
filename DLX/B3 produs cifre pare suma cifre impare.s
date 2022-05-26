;int n, s=0, p=1
;while(n!=0)
;{
;	cifra= n%10;
;	if(cifra%2==0)
;		p=p*cifra;
;	else
;		s=s+cifra;
;   n=n/10;
;}
;cout<<s<<" "<<p;

.data
mesaj_n:
	.asciiz "Introduceti un nr: "
mesaj_negativ:
	.asciiz "Nr introdus este negativ! Reintroduceti: "
mesaj_produs:
	.asciiz "Produsul cifrelor pare este: %d"
mesaj_suma:
	.asciiz "Suma cifrelor impare este: %d"
	
	PrintfNegativ: 
		.word mesaj_negativ
	PrintfProdus:
		.word mesaj_produs
		ValoareProdus: .space 4
	PrintfSuma: 
		.word mesaj_suma
		ValoareSuma: .space 4
	
.text
.global main
main:
	addi r1, r0, mesaj_n
	jal InputUnsigned
	add r2, r0, r1 ;r2=n
	;test de pozitivitate
	slt r3, r2, r0 ;daca n<0
	bnez r3, negativ
	addi r4, r0, 0 ;s=0
	addi r5, r0, 1 ;p=1
	addi r7, r0, 10 ;r7=10 pt rest
	addi r9, r0, 2 
while:
	div r6, r2, r7 ;catul=r6
	mult r8, r6, r7 ;r8=cat(r6)*impartitor(r7)
	sub r8, r2, r8 ;r8=deimpartit-cat*impartitor ;r8=cifra
	div r10, r8, r9 ;r10=cifra/2
	mult r11, r10, r9 
	sub r11, r8, r11 ;r11=rest pt cifra%2
	seq r12, r11, r0 ;verif daca cifra%2==0
	bnez r12, produs
	;facem suma
	add r4, r4, r8 ;s=s+cifra
	j sfarsit_while
	produs:
		mult r5, r5, r8 ;p=p*cifra
sfarsit_while:
	add r2, r6, r0 ;n=n/10 
	bnez r2, while ;conditia de while

afisare:
	sw ValoareProdus, r5
	addi r14, r0, PrintfProdus
	trap 5
	sw ValoareSuma, r4
	addi r14, r0, PrintfSuma
	trap 5
	
trap 0
negativ:
	addi r14, r0, PrintfNegativ
	trap 5
	j main
	
	
	