;
; Section 5.2 - Moving a constant into a register
;

;
; Breakpoint 1, main () at ex.s:8
; 8               mov     rax,            100
; (gdb) s
; 13              mov     eax,            100
; (gdb) p $rax
; $1 = 100
; (gdb) s
; 16              xor eax, eax
; (gdb) p $rax
; $2 = 100
; (gdb) p $eax
; $3 = 100

	segment .text
	global main
main:
	mov	rax,		100

	; The following has the same effect as the above instruction.
	; Arithmetic operations and move with 4-byte registers are
	; zero-extended to 8-bytes.
	mov	eax,		100


	xor	eax,		eax
	ret
