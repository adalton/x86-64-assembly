;
; ex.s
;
; Example for using a while loop to count the 1 bits in a quad-word, page 97
;
	segment .data
; data = 1111111011011100101110101001100001110110010101000011001000010000b
data	dq	0xfedcba9876543210	; long data = 0x...;
sum	dq	0			; long sum = 0;

	segment .text
	global main

;
; Register usage
;     rax : bits being examined
;     rbx : carry bit after bt, setc
;     rcx : loop counter i, 0-63
;     rdx : sum of 1 bits
main:					; int main(void) {
	push	rbp
	mov	rbp,	rsp

	mov	rax,	[data]
	xor	ebx, 	ebx             ;     int carryBit = 0;
	xor	ecx,	ecx		;     int i = 0;
	xor	edx,	edx		;     sum = 0; /* in a register */

.while:					;     while (i < 64) {
	cmp	rcx,	64
	jnl	.end_while

	bt	rax,	0		;         sum += data & 0x1
	setc	bl			;         /* bl = lower byte of ebx */
	add	edx,	ebx

	shr	rax,	1		;         data >>= 1;
	inc	rcx			;         ++i;
	jmp	.while
.end_while:				;     }
	mov	[sum],	rdx

	xor	eax,	eax		;     rc = 0;
	leave
	ret				;     return rc;
	                                ; }
