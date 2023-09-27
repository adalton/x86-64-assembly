# Exercises

1. Write an assembly program to count all the 1 bits in a byte stored in
   memory. Use repeated code rather than a loop.
   ```asm
           segment .data
   a               db        11001001b             ; byte with 1's to count
   
           segment .text
           global main
   ;
   ; ax = 1 counter
   ; cx = copy of variable a in a register
   ; bx = copy of cx against which we'll apply a bitmask
   ;
   main:
           push       rbp
           mov        rbp,       rsp
   
           xor        rax,       rax               ; Initialize rax to 0
           movzx      cx,        byte [a]          ; Copy a to cx (leave it here)
   
           ; Bit 0
           mov        bx,        cx                ; Copy a into bx
           and        bx,        1                 ; Test bit 0
           add        ax,        bx                ; Add bx to ax; if the bit was set,
                                                   ; we'll add 1, otherwise 0
           ; Bit 1
           mov        bx,        cx                ; Copy original a into bx
           shr        bx,        1                 ; Shift away the bit we counted above
           and        bx,        1                 ; Test bit 1
           add        ax,        bx                ; Add bx to ax; if the bit was set,
                                                   ; we'll add 1, otherwise 0
           ; Bit 2
           mov        bx,        cx                ; Copy original a into bx
           shr        bx,        2                 ; Shift away the bits we counted above
           and        bx,        1                 ; Test bit 2
           add        ax,        bx                ; Add bx to ax; if the bit was set,
                                                   ; we'll add 1, otherwise 0
           ; Bit 3
           mov        bx,        cx                ; Copy original a into bx
           shr        bx,        3                 ; Shift away the bits we counted above
           and        bx,        1                 ; Test bit 3
           add        ax,        bx                ; Add bx to ax; if the bit was set,
                                                   ; we'll add 1, otherwise 0
           ; Bit 4
           mov        bx,        cx                ; Copy original a into bx
           shr        bx,        4                 ; Shift away the bits we counted above
           and        bx,        1                 ; Test bit 4
           add        ax,        bx                ; Add bx to ax; if the bit was set,
                                                   ; we'll add 1, otherwise 0
           ; Bit 5
           mov        bx,        cx                ; Copy original a into bx
           shr        bx,        5                 ; Shift away the bits we counted above
           and        bx,        1                 ; Test bit 5
           add        ax,        bx                ; Add bx to ax; if the bit was set,
                                                   ; we'll add 1, otherwise 0
           ; Bit 6
           mov        bx,        cx                ; Copy original a into bx
           shr        bx,        6                 ; Shift away the bits we counted above
           and        bx,        1                 ; Test bit 6
           add        ax,        bx                ; Add bx to ax; if the bit was set,
                                                   ; we'll add 1, otherwise 0
           ; Bit 7
           mov        bx,        cx                ; Copy original a into bx
           shr        bx,        7                 ; Shift away the bits we counted above
           and        bx,        1                 ; Test bit 7
           add        ax,        bx                ; Add bx to ax; if the bit was set,
                                                   ; we'll add 1, otherwise 0
   
           ; Return the count in ax for easy testing
           leave
           ret
   ```

   ```none
   $ gdb ./ex
   (gdb) break main
   Breakpoint 1 at 0x401110: file ex.s, line 24.
   (gdb) run
   Starting program: .../ex 
   
   Breakpoint 1, main () at ex.s:24
   24              push    rbp
   (gdb) x/bt &a
   0x404010:       11001001
   (gdb) stepi
   25              mov     rbp,    rsp
   (gdb) 
   27              xor     rax,    rax             ; Initialize rax to 0
   (gdb) 
   28              movzx   cx,     byte [a]        ; Copy a to cx (leave it here)
   (gdb) 
   31              mov     bx,     cx              ; Copy a into bx
   (gdb) 
   32              and     bx,     1               ; Test bit 0
   (gdb) 
   33              add     ax,     bx              ; Add bx to ax; if the bit was set,
   (gdb) 
   36              mov     bx,     cx              ; Copy original a into bx
   (gdb) p $ax
   $1 = 1
   (gdb) stepi
   37              shr     bx,     1               ; Shift away the bit we counted above
   (gdb) 
   38              and     bx,     1               ; Test bit 1
   (gdb) 
   39              add     ax,     bx              ; Add bx to ax; if the bit was set,
   (gdb) 
   42              mov     bx,     cx              ; Copy original a into bx
   (gdb) p $ax
   $2 = 1
   (gdb) stepi
   43              shr     bx,     2               ; Shift away the bits we counted above
   (gdb) 
   44              and     bx,     1               ; Test bit 2
   (gdb) 
   45              add     ax,     bx              ; Add bx to ax; if the bit was set,
   (gdb) 
   48              mov     bx,     cx              ; Copy original a into bx
   (gdb) p $ax
   $3 = 1
   (gdb) stepi
   49              shr     bx,     3               ; Shift away the bits we counted above
   (gdb) 
   50              and     bx,     1               ; Test bit 3
   (gdb) 
   51              add     ax,     bx              ; Add bx to ax; if the bit was set,
   (gdb) 
   54              mov     bx,     cx              ; Copy original a into bx
   (gdb) p $ax
   $4 = 2
   (gdb) stepi
   55              shr     bx,     4               ; Shift away the bits we counted above
   (gdb) 
   56              and     bx,     1               ; Test bit 4
   (gdb) 
   57              add     ax,     bx              ; Add bx to ax; if the bit was set,
   (gdb) 
   60              mov     bx,     cx              ; Copy original a into bx
   (gdb) p $ax
   $5 = 2
   (gdb) stepi
   61              shr     bx,     5               ; Shift away the bits we counted above
   (gdb) 
   62              and     bx,     1               ; Test bit 5
   (gdb) 
   63              add     ax,     bx              ; Add bx to ax; if the bit was set,
   (gdb) 
   66              mov     bx,     cx              ; Copy original a into bx
   (gdb) p $ax
   $6 = 2
   (gdb) stepi
   67              shr     bx,     6               ; Shift away the bits we counted above
   (gdb) 
   68              and     bx,     1               ; Test bit 6
   (gdb) 
   69              add     ax,     bx              ; Add bx to ax; if the bit was set,
   (gdb) 
   72              mov     bx,     cx              ; Copy original a into bx
   (gdb) p $ax
   $7 = 3
   (gdb) stepi
   73              shr     bx,     7               ; Shift away the bits we counted above
   (gdb) 
   74              and     bx,     1               ; Test bit 7
   (gdb) 
   75              add     ax,     bx              ; Add bx to ax; if the bit was set,
   (gdb) 
   79              leave
   (gdb) p $ax
   $8 = 4
   ```

