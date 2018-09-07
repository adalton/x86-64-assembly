;
; ex.s
;
; Multiplication example, page 65
;
; Multiplication of unsigned integers is performed using the 'mul' instruction.
; Multiplication of signed integers is performed using the 'imul' instruction.
;
; The 'imul' instruction, unlike 'add' and 'sub', has 3 different forms:
;  - 1 operand  -- the source
;  - 2 operands -- source and destination
;  - 3 operands -- destination and 2 source
;
; The 1 operand version of 'imul' multiplies the value in rax by the source
; operand and stores the result in rdx:rax.  The low-order bits of the answer
; are in rax and the high-order bits are in rdx.
;
; Multiplying by 256 is like left-shifting 8 bits, so the high-order byte ends
; ends up in rdx and the low-order 8 bits of rax are 0
;
; 	(gdb) p/x $rdx
; 	$3 = 0x7f
; 	(gdb) p/x $rax
; 	$4 = 0xffffffffffffff00

	segment .data
a		dq	100
b		dq	200
diff		dq	0

	segment .text
	global main
main:
	push	rbp			; establish a stack frame
	mov	rbp,	rsp

	mov	rax,	0x7fffffffffffffff
	mov	rbx,	256
	imul	rbx

	xor	eax,	eax
	leave
	ret

; The two-operand 'imul' is like add, sub:
;
;	imul	rax,	100	; multiply rax by 100, store in rax
;	imul	r8,	[x]	; multiply r8 by the value in x, store in r8
;	imul	r9,	r10	; multiply r9 by r10, store in r9
;
; With the three-operand 'imul', the destination is not one of the products:
;
;	imul	rbx,	[x],	100	; rbx = x * 100
;	imul	rdx,	rbx,	50	; rdx = rbx * 50
