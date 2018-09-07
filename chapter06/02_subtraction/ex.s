;
; ex.s
;
; Subtraction example, page 63
;
	segment .data
a		dq	100
b		dq	200
diff		dq	0

	segment .text
	global main
main:
	push	rbp			; establish a stack frame
	mov	rbp,	rsp
	sub	rsp,	16

	mov	rax,	10
	sub	[a],	rax		; subtract 10 from a
	sub	[b],	rax		; subtract 10 from b
	mov	rax,	[b]		; move b into rax
	sub	rax,	[a]		; set rax to b-a
	mov	[diff],	rax		; move the difference to diff

	; "xor rax, rax" is an alternative to "mov rax, 0" (i.e., setting
	; rax to 0).  The mov instruction is a 3-byte instruction while
	; the xor instruction is a 2-byte instruction; using the 2-byte
	; instruction saves memory space in the instruction cache.
	xor	eax,	eax		; was "mov rax, 0"
	leave
	ret