2. Write an assembly program to swap 2 quad-words in memory using `xor`.
   Use the following algorithm:
   ```c
       a = a ^ b;
       b = a ^ b;
       a = a ^ b;
   ```

   ```asm
           segment .data
   a               dq               42
   b               dq               17
   
           segment .text
           global main
   ;
   ; rax = a
   ; rbx = b
   ;
   ; Note that I could have solved this with one fewer register by using memory
   ; references in the xor instructions:
   ;
   ;       mov        rax,        [a]
   ;
   ;       xor        rax,        [b]
   ;       xor        [b],        rax
   ;       xor        rax,        [b]
   ;       mov        [a],        rax
   ;
   main:
           push       rbp
           mov        rbp,        rsp
   
           mov        rax,        [a]
           mov        rbx,        [b]
   
           xor        rax,        rbx              ; a = a ^ b
           xor        rbx,        rax              ; b = b ^ a (b ^ a = a ^ b)
           xor        rax,        rbx              ; a = a ^ b
   
           mov        [a],        rax
           mov        [b],        rbx
   
           xor        eax,        eax              ; 0 return value
           leave
           ret
   ```

   ```none
   $ gdb ./ex 
   (gdb) break main
   Breakpoint 1 at 0x401110: file ex.s, line 44.
   (gdb) run
   Starting program: .../ex 
   
   Breakpoint 1, main () at ex.s:44
   44              push    rbp
   (gdb) stepi
   45              mov     rbp,    rsp
   (gdb) 
   47              mov     rax,    [a]
   (gdb) 
   48              mov     rbx,    [b]
   (gdb) 
   50              xor     rax,    rbx             ; a = a ^ b
   (gdb) 
   51              xor     rbx,    rax             ; b = b ^ a (b ^ a = a ^ b)
   (gdb) 
   52              xor     rax,    rbx             ; a = a ^ b
   (gdb) 
   54              mov     [a],    rax
   (gdb) 
   55              mov     [b],    rbx
   (gdb) 
   57              xor     eax,    eax             ; return 0
   (gdb) x/d &a
   0x404010:       17
   (gdb) x/d &b
   0x404018:       42
   ```

