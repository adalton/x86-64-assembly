;
; Exercise 3 (page 57)
;
; Write an assembly program to define 3 integers of 2 bytes each.  Name
; these a, b, and c.  Compute and save into 4 memory locations a+b, a-b,
; a+c, and a-c
;

	segment .data
a		dw	1	; 2 bytes
b		dw	2	; 2 bytes
c		dw	3	; 2 bytes
sum_ab		dw	0
diff_ab		dw	0
sum_ac		dw	0
diff_ac		dw	0

	segment .text
	global main
main:
	;
	; This "solution" is wrong....
	;
	; It *seems* to work if you examine the variables as you go along
	; (and even at the end), but the moves from registers back to
	; memory are copying 8 bytes instead of two
	;
	;
	; First, note the initial state of memory (with some bytes after the
	; last variable
	; 
	; 	Breakpoint 1, main () at ex.s:21
	; 	21              movsx   r8,             word [a]
	; 	(gdb) x/14x &a
	;                          a       b       c    sum_ab  diffab  sum_ac  diffac
	; 	0x601028:       0x0001  0x0002  0x0003  0x0000  0x0000  0x0000  0x0000  0x0000
	; 	0x601038:       0x0000  0x0000  0x0000  0x0000  0x0000  0x0000
	;
	; Next, load the registers and calculate the sum of a and b
	; 	(gdb) s
	; 	22              movsx   r9,             word [b]
	; 	(gdb) 
	; 	23              movsx   r10,            word [c]
	; 	(gdb) 
	; 	25              mov     rax,            r8
	; 	(gdb) 
	; 	26              add     rax,            r9
	; 	(gdb) 
	; 	27              mov     [sum_ab],       rax     ; 3
	; 	(gdb) 
	; 	29              mov     rax,            r8
	;
	; Now look at memory again.  It looks ok, but only because the high-order
	; bits of rax were the same as what was in memory.
	; 	(gdb) x/14x &a
	;                          a       b       c    sum_ab  diffab  sum_ac  diffac
	; 	0x601028:       0x0001  0x0002  0x0003  0x0003  0x0000  0x0000  0x0000  0x0000
	; 	0x601038:       0x0000  0x0000  0x0000  0x0000  0x0000  0x0000
	;
	; Next, calculate the difference of a and b
	; 	(gdb) s
	; 	30              sub     rax,            r9
	; 	(gdb) 
	; 	31              mov     [diff_ab],      rax     ; -1
	; 	(gdb) 
	; 	33              mov     rax,            r8
	;
	; Now look at memory again.  Notice that not only is diffab 0xffff, but
	; so is the next *6 bytes* past diffab.  The instruction
	; "mov [diff_ab], rax" copied the 8-byte register value stored in rax
	; to the memory address starting at diff_ab.  Since the register
	; contained -1 (0xffffffffffffffff), it wrote that to memory.
	; 	(gdb) x/14x &a
	; 	                   a       b       c    sum_ab  diffab  sum_ac  diffac
	; 	0x601028:       0x0001  0x0002  0x0003  0x0003  0xffff  0xffff  0xffff  0xffff
	; 	0x601038:       0x0000  0x0000  0x0000  0x0000  0x0000  0x0000
	;
	; See 03_v2 for an improved solution


	movsx	r8,		word [a]
	movsx	r9,		word [b]
	movsx	r10,		word [c]

	mov	rax,		r8
	add	rax,		r9
	mov	[sum_ab],	rax	; 3

	mov	rax,		r8
	sub	rax,		r9
	mov	[diff_ab],	rax	; -1

	mov	rax,		r8
	add	rax,		r10
	mov	[sum_ac],	rax	; 4

	mov	rax,		r8
	sub	rax,		r10
	mov	[diff_ac],	rax	; -2

	xor	eax,		eax
	ret

	;
	; I tried the following first -- it didn't work.  When I inspect the
	; variables a, b, and c by name in gdb, they'd often have some sort of
	; junk in the higher order bits.  Then when I used the add/sub instructions,
	; those instructions would pick up that junk as part of the operation
	; and yield junk answer.
	;
	; EDIT: The "junk" was the next byte
	;	(gdb) x &a
	;	0x601028:       0x00020001
	;	(gdb) x &b
	;	0x60102a:       0x00030002
	;	(gdb) x &c
	;	0x60102c:       0x00000003
	;
	; The word (in gdb terms, a 4-byte thing) at a includes b, and at
	; b includes c.  We can, instead, use x/h (eXamine Halfword;
	; halfword in gdb terms = 2 bytes).
	; 
	; 	(gdb) x/h &a
	; 	0x601028:       1
	; 	(gdb) x/h &b
	; 	0x60102a:       2
	; 	(gdb) x/h &c
	; 	0x60102c:       3
	;

	;
	; movsx   eax,        word [a]
	; add     eax,        [b]
	; mov     [sum_ab],   eax         ; 3

	; movsx   eax,        word [a]
	; sub     eax,        [b]
	; mov     [diff_ab],  eax         ; -1

	; movsx   eax,        word [a]
	; add     eax,        [c]
	; mov     [sum_ac],   eax         ; 4

	; movsx   eax,        word [a]
	; sub     eax,        [c]
	; mov     [diff_ac],  eax         ; -2

	; xor	eax, eax
	; ret
