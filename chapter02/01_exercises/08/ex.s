;
; ex.s
;
; Exercise 8, page 26
;
; Write an assembly "program" (data only) defining data values using dw and
; dd for all numbers in Exercise 1-4.

	segment .data
a_dw            dw         1.375
b_dw            dw         0.041015625
c_dw            dw      -571.3125
d_dw            dw      4091.125

a_dd            dd         1.375
b_dd            dd         0.041015625
c_dd            dd      -571.3125
d_dd            dd      4091.125


	segment .text
	global main
main:
	push	rbp
	mov	rbp,	rsp

	xor	eax,	eax
	leave
	ret
