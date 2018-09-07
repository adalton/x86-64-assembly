;
; ex.s
;
; Example of a recursive function to compute n!, page
;
; Factorial can be defined recursively:
;     fact(n) = { 1               if n <= 1
;               { n * f(n - 1)    if n > 1
;
; Sample runs:
;
; $ ./ex
; 0
; fact(0) = 1
;
; $ ./ex
; 1
; fact(1) = 1
;
; $ ./ex
; 2
; fact(2) = 2
;
; $ ./ex
; 3
; fact(3) = 6
;
; $ ./ex
; 4
; fact(4) = 24
;
; $ ./ex
; 5
; fact(5) = 120
;

	segment .data
x		dq	0

	segment .rodata
scanf_format	db	"%ld", 0
printf_format	db	"fact(%ld) = %ld", 0x0a, 0

	segment .text
	extern printf
	extern scanf

	global main
	global fact
main:
	push	rbp
	mov	rbp,	rsp

	lea	rdi,	[scanf_format]		; set arg 1 for scanf
	lea	rsi,	[x]			; set arg 2 for scanf
	xor	eax,	eax			; no floating point args
	call	scanf				; Read number into x

	mov	rdi,	[x]			; set arg 1
	call	fact
	; return value is in rax

	lea	rdi,	[printf_format]		; set arg 1 for printf
	mov	rsi,	[x]			; set arg 2 for printf
	mov	rdx,	rax			; set arg 3 for printf
	xor	eax,	eax			; no floating point args
	call	printf
	
	xor	eax,	eax
	leave
	ret
fact:
	push	rbp
	mov	rbp,	rsp

n	equ	8
	sub	rsp,	16			; make room for n on stack
						; (multiple of 16 bits)

	cmp	rdi,	1			; base case
	jg	.greater
	mov	rax,	1			; return 1
	jmp	.done

.greater:
	mov	[rsp + n], rdi			; save n on the stack

	dec	rdi				; recursively call fact with n-1
	call	fact

	mov	rdi,	[rsp + n]		; restore original n
	imul	rax,	rdi			; multiply fact(n-1) by n
.done:
	leave
	ret
