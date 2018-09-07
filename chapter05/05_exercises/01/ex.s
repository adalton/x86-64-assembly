;
; Exercise 1 (page 57)
;
; Write an assembly program to define 4 integers in the .data segment.  Give
; two of these integers positive values and 2 negative values.  Define one of
; your positive numbers using hexadecimal notation.  Write instruction to load
; the 4 integers into 4 different register and add them with the sum being
; left in a register.  Use gdb to single-step through your program and inspect
; each register as it is modified.
;
; Note that using 64-bit values for everything simplifies life here since
; everything is the same size.  I did that, in part, because of the "4
; different register" requirement.
;
	segment .data
a		dq	1
b		dq	0x42
c		dq	-1
d		dq	-0x42

	segment .text
	global main
main:
	mov	r8,	[a]
	mov	r9,	[b]
	mov	r10,	[c]
	mov	r11,	[d]

	mov	rax,	r8
	add	rax,	r9
	add	rax,	r10
	add	rax,	r11

	xor	eax,	eax
	ret
