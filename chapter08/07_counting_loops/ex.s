;
; ex.s
;
; Example for conditional jump -- counting (for) loop, page 100
;
; for (i = 0; i < n; ++i) {
;     c[i] = a[i] + b[i];
; }
;
; It is possible to do a test on rxd being 0 before executing the loop.
; This could allow the compare and conditional jump statements to be placed
; at the end of the loop. However, it might be easier to simply translate C
; statements without worrying about optimizations until you improve your
; assembly skills.
;
	segment .data
n	dq	5
;a	dq	1, 2, 3,  4,  5
;b	dq	7, 8, 9, 10, 11

a	times 5 dq 0
b	times 5 dq 0
c	times 5 dq 0

	segment .text
	global main
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 16

	; Hum.. I couldn't figure out how to correctly define and initialize
	; the array above, so I'll do it here manually.
	mov	rax, 1
	mov	[a + 0 * 8], rax
	inc	rax
	mov	[a + 1 * 8], rax
	inc	rax
	mov	[a + 2 * 8], rax
	inc	rax
	mov	[a + 3 * 8], rax
	inc	rax
	mov	[a + 4 * 8], rax

	mov	rax, 7
	mov	[b + 0 * 8], rax
	inc	rax
	mov	[b + 1 * 8], rax
	inc	rax
	mov	[b + 2 * 8], rax
	inc	rax
	mov	[b + 3 * 8], rax
	inc	rax
	mov	[b + 4 * 8], rax

	mov	rdx, [n]
	xor	ecx, ecx		; for (i = 0;
.for:	cmp	rcx, rdx		;      i < n;
	je	.end_for
	mov	rax, [a + rcx * 8]	;	   /*   a[i] */
	add	rax, [b + rcx * 8]	;	   /* + b[i] */
	mov	[c + rcx * 8], rax	;          c[i] = a[i] + b[i]
	inc	rcx			;      ++i)
	jmp	.for			; }
.end_for

; (gdb) x/5g &a
; 0x601030:       1       2
; 0x601040:       3       4
; 0x601050:       5
; (gdb) x/5g &b
; 0x601058:       7       8
; 0x601068:       9       10
; 0x601078:       11
; (gdb) x/5g &c
; 0x601080:       8       10
; 0x601090:       12      14
; 0x6010a0:       16

	xor	eax,	eax
	leave
	ret
