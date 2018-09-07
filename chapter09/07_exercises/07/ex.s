;
; ex.s
;
; Exercise 7, page 119
;
; Write an assembly program to read a string of left and right parentheses and
; determine whether the string contains a balanced set of parentheses.  You can
; read the string with 'scanf' using "%79s" into a character array of length
; 80.  A set of parentheses is balanced if it is the empty string or if it
; contains a left parenthesis followeb y a sequence of balanced sets and a
; right parenthesis.  Here's an example of a balanced set of parentheses:
; "((()())())"
;
; Sample runs;
;    $ ./ex
;    Enter a sequence of parentheses: ((()())())
;    The sequence '((()())())' is balanced
;
;    $ ./ex
;    Enter a sequence of parentheses: (((()())())
;    The sequence '(((()())())' is not balanced
;
;    $ ./ex
;    Enter a sequence of parentheses: ((()())()))
;    The sequence '((()())()))' is not balanced
;
BUFFER_LEN	equ	80
LEFT_PAREN	equ	0x28	; '('
RIGHT_PAREN	equ	0x29	; ')'
NL		equ	0x0a	; '\n'
NIL		equ	0x00	; '\0'

;==============================================================================
	segment .rodata
;==============================================================================
promptFormat	db	"Enter a sequence of parentheses: ", NIL
scanFormat	db	"%79s", 0 ; should be BUFFER_LEN - 1
resultFormat	db	"The sequence '%s' is %s", NL, NIL
balanced	db	"balanced", NIL
notBalanced	db	"not balanced", NIL

;==============================================================================
	segment .bss
;==============================================================================
buffer	resb	BUFFER_LEN

;==============================================================================
	segment .text
;==============================================================================
	extern printf
	extern scanf

	global main
main:
	push	rbp
	mov	rbp,	rsp

	;----------------------------------------------------------------------
	;-- Prompt for input
	;----------------------------------------------------------------------
	lea	rdi,	[promptFormat]
	xor	eax,	eax
	call	printf

	;----------------------------------------------------------------------
	;-- Read input
	;----------------------------------------------------------------------
	lea	rdi,	[scanFormat]
	lea	rsi,	[buffer]
	xor	eax,	eax
	call	scanf

	;----------------------------------------------------------------------
	;-- Determine if balanced
	;----------------------------------------------------------------------
	call isBalanced

	;----------------------------------------------------------------------
	;-- Print result
	;----------------------------------------------------------------------
	lea	rdi,	[resultFormat]
	lea	rsi,	[buffer]
	lea	rdx,	[balanced]
	lea	rcx,	[notBalanced]	; not a parameter, used with cmovz
	cmp	rax,	0
	cmovz	rdx,	rcx
	xor	eax,	eax
	call	printf

	xor	eax,	eax
	leave
	ret

;
; bool isBalanced(void);
;
; Determine if the parentheses sequence in 'buffer' is balanced.  Returns
; 1 if true, 0 if false.
;
; Register usage:
;     r12 - i
;     r13 - current
;     r14 - parenDepth
;     rax - balanced (0 = false, 1 = true)
;
isBalanced:
	push	rbp
	mov	rbp,	rsp
	push	r12
	push	r13
	push	r14

	mov	rax,	1		; Assume balanced until proven not
	mov	r12,	-1		; i = -1
	xor	r14,	r14		; parenDepth = 0

.begin_loop:
	inc	r12			; ++i;
	xor	r13,	r13
	mov	r13b,	[buffer + r12]	; current = buffer[i]
	cmp	r13,	NIL		; if (current == '\0')
	je	.end_loop		;     goto end_loop;
	cmp	r13,	RIGHT_PAREN	; if (current == ')')
	je	.right_paren		;     goto right_paren;
	inc	r14			; ++parenDepth; /* current == '(' */
	jmp	.begin_loop

.right_paren:
	dec	r14
	;cmp	r14,	0
	jl	.end_loop
	jmp	.begin_loop

.end_loop:
	; If the parentheses are balanced, r14 will be 0.  We've already
	; initialized rax to 1 above, so we can just goto end.  Otherwise
	; set rax to 0.
	cmp	r14,	0
	je	.end
	mov	rax,	0

.end:
	pop	r14
	pop	r13
	pop	r12
	leave
	ret
