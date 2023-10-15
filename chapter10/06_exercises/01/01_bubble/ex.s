;
; ex.s
;
; Exercise 1 (part 1), page 131
;
; Write 2 test programs: one to sort an array of random 4-byte integers
; using bubble sort... Your program should use the C library function
; `atol` to convert a number supplied on the command line from ASCII to
; long. This number is the size of the array (number of 4-byte integers).
; Then your program can allocate the array using `malloc` and fill the array
; using `random`.
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

	; The desired array size is now in rax, save a copy on the stack
	mov		[rsp + .size],		rax

	mov		rdi,			rax
	call		create

	; The pointer to the array is now in rax, save a copy on the stack
	mov		[rsp + .array],		rax


	mov		rdi,			[rsp + .array]
	mov		rsi,			[rsp + .size]
	call		fill
	; The array is now full of random numbers

	mov		rdi,			[rsp + .array]
	mov		rsi,			[rsp + .size]
	call		bubbleSort

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

; void bubbleSort(int* array, const int size)
; {
;     bool swapped = false;
;     int i;
;
;     do {
;         swapped = false;
;
;         for (i = 0; i < (size - 1); ++i) {
;             if (array[i] > array[i + 1]) {
;                 array[i] = array[i] ^ array[i + 1];
;                 array[i + 1] = array[i] ^ array[i + 1];
;                 array[i] = array[i] ^ array[i + 1];
;                 swapped = true;
;             }
;         }
;     } while (swapped);
; }

bubbleSort:
.ELEMENT_SIZE		equ	 		4		; Size of each array element
.array			equ			0
.size			equ			.array   + 8
.swapped		equ			.size    + 8
.i			equ			.swapped + 8

	push		rbp
	mov		rbp,			rsp
	sub		rsp,			32

	; Subtract 1 from rsi (size) since we reference only (size - 1)
	sub		rsi,			1

	; Save a copy of the parameters on the stack
	mov		[rsp + .array],		rdi
	mov		[rsp + .size],		rsi

.begin_do:
 	mov		rsi,			0
 	mov		[rsp + .swapped],	rsi		; swapped = false
 	mov		[rsp + .i],		rsi		; i = 0

.for_test:
 	cmp		rsi,			[rsp + .size]	; i < size
 	jge		.end_for

; .begin_if:
    	mov		rdi,			[rsp + .array]
    	mov		edx,			[rdi + rsi * .ELEMENT_SIZE]
    	inc		rsi
    	mov		ecx,			[rdi + rsi * .ELEMENT_SIZE]
    	cmp		edx,			ecx
    	jle		.end_if

	xor		edx,			ecx
	xor		ecx,			edx
	xor		edx,			ecx

	mov		[rdi + rsi * .ELEMENT_SIZE],	ecx
	dec		rsi
	mov		[rdi + rsi * .ELEMENT_SIZE],	edx

	mov		rsi,			1
	mov		[rsp + .swapped],	rsi		; swapped = true
.end_if:
	mov		rsi,			[rsp + .i]
 	inc		rsi
 	mov		[rsp + .i],		rsi		; i++
 	jmp		.for_test

.end_for:
;     } while (swapped);
	mov		rsi,			[rsp + .swapped]
	cmp		rsi,			0
	jne		.begin_do

	leave
	ret
