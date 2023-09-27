# Exercises

1. Write an assembly program to define 4 integers in the `.data` section.
   Give two of these integers positive values and 2 negative values.
   Define one of your positive numbers using hexadecimal notation.
   Write instructions to load the 4 integers into 4 different registers and
   add them with the sum being left in a register.  Use `gdb` or `ebe` to
   single-step through your program and inspect each register as it is
   modified.
   ```asm
           segment .data
   a               dq          1
   b               dq          0x42
   c               dq          -1
   d               dq          -0x42
   
           segment .text
           global main
   main:
           mov     r8,         [a]
           mov     r9,         [b]
           mov     r10,        [c]
           mov     r11,        [d]
   
           mov     rax,        r8
           add     rax,        r9
           add     rax,        r10
           add     rax,        r11
   
           xor     eax,        eax
           ret
   ```

   ```none
   $ gdb ./ex
   (gdb) break main
   Breakpoint 1 at 0x401110: file ex.s, line 24.
   (gdb) run
   Starting program: .../ex 
   
   Breakpoint 1, main () at ex.s:24
   24              mov     r8,     [a]
   (gdb) stepi
   25              mov     r9,     [b]
   (gdb) print $r8
   $1 = 1
   (gdb) stepi
   26              mov     r10,    [c]
   (gdb) p $r9
   $2 = 66
   (gdb) stepi
   27              mov     r11,    [d]
   (gdb) p $r10
   $3 = -1
   (gdb) stepi
   29              mov     rax,    r8
   (gdb) p $r11
   $4 = -66
   (gdb) stepi
   30              add     rax,    r9
   (gdb) p $rax
   $5 = 1
   (gdb) stepi
   31              add     rax,    r10
   (gdb) p $rax
   $6 = 67
   (gdb) stepi
   32              add     rax,    r11
   (gdb) p $rax
   $7 = 66
   (gdb) stepi
   34              xor     eax,    eax
   (gdb) p $rax
   $8 = 0
   ```

2. Write an assembly program to define 4 integers -- one each of length 1, 2,
   4, and 8 bytes. Load the 4 integers into 4 registers using sign extension
   for the shorter values.  Add the values and store the sum in a memory
   location.
   
   ```asm
           segment .data
   ; Note here the the initial values of these variables just happen to match
   ; the negation of the size of the variable.
   a               db          -1         ; 1 byte
   b               dw          -2         ; 2 bytes
   c               dd          -4         ; 4 bytes
   d               dq          -8         ; 8 bytes
   sum             dq           0
   
           segment .text
           global main
   main:
   ; movsx  = MOVe-Sign-eXtend
   ; movsxd = MOVe-Sign-eXtend-Doubleword
           movsx   r8,         byte  [a]
           movsx   r9,         word  [b]
           movsxd  r10,        dword [c]
           mov     r11,              [d]  ; Plain old move is sufficient for quad-word
   
           mov     rax,        r8
           add     rax,        r9
           add     rax,        r10
           add     rax,        r11
   
           mov     [sum],      rax
   
           xor     eax,        eax
           ret
   ```

   ```none
   $ gdb ./ex
   (gdb) break main
   Breakpoint 1 at 0x401110: file ex.s, line 23.
   (gdb) run
   Starting program: .../ex 
   
   Breakpoint 1, main () at ex.s:23
   23              movsx   r8,     byte  [a]
   (gdb) stepi
   24              movsx   r9,     word  [b]
   (gdb) p $r8
   $1 = -1
   (gdb) stepi
   25              movsxd  r10,    dword [c]
   (gdb) p $r9
   $2 = -2
   (gdb) stepi
   26              mov     r11,    [d]     ; Plain old move is sufficient for quad-word
   (gdb) p $r10
   $3 = -4
   (gdb) stepi
   28              mov     rax,    r8
   (gdb) p $r11
   $4 = -8
   (gdb) stepi
   29              add     rax,    r9
   (gdb) p $rax
   $5 = -1
   (gdb) stepi
   30              add     rax,    r10
   (gdb) p $rax
   $6 = -3
   (gdb) stepi
   31              add     rax,    r11
   (gdb) p $rax
   $7 = -7
   (gdb) stepi
   33              mov     [sum],  rax
   (gdb) p $rax
   $8 = -15
   (gdb) stepi
   35              xor     eax,    eax
   (gdb) x/qx &sum
   0x40401f:       0xfffffff1
   ```

3. Write an assembly program to define 3 integers of 2 bytes each. Name these
   `a`, `b`, and `c`. Compute and save into 4 memory locations `a + b`, `a - b`,
   `a + c`, and `a - c`.

   ```asm
           segment .data
   a               dw          1          ; 2 bytes
   b               dw          2          ; 2 bytes
   c               dw          3          ; 2 bytes
   sum_ab          dw          0
   diff_ab         dw          0
   sum_ac          dw          0
   diff_ac         dw          0
   
           segment .text
           global main
   main:
   ; Note: using ax instead of rax to operate on 2 byte values instead of 8
           mov     ax,         [a]
           add     ax,         [b]
           mov     [sum_ab],   ax         ; 3
   
           mov     ax,         [a]
           sub     ax,         [b]
           mov     [diff_ab],  ax         ; -1
   
           mov     ax,         [a]
           add     ax,         [c]
           mov     [sum_ac],   ax         ; 4
   
           mov     ax,         [a]
           sub     ax,         [c]
           mov     [diff_ac],  ax         ; -2
   
           xor     eax,        eax
           ret
   ```

   ```none
   $ gdb ./ex
   (gdb) break main
   Breakpoint 1 at 0x401110: file ex.s, line 29.
   (gdb) run
   Starting program: .../ex 
   
   Breakpoint 1, main () at ex.s:29
   29              mov     ax,             [a]
   (gdb) stepi
   30              add     ax,             [b]
   (gdb) p $ax
   $1 = 1
   (gdb) stepi
   31              mov     [sum_ab],       ax              ; 3
   (gdb) p $ax
   $2 = 3
   (gdb) stepi
   33              mov     ax,             [a]
   (gdb) x/d &sum_ab
   0x404016:       3
   (gdb) stepi
   34              sub     ax,             [b]
   (gdb) p $ax
   $3 = 1
   (gdb) stepi
   35              mov     [diff_ab],      ax              ; -1
   (gdb) p $ax
   $4 = -1
   (gdb) stepi
   37              mov     ax,             [a]
   (gdb) x/d &diff_ab
   0x404018:       65535
   (gdb) stepi
   38              add     ax,             [c]
   (gdb) p $ax
   $5 = 1
   (gdb) stepi
   39              mov     [sum_ac],       ax              ; 4
   (gdb) p $ax
   $6 = 4
   (gdb) stepi
   41              mov     ax,             [a]
   (gdb) x/d &sum_ac
   0x40401a:       4
   (gdb) stepi
   42              sub     ax,             [c]
   (gdb) p $ax
   $7 = 1
   (gdb) stepi
   43              mov     [diff_ac],      ax              ; -2
   (gdb) p $ax
   $8 = -2
   (gdb) stepi
   45              xor     eax,            eax
   (gdb) x/d &diff_ac
   0x40401c:       65534
   ```
