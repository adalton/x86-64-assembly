;
; ex.s
;
; Example of a function to return the maximum of two integers, page 114
;
; Note that I've changed this from what's in the book.  The book had the
; function print the value.  I'm having the function return the value, and
; I'll print it in main.  I'll do the book's version next.
;
	segment .rodata
maxStr	db	"The max of %ld and %ld is: %ld", 0x0a, 0

	segment .text
	extern printf
	global main
	global	findMax

main:
	push	rbp
	mov	rbp,	rsp

	mov	rdi,	-14
	mov	rsi,	-7
	call findMax

	lea	rdi,	[maxStr]
	mov	rsi,	-14
	mov	rdx,	-7
	mov	rcx,	rax
	xor	eax,	eax	; 0 floating point parameters
	call printf

	xor	eax,	eax	; return 0;
	leave
	ret

;
; Register usage:
;    rdi: a -- the first parameter
;    rsi: b -- the second parameter
;
findMax:			; long findMax(long a, long b)
	push	rbp
	mov	rbp,	rsp

	cmp	rdi,	rsi
	jl	.second
; .first:
	mov	rax,	rdi
	jmp	.done
.second
	mov	rax,	rsi
.done
	leave
	ret
