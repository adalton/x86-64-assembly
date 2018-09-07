;
; ex.s
;
; Example for conditional jump -- if/else, page 94
;
	segment .data
a	dq	42
b	dq	17
max	dq	0

	segment .text
	global main
main:
	; Suppose that we are implementing the following C code:
	;     if (a < b) {
	;         max = b;
	;     } else {
        ;         max = a;
	;     }

	mov	rax,	[a]		; if (a < b) {
	mov	rbx,	[b]
	cmp	rax,	rbx
	jnl	.else
	mov	qword [max],	rbx	;    max = b;
	jmp	.endif
.else                                   ; } else {
	mov	qword [max],	rax     ;    max = a;
.endif                                  ; }

	xor	eax,	eax
	ret				; return
