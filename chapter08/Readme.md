# Exercises

1. Write an assembly program to compute the dot product of 2 arrays
   (i.e., `sum i=0:n-1 (a[i] * b[i])`).  Your arrays should be double word
   arrays in memory and the dot product should be stored in memory.

   ```asm
           segment .data
   
   N               db        5
   array1          dd        2, 4, 6, 8, 10
   array2          dd        3, 6, 9, 12, 15
   dp              dd        0
   
   ; dp = (2 * 3) + (4 * 6) + (6 * 9) + (8 * 12) + (10 * 15)
   ;    = 6 + 24 + 54 + 96 + 150
   ;    = 330
   
           segment .text
           global main
   ;
   ; Register usage:
   ;   eax: N    -- the number of elements in the array
   ;   ecx: i    -- loop control variable
   ;   edx: prod -- The product of array1[i] and array2[i]
   ;
   main:
           movzx      eax,        byte [N]                ; eax = N
           xor        ecx,        ecx                     ; i = 0
   
           ; Pre-check to skip loop all together if N == 0
           cmp        eax,        ecx
           jz         .end_loop                           ; if N is zero, bail out
   
   .begin_loop
           mov        edx,        [array1 + ecx * 4]      ; prod = array1[i]
           imul       edx,        [array2 + ecx * 4]      ; prod = prod * array2[i]
           add        [dp],       edx                     ; dp += prod
           inc        rcx                                 ; ++i
           cmp        eax,        ecx
           jnz        .begin_loop                         ; Keep looping

   .end_loop:
           xor        eax,        eax                     ; 0 return value from main
           ret

   ```

   ```none
   $ gdb ./ex
   Reading symbols from ./ex...
   (gdb) break main
   Breakpoint 1 at 0x401110: file ex.s, line 30.
   (gdb) run
   Starting program: .../ex 
   
   Breakpoint 1, main () at ex.s:30
   30              movzx   eax,    byte [N]                ; eax = N
   (gdb) stepi
   31              xor     ecx,    ecx                     ; i = 0
   (gdb) 
   34              cmp     eax,    ecx
   (gdb) 
   35              jz      .end_loop                       ; if N is zero, bail out
   (gdb) 
   main.begin_loop () at ex.s:38
   38              mov     edx,    [array1 + ecx * 4]      ; prod = array1[i]
   (gdb) 
   39              imul    edx,    [array2 + ecx * 4]      ; prod = prod * array2[i]
   (gdb) 
   40              add     [dp],   edx                     ; dp += prod
   (gdb) 
   41              inc     rcx                             ; ++i
   (gdb) 
   42              cmp     eax,    ecx
   (gdb) 
   43              jnz     .begin_loop                     ; Keep looping
   (gdb) 
   38              mov     edx,    [array1 + ecx * 4]      ; prod = array1[i]
   (gdb) 
   39              imul    edx,    [array2 + ecx * 4]      ; prod = prod * array2[i]
   (gdb) 
   40              add     [dp],   edx                     ; dp += prod
   (gdb) 
   41              inc     rcx                             ; ++i
   (gdb) 
   42              cmp     eax,    ecx
   (gdb) 
   43              jnz     .begin_loop                     ; Keep looping
   (gdb) 
   38              mov     edx,    [array1 + ecx * 4]      ; prod = array1[i]
   (gdb) 
   39              imul    edx,    [array2 + ecx * 4]      ; prod = prod * array2[i]
   (gdb) 
   40              add     [dp],   edx                     ; dp += prod
   (gdb) 
   41              inc     rcx                             ; ++i
   (gdb) 
   42              cmp     eax,    ecx
   (gdb) 
   43              jnz     .begin_loop                     ; Keep looping
   (gdb) 
   38              mov     edx,    [array1 + ecx * 4]      ; prod = array1[i]
   (gdb) 
   39              imul    edx,    [array2 + ecx * 4]      ; prod = prod * array2[i]
   (gdb) 
   40              add     [dp],   edx                     ; dp += prod
   (gdb) 
   41              inc     rcx                             ; ++i
   (gdb) 
   42              cmp     eax,    ecx
   (gdb) 
   43              jnz     .begin_loop                     ; Keep looping
   (gdb) 
   38              mov     edx,    [array1 + ecx * 4]      ; prod = array1[i]
   (gdb) 
   39              imul    edx,    [array2 + ecx * 4]      ; prod = prod * array2[i]
   (gdb) 
   40              add     [dp],   edx                     ; dp += prod
   (gdb) 
   41              inc     rcx                             ; ++i
   (gdb) 
   42              cmp     eax,    ecx
   (gdb) 
   43              jnz     .begin_loop                     ; Keep looping
   (gdb) 
   main.end_loop () at ex.s:49
   49              xor     eax,    eax                     ; 0 return value from main
   (gdb) x/d &dp
   0x404039:       330
   ```

