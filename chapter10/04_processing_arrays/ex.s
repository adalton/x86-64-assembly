;
; Section 10.4 - Processing arrays
;
	segment .bss
pointer		resq		1

	segment .text

	extern atoi
	extern free
	extern malloc
	extern printf
	extern random

	global main
main:
.array	equ	0
.size	equ	8

	push	rbp
	mov	rbp,			rsp
	sub	rsp,			16

	mov	ecx,			10		; Set default size
	mov	[rsp + .size],		rcx

;	Check for argv[1] providing a size
	cmp	edi,			2
	jl	.nosize
	mov	rdi,			[rsi + 8]
	call	atoi
	mov	[rsp + .size],		rax

.nosize:
;	Create the array
	mov	rdi,			[rsp + .size]
	call	create
	mov	[rsp + .array],		rax

;	Fill the array with random numbers
	mov	rdi,			rax
	mov	rsi,			[rsp + .size]
	call	fill

;	If size < 20, print the array
	mov	rsi,			[rsp + .size]
	cmp	rsi,			20
	jg	.toobig
	mov	rdi,			[rsp + .array]
	call	print

.toobig:
;	Print the minimum
	segment .data
.format:
	db	"min: %ld", 0xa, 0
	segment .text

	mov	rdi,			[rsp + .array]
	mov	rsi,			[rsp + .size]
	call	min
	lea	rdi,			[.format]
	mov	rsi,			rax
	call	printf

;	Free the dynamically allocated memory
	mov	rdi,			[pointer]
	call	free

	leave
	ret

;
; int* create(size)
;
; Creates a dynamically allocated array of quad words of the given size.
;
create:
	push	rbp
	mov	rbp,			rsp
	imul	rdi,			4
	call	malloc
	leave
	ret

;
; void fill(array, size)
;
; Fills the given array of quad words of the given size with random values.
;
fill:
.array	equ	 0
.size	equ	 8
.i	equ	16

	push	rbp
	mov	rbp,			rsp
	sub	rsp,			32
	mov	[rsp + .array],		rdi
	mov	[rsp + .size],		rsi
	xor	ecx,			ecx
.more	mov	[rsp + .i],		rcx
	call	random
	mov	ecx,			[rsp + .i]
	mov	rdi,			[rsp + .array]
	mov	[rdi + rcx * 4],	eax
	inc	rcx
	cmp	rcx,			[rsp + .size]
	jl	.more
	leave
	ret

;
; void print(array, size)
;
; Prints the contents of the given array of the given size to standard output.
;
print:
.array	equ	 0
.size	equ	 8
.i	equ	16

	push	rbp
	mov	rbp,			rsp
	sub	rsp,			32
	mov	[rsp + .array],		rdi
	mov	[rsp + .size],		rsi
	xor	ecx,			ecx
	mov	[rsp + .i],		rcx

	segment	.data
.format:
	db	"%10d", 0x0a, 0
	segment	.text

.more	lea	rdi,			[.format]
	mov	rdx,			[rsp + .array]
	mov	rcx,			[rsp + .i]
	mov	esi,			[rdx + rcx * 4]
	mov	[rsp + .i],		rcx
	call	printf
	mov	rcx,			[rsp + .i]
	inc	rcx
	mov	[rsp + .i],		rcx
	cmp	rcx,			[rsp + .size]
	jl	.more
	leave
	ret

;
; int min(array, size)
;
; Finds and returns the minimum value in the given array of the given size.
; This is a leaf function, so we don't set up a stack frame.  A conditional
; move instruction is used to avoid interrupting the instruction pipeline.
;
min:
	mov	eax,			[rdi]
	mov	rcx,			1
.more	mov	r8d,			[rdi + rcx * 4]
	cmp	r8d,			eax
	cmovl	eax,			r8d
	inc	rcx
	cmp	rcx,			rsi
	jl	.more
	ret
