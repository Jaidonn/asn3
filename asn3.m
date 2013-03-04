!**************************************************************
! Jaidonn Freeland
! Assignment #3
! File: asn3.m
!
! Description:
!  	This file contain a program which takes an 9 digit number
!	and runs it through Luhn's algorithm. It doubling even digits 
!	by twoand if the doubled value is larger than 9, the composing  
!	digit(10's and 1's column) are added togehter. This digit is then 
!	added to a sum which is composed of the 9 digits. If there is a 
!	remainder when diving the sum by 10, it is evluated as invalid and 
!	a 'I' is outputed to the screen. If there is no remainder a 'V' is 
!	ouputed to the screen.
!
! Register Legend:
! counter_r	imput counter			%l0
! imput_r	user imput			%l1
! storage_r	storage value			%l2
! firsthalf_r	stores half of the sum		%l3
! secondhalf_r	stores half of the sum		%l4
! sum_r		total of imputed values		%l7
!
!**************************************************************	

define (NEWLINE,10)
define (VALID, 86)
define (INVALID, 73)	
define (counter_r,%l0)
define (imput_r,%l1)
define (storage_r,%l2)
define (firsthalf_r,%l3)
defome (secondhalf_r,%l4)
define (sum_r,%l7)

		.global main
main:	save %sp, -96, %sp			!Create a location to save
		clr counter_r			!Set counter to 0
		clr sum_r			!Set sum to 0

!***************************************************************
!
!***************************************************************		
loop:	
		call getchar				!get imput value
		nop
		mov %o0,imput_r				!store value in imput_r
		
		mov imput_r, storage_r			!move imput value to another register
		mov 2, %o0				!checking if imputed value is
		call .rem				!divisable by 2. If so
		bne double				!exits loop to go to doubleloop (if rem !=0)
		be	sum				!exits loop to go to sum (if rem equal to 0)
		
		inccc counter_r				!increment unsure_r
		subcc counter_r,NEWLINE,%g0		!compare unsure_r to 10. If unsure_r is
		ble loop				!less than 10 retrun to loop
		nop
		
		ba print
		
double:	
		sll imput_r, 2, storage_r		!multiply the inputed value by two and storing it in a new register
		subcc storage_r, 10, %g0		!set condition code (if imputed value >10)
		bge	splitandadd			!exits double to go to splitandadd (greater than 10)
		ble sum					!exits double to go to sum (less than 10)
	
splitandadd:
		mov storage_r, firsthalf_r		!move first character into firsthalf_r
		call getchar				!get first character
		nop
		mov storage_r, secondhalf_r		!move second character into secondhalf_r
		call get char				!get second character
		nop
		
		add firsthalf_r,secondhalf_r,storage_r	!Add the two parts together
		ba sum					!Exit splitandadd to go to sum
sum:
		add sum_r, storage_r, sum_r		!add the stored value and sum. Storing as sum
		ba loop					!Branch to loop

print:
		if sum mod 10 = 0 print "V"
		else print "I"
		mov sum_r, %o0				!moves the sum to an output register 
		mov 10, %o1				!checks is the sum is divisable by 10
		call .rem
		bne invalid				!exits print to go to invalid(rem !=0)
		be valid				!exits print to go to valid(rem is equal 0)

valid:		
		mov VALID, %o0				!move 'V' to an output register
		call writeChar				!Print 'V' to the screen
		nop
		
		mov NEWLINE, %o1			!Move newline to output register
		call writeChar				!Print a newline for formatting
		nop

		ret					!Exit
		restore
		
invalid:
		mov INVALID, %o0			!Move 'I' to the output register
		call writeChar				!Print 'I' to the screen
		nop
		
		mov NEWLINE, %o1			!Move newline to output register
		call writeChar				!Print a newline for formatting
		nop

		ret					!Exit
		restore
				
