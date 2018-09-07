;
; ex.s
;
; Division example, page 70
;
; The 'idiv' instruction is the inverse of the single-operand 'imul'
; instruction.  It uses rdx:rax for the 128-bit dividend.  The quotient is
; stored in rax and the remainder is stored in rdx.
;
; (gdb) p quot
; $1 = 20
; (gdb) p rem
; $2 = 5

	segment .data
x		dq	325	; dividend
y		dq	16	; divisor
quot		dq	0	; quotient
rem		dq	0	; remainder

	segment .text
	global main
main:
	mov	rax,	[x]	; move x into rax
	mov	rdx,	0	; rdx:rax is the dividend

	idiv	qword [y]	; Divide x by y
	mov	[quot],	rax	; Save the quotient
	mov	[rem],	rdx	; Save the remainder

	xor	eax,	eax	; return value
	ret
