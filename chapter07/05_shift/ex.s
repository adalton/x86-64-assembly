;
; ex.s
;
; Example for bit shifting operations, pages 78
;
; In the x86_64 architecture there are 4 shift instructions:
;     - shl -- shift left
;     - sal -- shift arithmetic left
;     - shr -- shift right
;     - sar -- shift arithmetic right
;
; shl and sal are actually the same instruction.
;
; The sar instruction propagates the sign bit into the newly vacated positions
; on the left, which preserves the sign of the number, while shr introduces 0
; bits from the left.
;
; The shift instructions take two operands: (1) the register or memory location
; containing the value to shift and (2) the number of bits to shift.  The
; second operand can be an immediate value or the 'cl' register.
;
	segment .text
	global main
main:
	push	rbp
	mov	rbp,	rsp

	mov	rax,	0x12345678
	shr	rax,	8		; I want bits 8-15
	and	rax,	0xff		; rax now holds 0x56

	mov	rax,	0x12345678	; I want to replace bits 8-15
	mov	rdx,	0xaa		; rdx holds replacement field
	mov	rbx,	0xff		; I need an 8-bit mask
	shl	rbx,	8		; shift mask to align at bit 8 (0xff00)
	not	rbx			; rbx is the inverted mask
	and	rax,	rbx		; Now bits 8-15 are all 0
	shl	rdx,	8		; shift the new bits to align
	or	rax,	rdx		; rax now has 0x1234aa78

	leave
	xor	eax,	eax
	ret				; return
