;
; Section 10.5 - Command Line Parameter Array
;
	segment .data
format		db		"%s", 0x0a, 0

	segment .text
	global main
	extern printf
main:
	push		rbp
	mov		rbp,		rsp
	sub		rsp,		16

	mov		rcx,		rsi
	mov		rsi,		[rcx]		; Get first argv string
start_loop:
	lea		rdi,		[format]
	mov		[rsp],		rcx
	xor		eax,		eax
	call		printf
	mov		rcx,		[rsp]		; Restore rsi
	add		rcx,		8		; Advance to the next pointer in argv
	mov		rsi,		[rcx]		; Get next argv string
	cmp		rsi,		0		; It's sad that movee doesn't also test
	jnz		start_loop
end_loop:
	xor		eax,		eax
	leave
	ret