2. Write an assembly program to compute Fibonacci numbers, storing all the
   computed Fibonacci numbers in a quad-word array in memory.

   Fibonacci numbers are defined by:
   ```none
       fib(0) = 0
       fib(1) = 1
       fib(i) = fib(i - 1) + fib(i - 2) for i > 1
   ```
   What is the largest `i` for which you can compute `fib(i)`?

   ```asm
           segment .bss
   fibs            resq        100                                       ; 100 quad-words initialize to 0
   
           segment .data
   N               db          2                                         ; elements in fibs[] (>= 2)
   
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
           mov        rcx,              qword [N]                        ; rcx = N
   
           ; Here, rbx is tmp.  We'll assume fibs has at least two elements
           mov        rbx,              1                        
           mov        [fibs + rbx * 8], rbx                              ; fibs[1] = 1
                                                                         ; (fibs[0] is already 0)
           cmp        rcx,              2
           jng        .end_loop                                          ; Bail out if (N - 2) <= 0
   
           ; From here down, rbx is loop control variable
           mov        rbx,              2                                ; i = 2

   .begin_loop
           mov        rax,              [fibs + (rbx - 1) * 8]           ; sum =  fibs[i - 1]
           add        rax,              [fibs + (rbx - 2) * 8]           ; sum += fibs[i - 2]
           jo         .end_loop                                          ; bail out on overflow
           mov        [fibs + rbx * 8], rax                              ; fibs[i] = sum
           inc        rbx                                                ; ++i
           cmp        rbx,              rcx
           jnz        .begin_loop                                        ; if i < N, keep looping
   
   .end_loop:
           xor        eax,              eax                              ; 0 return value from main
           ret
   ```

   ```none
   # Note: I massaged the output a bit here
   (gdb) x/100g &fibs
   0x404018:                         0                        1
   0x404028:                         1                        2
   0x404038:                         3                        5
   0x404048:                         8                       13
   0x404058:                        21                       34
   0x404068:                        55                       89
   0x404078:                       144                      233
   0x404088:                       377                      610
   0x404098:                       987                     1597
   0x4040a8:                      2584                     4181
   0x4040b8:                      6765                    10946
   0x4040c8:                     17711                    28657
   0x4040d8:                     46368                    75025
   0x4040e8:                    121393                   196418
   0x4040f8:                    317811                   514229
   0x404108:                    832040                  1346269
   0x404118:                   2178309                  3524578
   0x404128:                   5702887                  9227465
   0x404138:                  14930352                 24157817
   0x404148:                  39088169                 63245986
   0x404158:                 102334155                165580141
   0x404168:                 267914296                433494437
   0x404178:                 701408733               1134903170
   0x404188:                1836311903               2971215073
   0x404198:                4807526976               7778742049
   0x4041a8:               12586269025              20365011074
   0x4041b8:               32951280099              53316291173
   0x4041c8:               86267571272             139583862445
   0x4041d8:              225851433717             365435296162
   0x4041e8:              591286729879             956722026041
   0x4041f8:             1548008755920            2504730781961
   0x404208:             4052739537881            6557470319842
   0x404218:            10610209857723           17167680177565
   0x404228:            27777890035288           44945570212853
   0x404238:            72723460248141          117669030460994
   0x404248:           190392490709135          308061521170129
   0x404258:           498454011879264          806515533049393
   0x404268:          1304969544928657         2111485077978050
   0x404278:          3416454622906707         5527939700884757
   0x404288:          8944394323791464        14472334024676221
   0x404298:         23416728348467685        37889062373143906
   0x4042a8:         61305790721611591        99194853094755497
   0x4042b8:        160500643816367088       259695496911122585
   0x4042c8:        420196140727489673       679891637638612258
   0x4042d8:       1100087778366101931      1779979416004714189
   0x4042e8:       2880067194370816120      4660046610375530309
   0x4042f8:       7540113804746346429                        0
   0x404308:                         0                        0
   0x404318:                         0                        0
   0x404328:                         0                        0
   ```

   > What is the largest `i` for which you can compute `fib(i)`?

   I did a little massaging of the output format to make it look nice
   fibs is 100 elements big (0-99), so the last Fibonacci number we were
   able to successfully calculate was: `fib(92) = 7540113804746346429`.
   `fib(93)` caused overflow.

