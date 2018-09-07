;
; ex.s
;
; Example for bit-wise or, page 76
;
	segment .text
	global main
main:
	mov	rax,	0x1000
	or	rax,	0x0001		; make the number odd; rax = 0x10001
	or	rax,	0xff00		; set bits 15-8 to 1; rax = ff001

	xor	eax,	eax
	ret				; return
