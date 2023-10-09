	segment .data
a:	dd	1, 2, 3, 4, 5

	segment .bss
b:	resd	10

	segment .text
	global main, copy_array
main:
	push	rbp
	mov	rbp,	rsp
	lea	rdi,	[b]
	lea	rsi,	[a]
	mov	edx,	5
	call	copy_array
	xor	eax,	eax
	leave
	ret

;
; copy_array
;
; Copy one array to another
;
; Parameters:
;       rdi - Address of the first element of the destination array
;       rsi - Address of the first element of the source array
;       edx - The number of elements to copy
;
copy_array:
	xor	ecx,			ecx
more:	mov	eax,			[rsi + 4 * rcx]
	mov	[rdi + 4 * rcx],	eax
	add	rcx,			1
	cmp	rcx,			rdx
	jne	more
	xor	eax,			eax
	ret

; After copy_array returns:
;
; (gdb) x/5d &a
; 0x404010:       1       2       3       4
; 0x404020:       5
;
; (gdb) x/10d &b
; 0x404028:       1       2       3       4
; 0x404038:       5       0       0       0
; 0x404048:       0       0

