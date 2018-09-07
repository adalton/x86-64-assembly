;
; Section 5.5 - Movingb data from one register to another
;

	segment .data
a		dq	175
b		dq	4097
sum		dq	0
diff		dq	0

	segment .text
	global main
main:
	mov	rax,	[a]	; move a (175) into rax
	mov	rbx,	rax	; move rax to rbx
	add	rax,	[b]	; add b to rax
	mov	[sum],	rax	; save the sum
	sub	rbx,	[b]	; subtrace b from rax
	mov	[diff],	rbx	; save the difference

	xor	eax,	eax
	ret
