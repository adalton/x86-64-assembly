;
; ex.s
;
; Conditional move example, page 71
;
; Use conditional move instead of branching, where possible, to avoid branch
; prediction misses.
;
; The conditional move instructions have operands much like the 'mov'
; instruction, but they do not support immediate operands.
;
;     instruction  |  effect
;     -------------+-------------------------------------------------------
;     cmovz        | move if result was zero
;     cmovnz       | move if result was non-zero
;     cmovl        | move if result was < 0
;     cmovle       | move if result was <= 0
;     cmovg        | move if result was > 0
;     cmovge       | move if result was >= 0
;
; These all operate by testing for combinations of the sign flag (SF) and
; the zero flag (ZF), which are set by the various arithmetic operations
; (except for 'idiv').
;
; Breakpoint 1, main () at ex.s:33
; 33              mov     rax,    [a]
; (gdb) s
; 34              mov     rbx,    rax     ; save the original value
; (gdb)
; 35              neg     rax             ; negate rax -- sets SF if the result is
; (gdb)
; 37              cmovl   rax,    rbx     ; replace rax if negative; examines SF
; (gdb) p $eflags
; $1 = [ CF AF SF IF ]
; (gdb) p $rax
; $2 = -42
; (gdb) s
; 40              mov     rax,    [b]
; (gdb) p $rax
; $3 = 42
; (gdb) s
; 41              mov     rbx,    rax
; (gdb)
; 42              neg     rax
; (gdb)
; 44              cmovl   rax,    rbx     ; performs the move since SF is set
; (gdb) p $eflags
; $4 = [ CF AF IF ]
; (gdb) p $rax
; $5 = 42
; (gdb) s
; 46              xor     rax,    rax     ; return value from main

;
	segment .data
a	dq	42
b	dq	-42

	segment .text
	global main
main:
	; absolute value of rax
	mov	rax,	[a]
	mov	rbx,	rax	; save the original value
	neg	rax		; negate rax -- sets SF if the result is
				; negative and ZF if the result is 0
	cmovl	rax,	rbx	; replace rax if negative; examines SF --
				; performs the move in this case since SF is set

	mov	rax,	[b]
	mov	rbx,	rax
	neg	rax

	cmovl	rax,	rbx	; does NOT perform the move since SF is clear

	xor	eax,	eax	; return value from main
	ret
