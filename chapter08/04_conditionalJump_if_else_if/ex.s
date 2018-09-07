;
; ex.s
;
; Example for conditional jump -- if/else, page 95
;
	segment .data
a	dq	42
b	dq	17
c	dq	60
res	dq	0

	segment .text
	global main
main:
	; Suppose that we are implementing the following C code:
	;     if (a < b) {
        ;         res = 1;
	;     } else if (a > c) {
        ;         res = 2;
	;     } else {
        ;         res = 3;
	;     }

	mov	rax,	[a]		; if (a < b) {
	mov	rbx,	[b]
	cmp	rax,	rbx
	jge	.else_if
	mov	qword [res],	1	;     res = 1;
	jmp	.endif
.else_if:				; }
	mov	rcx,	[c]		; else if (a > c) {
	cmp	rax,	rcx
	jng	.else
	mov	qword [res], 2		;     res = 2;
	jmp	.endif
.else					; } else {
	mov	qword [res], 3		;     res = 3;
.endif:					; }

	xor	eax,	eax
	ret				; return
