;
; ex.s
;
; Example for bit-wise and, page 76
;
	segment .text
	global main
main:
	mov	rax,	0x12345678
	mov	rbx,	rax
	and	rbx, 	0xf		; rbx has nibble 0x8

	mov	rdx,	0		; prepare to divide ...
	mov	rcx,	16		; ... by 16
	idiv	rcx			; rax has 0x1234567
	and	rax,	0xf		; rax has nibble 0x7

	xor	eax,	eax
	ret				; return
