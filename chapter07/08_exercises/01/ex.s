;
; ex.s
;
; Exercise 1, Page 90
;
; Write an assembly program to count all the 1 bits in a byte stored in
; memory.  Use repeated code rather than a loop.
;
; $ ./ex
; $ echo $?
; 4
;
	segment .data
a	db	11001001b		; byte with 1's to count

	segment .text
	global main
;
; ax = 1 counter
; cx = copy of variable a in a register
; bx = copy of cx against we'll apply a bitmask
;
main:
	push	rbp
	mov	rbp,	rsp

	xor	rax,	rax		; Initialize rax to 0
	movzx	cx,	byte [a]	; Copy a to cx (leave it here)

	; Bit 0
	mov	bx,	cx		; Copy a into bx
	and	bx,	1		; Test bit 0
	add	ax,	bx		; Add bx to ax; if the bit was set,
					; we'll add 1, otherwise 0
	; Bit 1
	mov	bx,	cx		; Copy original a into bx
	shr	bx,	1		; Shift away the bit we counted above
	and	bx,	1		; Test bit 1
	add	ax,	bx		; Add bx to ax; if the bit was set,
					; we'll add 1, otherwise 0
	; Bit 2
	mov	bx,	cx		; Copy original a into bx
	shr	bx,	2		; Shift away the bits we counted above
	and	bx,	1		; Test bit 2
	add	ax,	bx		; Add bx to ax; if the bit was set,
					; we'll add 1, otherwise 0
	; Bit 3
	mov	bx,	cx		; Copy original a into bx
	shr	bx,	3		; Shift away the bits we counted above
	and	bx,	1		; Test bit 3
	add	ax,	bx		; Add bx to ax; if the bit was set,
					; we'll add 1, otherwise 0
	; Bit 4
	mov	bx,	cx		; Copy original a into bx
	shr	bx,	4		; Shift away the bits we counted above
	and	bx,	1		; Test bit 4
	add	ax,	bx		; Add bx to ax; if the bit was set,
					; we'll add 1, otherwise 0
	; Bit 5
	mov	bx,	cx		; Copy original a into bx
	shr	bx,	5		; Shift away the bits we counted above
	and	bx,	1		; Test bit 5
	add	ax,	bx		; Add bx to ax; if the bit was set,
					; we'll add 1, otherwise 0
	; Bit 6
	mov	bx,	cx		; Copy original a into bx
	shr	bx,	6		; Shift away the bits we counted above
	and	bx,	1		; Test bit 6
	add	ax,	bx		; Add bx to ax; if the bit was set,
					; we'll add 1, otherwise 0
	; Bit 7
	mov	bx,	cx		; Copy original a into bx
	shr	bx,	7		; Shift away the bits we counted above
	and	bx,	1		; Test bit 7
	add	ax,	bx		; Add bx to ax; if the bit was set,
					; we'll add 1, otherwise 0

	; Return the count in ax for easy testing
	leave
	ret				; return
