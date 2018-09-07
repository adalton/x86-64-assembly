;
; ex.s
;
	segment .text
	global main

main:
	push	rbp		; save old base pointer
	mov	rbp,	rsp	; "top" of stack after saving old base pointer
				; is the new base

	call	a

	xor	eax,	eax	; return 0;
	leave
	ret

a:
	push	rbp
	mov	rbp,	rsp

	call	b

	xor	eax,	eax	; return 0;
	leave
	ret

b:
	push	rbp
	mov	rbp,	rsp

	xor	eax,	eax	; return 0;
	leave
	ret

