;
; ex.s
;
; Exercise 2, page 118
;
; Write an assembly program to generate an array of random integers (by calling
; the C library function 'random'), to sort the array using a bubble sort
; function, and to print the array.  The array should be stored in the '.bss'
; segment and does not need to by dynamically allocated.  The number of
; elements to fill, sort, and print should be stored in a memory locaiton.
; Write a function to loop through the array elements filling the array with
; random integers.  Write a function to print the array contents.  If the array
; size is less than or equal to 20, call your print function before and after
; sorting.
;
; Note that I tweaked the print function to take the max number of elements
; as a parameter so that I didn't have to repeat the logic to check for
; NUM_ELEMENTS > MAX_PRINT_SIZE.
;

NUM_ELEMENTS	equ	20	; Number of elements in the array
ELEMENT_SIZE	equ	 8	; Size of each element
MAX_PRINT_SIZE	equ	20	; Maximum number of elements to print

;==============================================================================
	segment .rodata
;==============================================================================
numElements		dq	NUM_ELEMENTS
printNumberFormat	db 	"%ld ", 0x0
printNewlineFormat	db	0xa, 0x0

;==============================================================================
	segment .bss
;==============================================================================
elements	resq	NUM_ELEMENTS	; array of elements


;==============================================================================
	segment .text
;==============================================================================
	extern random
	extern srandom
	extern printf

	global main
main:
	push	rbp
	mov	rbp,	rsp

	; Seed random number generator with a random number
	rdrand	rdi
	call srandom

	call fillArrayRandom

	mov	rdi,	MAX_PRINT_SIZE
	call printArray

	call bubbleSort

	mov	rdi,	MAX_PRINT_SIZE
	call printArray

	xor	eax,	eax
	leave
	ret

;
; void bubbleSort(void);
;
; Sort NUM_ELEMENTS in array at 'elements'
;
; Register usage:
;     rsi = array[i - 2]
;     rdi = array[i - 1]
;     r12 = i
;     r13 = anyElementsSwapped
;     r14 = numSwapsThisPass
;
bubbleSort:
	push	rbp
	mov	rbp,	rsp
	push	r12
	push	r13
	push	r14

.begin_pass_loop:
	xor	r14,	r14	; numSwapsThisPass = 0

	lea	rsi,	[elements - ELEMENT_SIZE]
	lea	rdi,	[elements]
	mov	r12,	1

.begin_swap_loop:
	inc	r12
	add	rsi,	ELEMENT_SIZE
	add	rdi,	ELEMENT_SIZE

	call swapIfLarger
	add	r14,	rax

	cmp	r12,	NUM_ELEMENTS
	jnz	.begin_swap_loop

	cmp	r14,	0
	jg	.begin_pass_loop
	
	xor	eax,	eax
	pop	r14
	pop	r13
	pop	r12
	leave
	ret

;
; long swapIfLarger(long* a, long* b)
;
; Returns 0 if no swap, 1 is swapped
;
; Register usage:
;     r12 - *a
;     r13 = *b
;
swapIfLarger:
	push	rbp
	mov	rbp,	rsp
	push	r12
	push	r13

	xor	eax,	eax

	mov	r12,	[rdi]	; r12 = *rdi;
	mov	r13,	[rsi]	; r13 = *rsi;

	cmp	r12,	r13
	jg	.done

	mov	qword [rdi],	r13	; *rdi = r13
	mov	qword [rsi],	r12	; *rsi = r12

	mov	rax,	1	; will return 1 to indicate swap was performed

.done
	pop r13
	pop r12
	leave
	ret

;
; void printArray(long maxSize);
;
; Print all elements in array 'elements'
;
; Preconditions: NUM_ELEMENTS > 0
;
; Register usage:
;     rbx = array[i]
;     r12 = i
printArray:
	push	rbp
	mov	rbp,	rsp
	push	rbx
	push	r12

	cmp	rdi,	NUM_ELEMENTS
	jl	.done

	lea	rbx,	[elements]	; rbx = array
	xor	r12,	r12		; i = 0;

.begin_loop:
	lea	rdi,	[printNumberFormat]
	mov	rsi,	[rbx]
	xor	eax,	eax
	call	printf

	add	rbx,	ELEMENT_SIZE
	inc	r12
	cmp	r12,	[numElements]
	jnz	.begin_loop

	lea	rdi,	[printNewlineFormat]
	xor	eax,	eax
	call	printf

.done:
	xor	eax,	eax
	pop	r12
	pop	rbx
	leave
	ret

;
; void fillArrayRandom(void);
;
; Fill array 'elements' with random numbers
;
; Preconditions: NUM_ELEMENTS > 0
;
; Register usage:
;     rbx = array[i]
;     r12 = i
;
fillArrayRandom:
	push	rbp
	mov	rbp,	rsp
	push	rbx
	push	r12

	lea	rbx,	[elements]	; rbx = array
	xor	r12,	r12		; i = 0;

.begin_loop:
	call	random
	mov	qword [rbx],	rax

	add	rbx,	ELEMENT_SIZE
	inc	r12
	cmp	r12,	[numElements]
	jnz	.begin_loop

	xor	eax,	eax
	pop	r12
	pop	rbx
	leave
	ret
