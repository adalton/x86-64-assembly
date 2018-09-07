;
; ex.s
;
; Example for conditional jump -- simple if, page 93--94
;
; There are several conditional jump instructions, with the general form:
;     jCC label
;
; The CC part of the instruction represents a wide variety of condition codes,
; which are based on specific flags in 'eflags' (zero, sign, carry flags).
; Here are some useful conditional jump instructions:
;
;     instruction  meaning                 alias     flags
;     -----------  ----------------------  --------  -------------
;     jz           jump if zero            je        ZF=1
;     jnz          jump if not zero        jne       ZF=0
;     jg           jump if > 0             jnle      ZF=0 and SF=0
;     jge          jump if >= 0            jnl       SF=0
;     jl           jump if < 0             jnge, js  SF=1
;     jle          jump if <= 0            jng       ZF=1 or SF=1
;     jc           jump if carry           jb, jnae  CF=1
;     jnc          jump if not carry       jnb, jae
;
	segment .data
;a	dq	42
;b	dq	17
a	dq	17
b	dq	42
temp	dq	0

	segment .text
	global main
main:
	; Suppose that we are implementing the following C code:
	;     if (a < b) {
        ;         temp = a;
	;         a = b;
	;         b = temp;
	;     }

	mov	rax,	[a]	; if (a < b) {
	mov	rbx,	[b]
	cmp	rax,	rbx
	jge	.in_order
	mov	[temp],	rax	;     temp = a
	mov	[a],	rbx	;     a = b
	mov	[b],	rax	;     b = tmp
.in_order:			; }

	xor	eax,	eax
	ret			; return
