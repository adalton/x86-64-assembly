;
; ex.s
;
; Exercise 4, page 106
;
; Write an assembly program to determine if a string stored in memory is a
; palindrome.  A palindrome is a string which is the same after being reversed,
; like "refer".  Use at least one repeat instruction.
;
; We'll consider the empty string to be a palindrome
;
	segment .data
data	db	"amanaplanacanalpanama", 0
;data	db	"notapalindrome", 0
;data	db	0
;data	db	"refer", 0

	segment .text
	global main
;
; Register usage:
;     ebx: i   -- index walking from (N - 1) backwards toward 0
;     ecx: pal -- 0 if string is not a palindrome, 1 otherwise
;     rsi: itr -- character pointer walking the string forward
;     al:  c   -- current character at *itr
;
; Repeat instruction: Load
;
; The 'lodsb' instruction moves the byt3e from the address specified by rsi to
; the 'al' register.
;
main:
	xor	ebx,	ebx			; i = 0;

; -----------------------------------------------------------------------------
; -- Determine the length of data, length will be stored in ebx
; -- We could have used the 'scasb' instruction here (see page 103), but
; -- I didn't notice that until I had already written this :)
; -----------------------------------------------------------------------------
	; lea = "load effective address"
	lea	rsi,	[data]			; itr = data; /* = &data[0] */
.start_len_loop:
	lodsb					; c = *itr; ++itr;
	cmp	al,	0			; if (c == '\0') {
	jz	.end_len_loop			;     goto end_len_loop;
						; }
	inc	ebx				; ++i
	jmp	.start_len_loop
.end_len_loop:

; -----------------------------------------------------------------------------
; -- Determine whether data is a palindrome, ecx will be 1 if yes, 0 if no
; -----------------------------------------------------------------------------
	xor	ecx,	ecx			; pal = false
	lea	rsi,	[data]			; itr = data; /* = &data[0] */

.start_loop:
	sub	ebx, 1				; --i;
	jl	.is_palindrome			; if (i < 0) { goto is_palindrome; }

	lodsb					; c = *itr; ++itr;
	cmp	al,	byte [data + ebx]	; if (c != data[i])
	jnz	.not_palindrome			;     goto not_palindrome;
	jmp	.start_loop
.is_palindrome:
	mov	ecx,	1			; pal = true;
.not_palindrome:

; $ ./ex
; $ echo $?
; 1

	; exit with status 1 is string is palindrome, 0 otherwise
	mov	eax,	ecx			; rc = pal
	ret					; return rc
