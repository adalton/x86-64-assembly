;
; ex.s
;
; Exercise 1, page 105
;
; Write an assembly program to compute the dot product of 2 arrays.  Your
; arrays should be double word arrays in memory and the dot product should
; be stored in memory.
;
	segment .data

N	db	5
array1	dd	2, 4, 6, 8, 10
array2	dd	3, 6, 9, 12, 15
dp	dd	0

; dp = (2 * 3) + (4 * 6) + (6 * 9) + (8 * 12) + (10 * 15)
;    = 6 + 24 + 54 + 96 + 150
;    = 330

	segment .text
	global main
;
; Register usage:
;   eax: N    -- the number of elements in the array
;   ecx: i    -- loop control variable
;   edx: prod -- The product of array1[i] and array2[i]
;
main:
	movzx	eax,	byte [N]		; eax = N
	xor	ecx,	ecx			; i = 0

	; Pre-check to skip loop all together if N == 0
	cmp	eax,	ecx
	jz	.end_loop			; if N is zero, bail out

.begin_loop
	mov	edx,	[array1 + ecx * 4]	; prod = array1[i]
	imul	edx,	[array2 + ecx * 4]	; prod = prod * array2[i]
	add	[dp],	edx			; dp += prod
	inc	rcx				; ++i
	cmp	eax,	ecx
	jnz	.begin_loop			; Keep looping
.end_loop:

; (gdb) p dp
; $1 = 330

	xor	eax,	eax			; rc = 0
	ret					; return rc
