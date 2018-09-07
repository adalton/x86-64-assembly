;
; ex.s
;
; The 8086 had the following 16-bit registers:
;
;   ax - accumulator for numeric operations
;   bx - base register (array access)
;   cx - count register (string operations)
;   dx - data register
;   si - source index
;   di - destination index
;   dp - base pointer (for function frames)
;   sp - stack pointer
;
; In addition, the 2 halfs of the first 4 registers (ax, bx, cx, dx) can be
; accessed using Xl and Xh for the low and high bytes (e.g, al and ah are the
; low and high bytes of the ax register).
;
; The 80386 expanded the registers to 32-bits and renamed them eXY (e.g., eax).
; The 16-bit (and 8-bit) names can still be used.
;
; The x86-64 architecture expanded the registers to 64-bits, and added 8
; additional general-purpose registers.  The 64-bit names for the existing
; registers are rXY (e.g., rax), and the 8 additional registers are named
; r8-r15.
;
; For example, the rax register can be addressed using the following names,
; representing the given bits of the reigster:
;                                                          ---al---
;                                                  ---ah---
;                                                  -------ax-------
;                                  ---------------eax-------------- 
;  ------------------------------rax------------------------------- 
; +----------------------------------------------------------------+
; |                                                                |
; +----------------------------------------------------------------+
;

	segment .text
	global main
main:
	mov	rax,	100	; Move the constant 100 into rax
	mov	eax,	100	; Move the constant 100 into eax (has same effect
				; as the above). Arithmetic operaitons and moves with
				; 4 byte registers are zero-extended to 8 bytes.
	mov	rax,	0
	ret
