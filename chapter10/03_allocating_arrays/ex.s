;
; Section 10.3 - Allocating arrays
;
	segment .bss
pointer		resq		1

	segment .text
	global main
	extern malloc
	extern free
main:
	push	rbp
	mov	rbp,		rsp

	; Dynamically allocate 1000000000 bytes, store the address in pointer
	mov	rdi,		1000000000
	call	malloc
	mov	[pointer],	rax

	; Release the memory
	mov	rdi,		[pointer]
	call	free

	xor	eax,		eax
	leave
	ret

; After malloc(), before free()
; For me, the values were 0.  There's no guarantee what the values will be,
; but given the size of the allocation, malloc() probably invoked a system
; call to get more memory, and that will give us 0 bytes.
;
; (gdb) x/b (char*)pointer
; 0x7fffbc421010: 0
; (gdb) x/b &((char*)pointer)[99999999]
; 0x7fffc237f10f: 0
