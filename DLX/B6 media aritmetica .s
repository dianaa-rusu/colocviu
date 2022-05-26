;cin>>n;
;test pozitivitate
;i=0;
;suma = 0;
;while (n>0) {
;   vector[i] = n%10;
;   n = n/10;
;   suma = suma + vector[i];
;   i++;
;}
;contorMaiMic = 0;
;contorMaiMare = 0;
;medie = suma/i;
;for (j = 0, j <i; j++) {
;   if (vector[j] < medie) {
;       contorMaiMic++;
;   }
;   else {
;       contorMaiMare++;
;   }
;}
;cout << contorMaiMic << contorMaiMare;

.data
    mesajIntroN: .asciiz "Introduceti n: "
    mesajEroare: .asciiz "N trebuie sa fie pozitiv. \n"
    mesajMaiMic: .asciiz "Exista %d numere mai mici ca media aritmetica. \n"
    mesajMaiMare: .asciiz "Exista %d numere mai mari ca media aritmetica. \n"

    .align 2
    PrintfEroare:
        .word mesajEroare
    PrintfMaiMic:
        .word mesajMaiMic
        ValueMaiMic: .space 4
    PrintfMaiMare:
        .word mesajMaiMare
        ValueMaiMare: .space 4

    .align 4
    vector: .space 100

.text
.global main
main:
    addi r1, r0, mesajIntroN
    jal InputUnsigned
    add r2, r0, r1              ;r2 <- n
    slt r3, r2, r0
    bnez r3, eroare
    addi r3, r0, 0              ;contor i
    addi r4, r0, 0              ;sumaCifre
    addi r5, r0, vector         ;aducem adresa in r5
    addi r6, r0, 10             ;punem 10 pentru impartire
    while_n:
        div r7, r2, r6          ;n/10
        mult r8, r7, r6         ;impartitor*cat
        sub r8, r2, r8          ;rest = deimpartit - impartitor*cat -> ultima cifra din numar
        sw (r5), r8             ;stocam ultima cifra in vector
        add r4, r4, r8          ;adunam ultima cifra la suma
        addi r3, r3, 1          ;crestem contorul i (dimensiunea vectorului)
        addi r5, r5, 4          ;incrementam adresa vectorului
        add r2, r7, r0          ;n = n/10
        bnez r2, while_n        ;daca n!=0 continuam while
    div r9, r4, r3              ;media = suma/i
    addi r10, r0, 0             ;contorMaiMare = 0
    addi r11, r0, 0             ;contorMaiMic = 0
    addi r12, r0, 0             ;contor j
    addi r5, r0, vector         ;aducem adresa in r5!!!
    for_vector:
        lw r15, (r5)            ;load word - incarc in r15 ce se afla la adresa din r5
        slt r13, r15, r9         ;daca cifra mai mica decat media
        bnez r13, maiMic
        addi r10, r10, 1        ;creste contorMaiMare
        j sfarsit_for
        maiMic:
            addi r11, r11, 1    ;crestem contorMaiMic
        sfarsit_for:
            addi r12, r12, 1        ;crestem j
            addi r5, r5, 4          ;incrementam adresa
            slt r13, r12, r3        ;daca j<i
            bnez r13, for_vector
    afisare:
        sw ValueMaiMare, r10
        addi r14, r0, PrintfMaiMare
        trap 5
        sw ValueMaiMic, r11
        addi r14, r0, PrintfMaiMic
        trap 5
trap 0

eroare:
    addi r14, r0, PrintfEroare
    trap 5
    j main