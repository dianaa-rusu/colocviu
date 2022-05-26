; cin>>n;
; ct1=0
; ct2=0
; for(int i=0;i<n;i++)
; {
; cin>> a
; if(a>0)
; {
; 	if(a%2==0)
; 	{
; 		ct1++;
; 	}
; }
; else
; {
; 	a=-a;
; 	if(a%2==1)
; 	{
; 		ct2++;
; 	}	
; }
; }
; cout<< ct1
; cout<< ct2 


.data
mesaj_n:
.asciiz "Introduceti numarul de elemente n = "
mesaj_element:
.asciiz "Introduceti elementul = "
mesaj_negativ:
.asciiz "Introduceti un nr pozitiv"
mesaj_afisare_1:
.asciiz "Numar de elemente pozitive si pare: %d"
mesaj_afisare_2:
.asciiz "Numar de elemente negative si impare: %d"
 ;format afisare: mesaj + valoare 
PrintfAfisare1:                
    PrintfMesaj1: .word mesaj_afisare_1
    PrintfValue1: .space 4
PrintfAfisare2:
    PrintfMesaj2: .word mesaj_afisare_2
    PrintfValue2: .space 4

PrintfEroare:
    .word mesaj_negativ 

.text
.global main
main:
addi r1,r0,mesaj_n  ;r0 = 0
jal InputUnsigned
add r2,r1,r0  ;r2= r1+0  (n) 
sgt r7, r2, r0          ;test pozitivitate
beqz r7, negativ

add r3, r0, r0  ;r3<-0  (i de la for)
add r4, r0, r0  ;ct1=0
add r5, r0, r0  ;ct2=0

for_citire:
    addi r1,r0,mesaj_element
    jal InputUnsigned
    add r6,r1,r0        ;r6<-r1 (cin>>a)
    sgt r7, r6, r0      ;r7=a>0
    beqz r7, numar_negativ
    addi r8,r0,2        ;r8<-2
    div r9, r6, r8      ;r9<-r6/2
    ;rest = deimpartit-cat*impartitor
    mult r9, r9, r8      ;r9<-cat*impartitor
    sub r9, r6, r9      ;r9<-deimpartit-cat*impartitor
    seq r10, r9, r0     ;r10<- r9==0
    beqz r10, sfarsit_for
    addi r4,r4,1        ;ct1++
    j sfarsit_for 

    numar_negativ:
    addi r8,r0,2        ;r8<-2
    sub r6,r0,r6        ;r6=0-r6
    div r9, r6, r8      ;r9<-r6/2
    ;rest = deimpartit-cat*impartitor
    mult r9, r9, r8      ;r9<-cat*impartitor
    sub r9, r6, r9      ;r9<-deimpartit-cat*impartitor
    seq r10, r9, r0     ;r10<- r9==0
    bnez r10, sfarsit_for
    addi r5,r5,1        ;ct2++
    sfarsit_for:
    addi r3,r3,1        ;i++
    slt r11,r3,r2       ;i<n
    bnez r11, for_citire

;store dest, sursa
sw PrintfValue1, r4     ;sw ct1
sw PrintfValue2, r5     ;sw ct2
add r14,r0, PrintfAfisare1
trap 5
add r14,r0, PrintfAfisare2
trap 5

trap 0
negativ:
addi r14,r0,PrintfEroare
trap 5
j main
