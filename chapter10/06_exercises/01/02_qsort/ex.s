;
; ex.s
;
; Exercise 1 (part 2), page 131
;
; Write 2 test programs: ...and a second program to sort an array of random
; 4-byte ; integers using the `qsort` function from the C library. Your program
; should ; use the C library function `atol` to convert a number supplied on
; the ; command line from ASCII to long. This number is the size of the array
; (number of 4-byte integers). Then your program can allocate the array
; using `malloc` and fill the array using `random`. You call qsort like
; this:
;
;      qsort(array, n, 4, compare );
;
; The second parameter is the number of array elements to sort and the third
; is the size in bytes of each element.  The fourth paramter is the
; address of a comparison function. Your comparison function will accept two
; parameters.  Each will return a pointer to a 4-byte integer. The comparison
; function should return a negative, 0, or positive value based on the ordering
; of the 2 integers.  All you have to do is subtract the second integer from
; the first.
;
	segment .data
format		db		"%s", 0x0a, 0

	segment .text
	global main

	extern atol
	extern free
	extern malloc
	extern printf
	extern qsort
	extern random
main:
.array	equ		0
.size	equ		8
	push		rbp
	mov		rbp,			rsp
	sub		rsp,			16

	mov		rcx,			rsi
	mov		rdi,			[rcx + 8]	; Skip the command name
	call		atol

;       The desired array size is now in rax, save a copy on the stack
	mov		[rsp + .size],		rax
	
	mov		rdi,			rax
	call		create

;       The pointer to the array is now in rax, save a copy on the stack
	mov		[rsp + .array],		rax


	mov		rdi,			[rsp + .array]
	mov		rsi,			[rsp + .size]
	call		fill
;       The array is now full of random numbers

;       qsort(array, n, 4, compare );
	mov		rdi,			[rsp + .array]
	mov		rsi,			[rsp + .size]
	mov		rdx,			4
	mov		rcx,			compare
	call		qsort

;	Print the result
	mov		rdi,			[rsp + .array]
	mov		rsi,			[rsp + .size]
	call		print

;	Release the dynamically allocated memory
	mov		rdi,			[rsp + .array]
	call		free

	xor		eax,			eax
	leave
	ret

;
; int compare(int* v1, int* v2);
;
compare:
.first	equ		0
.second	equ		8
	push		rbp
	mov		rbp,			rsp
	sub		rsp,			16

	mov		[rsp + .first],		rdi
	mov		[rsp + .second],	rsi
	mov		rax,			[rsp + .first]
	mov		rdx,			[rax]
	mov		rax,			[rsp + .second]
	mov		rax,			[rax]
	sub		rdx,			rax

	mov		rax,			rdx
	leave
	ret

;
; int* create(int size)
;
; Creates a dynamically allocated array of quad words of the given size.
;
create:
.ELEMENT_SIZE		equ	 		4		; Size of each array element
	push		rbp
	mov		rbp,			rsp
	imul		rdi,			.ELEMENT_SIZE
	call		malloc
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
	push		rbp
	mov		rbp,			rsp
	sub		rsp,			32

	mov		[rsp + .array],		rdi
	mov		[rsp + .size],		rsi
	xor		ecx,			ecx
.more	mov		[rsp + .i],		rcx
	call		random
	mov		ecx,			[rsp + .i]
	mov		rdi,			[rsp + .array]
	mov		[rdi + rcx * 4],	eax
	inc		rcx
	cmp		rcx,			[rsp + .size]
	jl		.more
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

	push		rbp
	mov		rbp,			rsp
	sub		rsp,			32
	mov		[rsp + .array],		rdi
	mov		[rsp + .size],		rsi
	xor		ecx,			ecx
	mov		[rsp + .i],		rcx

	segment	.data
.format:
	db	"%10d", 0x0a, 0
	segment	.text

.more	lea		rdi,			[.format]
	mov		rdx,			[rsp + .array]
	mov		rcx,			[rsp + .i]
	mov		esi,			[rdx + rcx * 4]
	mov		[rsp + .i],		rcx
	call		printf
	mov		rcx,			[rsp + .i]
	inc		rcx
	mov		[rsp + .i],		rcx
	cmp		rcx,			[rsp + .size]
	jl		.more
	leave
	ret
