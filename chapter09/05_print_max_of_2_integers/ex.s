;
; ex.s
;
; Example of a function to print the maximum of two integers, pages 114-115
;
	segment .text
	extern printf
	global main
	global print_max

main:
	push	rbp
	mov	rbp,	rsp

	; print_max(100, 200);
	mov	rdi,	100	; first parameter
	mov	rsi,	200	; second parameter
	call print_max

	xor	eax,	eax	; return 0;
	leave
	ret
				; void print_max(long a, long b)
print_max:			; {
	push	rbp		;     /* normal stack frame setup */
	mov	rbp,	rsp

	a	equ	0	;     /* offset from rsp for saving rdi (a) */
	b	equ	8	;     /* offset from rsp for saving rsi (b) */
	max	equ	16	;     int max;

	sub	rsp,	32	;     /* Space for a, b, and max, rounded up */
				;     /* to a multiple of 16 */

	mov	[rsp + a], rdi	;     /* Save rdi (a) on stack */
	mov	[rsp + b], rsi	;     /* Save rsi (b) on stack */

	mov	[rsp + max], rdi;     max = a;

	cmp	rsi, rdi	;     if (b > a) { max  = b; }
	jng	.skip
	mov	[rsp + max], rsi;
.skip:
	segment .rodata		; Can mix segments to put this close to use
fmt	db	"max(%ld, %ld) = %ld", 0x0a, 0
	segment .text
	lea	rdi,	[fmt]
	mov	rsi,	[rsp + a]
	mov	rdx,	[rsp + b]
	mov	rcx,	[rsp + max]
	xor	eax,	eax	;     /* 0 floating point parameters */
	call	printf

	leave
	ret			; }
