;
; ex.s
;
; Example of stack frames, page 113
;
; To track stack frames, we need to keep a pointer in the 'rbp' register to
; a 2 quad-word object on the stack identifying the previous value of 'rbp'
; along with the return address.  The 'call' instruction pushes the return
; address already, so the first thing we do in a function is push the current
; value of rbp --- the calling function's stack frame base pointer --- then
; save our stack frame base pointer in rbp.  This also has the nice property
; that it maintains the stack pointer on a 16-byte boundary
;
; Tools like 'gdb' can use the information in these registers (and on the
; stack) to walk back stack frames.
;
; To establish a stack frame:
;	push	rbp
;	mov	rbp,	rsp
;
; The effect of the these 2 instructions and a possible subtraction from rsp
; can be undone using the 'leave' instruction just before the 'ret' instruction.
;
; When you have local variables in the stack frame it makes sens to access
; those variables using names rather than adding 8 or 16 to rsp.  This can be
; done by using yasm's 'equ' pseudo-op.  The following sets up symbolic names
; for 0 and 8 for two local variables:
;
;	x	equ	0
;	y	equ	8
;
; Now we can easily save registers in x and y prior to using them:
;	mov	[rsp + x], r8
;	mov	[rsp + y], r9
;
; If the callee wishes to use registers RBX, RBP, and R12–R15, it must save
; the original values on the stack and restore them before returning control
; to the caller. All other registers must be saved by the caller prior to
; calling a function if it wishes to preserve their values.
;
	segment .text
	global main
	global f1
	global f2
	global f3

main:
	push	rbp
	mov	rbp,	rsp

	call f1

	xor	eax,	eax	; return 0;
	leave
	ret

f1:
	push	rbp
	mov	rbp,	rsp

	call f2

	xor	eax,	eax
	leave
	ret

f2:
	push	rbp
	mov	rbp,	rsp

	call f3

	xor	eax,	eax
	leave
	ret

f3:
	push	rbp
	mov	rbp,	rsp

; Breakpoint 1, main () at ex.s:48
; 48              push    rbp
; (gdb) s
; 49              mov     rbp,    rsp
; (gdb) 
; 51              call f1
; (gdb) 
; f1 () at ex.s:58
; 58              push    rbp
; (gdb) 
; 59              mov     rbp,    rsp
; (gdb) 
; 61              call f2
; (gdb) 
; f2 () at ex.s:68
; 68              push    rbp
; (gdb) 
; 69              mov     rbp,    rsp
; (gdb) 
; 71              call f3
; (gdb) 
; f3 () at ex.s:78
; 78              push    rbp
; (gdb) 
; 79              mov     rbp,    rsp
; (gdb) 
; 81              xor     eax,    eax
; (gdb) bt
; #0  f3 () at ex.s:81
; #1  0x00000000004004b3 in f2 () at ex.s:71
; #2  0x00000000004004a6 in f1 () at ex.s:61
; #3  0x0000000000400499 in main () at ex.s:51

; Note that if I put a local label in f3 and set a break point on that label,
; it seems to want to treat that label like a function too -- it confuses
; gdb's backtrace

	xor	eax,	eax
	leave
	ret
