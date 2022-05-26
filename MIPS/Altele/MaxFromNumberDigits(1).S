.data
introdu_str: .asciiz "introdu un numar"
n: .space 4
.align 4
cifre:
.space 100
contor:
.space 4


.text
#afisam stringul pentru introducere numar
la $a0,introdu_str 
li $v0,4
syscall

#citim numar
li $v0,5
syscall

#punem numar in $t1
move $t1,$v0#t1=n;

# check if numer is zero 
# if true go to end

la $t2,cifre # folosim cifre ca un pointer v 
			 # spre inceputul vectorului
li $t3,0 #contor cifre

li $t0,10

repeta:			# exemple pentru nr 152
	div $t1,$t0 # lo= catul impartirii ex 15
				# hi= restul impartirii ex 2
	mfhi $a0    # pun in $a0
	sw $a0,($t2) #pun valorea si mut pointerul cu 4 adica o pozitie
	addi $t3,$t3,1
	addi $t2,$t2,4
	mflo $t1     #t1 adica n = catul 
	
    bnez $t1 repeta

sw $t3,contor

#Bubble sort
#for(k = 1; k < n; k++)
# for(i = 0; i < n-1; i++)
# if(a[i] > a[i+1])
# interschimba-le

#in a1 am n-ul

lw $a1,contor


bubble_sort:
li $t1, 1 #t1 = k = 1
move $t2, $a1 #t2 = n
#for(i = 0; i < n-1; i++)
for1:
li $t3, 0 #t3 = i
move $t4, $a1
addi $t4, $t4, -1 #t4 = n-1
la $t0, cifre
#for(k = 1; k < n; k++)
for2:
lw $t5,($t0) #a[i]
lw $t6,4($t0) #a[i+1]
sgt $t7, $t5, $t6 #if(a[i] > a[i+1])
beqz $t7, continua
interschimbare:
sw $t6,($t0) #interschimbare a[i] <-> a[i+1]
sw $t5,4($t0)
continua:
addi $t0, $t0, 4
addi $t3, $t3, 1
slt $t7, $t3, $t4 #t7 = t3 < t4?
bnez $t7, for2

addi $t1, $t1, 1
slt $t7, $t1, $t2
bnez $t7, for1
  

#afisare
la $t2,cifre
lw $t3,contor


afisare1:
	lw $a0,($t2)
	li $v0,1
	syscall
	sub $t3,1
	beqz $t3,end
	addi $t2,$t2,4
	j afisare1







end:
li,$v0,10
syscall
