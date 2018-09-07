;
; ex.s
;
; Example for bit testing and setting operations, pages 85
;
; In the x86_64 architecture there instructions for testing and setting bits:
;     - bt  -- bit test
;     - bts -- bit test and set
;     - btr -- bit test and reset
;
; The 'bt' instruction has two operands. The first is a 16-, 32-, or 64-bit
; word in memory or a register that contains the bit to test.  The second
; operand is the bit number from 0 to the number of bits minus 1 for the
; word size, which is either an immediate value or a value in a register.
; The 'bt' instruction set the carry flag (CF) to the value of the bit being
; tested.
;
; The 'bts' and 'btr' instructions operate similarly.  Both test the specified
; bit like 'bt'.  The differ in that 'bts' sets the bit to 1 and 'btr' sets
; the bit to 0.
;
; Following the 'bt' instruction, the 'setc' instruction can be used to store
; the value of the carry flag into an 8-bit register.  There are setCC
; instructions for each of the condition flags in the 'eflags' register.
;
	segment .bss
set	resq	10

	segment .text
	global main
main:
	push	rbp
	mov	rbp,	rsp

	bts	qword [set],	4	; set bit 4 of set
	bts	qword [set],	7	; set bit 7 of set
	bts	qword [set],	8	; set bit 8 of set
	bts	qword [set+8],	12	; set bit 76 of set (8*sizeof(qword)+12)
	mov	rax,		76	; test bits 4, 76, 77
	mov	rbx,		rax	; copy bit number to rbx
	shr	rbx,		6	; qword of set to test
	mov	rcx,		rax	; copy bit number to rcx
	and	rcx,		0x3f	; extract rightmost 6 bits
	xor	edx, 		edx	; set rdx to 0
	bt	[set+8*rbx],	rcx	; test bit
	setc	dl			; edx equals the tested bit
	bts	[set+8*rbx],	rcx	; set the bit, insert into set
	btr	[set+8*rbx],	rcx	; clear the bit, remove

	xor	eax,	eax
	leave
	ret				; return
