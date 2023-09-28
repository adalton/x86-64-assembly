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

4. Write an assembly program to determine if a string stored in memory is a
   palindrome. A palindrome is a string which is the same after being
   reversed, like "refer". Use at least one repeat instruction.

   ```asm
           segment .data
   data            db        "amanaplanacanalpanama", 0
   
           segment .text
           global main
   ;
   ; Register usage:
   ;     ebx: i   -- index walking from (N - 1) backwards toward 0
   ;     ecx: pal -- 0 if string is not a palindrome, 1 otherwise
   ;     rsi: itr -- character pointer walking the string forward
   ;     al:  c   -- current character at *itr
   ;
   ; Repeat instruction: Load
   ;
   ; The 'lodsb' instruction moves the byte from the address specified by rsi to
   ; the 'al' register.
   ;
   main:
           xor        ebx,        ebx                        ; i = 0;
   
   ; -----------------------------------------------------------------------------
   ; -- Determine the length of data, length will be stored in ebx
   ; -- We could have used the 'scasb' instruction here (see page 103), but
   ; -- I didn't notice that until I had already written this :)
   ; -----------------------------------------------------------------------------
           ; lea = "load effective address"
           lea        rsi,            [data]                 ; itr = data; /* = &data[0] */

   .start_len_loop:
           lodsb                                             ; c = *itr; ++itr;
           cmp        al,             0                      ; if (c == '\0') {
           jz        .end_len_loop                           ;     goto end_len_loop;
                                                             ; }
           inc        ebx                                    ; ++i
           jmp        .start_len_loop
   
   ; -----------------------------------------------------------------------------
   ; -- Determine whether data is a palindrome, ecx will be 1 if yes, 0 if no
   ; -----------------------------------------------------------------------------
   .end_len_loop:
           xor        ecx,            ecx                    ; pal = false
           lea        rsi,            [data]                 ; itr = data; /* = &data[0] */
   
   .start_loop:
           sub        ebx,            1                      ; --i;
           jl        .is_palindrome                          ; if (i < 0) { goto is_palindrome; }
   
           lodsb                                             ; c = *itr; ++itr;
           cmp        al,             byte [data + ebx]      ; if (c != data[i])
           jnz        .not_palindrome                        ;     goto not_palindrome;
           jmp        .start_loop

   .is_palindrome:
           mov        ecx,            1                      ; pal = true;

   .not_palindrome:
   
           ; exit with status 1 is string is palindrome, 0 otherwise
           mov        eax,            ecx
           ret
   ```

   ```none
   $ ./ex   
   $ echo $?
   1
   ```

