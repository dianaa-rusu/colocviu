.data
mesajCitire: .asciiz "Introduceti nr:"
mesajRezultatMaiMici: .asciiz "\nNr cifre mai mici ca media aritmetica a cifrelor: "
mesajRezultatMaiMari: .asciiz "\nNr cifre mai mari ca media aritmetica a cifrelor: "
mesajNegativ: .asciiz "Introduceti un nr pozitiv!"

.align 4 #word
vectorCifre: .space 100

.globl main
.text
main:
puts mesajCitire
geti $t0  #nr
bltz $t0, negativ
move $t1,$t0

li $t2, 0 #i  - dimensiunea vectorului
la $t3, vectorCifre
li $t4,10 
while_impartire_nr:
    div $t1,$t4
    mfhi $t5  #t5=t1%10
    sw $t5, ($t3)
    addi $t3,$t3,4
    addi $t2,$t2,1
    mflo $t1  #t1=t1/10
    bnez $t1,while_impartire_nr

la $t3, vectorCifre
li $t4, 0 #i
li $t5, 0 #suma
for_suma:
    lw $t6,($t3)
    add $t5,$t5,$t6
    addi $t4,$t4,1
    addi $t3,$t3,4
    bne $t4,$t2,for_suma
div $t5,$t2
mflo $t4  #media

la $t3, vectorCifre
li $t5, 0 #i
li $t7, 0 #contor mai mic
li $t8, 0 #contor mai mare
for_verificare:
    lw $t6,($t3)
    blt $t6, $t4 less
    #else
    addi $t8,$t8,1
    b incrementare
    less:
    #if
    addi $t7,$t7,1
    incrementare:
    addi $t5,$t5,1
    addi $t3,$t3,4
    bne $t5,$t2,for_verificare
puts mesajRezultatMaiMari
puti $t8
puts mesajRezultatMaiMici
puti $t7
done
negativ:
puts mesajNegativ
j main
