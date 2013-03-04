! mystery program for CS2208 

BITPATTERN = 0xAB01DE89
  
	.global main

main:	save %sp, -96, %sp
	
        set BITPATTERN, %l0
        clr	%l1

ckpt1:	sll	%l0, 24, %l2	! checkpoint 1	
        add	%l2, %l1, %l1

ckpt2:	srl	%l0, 8, %l2     ! checkpoint 2
        sll	%l2, 24, %l2
        srl	%l2, 8, %l2
        add	%l2, %l1, %l1

ckpt3:	srl	%l0, 16, %l2	! checkpoint 3	
        sll	%l2, 24, %l2
        srl	%l2, 16, %l2
        add	%l2, %l1, %l1

ckpt4:	srl	%l0, 24, %l2	! checkpoint 4	
        add	%l2, %l1, %l1	
			
ckpt5:	ret                 ! checkpoint 5
        restore




