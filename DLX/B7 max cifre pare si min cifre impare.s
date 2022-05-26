;cin>>n
;max = 0;
;min = 10;
;while (n>0){
;   cifra = n%10;
;   if (cifra % 2 == 0){
;       if (cifra > max) {
;           max = cifra;
;       }
;   }
;   else {
;       if (cifra < min) {
;           min = cifra;
;       }
;   }
;}
;cout <<min <<max;

.data
    mesajIntroN: .asciiz "Introduceti n: "
    mesajEroare: .asciiz "N trebuie sa fie pozitiv."
    mesajMaxPare: .asciiz "Maximul cifrelor pare este: %d \n"
    mesajMinImpare: .asciiz "Minimul cifrelor impare este: %d \n"

    PrintfEroare:
        .word mesajEroare
    PrintfMaxPar:
        .word mesajMaxPare
        ValueMax: .space 4
    PrintfMinImpar:
        .word mesajMinImpare
        ValueMin: .space 4

.text
.global main
main:
    addi r1, r0, mesajIntroN
    jal InputUnsigned
    add r2, r0, r1              ;r2 <- n
    slt r3, r2, r0
    bnez r3, eroare
    add r3, r0, r0              ;max = 0
    addi r4, r0, 10             ;min = 10
    addi r10, r0, 10            ;10 pentru impartire
    addi r11, r0, 2             ;2 pentru impartire
    while_n:
        div r5, r2, r10         ;n/10
        mult r6, r5, r10        ;impartitor*cat
        sub r6, r2, r6          ;rest = deimpartit - impartitor*cat
        div r7, r6, r11         ;(n % 10) / 2
        mult r8, r7, r11        ;impartitor*cat
        sub r8, r6, r8          ;rest = deimpartit - impartitor*cat
        bnez r8, impar          ;daca restul e 1 atunci nr e impar
        par:
            slt r9, r6, r3      ;daca cifra < max
            bnez r9, sfarsit_while
            add r3, r0, r6      ;daca e mai mare atunci max = cifra
            j sfarsit_while
        impar:
            sgt r9, r6, r4      ;daca cifra > min
            bnez r9, sfarsit_while
            add r4, r0, r6      ;daca e mai mic atunci min = cifra
        sfarsit_while:
            add r2, r0, r5      ;n = n/10
            bnez r2, while_n    ;daca n!=0 mai trecem prin while
    afisare:
        sw ValueMax, r3
        addi r14, r0, PrintfMaxPar
        trap 5
        sw ValueMin, r4
        addi r14, r0, PrintfMinImpar
        trap 5
    trap 0
    eroare:
        addi r14, r0, PrintfEroare
        trap 5
        j main