3. Write an assembly program to use 3 quad-words in memory to represent 3 sets:
   `A`, `B`, and `C`. Each set will allow storing set values 0-63 in the
   corresponding bits of the quad-word. Perform these steps:
   ```none
       insert  0 into A
       insert  1 into A
       insert  7 into A
       insert 13 into A
       insert  1 into B
       insert  3 into B
       insert 12 into B
       store A union B into C
       store A intersect B into C
       store A symmetric-difference B into C
       remove 7 from C
   ```

   ```asm
           segment .data
   A               dq               0
   B               dq               0
   C               dq               0
   
           segment .text
           global main
   main:
           push       rbp
           mov        rbp,              rsp
   
           bts        qword [A],         0       ; insert  0 into A
           bts        qword [A],         1       ; insert  1 into A
           bts        qword [A],         7       ; insert  7 into A
           bts        qword [A],        13       ; insert 13 into A
           ; A = 0000000000000000000000000000000000000000000000000010000010000011
   
           bts        qword [B],         1       ; insert  1 into B
           bts        qword [B],         3       ; insert  3 into B
           bts        qword [B],        12       ; insert 12 into B
           ; B = 0000000000000000000000000000000000000000000000000001000000001010
   
           mov        rax,              [A]      ; Store (A union B) into C
           or         rax,              [B]
           mov        [C],              rax
           ; C = 0000000000000000000000000000000000000000000000000011000010001011
   
           mov        rax,              [A]      ; Store (A intersection B) into C
           and        rax,              [B]
           mov        [C],              rax
           ; C = 0000000000000000000000000000000000000000000000000000000000000010
           
           mov        rax,              [A]      ; Store (A symmetric-difference B) into C
           xor        rax,              [B]
           mov        [C],              rax
           ; C = 0000000000000000000000000000000000000000000000000011000010001001
   
           btr        qword [C],        7        ; Remove 7 from C
           ; C = 0000000000000000000000000000000000000000000000000011000000001001
   
           xor        eax,              eax      ; 0 return value
           leave
           ret
   ```

   ```none
   $ gdb ./ex
   (gdb) break main
   Breakpoint 1 at 0x401110: file ex.s, line 32.
   (gdb) run
   Starting program: .../ex 
   
   Breakpoint 1, main () at ex.s:32
   32              push    rbp
   (gdb) stepi
   33              mov     rbp,    rsp
   (gdb) 
   35              bts     qword [A],      0       ; insert  0 into A
   (gdb) 
   36              bts     qword [A],      1       ; insert  1 into A
   (gdb) 
   37              bts     qword [A],      7       ; insert  7 into A
   (gdb) 
   38              bts     qword [A],      13      ; insert 13 into A
   (gdb) 
   41              bts     qword [B],      1       ; insert  1 into B
   (gdb) x/tg &A
   0x404010:       0000000000000000000000000000000000000000000000000010000010000011
   (gdb) stepi
   42              bts     qword [B],      3       ; insert  3 into B
   (gdb) 
   43              bts     qword [B],      12      ; insert 12 into B
   (gdb) 
   46              mov     rax,            [A]     ; Store (A union B) into C
   (gdb) x/tg &B
   0x404018:       0000000000000000000000000000000000000000000000000001000000001010
   (gdb) stepi
   47              or      rax,            [B]
   (gdb) 
   48              mov     [C],            rax
   (gdb) 
   51              mov     rax,            [A]     ; Store (A intersection B) into C
   (gdb) x/tg &C
   0x404020:       0000000000000000000000000000000000000000000000000011000010001011
   (gdb) stepi
   52              and     rax,            [B]
   (gdb) 
   53              mov     [C],            rax
   (gdb) 
   56              mov     rax,            [A]     ; Store (A symmetric-difference B) into C
   (gdb) x/tg &C
   0x404020:       0000000000000000000000000000000000000000000000000000000000000010
   (gdb) stepi
   57              xor     rax,            [B]
   (gdb) 
   58              mov     [C],            rax
   (gdb) 
   61              btr     qword [C],      7       ; Remove 7 from C
   (gdb) x/tg &C
   0x404020:       0000000000000000000000000000000000000000000000000011000010001001
   (gdb) stepi
   64              xor     eax,            eax     ; 0 return value
   (gdb) x/tg &C
   0x404020:       0000000000000000000000000000000000000000000000000011000000001001
   ```

