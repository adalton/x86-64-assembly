;
; ex.s
;
; Exercise 2, Page 90
;
; Write an assembly program to swap 2 quad-words in memory using xor. Use
; the following algorithm:
;
; a = a ^ b
; b = a ^ b
; a = a ^ b
;
; (gdb) p a
; $1 = 42
; (gdb) p b
; $2 = 17
; ...
; (gdb) p a
; $3 = 17
; (gdb) p b
; $4 = 42
;
	segment .data
a	dq	42
b	dq	17

	segment .text
	global main
;
; rax = a
; rbx = b
;
; Note that I could have solved this with one fewer register by using memory
; references in the xorg instructions:
;
;	mov	rax,	[a]
;
;	xor	rax,	[b]
;	xor	[b],	rax
;	xor	rax,	[b]
;	mov	[a],	rax
;
main:
	push	rbp
	mov	rbp,	rsp

	mov	rax,	[a]
	mov	rbx,	[b]

	xor	rax,	rbx		; a = a ^ b
	xor	rbx,	rax		; b = b ^ a (b ^ a = a ^ b)
	xor	rax,	rbx		; a = a ^ b

	mov	[a],	rax
	mov	[b],	rbx

	xor	eax,	eax		; return 0
	leave
	ret				; return
