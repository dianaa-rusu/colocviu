
#Citim n
#Citim baza 
#Vedem daca numarul e pozitiv(n)
#impartim numarul la baza pana cand catul este 0 si afisam in ordine inversa resturile

.data
citire_n:
    .asciiz "numarul este "
citire_k:
    .asciiz "baza este "
afisare_nr_baza_noua:
    .asciiz "numarul transformat este "
afisare_eroare:
    .asciiz "numarul este negativ"
.text
.globl main
main:

puts citire_n
geti $t0  #n

puts citire_k
geti $t1 #k


li $t2,0
li $t9,0

sle $t2,$t0,$t9 #pozitivitate
bnez $t2,end


#16:2 = 8 r 0
#8: 2= 4 r 0
#4:2= 2 r 0
#2:2= 1 r 0
#1:2 = 0 r 1
#ceva=1 (tot inmultim cu 10)
#=>numar = numar+ rest * ceva

li $t3,1 # (acel ceva cu care inmultim, il creste ccu * 10)
li $t4,0 #numarul ce trebuie afisat in noua baza
li $t5,10 #inmultim (crestem cu *10) ceva pentru fiecare pas

#cat in lo si rest in hi
li $t6,0
add $t6,$t6,$t0 #punem in t6 pe n ca sa nu il alteram

baza:
   div $t6,$t1 
   mflo $t6 #cat
   mfhi $t7 #rest
    mul  $t8,$t7,$t3 # rest* ceva
    mul $t3,$t3,$t5 #"crestem" ceva-ul
    add $t4,$t4,$t8

bnez $t6,baza

puts afisare_nr_baza_noua
puti $t4
j sfarsit


end:
    puts afisare_eroare
sfarsit:
    done


   