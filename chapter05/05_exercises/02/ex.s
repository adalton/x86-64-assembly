;
; Exercise 2 (page 57)
;
; Write an assembly program to define 4 integers - one each of length 1, 2,
; 4, and 8 bytes.  Load the 4 integers into 4 registers using sign extension
; for the shorter values.  Add the values and store the sum in a memory
; location
;
	segment .data
; Note here the the initial values of these variables just happen to match
; the negation of the size of the variable.
a		db	-1	; 1 byte
b		dw	-2	; 2 bytes
c		dd	-4	; 4 bytes
d		dq	-8	; 8 bytes
sum		dq	0

	segment .text
	global main
main:
; movsx = MOVe-Sign-eXtend
; movsxd = MOVe-Sign-eXtend-Doubleword
	movsx	r8,	byte  [a]
	movsx	r9,	word  [b]
	movsxd	r10,	dword [c]
	mov	r11,	[d]	; Plain old move is sufficient for quad-word

	mov	rax,	r8
	add	rax,	r9
	add	rax,	r10
	add	rax,	r11

	mov	[sum],	rax

	xor	eax,	eax
	ret
