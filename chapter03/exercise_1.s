; Yasm understands the following instructions:
;
;	DB - byte (1 byte)
;	DW - word (2 bytes)
;	DD - double word (4 bytes)
;	DQ - quad-word (8 bytes)
;
	segment .data
array1		times	10 dq 0			; 10 quad word (8-byte) integers
string		db	"hello, world", 0	; a string terminated by 0

; Yasm understands the following instructions:
;
;	RESB - Reserve byte (1 byte)
;	RESW - Reserve word (2 bytes)
;	RESD - Reserve double word (4 bytes)
;	RESQ - Reserve quad word (8 bytes)

	segment .bss
array2		resw	5 			; 5 double word (2-byte) integers

	segment .text
	global main 
main:
	push	rbp				; set up a stack frame
	mov	rbp,	rsp			; rbp points to stack frame
	mov	rax,	0			; return value from main
	leave					; undo stack frame changes
	ret
