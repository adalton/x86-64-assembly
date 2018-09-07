;
; Exercise 1 (page 39)
;
; Write a data-only program like the one in this chapter to define an array of
; 10 8-byte integers in the data segment, an array of 5 2-byte integers in the
; bss segment, and a string terminate by 0 in the data segment.  Use gdb's
; examine command to print the 8-byte integers in hexadecimal, the 2-byte
; integers as unsigned values, and the string as a string.
;
; The 8-byte integers in hexadecimal:
;	(gdb) x/10gx &a
;	0x601028:       0x0000000000000001      0x0000000000000001
;	0x601038:       0x0000000000000001      0x0000000000000001
;	0x601048:       0x0000000000000001      0x0000000000000001
;	0x601058:       0x0000000000000001      0x0000000000000001
;	0x601068:       0x0000000000000001      0x0000000000000001
;
; The 5 2-byte integers as unsigned values
;
;	(gdb) x/5uh &b
;	0x60108c:       0       0       0       0       0
;
; The string as a string:
;	(gdb) x/s &string
;	0x601078:       "Hello, world!"

	segment .data
a		times 10 dq	1
string		db		"Hello, world!", 0

	segment .bss
b		resw	5

; I define main here just to simplify using my Makefile with this exercise
	segment .text
	global main
main:
	ret
