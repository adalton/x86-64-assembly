	segment .bss
a	resb	100	; array of 100 bytes        ( 8-bit values)
b	resd	100	; array of 100 double words (32-bit values)
	align 	8
c	resq	100	; array of 100 quad words   (64-bit values)


	segment .text
	global main
main:
	push	rbp
	mov	rbp,	rsp
	sub	rsp,	16
	leave
	ret

; Note that each elements is 1 byte apart
; (gdb) p (unsigned char*) &a
; $1 = (unsigned char *) 0x404018 ""
; (gdb) p &((unsigned char*) &a)[1]
; $2 = (unsigned char *) 0x404019 ""
; (gdb) p &((unsigned char*) &a)[2]
; $3 = (unsigned char *) 0x40401a ""
;
; Note that each elements is 4 bytes apart
; (gdb) p (int*)&b
; $4 = (int *) 0x40407c
; (gdb) p &((int*)&b)[1]
; $5 = (int *) 0x404080
; (gdb) p &((int*)&b)[2]
; $6 = (int *) 0x404084
;
; Note that each elements is 8 bytes apart
; (gdb) p (long*)&c
; $7 = (long *) 0x404210
; (gdb) p &((long*)&c)[1]
; $8 = (long *) 0x404218
; (gdb) p &((long*)&c)[2]
; $9 = (long *) 0x404220
