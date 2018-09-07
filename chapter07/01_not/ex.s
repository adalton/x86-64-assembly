;
; ex.s
;
; Example for bit-wise not, page 75
;
	segment .text
	global main
main:
	mov	rax,	0
	not	rax			; rax = 0xffffffffffffffff

	mov	rdx,	0		; preparing for divide
	mov	rbx,	15		; will divide by 15 (0xf)
	div	rbx			; unsigned divide
					; rax = 0x1111111111111111
	not	rax			; rax = 0xeeeeeeeeeeeeeeee

	xor	eax,	eax
	ret				; return
