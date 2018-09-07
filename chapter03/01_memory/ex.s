;
; ex.s
;
; Memory (re: initialized static data) is in the .data segment.  yasm
; understands the following types:
;
;	db - byte (1 byte)
;	dw - word (2 bytes)
;	dd - double word (4 bytes)
;	dq - quad-word (8 bytes)
;
	segment .data
a		dd	4
b		dd	4.4			; floating-point number
c		times	10 dd 0			; 10 double word (4-byte) integer = array
d		dw	1, 2			; array of 2 double-words (2-byte) integers
e		db	0xfb			; 1-byte
f		db	"hello world", 0	; Array of bytes with explicit NUL terminator
j		dq	0			; quad word (8-byte) integer

	segment .bss
g		resd	1			; resd 1 = "reserve 1 double word" (4 bytes)
h		resd	10			; "reserve 10 double words" (40 bytes)
i		resb	100			; resb 100 = "reserve 100 bytes" (100 bytes)

	segment .text
	global main 
main:
	push	rbp				; set up a stack frame
	mov	rbp,	rsp			; rbp points to stack frame
	sub	rsp,	16			; leave some room for locals
						; rsp on a 16-byte boundary
	xor	eax,	eax			; rax = 0 for return value
	leave					; undo stack frame changes
	ret
