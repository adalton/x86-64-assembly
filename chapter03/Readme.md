# Exercises

1. Write a data-only program like the one in this chapter to define an array
   of 10 8-byte integers in the data section, an array of 5 2-byte integers
   in the `bss` section, and a string terminated by 0 in the `data` section.
   Use `gdb`'s `examine` command to print the 8-byte integers in hexadecimal,
   the 2-byte integers as unsigned values, and the string as a string.

   ```asm
; Yasm understands the following instructions:
;
;	db - byte (1 byte)
;	dw - word (2 bytes)
;	dd - double word (4 bytes)
;	dq - quad-word (8 bytes)
;
	segment .data
array1		times	10 dq 0			; 10 quad word (8-byte) integers
string		db	"hello, world", 0	; a string terminated by 0

; Yasm understands the following instructions:
;
;	resb - Reserve byte (1 byte)
;	resw - Reserve word (2 bytes)
;	resd - Reserve double word (4 bytes)
;	resq - Reserve quad word (8 bytes)

	segment .bss
array2		resw	5 			; 5 double word (2-byte) integers

	segment .text
	global main 
main:
	push	rbp				; set up a stack frame
	mov		rbp,	rsp		; rbp points to stack frame
	mov		rax,	0		; return value from main
	leave					; undo stack frame changes
	ret
   ```

   > Use `gdb`'s `examine` command to print the 8-byte integers in hexadecimal
   ```none
   (gdb) x/10gx &array1
   0x4010: 0x0000000000000000      0x0000000000000000
   0x4020: 0x0000000000000000      0x0000000000000000
   0x4030: 0x0000000000000000      0x0000000000000000
   0x4040: 0x0000000000000000      0x0000000000000000
   0x4050: 0x0000000000000000      0x0000000000000000
   ```

   > Use `gdb`'s `examine` command to print the 2-byte integers as unsigned values
   ```none
   (gdb) x/5hu &array2
   0x4074: 0       0       0       0       0
   ```

   > Use `gdb`'s `examine` command to print the string as a string.
   ```none
   (gdb) x/s &string
   0x4060: "hello, world"
   ```

2. Assuming that the stack size limit is 16MB, about how large can you declare
   an array of `double`s inside a C++ function. Do not use the keyword
   `static`.

3. Find out the stack size limit using the `ulimit` command in `bash`. If
   `bash` is not your shell, simply type in `bash` to start a sub-shell.

4. Print the value of `rsp` in `gdb`. How many bits are required to store
   this value?
