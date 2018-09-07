;
; ex.s
;
; Example of a function call with parameters, page 112
;
; Linux uses the "System V Application Binary Interface" for function
; calling convention.  For 64-bit applications, it allows the first 6
; integral parameters to be passed in the following registers, in order:
; rdi, rsi, rdx, rcx, r8, and r9.  Integral return values are in rax.
;
; Linux allows the first 8 floating point parameters to be passed in floating
; point registers xmm0-xmm7.  Functions like 'printf' and 'scanf', which take
; a variable number of arguments, expect the number of floating point arguments
; to be in rax.
;
; If a function has more than 6 parameters, then any parameters over 6 are
; pushed onto the stack in reverse order.
;
; Linux expects the stack pointer to be maintained on 16-byte boundaries in
; memory.  This means that the hexadecimal value of rsp should end in 0.  The
; motivation for this is to allow local variables in functions to be placed at
; 16 byte alignments for SSE and AVE instructions.
;
; Executing a 'call' instruction decrements rsp leaving it ending with an 8.
; Conforming functions must either push something or subtract 8 from rsp to
; get it back on a 16 byte boundary. It is common for a function to push 'rbp'
; ast part of establishing a stack frame that reestablishes the 16 byte
; boundary.  If your function calls any external functions, it is wise to stick
; to the 16 byte boundary requirement.
;
; Note: The protocol for 32-bit programs is different.  Registers r8-r15 are
; not available, so there is not much value in passing function parameters in
; registers.  These programs use the stack for all parameters.
;
	segment .rodata
msg	db	"Hello, World", 0x0a, 0 ; 0x0a = '\n'
msg2	db	"%s", 0

	segment .text
	extern	printf
	global main
main:
	push	rbp		; Restore 16-byte stack boundary
	mov	rbp,	rsp	; Keep a pointer to the pushed object

	; We use the "load effective address" instruction instead of "mov"
	; because under OS X, "mov" will not allow you to move an array into
	; a register -- static addresses for data have values that exceed
	; 32 bits and the constant file of the "mov" instruction is 32 bits.
	lea	rdi,	[msg]	; First parameter
	xor	eax,	eax	; 0 floating point parameters

	call	printf
	; We would expect eax to be 0 here since printf() would have returned 0

	;
	; Call it again with two parameters this time
	;
	lea	rdi,	[msg2]	; First parameter
	lea	rsi,	[msg]	; Second parameter
	xor	eax,	eax	; 0 floating point parameters

	call	printf
	; We would expect eax to be 0 here since printf() would have returned 0

	xor	eax,	eax	; return 0;
	pop	rbp		; Could also use the 'leave' instruction?
	ret
