;
; ex.s
;
; Exercise 2, page 73
;
; If we could do floating point division, this exercise would have you compute
; the slope of the line segment connecting 2 points.  Insted you are to store
; the difference in x coordinates in 1 memory location and the difference in
; y coordinates in another.  The input points are integers stored in memory.
; Leave register rax with the value 1 if the line segment is vertical
; (infinite or undefined slope) and 0 if it is not. You should use a conditional
; move to set the value of rax.
;
; m = (y2 - y1) / (x2 - x1)
;
; With (5, 7) and (14, 8):
;     m = (8 - 7) / (14 - 5)
;       = 1 / 9
;       => not infinite/undefined slope, so rax should be 0
;
;	$ ./ex
;	$ echo $?
;	0
;	$
;
; With (5, 7) and (5, 7):
;     m = (5 - 5) / (7 - 7)
;       = 0 / 0
;       => infinite/undefined slope, rax should be 1
;	
;	$ ./ex
;	$ echo $?
;	1
;	$

	segment .data
x1	dq	5
y1	dq	7
x2	dq	5 ;14
y2	dq	7 ;8
num	dq	0
den	dq	0
one	dq	1

	segment .text
	global main
main:
	; rax = (y2 - y1)
	mov	rax,	[y2]
	sub	rax,	[y1]
	mov	[num],	rax
	xor	rax,	rax	; zero out rax

	; rbx = (x2 - x1)
	mov	rbx,	[x2]
	sub	rbx,	[x1]
	cmovz	rax,	[one]	; make rax 1 iff rbx is zero
	mov	[den],	rbx

	; let main return the 0/1
	; xor	eax,	eax	; return 0/1 from main, make it easy to test
	ret
