;
; ex.s
;
; Exercise 4, Page 90
;
; Write an assembly program to move a quad-word stored in memory into a register
; and then compute the exclusive-or of the 8 bytes of the word.  Use either
; ror or rol to manipulate the bits of the register so that the original value
; is retained
;
	segment .data
a	dq	1000000001000000001000000001000000001000000001000000001000000001b

	segment .text
	global main
main:
	push	rbp
	mov	rbp,	rsp

	xor	ebx,	ebx		; ebx = 0
	mov	rax,	[a]		; rax = a

	xor	bl,	al		; byte 1
	ror	rax,	8
	xor	bl,	al		; byte 2
	ror	rax,	8
	xor	bl,	al		; byte 3
	ror	rax,	8
	xor	bl,	al		; byte 4
	ror	rax,	8
	xor	bl,	al		; byte 5
	ror	rax,	8
	xor	bl,	al		; byte 6
	ror	rax,	8
	xor	bl,	al		; byte 7
	ror	rax,	8
	xor	bl,	al		; byte 8
	ror	rax,	8

; ax = 11111111
; rax = a (original value of a)

	xor	eax,	eax		; return 0
	leave
	ret				; return
