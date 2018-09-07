;
; ex.s
;
; Exercise 3, Page 90
;
; Write an assembly program to use 3 quad-words in memory to represent 3 sets:
; A, B, and C.  Each set will allow storing set values 0-63 in the
; corresponding bits of the quad-word. Perform these steps:
;
;	insert  0 into A
;	insert  1 into A
;	insert  7 into A
;	insert 13 into A
;
;	insert  1 into B
;	insert  3 into B
;	insert 12 into B
;
;	store (A union B) into C
;	store (A intersection B) into C
;	store (A symmetric-difference B) into C
;	remove  7 from C
;
	segment .data
A	dq	0
B	dq	0
C	dq	0

	segment .text
	global main
main:
	push	rbp
	mov	rbp,	rsp

	bts	qword [A],	0	; insert  0 into A
	bts	qword [A],	1	; insert  1 into A
	bts	qword [A],	7	; insert  7 into A
	bts	qword [A],	13	; insert 13 into A
	; A = 0000000000000000000000000000000000000000000000000010000010000011

	bts	qword [B],	1	; insert  1 into B
	bts	qword [B],	3	; insert  3 into B
	bts	qword [B],	12	; insert 12 into B
	; B = 0000000000000000000000000000000000000000000000000001000000001010

	mov	rax,		[A]	; Store (A union B) into C
	or	rax,		[B]
	mov	[C],		rax
	; C = 0000000000000000000000000000000000000000000000000011000010001011

	mov	rax,		[A]	; Store (A intersection B) into C
	and	rax,		[B]
	mov	[C],		rax
	; C = 0000000000000000000000000000000000000000000000000000000000000010
	
	mov	rax,		[A]	; Store (A symmetric-difference B) into C
	xor	rax,		[B]
	mov	[C],		rax
	; C = 0000000000000000000000000000000000000000000000000011000010001001

	btr	qword [C],	7	; Remove 7 from C
	; C = 0000000000000000000000000000000000000000000000000011000000001001

	xor	eax,		eax	; return 0
	leave
	ret				; return