4. Write an assembly program to move a quad-word stored in memory into a
   register and then compute the exclusive-or of the 8 bytes of the word.
   Use either `ror` or `rol` to manipulate the bits of the register so that
   the original value is retained.

   ```asm
           segment .data
   a               dq        1000000001000000001000000001000000001000000001000000001000000001b
   
           segment .text
           global main
   main:
           push       rbp
           mov        rbp,       rsp
   
           xor        ebx,       ebx             ; ebx = 0
           mov        rax,       [a]             ; rax = a
   
           xor        bl,        al              ; byte 1
           ror        rax,       8
           xor        bl,        al              ; byte 2
           ror        rax,       8
           xor        bl,        al              ; byte 3
           ror        rax,       8
           xor        bl,        al              ; byte 4
           ror        rax,       8
           xor        bl,        al              ; byte 5
           ror        rax,       8
           xor        bl,        al              ; byte 6
           ror        rax,       8
           xor        bl,        al              ; byte 7
           ror        rax,       8
           xor        bl,        al              ; byte 8
           ror        rax,       8
   
   ; ebx = 11111111
   ; rax = a (original value of a)
   
           xor        eax,       eax             ; 0 return value
           leave
           ret
   ``` 

   ```none
   $ gdb ./ex
   (gdb) break main
   Breakpoint 1 at 0x401110: file ex.s, line 17.
   (gdb) run
   Starting program: .../ex 
   
   Breakpoint 1, main () at ex.s:17
   17              push    rbp
   (gdb) stepi
   18              mov     rbp,    rsp
   (gdb) 
   20              xor     ebx,    ebx             ; ebx = 0
   (gdb) 
   21              mov     rax,    [a]             ; rax = a
   (gdb) 
   23              xor     bl,     al              ; byte 1
   (gdb) 
   24              ror     rax,    8
   (gdb) 
   25              xor     bl,     al              ; byte 2
   (gdb) 
   26              ror     rax,    8
   (gdb) 
   27              xor     bl,     al              ; byte 3
   (gdb) 
   28              ror     rax,    8
   (gdb) 
   29              xor     bl,     al              ; byte 4
   (gdb) 
   30              ror     rax,    8
   (gdb) 
   31              xor     bl,     al              ; byte 5
   (gdb) 
   32              ror     rax,    8
   (gdb) 
   33              xor     bl,     al              ; byte 6
   (gdb) 
   34              ror     rax,    8
   (gdb) 
   35              xor     bl,     al              ; byte 7
   (gdb) 
   36              ror     rax,    8
   (gdb) 
   37              xor     bl,     al              ; byte 8
   (gdb) 
   38              ror     rax,    8
   (gdb) 
   43              xor     eax,    eax             ; return 0
   (gdb) p/t $rax
   $1 = 1000000001000000001000000001000000001000000001000000001000000001
   (gdb) x/tg &a
   0x404010:       1000000001000000001000000001000000001000000001000000001000000001
   (gdb) p/t $ebx
   $2 = 11111111
   ``` 

5. Write an assembly program to dissect a double stored in memory. This is a
   64-bit floating point value. Store the sign bit in one memory location.
   Store the exponent after subtracting the bais value into a second memory
   location. Store the fraction field with the implicit 1 bit at the front
   of the bit string into a third memory location.

   ```none
   I didn't do this one.
   ```

6. Write an assembly progrma to perform a product of 2 float values using
   integer arithmetic and bit operations. Start with 2 float values in memory
   and store the product in memory.

   ```none
   I didn't do this one.
   ```
