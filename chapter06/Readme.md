# Exercises

1. Write an assembly language program to compute the distance squared between
   2 points in the plane identified by 2 integer coordinates each, stored
   in memory.  Remember the Pythagoran Theorem!

   ```asm
           segment .data
   x1              dq           5
   y1              dq           7
   x2              dq          14
   y2              dq           8
   dist            dq           0
   
           segment .text
           global main
   main:
   ; d^2 = (x2 - x1)^2 + (y2 - y1)^2
   ;     = (14 -  5)^2 + (8  -  7)^2
   ;     = 9^2         + 1^2
   ;     = 81          + 1
   ;     = 82

           ; rax = (x2 - x1)^2
           mov        rax,        [x2]
           sub        rax,        [x1]
           imul       rax,        rax
   
           ; rbx = (y2 - y1)^2
           mov        rbx,        [y2]
           sub        rbx,        [y1]
           imul       rbx,        rbx
   
           add        rax,        rbx
           mov        [dist],     rax
   
           xor        eax,        eax        ; return value from main
           ret
   ```

   ```none
   $ gdb ./ex 
   (gdb) break main
   Breakpoint 1 at 0x401110: file ex.s, line 31.
   (gdb) run
   Starting program: .../ex 
   
   Breakpoint 1, main () at ex.s:31
   31              mov     rax,    [x2]
   (gdb) stepi
   32              sub     rax,    [x1]
   (gdb) p $rax
   $1 = 14
   (gdb) stepi
   33              imul    rax,    rax
   (gdb) p $rax
   $2 = 9
   (gdb) stepi
   36              mov     rbx,    [y2]
   (gdb) p $rax
   $3 = 81
   (gdb) stepi
   37              sub     rbx,    [y1]
   (gdb) p $rbx
   $4 = 8
   (gdb) stepi
   38              imul    rbx,    rbx
   (gdb) p $rbx
   $5 = 1
   (gdb) stepi
   40              add     rax,    rbx
   (gdb) p $rbx
   $6 = 1
   (gdb) stepi
   41              mov     [dist], rax
   (gdb) p $rax
   $7 = 82
   (gdb) stepi
   43              xor     eax,    eax     ; return value from main
   (gdb) x/d &dist
   0x404030:       82
   ```

2. If we could do floating point division, this exericse would have you
   compute the slope of the line segment connecting 2 points.  Instead you
   are to store the difference in x coordinates in 1 memory location and
   the difference in y coordinates in another. The input points are
   integers stored in memory. Leave register `rax` with the value 1 if the
   line segment is vertical (infinite or undefined slope) and 0 if it is not.
   You should use a conditional move to set the value of `rax`.

   ```none
   ; m = (y2 - y1) / (x2 - x1)
   ;
   ; With (5, 7) and (14, 8):
   ;     m = (8 - 7) / (14 - 5)
   ;       = 1 / 9
   ;       => not infinite/undefined slope, so rax should be 0
   ;
   ;   $ ./ex
   ;   $ echo $?
   ;   0
   ;   $
   ;
   ; With (5, 7) and (5, 7):
   ;     m = (5 - 5) / (7 - 7)
   ;       = 0 / 0
   ;       => infinite/undefined slope, rax should be 1
   ;
   ;   $ ./ex
   ;   $ echo $?
   ;   1
   ;   $
   
           segment .data
   x1              dq          5
   y1              dq          7
   x2              dq          5 ;14
   y2              dq          7 ;8
   num             dq          0
   den             dq          0
   one             dq          1
   
           segment .text
           global main
   main:
           ; rax = (y2 - y1)
           mov        rax,        [y2]
           sub        rax,        [y1]
           mov        [num],      rax
           xor        rax,        rax        ; zero out rax
   
           ; rbx = (x2 - x1)
           mov        rbx,        [x2]
           sub        rbx,        [x1]
           cmovz      rax,        [one]      ; make rax 1 iff rbx is zero
           mov        [den],      rbx
   
           ; let main return the 0/1
           ; xor        eax,        eax      ; return 0/1 from main, make it easy to test
           ret
   ```

   ```none
   $ gdb ./ex
   (gdb) break main
   Breakpoint 1 at 0x401110: file ex.s, line 49.
   (gdb) run
   Starting program: .../ex 
   
   Breakpoint 1, main () at ex.s:49
   49              mov     rax,    [y2]
   (gdb) stepi
   50              sub     rax,    [y1]
   (gdb) p $rax
   $1 = 7
   (gdb) stepi
   51              mov     [num],  rax
   (gdb) p $rax
   $2 = 0
   (gdb) stepi
   52              xor     rax,    rax     ; zero out rax
   (gdb) x/d &num
   0x404030:       0
   (gdb) stepi
   55              mov     rbx,    [x2]
   (gdb) p $rax
   $3 = 0
   (gdb) stepi
   56              sub     rbx,    [x1]
   (gdb) p $rbx
   $4 = 5
   (gdb) stepi
   57              cmovz   rax,    [one]   ; make rax 1 iff rbx is zero
   (gdb) p $rbx
   $5 = 0
   (gdb) stepi
   58              mov     [den],  rbx
   (gdb) p $rax
   $6 = 1
   (gdb) stepi
   62              ret
   (gdb) x/d &den
   0x404038:       0
   ```

