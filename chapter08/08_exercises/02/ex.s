;
; ex.s
;
; Exercise 2, page 105
;
; Write an assembly program to compute Fibonacci numbers storing all the
; computed Fibonacci numbers in a quad-word array in memory.  Fibonacci
; numbers are defined by:
;
;     fib(0) = 0
;     fib(1) = 1
;     fib(i) = fib(i - 1) + fib(i - 2) for i < 1
;
	segment	.bss
fibs	resq	100				; 100 quad-words initialize to 0

	segment .data
N	db	93				; elements in fibs[] (>= 2)

	segment .text
	global main
;
; Register usage:
;     rax: sum    -- sum of fibs(i) and fibs(i - 1)
;     rbx: tmp, i -- temp variable, then loop control
;     rcx: N      -- number of elements in fibs array
;
; Preconditions:
;     length of fibs >= 2 64-bit numbers
;
main:
	mov	rcx, qword [N]			; rcx = N

	; Here, rbx is tmp.  We'll assume fibs has at least two elements
	mov	rbx, 1			
	mov	[fibs + rbx * 8], rbx		; fibs[1] = 1
						; (fibs[0] is already 0)
	cmp	rcx, 2
	jng	.end_loop			; Bail out if (N - 2) <= 0

	; From here down, rbx is loop control variable
	mov	rbx, 2				; i = 2
.begin_loop
	mov	rax,	[fibs + (rbx - 1) * 8]	; sum =  fibs[i - 1]
	add	rax,	[fibs + (rbx - 2) * 8]	; sum += fibs[i - 2]
	jo	.end_loop			; bail out on overflow
	mov	[fibs + rbx * 8], rax		; fibs[i] = sum
	inc	rbx				; ++i
	cmp	rbx, rcx
	jnz	.begin_loop			; if i < N, keep looping
.end_loop:

;
; I did a little massaging of the output format to make it look nice
; fibs is 100 elements big (0-99), so the last Fibonacci number we were
; able to successfully calculate was: fib(92) = 7540113804746346429.
; fib(93) caused overflow
;
; (gdb) x/100g &fibs
; 0x601030:       0                       1
; 0x601040:       1                       2
; 0x601050:       3                       5
; 0x601060:       8                       13
; 0x601070:       21                      34
; 0x601080:       55                      89
; 0x601090:       144                     233
; 0x6010a0:       377                     610
; 0x6010b0:       987                     1597
; 0x6010c0:       2584                    4181
; 0x6010d0:       6765                    10946
; 0x6010e0:       17711                   28657
; 0x6010f0:       46368                   75025
; 0x601100:       121393                  196418
; 0x601110:       317811                  514229
; 0x601120:       832040                  1346269
; 0x601130:       2178309                 3524578
; 0x601140:       5702887                 9227465
; 0x601150:       14930352                24157817
; 0x601160:       39088169                63245986
; 0x601170:       102334155               165580141
; 0x601180:       267914296               433494437
; 0x601190:       701408733               1134903170
; 0x6011a0:       1836311903              2971215073
; 0x6011b0:       4807526976              7778742049
; 0x6011c0:       12586269025             20365011074
; 0x6011d0:       32951280099             53316291173
; 0x6011e0:       86267571272             139583862445
; 0x6011f0:       225851433717            365435296162
; 0x601200:       591286729879            956722026041
; 0x601210:       1548008755920           2504730781961
; 0x601220:       4052739537881           6557470319842
; 0x601230:       10610209857723          17167680177565
; 0x601240:       27777890035288          44945570212853
; 0x601250:       72723460248141          117669030460994
; 0x601260:       190392490709135         308061521170129
; 0x601270:       498454011879264         806515533049393
; 0x601280:       1304969544928657        2111485077978050
; 0x601290:       3416454622906707        5527939700884757
; 0x6012a0:       8944394323791464        14472334024676221
; 0x6012b0:       23416728348467685       37889062373143906
; 0x6012c0:       61305790721611591       99194853094755497
; 0x6012d0:       160500643816367088      259695496911122585
; 0x6012e0:       420196140727489673      679891637638612258
; 0x6012f0:       1100087778366101931     1779979416004714189
; 0x601300:       2880067194370816120     4660046610375530309
; 0x601310:       7540113804746346429     0
; 0x601320:       0                       0
; 0x601330:       0                       0
; 0x601340:       0                       0

	xor	eax,	eax			; rc = 0
	ret					; return rc
