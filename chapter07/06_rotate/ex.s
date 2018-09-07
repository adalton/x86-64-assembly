;
; ex.s
;
; Example for bit rotating operations, pages 82
;
; In the x86_64 architecture there are two rotate instructions:
;     - rol -- rotate left
;     - ror -- rotate right
;
; These are useful to shift a particular part of a bit string into proper
; position for testing while preserving the bits.
;
	segment .text
	global main
main:
	push	rbp
	mov	rbp,	rsp

	mov	rax,	0x12345678	; Initial value for rax
	ror	rax,	8		; Preserve bits 7-0
					; now, rax = 0x7800000000123456
	shr	rax,	4		; Shift out original 11-8
					; now, rax = 0x0780000000012345
	shl	rax,	4		; Bits 3-0 are 0's
					; now, rax = 0x7800000000123450
	or	rax,	1010b		; set the field to 1010b (a)
					; now, rax = 0x780000000012345a
	rol	rax,	8		; Bring back bits 7-0
					; now, rax = 0x12345a78

	xor	eax,	eax
	leave
	ret				; return
