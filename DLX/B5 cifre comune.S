;cin>>x
;n=0
;while(x!=0)
;{
;   a[n] = x%10
;   x=x/10;
;   n++;
;}  
;cin>>y
;while(y!=0)
;{
;   int ultima = y%10
;   bool afiseaza=false;
;   for(int i =0;i<n;i++)
;   {
;       if(a[i]==ultima)
;           afiseaza=true
;   }
;   if(afiseaza==true)
;   {
;       cout<<ultima
;   }
;   y=y/10
;}
;

.data
    mesajX: .asciiz "Introduceti primul nr: "
    mesajY: .asciiz "Introduceti al doilea numar: "
    mesajRezultat: .asciiz "Cifrele comune sunt: "
    mesajElement: .asciiz "%d "

    .align 2
    PrintfRezultat:
        .word mesajRezultat
    PrintfElement:
        .word mesajElement
        ElementValue: .space 4

    .align 4
    vector: .space 100

.text
    .global main
    main:
    addi r1,r0,mesajX
    jal InputUnsigned
    add r2,r1,r0  ;r2=x
    add r3,r0,r0  ;r3=0 (dimensiunea vectorului=n)
    addi r4,r0,vector ;adresa vectorului
    addi r5,r0,10
    whileX:
        div r6,r2,r5        ;x/10
        mult r7,r6,r5       ;cat*impartitor
        sub r7,r2,r7        ;rest = deimpartit - cat*impartitor
        sw (r4),r7          ;a[n]=x%10
        addi r4,r4,4        ;trecem la adresa urmatoare
        addi r3,r3,1        ;n++
        add r2,r6,r0        ;x=x/10
        bnez r2,whileX
    addi r1,r0,mesajY
    jal InputUnsigned
    add r2,r1,r0  ;r2=y
    addi r14,r0,PrintfRezultat
    trap 5 
    whileY:
        div r6,r2,r5        ;y/10
        mult r7,r6,r5       ;cat*impartitor
        sub r7,r2,r7        ;rest = deimpartit - cat*impartitor
        addi r4,r0,vector   ;adresa vectorului
        addi r8,r0,0       ;i=0
        for:
            lw r9,(r4)      ;a[i]
            seq r10,r9,r7   ;bool afiseaza = true daca am gasit ultima cifra din y in x
            bnez r10,afisare
            addi r4,r4,4    ;incrementam adresa
            addi r8,r8,1    ;i++
            slt r11,r8,r3   ;i<n
            bnez r11,for
        j sfarsit_while
        afisare:
        sw ElementValue, r7
        addi r14,r0,PrintfElement
        trap 5
        sfarsit_while:
            add r2,r0,r6
    bnez r2, whileY
trap 0