5. Write an assembly program to perform a "find and replace" operation on a
   string in memory. Your program should have an input array and and output
   array. Make your program replace every occurrence of "amazing" with
   "incredible".

   ```asm
           segment .rodata
   AMAZING                db        "amazing", 0
   INCREDIBLE             db        "incredible", 0
   AMAZING_LEN            db         7
   INCREDIBLE_LEN         db        10
   
   ; Note that I put some "XXXXX" characters after the first '\0' so that I can
   ; ensure that I don't copy bytes past the first '\0' to dest.
   DATA                   db        "This is an amazing program that copies amazing ", \
                                    "characters to amazing places and that is amazing", \
                                    0, "XXXXX", 0
   
           segment .bss
   dest                   resb      150        ; This must be big enough to hold the transformation
   
           segment .text
           global main
   ;
   ; Register usage:
   ;     rax:   i -- Index into src
   ;     rbx:   j -- index into dest
   ;     rcx:     -- AMAZING_LEN
   ;     rdx: tmp -- Temporary variable
   ;     rsi:     -- source index pointer for comparisons
   ;     rdi:     -- destination index pointer for comparisons
   ;
   ; My approach: Walk src character-by-character.  At each character, determine
   ; if that character starts the word "amazing".  If not, copy the character
   ; to dest and advance the index.  If so, copy the word "incredible" to dest
   ; and advance the index by the length of "incredible".
   ;
   ; Repeat instruction: Compare
   ;
   ; The 'cmpsb' instruction compares values of 2 arrays, pointed to by rsi and
   ; rdi.  Typically it is used with 'repe', which will continue to compare values
   ; until either the count in 'ecx' reaches 0 or two different values are located.
   ;
   ; Repeat instruction: Move
   ;
   ; The 'movsb' instruction moves 'rcx' number of bytes from the address specified
   ; by 'rsi' to the address specified by 'rdi'.
   ;
   main:
           xor        eax,        eax                      ; i = 0;
           xor        ebx,        ebx                      ; j = 0;
   
   .loop:
           ; Bail out if we've reach the terminator
           movzx      dx,           [DATA + eax]           ; tmp = src[i];
           cmp        dx,           0                      ; if (tmp == '\0')
           jz         .end_loop                            ;     goto end_loop;
   
           lea        rsi,          [DATA + eax]           ; rsi = DATA + i
           lea        rdi,          [AMAZING]              ; rdi = AMAZING
           movzx      rcx,          byte [AMAZING_LEN]     ; rcx = strlen(AMAZING)
   
           ; See if rsi points to the string "amazing"; compare until a difference
           ; is found or until rcx reaches 0.
           repe       cmpsb
           cmp        rcx,          0
           jz        .equal

   ;.not_equal: -- for readability
           mov        [dest + ebx], dx                     ; dest[j] = tmp;
           inc        eax                                  ; ++i
           inc        ebx                                  ; ++j
           jmp        .loop

   .equal:
           lea        rsi,          [INCREDIBLE]           ; rsi = INCREDIBLE
           lea        rdi,          [dest + ebx]           ; rdi = dest + j
           movzx      rcx,          byte [INCREDIBLE_LEN]  ; rcx = strlen(INCREDIBLE)
           rep        movsb                                ; copy INCREDIBLE to dest + i
   
           movzx      dx,           [AMAZING_LEN]          ; tmp = AMAZING_LEN;
           add        ax,           dx                     ; i += tmp;
   
           movzx      dx,           [INCREDIBLE_LEN]       ; tmp = INCREDIBLE_LEN;
           add        bx,           dx                     ; j += tmp;
           jmp        .loop

   .end_loop
           xor        eax,          eax                    ; return 0 from main
           ret
   ```

   ```none
   ; (gdb) printf "%s\n", &dest
   ; This is an incredible program that copies incredible characters to incredible places and that is incredible
   ;
   ; (gdb) x/110c &dest
   ; 0x60102c:       84 'T'  104 'h' 105 'i' 115 's' 32 ' '  105 'i' 115 's' 32 ' '
   ; 0x601034:       97 'a'  110 'n' 32 ' '  105 'i' 110 'n' 99 'c'  114 'r' 101 'e'
   ; 0x60103c:       100 'd' 105 'i' 98 'b'  108 'l' 101 'e' 32 ' '  112 'p' 114 'r'
   ; 0x601044:       111 'o' 103 'g' 114 'r' 97 'a'  109 'm' 32 ' '  116 't' 104 'h'
   ; 0x60104c:       97 'a'  116 't' 32 ' '  99 'c'  111 'o' 112 'p' 105 'i' 101 'e'
   ; 0x601054:       115 's' 32 ' '  105 'i' 110 'n' 99 'c'  114 'r' 101 'e' 100 'd'
   ; 0x60105c:       105 'i' 98 'b'  108 'l' 101 'e' 32 ' '  99 'c'  104 'h' 97 'a'
   ; 0x601064:       114 'r' 97 'a'  99 'c'  116 't' 101 'e' 114 'r' 115 's' 32 ' '
   ; 0x60106c:       116 't' 111 'o' 32 ' '  105 'i' 110 'n' 99 'c'  114 'r' 101 'e'
   ; 0x601074:       100 'd' 105 'i' 98 'b'  108 'l' 101 'e' 32 ' '  112 'p' 108 'l'
   ; 0x60107c:       97 'a'  99 'c'  101 'e' 115 's' 32 ' '  97 'a'  110 'n' 100 'd'
   ; 0x601084:       32 ' '  116 't' 104 'h' 97 'a'  116 't' 32 ' '  105 'i' 115 's'
   ; 0x60108c:       32 ' '  105 'i' 110 'n' 99 'c'  114 'r' 101 'e' 100 'd' 105 'i'
   ; 0x601094:       98 'b'  108 'l' 101 'e' 0 '\000'        0 '\000'        0 '\000'
   ```

