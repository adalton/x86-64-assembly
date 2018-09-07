;
; ex.s
;
; Exercise 6, page 119
;
; Write an assembly program to read two 8 byte integers with 'scanf' and
; compute their greatest common divisor using Euclid's algorithm, which is
; based on the recursive definition:
;
;     gcd(a, b) = a                  if b == 0
;               = gcd(b, a mod b)    otherwise
;
; Sample Output:
;     Enter a: 11571
;     Enter b: 1767
;     gcd(11571, 1767) = 57
;
a	equ	0x61	; 'a'
b	equ	0x62	; 'b'

;==============================================================================
	segment .rodata
;==============================================================================
prompt			db	"Enter %c: ", 0
scanNumber		db	"%ld", 0
result			db	"gcd(%ld, %ld) = %ld", 0xa, 0

;==============================================================================
	segment .text
;==============================================================================
	extern printf
	extern scanf

	global main
main:
.a_stack	equ	0	; a's offset from the stack pointer
.b_stack	equ	8	; b's offset from the stack pointer

	push	rbp
	mov	rbp,	rsp
	sub	rsp,	16	; Allocate room on the stack for a and b

	;----------------------------------------------------------------------
	;-- Prompt for a
	;----------------------------------------------------------------------
	lea	rdi,	[prompt]
	mov	rsi,	a
	xor	eax,	eax
	call	printf

	;----------------------------------------------------------------------
	;-- Read a
	;----------------------------------------------------------------------
	lea	rdi,	[scanNumber]
	lea	rsi,	qword [rsp + .a_stack]
	xor	eax,	eax
	call	scanf

	;----------------------------------------------------------------------
	;-- Prompt for b
	;----------------------------------------------------------------------
	lea	rdi,	[prompt]
	mov	rsi,	b
	xor	eax,	eax
	call	printf

	;----------------------------------------------------------------------
	;-- Read b
	;----------------------------------------------------------------------
	lea	rdi,	[scanNumber]
	lea	rsi,	qword [rsp + .b_stack]
	xor	eax,	eax
	call	scanf

	;----------------------------------------------------------------------
	;-- call gcd(a, b)
	;----------------------------------------------------------------------
	mov	rdi,	qword [rsp + .a_stack]
	mov	rsi,	qword [rsp + .b_stack]
	call	gcd

	;----------------------------------------------------------------------
	;-- Print result
	;----------------------------------------------------------------------
	lea	rdi,	[result]
	mov	rsi,	qword [rsp + .a_stack]
	mov	rdx,	qword [rsp + .b_stack]
	mov	rcx,	rax
	xor	eax,	eax
	call	printf

	xor	eax,	eax
	leave
	ret

;
; long gcd(long a, long b);
;
; Returns the greatest common divisior of a an b using Euclid's algorithm.
;
gcd:
.a_stack	equ	8
.b_stack	equ	0
	push	rbp
	mov	rbp,	rsp
	push	rdi
	push	rsi

	cmp	rsi,	0	; if (b == 0)
	je	.answer_a	;     goto answer_a;

	; For idiv, rdx:rax is the dividend, after operation rax contains
	; quotient and rdx contains remainder
	mov	rdi,	qword [rsp + .b_stack] ; 1st parm to recusive call is b

	mov	rdx,	0
	mov	rax,	qword [rsp + .a_stack]
	idiv	rdi				; a / b

	mov	rsi,	rdx			; 2nd parm is remainder

	call	gcd
	jmp	.done

.answer_a:
	mov	rax,	rdi

.done:
	leave
	ret
