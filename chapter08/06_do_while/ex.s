;
; ex.s
;
; Example for conditional jump -- do-while loop, page 99-100
;
; Let's look at a program implementing a search in a character array,
; terminated by a 0 byte.  We will do an explicit test before the loop to
; not execute the loop if the first character is 0.  Here's the C code
; for the loop:
;
; i = 0;
; c = data[i];
;
; if (c != 0) {
;     do {
;         if (c == x) {
;             break;
;         }
;         ++i;
;         c = data[i];
;     } while (c != 0);
; }
; n = (c == 0) ? -1 : i;
;
; Here's an assembly implementation of this code:
;
	segment .data
needle	db	'w'
data	db	"hello, world", 0	; 'w' (needle) at index 7
n	dq	0

	segment .text
	global main
;
; Register usage:
;   rax: c -- byte of data array
;   bl:  x -- byte to search for
;   rcx: i -- loop counter, 0-63
main:					; int main(void) {
	push	rbp
	mov	rbp,	rsp
	sub	rsp,	16

	mov	bl,	[needle]	;     x = needle;
	xor	rcx,	rcx		;     i = 0;
	mov	al,	[data + rcx]	;     c = data[i];

	cmp	al,	0		;     if (c != 0) {
	jz	.end_if

.do_while				;         do {
	cmp	al,	bl		;             if (c == x) {
	je	.found			;                 break;
					;             }
	inc	rcx			;             ++i;
	mov	al,	[data + rcx]	;             c = data[i];
	cmp	al,	0		;         } while (c != 0);
	jnz	.do_while
.end_if					;     }
					;     /* c == 0 if you reach here */
	mov	rcx,	-1		;     n = (c == 0) ? -1 : i
.found
	mov	[n],	rcx		;     n = i;

	xor	eax,	eax		;     rc = 0;
	leave
	ret				;     return rc;
					; }
