;
; ex.s
;
; Exercise 3, page 73
;
; Write an assembly language program to compute the average of 4 grades.  Use
; memory locations for the 4 grades.  Make the grades all different numbers
; from 0 to 100.  Store the average of the 4 grades in memory and also store
; the remainder from the division in memory.
;
; (100 + 87 + 96 + 76) / 4
;                  355 / 4
;                          = 88 r 3
;
; 	(gdb) p avg
; 	$1 = 88
; 	(gdb) p rem
; 	$2 = 3
;

	segment .data
; I'd like to make the grades an array, but I don't yet know how to correctly
; use arrays.  For now, we'll make it 4 individual variables
g1	dq	100
g2	dq	87
g3	dq	92
g4	dq	76
avg	dq	0
rem	dq	0

	segment .text
	global main
main:
	mov	rax,	[g1]
	add	rax,	[g2]
	add	rax,	[g3]
	add	rax,	[g4]

	xor	rdx,	rdx
	mov	rbx,	4
	idiv	rbx		; Could also do: idiv qword [four]

	; quotient is in rax, remainder is in rdx
	mov	[avg],	rax
	mov	[rem],	rdx

	xor	eax,	eax	; return 0/1 from main, make it easy to test
	ret
