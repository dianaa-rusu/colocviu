.data
mesaj_n: 
	.asciiz "Introduceti un nr: "
mesaj_negativ:
	.asciiz "Nr introdus este negativ! "
mesaj_afisare:
	.asciiz "Nr prime care citite invers sunt tot prime: "
spatiu: .asciiz " "
.text
.globl main
main:
	puts mesaj_n
	geti $t0 #t0=n
	bltz $t0, negativ

#for(int i=2;i<n;i++)
#{
#	ok=true;
#	
#	for(int j=2;j<i;j++)
#	{
#		if(i%j!=0)
#		{
#			ok=false;
#			
#		}
#	}
#	int invers=0;
#	int copie_i=0;
#	while(copie_i!=0)
#	{
#		invers=invers*10+copie_i%10;
#		copie_i= copie_i/10;
#	}
#	for(int j=2;j<invers;j++)
#	{
#		if(invers%j!=0)
#		{
#			ok=false;
#			
#		}
#	}
#	
#	if(ok==true)
#	{
#		cout<<i<< " ";
#	}
#}

li $t1, 2 #i
puts mesaj_afisare
bgt $t0,$t1,afisare_2
for_parcurgere:
	li $t2, 2 #j
	for_2:
		div $t1, $t2
		mfhi $t3 #restul
		beqz $t3, incrementare
		addi $t2, $t2, 1 #incrementare j de la for_2
		blt $t2, $t1, for_2 #j<i
	li $t3, 0 #invers
	li $t4, 10
	move $t5, $t1 #copie i
	while:
		div $t5, $t4
		mfhi $t6 #restul
		mul $t3, $t3, $t4 #invers=invers*10
		add $t3, $t3, $t6
		mflo $t5 #copie_i
		bnez $t5, while
	li $t2, 2 #j
	for_3:
		div $t3, $t2
		mfhi $t4 #restul
		beqz $t4, incrementare
		addi $t2, $t2, 1 #incrementare j de la for_3
		blt $t2, $t3, for_3 #j<invers
		
		puti $t1
		puts spatiu
	incrementare:
		addi $t1, $t1, 1 #incrementare i de la for_1
		
	blt $t1, $t0, for_parcurgere
done
negativ:
puts mesaj_Negativ
j main

afisare_2:
	puti $t1
	puts spatiu
	j for_parcurgere
