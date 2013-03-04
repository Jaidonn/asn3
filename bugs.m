! Program with bug(s) for CS2208
! This program is intended to compute the sum of:
!  x sqaured (x^2) for x = 0, 1, ... 5
! It prints the value of x^2 for each x,
! and then prints the value of the sum of the terms.
! 
! Register Legend: %x_r     to hold variable x
!                  %sum_r  to hold sum
  
define(NEWLINE,10)              ! newline character
define(MIN,0)                   ! minimum value for x
define(MAX,5)                   ! maximum value for x

define(x_r, l0)                 ! to hold variable x
define(sum_r, l1)               ! to hold sum

	.global main
main:	
    save	%sp, -96, %sp
	mov     MIN, %x_r           ! initialize x to its min value
	clr     %sum_r              ! initialize sum to 0
loop:	
	mov     %x_r, %o0           ! (x) into input Register
	mov     %x_r, %o1           ! (x) into input Register
	call	.mul                ! multiply them
	nop
	call	writeInt            ! print individual term
	nop
	mov     NEWLINE,%o0
	call	writeChar
	nop
	add     %sum_r, %o0, %sum_r	! add term into sum
	inc     %x_r                ! increment x
    subcc   %x_r, MAX, %g0      ! compare x to its max value
    bl      loop                ! check if done
    nop

done:	
    mov     %sum_r, %o0         ! print sum
	call	writeInt
	nop
	mov     NEWLINE,%o0
	call	writeChar
	nop
	ret
	restore
