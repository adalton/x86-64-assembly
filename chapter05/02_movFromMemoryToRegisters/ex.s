;
; Section 5.2 - Moving values from memory to registers
;
	segment .data
a		dq	175			; dq = data quad-word (8 bytes)
b		dq	4097
	segment .text
	global main
main:
	mov	rax,	a			; move address of a into rax
	mov	rax,	[a]        		; mov a (175) into rax
	add	rax,	[b]			; add b to rax

	mov	rax,	0x1122334455667788
	mov	al,	0xaa			; moves with 1-byte regs are not
						; zero extended.  Reg will be
						; 0x11223344556677aa

	mov	ax,	0xbbcc			; moves with 2-byte regs are not
						; zero-extended.  Reg will be
						; 0x112233445566bbcc

	movsx	rax,	byte [a]		; move byte, sign extend
	movzx	rax,	word [a]		; move word, zero extend
	movsxd	rax,	dword [a]		; move dword, size extend

	xor	eax,	eax
	ret
