;
; ex.s
;
; Exercise 1, page 118
;
; Write an assembly program to produce a billing report for an electric company.
; It should read a series of customer records using 'scanf' and print one
; output line per customer giving the customer details and the amount of the
; bill.  The customer data will consist of a name (up to 64 characters, not
; including the terminal 0) and a number of kilowatt hours.  The number of
; kilowatt hours is an integer.  The cost for a customer will be $20.00 if the
; number of kilowatt hours is less than or equal to 1000 or $20.00 plus 1 cent
; per kilowatt hour over 1000 if the usage is greater than 1000.  Use quotient
; and remainder after dividing by 100 to print the amounts as normal dollars
; and cents.  Write and use a function to compute the bill amount (in pennies).
;
;
; struct CustomerRecord {
;     char name[65]; /* 64 + 1 for '\0' */
;     long kwHours;
; };
;
custRecName	equ	   0	; offsetof(struct CustomerRecord, name)
custRecKw	equ	  65	; offsetof(struct CustomerRecord, kwHours)
custRecSize	equ 	  73	; sizeof(CustomerRecord) /* 65 + 8 = 73 bytes */
maxRecords	equ	   5	; Array length
penniesPerDollar equ	 100	; Number of pennies in $1.00
baseBillPennies	equ	2000	; Base cost
baseThresholdHrs equ	1000	; Max base cost threshold


;==============================================================================
	segment .rodata
;==============================================================================
namePrompt	db	"Enter customer's name: ", 0
kwPrompt        db	"Enter kilowatt hours:  ", 0
nameScan	db	"%s", 0
kwScan		db	"%ld", 0
printBill	db      "Customer %s owes $%ld.%02ld", 0xa, 0 ; 0xa = '\n'


;==============================================================================
	segment .bss
;==============================================================================
recs	resb	(maxRecords * custRecSize)	; array of customer records


;==============================================================================
	segment .text
;==============================================================================
	extern printf
	extern scanf

	global main
main:
	push	rbp
	mov	rbp,	rsp

	call readRecords
	cmp	rax,	0
	jz	.done			; Zero customers read

	mov	rdi,	rax
	call printRecords

.done
	xor	eax,	eax
	leave
	ret

;
; void printRecords(long numRecords);
;
; Calculates the amount owed by each customer and prints it.
; Precondition: numRecords > 0
;
; rbx = curr
; r12 = i
; r13 = penniesPerDollar
;
printRecords:
.numRecords	equ	0		; long numRecords;

	push	rbp
	mov	rbp,	rsp
	push	rbx			; Save callee-saved register
	push	r12			; Save callee-saved register
	push	r13			; Save callee-saved register
	sub	rsp,	8		; Allocate room for numRecords on stack
					; keeping stack 16-byte aligned

	mov	[rsp + .numRecords], rdi ; Save numRecords on the stack

	mov	r12,	0			; i = 0;
	; Start curr off so that we can increment it first thing
	lea	rbx,	[recs - custRecSize]	; rbx = &recs[-1]

.begin:
	add	rbx,	custRecSize	; curr = next entry

	mov	rdi,	[rbx + custRecKw]
	call	computeBill

	; rax contains the return value of computeBill
	; rax:rdx contains the dividend, zero rdx
	xor	edx,	edx

	mov	r13,	penniesPerDollar
	idiv	qword r13

	; quotient is in rax, remainder is in rdx

	lea	rdi,	[printBill]
	lea	rsi,	[rbx + custRecName]
	mov	rcx,	rdx
	mov	rdx,	rax
	xor	eax, 	eax
	call 	printf

	inc	r12
	cmp	r12,	[rsp + .numRecords]
	jl	.begin

	add	rsp,	8
	pop	r13			; Restore callee-saved register
	pop	r12			; Restore callee-saved register
	pop	rbx			; Restore callee-saved register
	leave
	ret

;
; long computeBill(long kwHours)
;
; The cost for a customer will be $20.00 if the number of kilowatt hours is less
; than or equal to 1000 or $20.00 plus 1 cent per kilowatt hour over 1000 if the
; usage is greater than 1000.
;
computeBill:
	push	rbp
	mov	rbp,	rsp


	mov	rax,	baseBillPennies		; ret = $20.00
	cmp	rdi,	baseThresholdHrs
	jle	.done

	; $20.00 + 1 cent per kilowatt hour over 1000
	sub	rdi,	baseThresholdHrs
	add	rax,	rdi

.done
	leave
	ret


;
; long readRecords();
;
; Reads customer records into 'recs' and returns the number of records stored.
;
; Register usage:
;  rbx = curr
;  r12 = i
;
readRecords:
	push	rbp
	mov	rbp,	rsp
	push	rbx			; Save callee-saved register
	push	r12			; Save callee-saved register

	;----------------------------------------------------------------------
	; Start i and curr at -1 offsets so that we can increment them
	; first thing in the loop
	;----------------------------------------------------------------------
	mov	r12,	-1			; i = -1
	lea	rbx,	[recs - custRecSize]	; curr = &recs[-1]

.begin_loop:
	; -- Advance current --------------------------------------------------
	add	rbx,	custRecSize	; curr = next entry
	inc	r12

	cmp	r12,	maxRecords	; Don't run off the end of the array
	jz	.done

	; -- Read name --------------------------------------------------------
	lea	rdi,	[namePrompt]
	xor	eax,	eax		; No floating point operands to printf
	call 	printf

	lea	rdi,	[nameScan]
	lea	rsi,	[rbx + custRecName]
	xor	eax,	eax		; No floating point operands to scanf
	call	scanf

	; -- Read kilowatts ---------------------------------------------------
	lea	rdi,	[kwPrompt]
	xor	eax,	eax		; No floating point operands to printf
	call 	printf

	lea	rdi,	[kwScan]
	lea	rsi,	[rbx + custRecKw]
	xor	eax,	eax		; No floating point operands to scanf
	call	scanf

	; -- if curr->custRecKw != 0, continue looping ------------------------
	mov	rax,	[rbx + custRecKw]
	cmp	rax,	0
	jnz	.begin_loop

.done:
	mov	rax,	r12

	pop	r12			; Restore callee-saved register
	pop	rbx			; Restore callee-saved register
	leave
	ret
