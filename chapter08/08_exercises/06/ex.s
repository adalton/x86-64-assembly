;
; ex.s
;
; Exercise 6, page 106
;
; A Pythagorean triple is a set of three integers, a, b, and c, such that
; a^2 + b^2 = c^2.  Write an assembly program to determine if an integer, c,
; stored in memory has 2 smaller integers, a and b, making the 3 integers
; a Pythagorean triple. If so, then place a and b in memory.
;
	segment .rodata	; Experiment to make these constant
;c	dq	   2	; DNE
;c	dq	   5	; (a=3,  b=4,   c=5)
;c	dq	  13	; (a=5,  b=12,  c=13)
;c	dq	  61	; (a=11, b=60,  c=61)
;c	dq	 181	; (a=19, b=180, c=181)
;c	dq	 421	; (a=29, b=420, c=421)
;c	dq	1741	; (a=59, b=1740, c=1741)
;c	dq	1861	; (a=61, b=1860, c=1861)
;c	dq	2521	; (a=71, b=2520, c=2521)
c	dq	3121	; (a=79, b=3120, c=3121)

	segment .data
a	dq	0
b	dq	0

	segment .text
	global main
;
; C Program:
;
;     int c = 42;
;     int csquare = c * c;
;
;     int main(void) {
;         register int i;
;         for (i = 0; i < c; ++i) {
;             register int j;
;             for (j = i + 1; j < c; ++j) {
;                 if ((i * i + j * j) == csquare) {
;                     a = i;
;                     b = j;
;                     goto done;
;                 }
;             }
;         }
;     done:
;         return 0;
;     }
;
;
; Register usage:
;     rsi: i       -- loop control variable
;     rdi: j       -- loop control variable
;     rax: csquare -- the square of the variable c
;     rbx: tmp1    -- i^2, then the sum of i^2 and j^2
;     rcx: tmp2    -- j^2
;
main:
	mov	rax,	[c]			; csquare = c;
	imul	rax,	rax			; csquare *= csquare;

	mov	rsi,	1			; i = 1;
.begin_outer_for:
	mov	rdi,	rsi			; j = i;
	add	rdi,	1			; j += 1; /* j = i + 1 */
.begin_inner_for:
	mov	rbx,	rsi
	imul	rbx,	rbx			; tmp1 = i * i;

	mov	rcx,	rdi
	imul	rcx,	rcx			; tmp2 = j * j;

	add	rbx,	rcx			; tmp1 += tmp2
	cmp	rax,	rbx			; if (csquare != tmp1)
	jnz	.not_found			;     goto not_found;
;.found:
	mov	[a],	rsi			; a = i;
	mov	[b],	rdi			; b = j;
	jmp	.end_outer_for			; goto end
.not_found:
	inc	rdi				; ++j;
	cmp	rdi,	[c]
	jle	.begin_inner_for
.end_inner_for:
	inc	rsi				; ++i;
	cmp	rsi,	[c]
	jle	.begin_outer_for
.end_outer_for:

; (gdb) p c
; $1 = 3121
; (gdb) p a
; $2 = 79
; (gdb) p b
; $3 = 3120

	xor	eax,	eax			; rc = 0;
	ret					; return rc;
