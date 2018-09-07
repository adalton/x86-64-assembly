;
; ex.s
;
; Exercise 3, page 105
;
; Write an assembly program to sort an array of double words using bubble
; sort.  Bubble sort is defined as:
;
;   do {
;       swapped = false;
;       for (i = 0; i < (n - 1); ++i) {
;           if (a[i] > a[i + 1]) {
;               swap a[i] and a[i + 1]
;               swapped = true;
;           }
;       }
;   } while (swapped);
;
	segment .data
;a	dd	5, 4, 3, 2, 1
;N	db	5				; elements in a[] (>= 1)

;a	dd	1, 3, 5, 7, 9, 10, 8, 6, 4, 2
;N	db	10				; elements in a[] (>= 1)

a	dd	11, 42, 62, 32, 51, 91, -93, 16, 53, 58, 15, 70, 13, 19, 25, 52
N	db	16				; elements in a[] (>= 1)

	segment .text
	global main
;
; Register usage:
;     eax: a[i]     -- The ith value in a
;     edx: a[i + 1] -- The (i + 1)th value in a
;     rbx: swapped  -- 0 = false, 1 = true
;     rcx: i        -- loop control
;     r8:  N        -- number of elements in a
;     r9:  ONE      -- the constant 1
;
main:
	movzx	r8,	byte [N]
	sub	r8,	1			; r8 = N - 1
	mov	r9,	1			; r9 = 1

.begin_do:					; do {
	xor	ebx,	ebx			;     swapped = false
	xor	ecx,	ecx			;     i = 0

.begin_for:					;     for (...) {
	mov	eax,	[a + rcx * 4]		;         tmp = a[i]
	mov	edx,	[a + (rcx + 1) * 4]	;         tmp2 = a[i + 1]

	cmp	eax,	edx			;         if (tmp > tmp2) {
	jle	.end_if

	mov	[a + rcx * 4], edx		;             a[i] = tmp2
	mov	[a + (rcx + 1) * 4], eax	;             a[i + 1] = tmp
	mov	rbx, r9				;             swapped = true
.end_if						;         }

	inc	rcx				;         ++i
	cmp	rcx,	r8
	jnz	.begin_for			;         Keep looping

.end_for:					;     }
	cmp	r9, 	rbx
	jng	.begin_do			; } while (swapped);
.end_do:

; (gdb) x/16d &a
; 0x601028:       -93     11      13      15
; 0x601038:       16      19      25      32
; 0x601048:       42      51      52      53
; 0x601058:       58      62      70      91

	xor	eax,	eax			; rc = 0
	ret					; return rc
