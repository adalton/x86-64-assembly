;
; ex.s
;
; Exercise 5, page 106
;
; Write an assembly program to perform a "find and replace" operation on a
; string in memory.  Your program should have an input array and an output
; array.  Make your program replace every occurrence of "amazing" with
; "incredible".
;
	segment .rodata	; Experiment to make these constant
AMAZING		db	"amazing", 0
INCREDIBLE	db	"incredible", 0
AMAZING_LEN	db	 7
INCREDIBLE_LEN  db	10

; Note that I put some "XXXXX" characters after the first '\0' so that I can
; ensure that I don't copy bytes past the first '\0' to dest.
DATA		db	"This is an amazing program that copies amazing ", \
			"characters to amazing places and that is amazing", \
			0, "XXXXX", 0

	segment .bss
dest	resb	150	; This must be big enough to hold the transformation

	segment .text
	global main
;
; Register usage:
;     rax:   i -- Index into src
;     rbx:   j -- index into dest
;     rcx:     -- AMAZING_LEN
;     rdx: tmp -- Temporary variable
;     rsi:     -- source index pointer for comparisons
;     rdi:     -- destination index pointer for comparisons
;
; My approach: Walk src character-by-character.  At each character, determine
; if that character starts the word "amazing".  If not, copy the character
; to dest and advance the index.  If so, copy the word "incredible" to dest
; and advance the index by the length of "incredible".
;
; Repeat instruction: Compare
;
; The 'cmpsb' instruction compares values of 2 arrays, pointed to by rsi and
; rdi.  Typically it is used with 'repe', which will continue to compare values
; until either the count in 'ecx' reaches 0 or two different values are located.
;
; Repeat instruction: Move
;
; The 'movsb' instruction moves 'rcx' number of bytes from the address specified
; by 'rsi' to the address specified by 'rdi'.
;
main:
	xor	eax,	eax			; i = 0;
	xor	ebx,	ebx			; j = 0;

.loop:
	; Bail out if we've reach the terminator
	movzx	dx,	[DATA + eax]		; tmp = src[i];
	cmp	dx,	0			; if (tmp == '\0')
	jz	.end_loop			;     goto end_loop;

	lea	rsi,	[DATA + eax]		; rsi = DATA + i
	lea	rdi,	[AMAZING]		; rdi = AMAZING
	movzx	rcx,	byte [AMAZING_LEN]	; rcx = strlen(AMAZING)

	; See if rsi points to the string "amazing"; compare until a difference
	; is found or until rcx reaches 0.
	repe	cmpsb
	cmp	rcx,	0
	jz	.equal
;.not_equal: -- for readability
	mov	[dest + ebx],	dx		; dest[j] = tmp;
	inc	eax				; ++i
	inc	ebx				; ++j
	jmp	.loop
.equal:
	lea	rsi,	[INCREDIBLE]		; rsi = INCREDIBLE
	lea	rdi,	[dest + ebx]		; rdi = dest + j
	movzx	rcx,	byte [INCREDIBLE_LEN]	; rcx = strlen(INCREDIBLE)
	rep	movsb				; copy INCREDIBLE to dest + i

	movzx	dx,	[AMAZING_LEN]		; tmp = AMAZING_LEN;
	add	ax,	dx			; i += tmp;

	movzx	dx,	[INCREDIBLE_LEN]	; tmp = INCREDIBLE_LEN;
	add	bx,	dx			; j += tmp;
	jmp	.loop
.end_loop

; (gdb) printf "%s\n", &dest
; This is an incredible program that copies incredible characters to incredible places and that is incredible
;
; (gdb) x/110c &dest
; 0x60102c:       84 'T'  104 'h' 105 'i' 115 's' 32 ' '  105 'i' 115 's' 32 ' '
; 0x601034:       97 'a'  110 'n' 32 ' '  105 'i' 110 'n' 99 'c'  114 'r' 101 'e'
; 0x60103c:       100 'd' 105 'i' 98 'b'  108 'l' 101 'e' 32 ' '  112 'p' 114 'r'
; 0x601044:       111 'o' 103 'g' 114 'r' 97 'a'  109 'm' 32 ' '  116 't' 104 'h'
; 0x60104c:       97 'a'  116 't' 32 ' '  99 'c'  111 'o' 112 'p' 105 'i' 101 'e'
; 0x601054:       115 's' 32 ' '  105 'i' 110 'n' 99 'c'  114 'r' 101 'e' 100 'd'
; 0x60105c:       105 'i' 98 'b'  108 'l' 101 'e' 32 ' '  99 'c'  104 'h' 97 'a'
; 0x601064:       114 'r' 97 'a'  99 'c'  116 't' 101 'e' 114 'r' 115 's' 32 ' '
; 0x60106c:       116 't' 111 'o' 32 ' '  105 'i' 110 'n' 99 'c'  114 'r' 101 'e'
; 0x601074:       100 'd' 105 'i' 98 'b'  108 'l' 101 'e' 32 ' '  112 'p' 108 'l'
; 0x60107c:       97 'a'  99 'c'  101 'e' 115 's' 32 ' '  97 'a'  110 'n' 100 'd'
; 0x601084:       32 ' '  116 't' 104 'h' 97 'a'  116 't' 32 ' '  105 'i' 115 's'
; 0x60108c:       32 ' '  105 'i' 110 'n' 99 'c'  114 'r' 101 'e' 100 'd' 105 'i'
; 0x601094:       98 'b'  108 'l' 101 'e' 0 '\000'        0 '\000'        0 '\000'

	xor	eax,	eax			; rc = 0;
	ret					; return rc;
