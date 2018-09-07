;
; ex.s
;
; Exercise 1, page 73
;
; Write an assembly language program to compute the distance squared between
; 2 points in the plane identified as 2 integer coordinates, each stored in
; memory.  Remember the Pythagoran Theorem!
;
; d^2 = (x2 - x1)^2 + (y2 - y1)^2
;
; d^2 = (14 - 5)^2 + (8 - 7)^2
;     = 9^2 + 1^2
;     = 81  + 1
;     = 82
;
; (gdb) p dist
; $1 = 82

	segment .data
x1	dq	5
y1	dq	7
x2	dq	14
y2	dq	8
dist	dq	0

	segment .text
	global main
main:
	; rax = (x2 - x1)^2
	mov	rax,	[x2]
	sub	rax,	[x1]
	imul	rax,	rax

	; rbx = (y2 - y1)^2
	mov	rbx,	[y2]
	sub	rbx,	[y1]
	imul	rbx,	rbx

	add	rax,	rbx
	mov	[dist],	rax

	xor	eax,	eax	; return value from main
	ret
