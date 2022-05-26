;cin >> n;
;test de pozitivitate;
;sumaDivizori = 0;
;for (i=1; i<n; i++){
;   if (n%i == 0);
;       sumaDivizori += i;
;}
;if (n == sumaDivizori) {
;   cout << "numar perfect";
;}
;else
;   cout << "numarul nu e perfect";
;}

.data
    mesajIntroN: .asciiz "Introduceti n: "
    mesajEroare: .asciiz "N trebuie sa fie pozitiv."
    mesajNrPerfect: .asciiz "Numarul este perfect."
    mesajNrNuEPerfect: .asciiz "Numarul nu este perfect."

    .align 2
    PrintfEroare: .word mesajEroare
    PrintfNrPerfect: .word mesajNrPerfect
    PrintfNrNuEPerfect: .word mesajNrNuEPerfect

.text
.global main
main:
    addi r1, r0, mesajIntroN
    jal InputUnsigned
    addi r2, r1, 0              ;r2 <- n
    slt r3, r2, r0              ;daca n e mai mic ca 0 avem 1 in r3
    bnez r3, eroare             ;daca e mai mic sarim la eroare

    add r4, r0, r0              ;sumaDivizori = 0
    addi r5, r0, 1              ;contor i pentru for
for:
    div r6, r2, r5              ;r6 <- n/i
    mult r7, r6, r5             ;cat*impartitor
    sub r7, r2, r7              ;rest = deimpartit - cat*impartitor
    sgt r8, r7, r0              ;daca restul e mai mare decat 0 punem 1 in r8
    bnez r8, sfarsit_for        ;nu e divizor => sfarsit_for
    add r4, r4, r5              ;daca e divizor il adaug la suma

    sfarsit_for:
        addi r5, r5, 1          ;i++
        slt r9, r5, r2          ;verificam daca i<n
        bnez r9, for

verificare:
    seq r9, r2, r4              ;daca n = sumaDivizori
    bnez r9, perfect
    ;else:
    addi r14, r0, PrintfNrNuEPerfect  ;la afisare mereu punem in r14
    trap 5
    j sfarsit

    perfect:
    addi r14, r0, PrintfNrPerfect  ;la afisare mereu punem in r14
    trap 5

sfarsit:
    trap 0

eroare:
    addi r14, r0, PrintfEroare  ;la afisare mereu punem in r14
    trap 5
    j main


;set -> folosim sa scriem conditia
;beqz -> verificam daca conditia o dat rezultat fals
;bnez -> verificam daca conditia o dat rezultat adevarat