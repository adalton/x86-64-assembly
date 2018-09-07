;
; ex.s
;
; Example for unconditional jump, page 92
;
	segment .data
switch:
	dq	main.case0
	dq	main.case1
	dq	main.case2
i	dq	2

	segment .text
	global main
main:
	mov	rax,	[i]		; load value of i into rax

	;
	; Some pointer arithmetic here.  'switch' is an array of 4 8-byte
	; values, which are pointers to labels within main; 'switch' is the
	; base address of that array.  'rax' contains the index into that
	; array (here, 2).  'rax * 8' skips rax * 8 bytes (1 element), so
	; '[switch + rax * 8]' gets the i-th address in the array.
	;
	; Note below the labels that begin with dot -- these are "local"
	; labels that are scoped within the regular label.  Also note that
	; the local labels can be reference (above) using main.<label>
	;
	jmp	[switch + rax * 8]	; switch (i)
.case0:					; go here if i == 0
	mov	rbx,	100
	jmp	.end
.case1:					; go here if i == 1
	mov	rbx,	101
	jmp	.end
.case2:					; go here if i == 2
	mov	rbx,	102
.end

	; Since i == 2, here rbx == 102

	xor	eax,	eax
	ret				; return