3. Write an assembly program to sort an array of double words using bubble
   sort. Bubble sort is defined as:

   ```c
       do {
           swapped = false;
           for (i = 0; i < n - 1; i++) {
               if (a[i] > a[i + 1]) {
                   swap a[i] and a[i + 1]
                   swapped = true;
               }
           }
       } while ( swapped );
   ```

   ```asm
           segment .data
   a               dd            11, 42, 62, 32, 51, 91, -93, 16, 53, 58, 15, 70, 13, 19, 25, 52
   N               db            16                             ; elements in a[] (>= 1)
   
           segment .text
           global main
   ;
   ; Register usage:
   ;     eax: a[i]     -- The ith value in a
   ;     edx: a[i + 1] -- The (i + 1)th value in a
   ;     rbx: swapped  -- 0 = false, 1 = true
   ;     rcx: i        -- loop control
   ;     r8:  N        -- number of elements in a
   ;     r9:  ONE      -- the constant 1
   ;
   main:
           movzx      r8,                  byte [N]
           sub        r8,                  1                    ; r8 = N - 1
           mov        r9,                  1                    ; r9 = 1
   
   .begin_do:                                                   ; do {
           xor        ebx,                 ebx                  ;     swapped = false
           xor        ecx,                 ecx                  ;     i = 0
   
   .begin_for:                                                  ;     for (...) {
           mov        eax,                 [a + rcx * 4]        ;         tmp = a[i]
           mov        edx,                 [a + (rcx + 1) * 4]  ;         tmp2 = a[i + 1]
   
           cmp        eax,                 edx                  ;         if (tmp > tmp2) {
           jle        .end_if
   
           mov        [a + rcx * 4],       edx                  ;             a[i] = tmp2
           mov        [a + (rcx + 1) * 4], eax                  ;             a[i + 1] = tmp
           mov        rbx,                 r9                   ;             swapped = true
   .end_if                                                      ;         }
   
           inc        rcx                                       ;         ++i
           cmp        rcx,                 r8
           jnz        .begin_for                                ;         Keep looping
   
   .end_for:                                                    ;     }
           cmp        r9,                  rbx
           jng        .begin_do                                 ; } while (swapped);

   .end_do:
           xor        eax,                 eax                  ; 0 return value from main
           ret
   ```

   ```none
   (gdb) x/16d &a
   0x404010:       -93     11      13      15
   0x404020:       16      19      25      32
   0x404030:       42      51      52      53
   0x404040:       58      62      70      91
   ```