3. Write an assembly language program to compute the average of 4 grades.
   Use memory locations for the 4 grades. Make the grades all different
   numbers from 0 to 100. Store the average of the 4 grades in memory and
   also store the remainder from the division in memory.

   ```asm
           segment .data
   ; I'd like to make the grades an array, but I don't yet know how to correctly
   ; use arrays.  For now, we'll make it 4 individual variables
   g1              dq          100
   g2              dq           87
   g3              dq           92
   g4              dq           76
   avg             dq            0
   rem             dq            0
   
           segment .text
           global main
   main:
           mov        rax,        [g1]
           add        rax,        [g2]
           add        rax,        [g3]
           add        rax,        [g4]
   
           xor        rdx,        rdx
           mov        rbx,        4
           idiv       rbx                    ; Could also do: idiv qword [four]
   
           ; quotient is in rax, remainder is in rdx
           mov        [avg],      rax
           mov        [rem],      rdx
   
           xor        eax,        eax        ; return 0/1 from main, make it easy to test
           ret
   ```

   ```none
   $ gdb ./ex 
   (gdb) break main
   Breakpoint 1 at 0x401110: file ex.s, line 34.
   (gdb) run
   Starting program: .../ex 
   
   Breakpoint 1, main () at ex.s:34
   34              mov     rax,    [g1]
   (gdb) stepi
   35              add     rax,    [g2]
   (gdb) p $rax
   $1 = 100
   (gdb) stepi
   36              add     rax,    [g3]
   (gdb) p $rax
   $2 = 187
   (gdb) stepi
   37              add     rax,    [g4]
   (gdb) p $rax
   $3 = 279
   (gdb) stepi
   39              xor     rdx,    rdx
   (gdb) p $rax
   $4 = 355
   (gdb) stepi
   40              mov     rbx,    4
   (gdb) p $rdx
   $5 = 0
   (gdb) stepi
   41              idiv    rbx             ; Could also do: idiv qword [four]
   (gdb) p $rbx
   $6 = 4
   (gdb) stepi
   44              mov     [avg],  rax
   (gdb) p $rax
   $7 = 88
   (gdb) p $rdx
   $8 = 3
   (gdb) stepi
   45              mov     [rem],  rdx
   (gdb) x/d &avg
   0x404030:       88
   (gdb) stepi
   47              xor     eax,    eax     ; return 0/1 from main, make it easy to test
   (gdb) x/d &rem
   0x404038:       3
   ```