6. A Pythagorean triple is a set of three integers `a`, `b`, and `c` such that
   a<sup>2</sup> + b<sup>2</sup> = c<sup>2</sup>. Write an assembly program
   to determine if an integer, `c` stored in memory has 2 smaller integers
   `a` and `b` making the 3 integers a Pythagorean triple. If so, then place
   `a` and `b` in memory.

   ```asm
           segment .rodata
   ;c              dq              2        ; DNE
   ;c              dq              5        ; (a=3,  b=4,   c=5)
   ;c              dq             13        ; (a=5,  b=12,  c=13)
   ;c              dq             61        ; (a=11, b=60,  c=61)
   ;c              dq            181        ; (a=19, b=180, c=181)
   ;c              dq            421        ; (a=29, b=420, c=421)
   ;c              dq           1741        ; (a=59, b=1740, c=1741)
   ;c              dq           1861        ; (a=61, b=1860, c=1861)
   ;c              dq           2521        ; (a=71, b=2520, c=2521)
   c               dq           3121        ; (a=79, b=3120, c=3121)
   
           segment .data
   a              dq            0
   b              dq            0
   
           segment .text
           global main
   ;
   ; C Program:
   ;
   ;     int c = 42;
   ;     int csquare = c * c;
   ;
   ;     int main(void) {
   ;         register int i;
   ;         for (i = 0; i < c; ++i) {
   ;             register int j;
   ;             for (j = i + 1; j < c; ++j) {
   ;                 if ((i * i + j * j) == csquare) {
   ;                     a = i;
   ;                     b = j;
   ;                     goto done;
   ;                 }
   ;             }
   ;         }
   ;     done:
   ;         return 0;
   ;     }
   ;
   ;
   ; Register usage:
   ;     rsi: i       -- loop control variable
   ;     rdi: j       -- loop control variable
   ;     rax: csquare -- the square of the variable c
   ;     rbx: tmp1    -- i^2, then the sum of i^2 and j^2
   ;     rcx: tmp2    -- j^2
   ;
   main:
           mov         rax,        [c]                        ; csquare = c;
           imul        rax,        rax                        ; csquare *= csquare;
   
           mov         rsi,        1                          ; i = 1;

   .begin_outer_for:
           mov         rdi,        rsi                        ; j = i;
           add         rdi,        1                          ; j += 1; /* j = i + 1 */

   .begin_inner_for:
           mov         rbx,        rsi
           imul        rbx,        rbx                        ; tmp1 = i * i;
   
           mov         rcx,        rdi
           imul        rcx,        rcx                        ; tmp2 = j * j;
   
           add         rbx,        rcx                        ; tmp1 += tmp2
           cmp         rax,        rbx                        ; if (csquare != tmp1)
           jnz         .not_found                             ;     goto not_found;

   ;.found:
           mov         [a],        rsi                        ; a = i;
           mov         [b],        rdi                        ; b = j;
           jmp         .end_outer_for                         ; goto end

   .not_found:
           inc         rdi                                    ; ++j;
           cmp         rdi,        [c]
           jle        .begin_inner_for

   .end_inner_for:
           inc        rsi                                     ; ++i;
           cmp        rsi,         [c]
           jle        .begin_outer_for

   .end_outer_for:
           xor        eax,         eax                        ; return 0 from main
           ret
   ```

   ```none
   (gdb) x &a
   0x404010:       79
   (gdb) x &b
   0x404018:       3120
   ```
