;
; ex.s
;
; Example for bit-wise exclusive or (xor), page 77
;
	segment .text
	global main
main:
	mov	rax,	0x1234567812345678
	xor	eax,	eax			; set to 0 (all of rax)
	mov	rax,	0x1234
	xor	rax,	0xf			; change to 0x123b

	xor	eax,	eax
	ret					; return
