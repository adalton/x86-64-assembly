;
; ex.s
;
; Example of 'call' and 'ret' instructions, pages 108-109
;
; The 'call' instruction is like performing the following operaitons:
;   push address_of_next_instruction
;   jmp target_function
;
; The 'ret' instruction is like:
;     pop address_of_next_instruction
;     jmp <next_instruction_address>
;

	segment .text
	global main

doit:
	mov	eax,	1
	ret

main:
	call	doit

	xor	eax,	eax
	ret


; Breakpoint 1, main () at ex.s:15
; 15              call doit
;
; This is the address of the 'call' instruction
; (gdb) p $rip
; $1 = (void (*)()) 0x400496 <main>
;
; (gdb) s
; doit () at ex.s:11
; 11              mov     eax,    1
;
; The address of the instruction following the 'call' instruction is pushed
; onto the stack.  Here, that's 0x40049b
; (gdb) x/5xg $rsp
; 0x7fffffffdbd0: 0x000000000040049b      0x00007ffff7a4b541
; 0x7fffffffdbe0: 0x00007fffffffdcb8      0x00007fffffffdcb8
; 0x7fffffffdbf0: 0x00000001f7ba1c08
;
; Once we return from the function, the return address is popped off the
; stack and placed in rip
; (gdb) s
; doit () at ex.s:12
; 12              ret
; (gdb) s
; main () at ex.s:17
; 17              xor     eax,    eax
; (gdb) p $rip
; $2 = (void (*)()) 0x40049b <main+5>
;
; (gdb) x/5xg $rsp
; 0x7fffffffdbd8: 0x00007ffff7a4b541      0x00007fffffffdcb8
; 0x7fffffffdbe8: 0x00007fffffffdcb8      0x00000001f7ba1c08
; 0x7fffffffdbf8: 0x0000000000400496
