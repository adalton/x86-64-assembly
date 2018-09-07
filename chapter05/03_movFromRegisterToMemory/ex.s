;
; Section 5.4 - Moving values from a register to memory
;

;
; Breakpoint 1, main () at ex.s:14
; 14              mov     rax,    [a]     ; move a (175) into rax
; (gdb) s
; 15              add     rax,    [b]     ; add b (4097) to the value in rax
; (gdb) p $rax
; $1 = 175
; (gdb) s
; 16              mov     [sum],  rax     ; move value in rax to memory location sum
; (gdb) p $rax
; $2 = 4272
; (gdb) p sum
; $3 = 0
; (gdb) s
; 18              xor     rax,    rax
; (gdb) p sum
; $4 = 4272

	segment .data
a		dq	175
b		dq	4097
sum		dq	0

	segment .text
	global main
main:
	mov	rax,	[a]	; move a (175) into rax
	add	rax,	[b]	; add b (4097) to the value in rax
	mov	[sum],	rax	; move value in rax to memory location sum

	xor	eax,	eax
	ret
