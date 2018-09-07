;
; Exercise 3 (page 57)
;
; Write an assembly program to define 3 integers of 2 bytes each.  Name
; these a, b, and c.  Compute and save into 4 memory locations a+b, a-b,
; a+c, and a-c
;
; This is a re-implementation of my previous attempt to address the operand
; size problems that I encountered.
;
; The fundamental take-away seems to be that instructons don't know the
; size of variables (unless the instruction accepts a size prefix to
; one of the operands).  Since I'm dealing with words (2-byte entities),
; this solution uses the 2-byte register names.
;

	segment .data
a		dw	1	; 2 bytes
b		dw	2	; 2 bytes
c		dw	3	; 2 bytes
sum_ab		dw	0
diff_ab		dw	0
sum_ac		dw	0
diff_ac		dw	0

	segment .text
	global main
main:
	mov	ax,		[a]
	add	ax,		[b]
	mov	[sum_ab],	ax		; 3

	mov	ax,		[a]
	sub	ax,		[b]
	mov	[diff_ab],	ax		; -1

	mov	ax,		[a]
	add	ax,		[c]
	mov	[sum_ac],	ax		; 4

	mov	ax,		[a]
	sub	ax,		[c]
	mov	[diff_ac],	ax		; -2

	xor	eax,		eax
	ret
