# Exercises

1. Write an assembly program to produce a billing report for an electric
   company. It should read a series of customer records using `scanf` and
   print one output line per customer giving the customer details and the
   amount of the bill. The customer data will consist of a name (up to 64
   characters not including the terminal 0) and a number of kilowatt
   hours per customer. The number of kilowatt hours is an integer. The
   cost for a customer will be $20.00 if the number of kilowatt hours is
   less than or equal to 1000 or $20.00 plus 1 cent per kilowatt hour over
   1000 if the usage is greater than 1000. Use quotient and remainder
   after dividing by 100 to print the amounts as normal dollars and cents.
   Write and use a function to compute the bill amount (in pennies).

   ```asm
   ; struct CustomerRecord {
   ;     char name[65]; /* 64 + 1 for '\0' */
   ;     long kwHours;
   ; };

   custRecName            equ           0        ; offsetof(struct CustomerRecord, name)
   custRecKw              equ          65        ; offsetof(struct CustomerRecord, kwHours)
   custRecSize            equ          73        ; sizeof(CustomerRecord) /* 65 + 8 = 73 bytes */
   maxRecords             equ           5        ; Array length
   penniesPerDollar       equ         100        ; Number of pennies in $1.00
   baseBillPennies        equ        2000        ; Base cost
   baseThresholdHrs       equ        1000        ; Max base cost threshold
   
   ;==============================================================================
           segment .rodata
   ;==============================================================================
   namePrompt             db         "Enter customer's name: ", 0
   kwPrompt               db         "Enter kilowatt hours:  ", 0
   nameScan               db         "%s", 0
   kwScan                 db         "%ld", 0
   printBill              db         "Customer %s owes $%ld.%02ld", 0xa, 0 ; 0xa = '\n'
   
   ;==============================================================================
           segment .bss
   ;==============================================================================
   recs                   resb       (maxRecords * custRecSize)  ; array of customer records
   
   ;==============================================================================
           segment .text
   ;==============================================================================
           extern printf
           extern scanf
   
           global main
   main:
           push        rbp
           mov         rbp,         rsp
   
           call        readRecords
           cmp         rax,         0
           jz         .done                        ; Zero customers read
   
           mov         rdi,         rax
           call        printRecords
   
   .done
           xor         eax,         eax
           leave
           ret
   
   ;
   ; void printRecords(long numRecords);
   ;
   ; Calculates the amount owed by each customer and prints it.
   ; Precondition: numRecords > 0
   ;
   ; rbx = curr
   ; r12 = i
   ; r13 = penniesPerDollar
   ;
   printRecords:
   .numRecords         equ          0              ; long numRecords;
   
           push        rbp
           mov         rbp,         rsp
           push        rbx                        ; Save callee-saved register
           push        r12                        ; Save callee-saved register
           push        r13                        ; Save callee-saved register
           sub         rsp,         8             ; Allocate room for numRecords on stack
                                                  ; keeping stack 16-byte aligned
   
           mov         [rsp + .numRecords], rdi   ; Save numRecords on the stack
   
           mov         r12,         0             ; i = 0;

           ; Start curr off so that we can increment it first thing
           lea         rbx,         [recs - custRecSize]  ; rbx = &recs[-1]
   
   .begin:
           add         rbx,         custRecSize           ; curr = next entry
   
           mov         rdi,         [rbx + custRecKw]
           call        computeBill
   
           ; rax contains the return value of computeBill
           ; rax:rdx contains the dividend, zero rdx
           xor         edx,         edx
   
           mov         r13,         penniesPerDollar
           idiv        qword r13
   
           ; quotient is in rax, remainder is in rdx
   
           lea         rdi,         [printBill]
           lea         rsi,         [rbx + custRecName]
           mov         rcx,         rdx
           mov         rdx,         rax
           xor         eax,         eax
           call        printf
   
           inc         r12
           cmp         r12,         [rsp + .numRecords]
           jl          .begin
   
           add         rsp,         8
           pop         r13                        ; Restore callee-saved register
           pop         r12                        ; Restore callee-saved register
           pop         rbx                        ; Restore callee-saved register
           leave
           ret
   
   ;
   ; long computeBill(long kwHours)
   ;
   ; The cost for a customer will be $20.00 if the number of kilowatt hours is
   ; less than or equal to 1000 or $20.00 plus 1 cent per kilowatt hour over
   ; 1000 if the usage is greater than 1000.
   ;
   computeBill:
           push        rbp
           mov         rbp,         rsp
   
   
           mov         rax,         baseBillPennies             ; ret = $20.00
           cmp         rdi,         baseThresholdHrs
           jle         .done
   
           ; $20.00 + 1 cent per kilowatt hour over 1000
           sub         rdi,         baseThresholdHrs
           add         rax,         rdi
   
   .done
           leave
           ret
   
   ;
   ; long readRecords();
   ;
   ; Reads customer records into 'recs' and returns the number of records stored.
   ;
   ; Register usage:
   ;  rbx = curr
   ;  r12 = i
   ;
   readRecords:
           push        rbp
           mov         rbp,         rsp
           push        rbx                        ; Save callee-saved register
           push        r12                        ; Save callee-saved register
   
           ;----------------------------------------------------------------------
           ; Start i and curr at -1 offsets so that we can increment them
           ; first thing in the loop
           ;----------------------------------------------------------------------
           mov         r12,         -1                        ; i = -1
           lea         rbx,         [recs - custRecSize]      ; curr = &recs[-1]
   
   .begin_loop:
           ; -- Advance current --------------------------------------------------
           add         rbx,         custRecSize       ; curr = next entry
           inc         r12
   
           cmp         r12,         maxRecords        ; Don't run off the end of the array
           jz         .done
   
           ; -- Read name --------------------------------------------------------
           lea         rdi,         [namePrompt]
           xor         eax,         eax               ; No floating point operands to printf
           call        printf
   
           lea         rdi,         [nameScan]
           lea         rsi,         [rbx + custRecName]
           xor         eax,         eax               ; No floating point operands to scanf
           call        scanf
   
           ; -- Read kilowatts ---------------------------------------------------
           lea         rdi,         [kwPrompt]
           xor         eax,         eax               ; No floating point operands to printf
           call        printf
   
           lea         rdi,         [kwScan]
           lea         rsi,         [rbx + custRecKw]
           xor         eax,         eax               ; No floating point operands to scanf
           call        scanf
   
           ; -- if curr->custRecKw != 0, continue looping ------------------------
           mov         rax,         [rbx + custRecKw]
           cmp         rax,         0
           jnz        .begin_loop
   
   .done:
           mov         rax,         r12
   
           pop         r12                            ; Restore callee-saved register
           pop         rbx                            ; Restore callee-saved register
           leave
           ret
   ```

   ```none
   $ ./ex
   Enter customer's name: Bob
   Enter kilowatt hours:  1843
   Enter customer's name: Sam
   Enter kilowatt hours:  3183 
   Enter customer's name: Nancy
   Enter kilowatt hours:  98815 
   Enter customer's name: Mike
   Enter kilowatt hours:  100000
   Enter customer's name: Sally
   Enter kilowatt hours:  104385
   Customer Bob owes $28.43
   Customer Sam owes $41.83
   Customer Nancy owes $998.15
   Customer Mike owes $1010.00
   Customer Sally owes $1053.85
   ```

2. Write an assembly program to generate an array of random integers (by
   calling the C library function `random`), to sort the array using a
   bubble sort function and to print the array. The array should be stored
   in the `.bss` segment and does not need to be dynamically allocated.
   The number of elements to fill, sort, and print should be stored in a
   memory location. Write a function to loop through the array elements
   filling the array with random integers. Write a function to print the
   array contents. If the array size is less than or equal to 20, call your
   print function before and after sorting.

   ```asm
   ; Note that I tweaked the print function to take the max number of elements
   ; as a parameter so that I didn't have to repeat the logic to check for
   ; NUM_ELEMENTS > MAX_PRINT_SIZE.
   
   NUM_ELEMENTS          equ        20      ; Number of elements in the array
   ELEMENT_SIZE          equ         8      ; Size of each element
   MAX_PRINT_SIZE        equ        20      ; Maximum number of elements to print
   
   ;==============================================================================
           segment .rodata
   ;==============================================================================
   numElements           dq         NUM_ELEMENTS
   printNumberFormat     db         "%ld ", 0x0
   printNewlineFormat    db         0xa, 0x0
   
   ;==============================================================================
           segment .bss
   ;==============================================================================
   elements              resq       NUM_ELEMENTS  ; array of elements
   
   ;==============================================================================
           segment .text
   ;==============================================================================
           extern random
           extern srandom
           extern printf
   
           global main
   main:
           push        rbp
           mov         rbp,         rsp
   
           ; Seed random number generator with a random number
           rdrand      rdi
           call        srandom

           call        fillArrayRandom
   
           mov         rdi,         MAX_PRINT_SIZE
           call        printArray
   
           call        bubbleSort
   
           mov         rdi,         MAX_PRINT_SIZE
           call        printArray
   
           xor         eax,         eax
           leave
           ret
   
   ;
   ; void bubbleSort(void);
   ;
   ; Sort NUM_ELEMENTS in array at 'elements'
   ;
   ; Register usage:
   ;     rsi = array[i - 2]
   ;     rdi = array[i - 1]
   ;     r12 = i
   ;     r13 = anyElementsSwapped
   ;     r14 = numSwapsThisPass
   ;
   bubbleSort:
           push        rbp
           mov         rbp,         rsp
           push        r12
           push        r13
           push        r14
   
   .begin_pass_loop:
           xor         r14,         r14        ; numSwapsThisPass = 0
   
           lea         rsi,         [elements - ELEMENT_SIZE]
           lea         rdi,         [elements]
           mov         r12,         1
   
   .begin_swap_loop:
           inc         r12
           add         rsi,         ELEMENT_SIZE
           add         rdi,         ELEMENT_SIZE
   
           call        swapIfLarger
           add         r14,         rax
   
           cmp         r12,         NUM_ELEMENTS
           jnz        .begin_swap_loop
   
           cmp         r14,         0
           jg         .begin_pass_loop
           
           xor         eax,         eax
           pop         r14
           pop         r13
           pop         r12
           leave
           ret
   
   ;
   ; long swapIfLarger(long* a, long* b)
   ;
   ; Returns 0 if no swap, 1 is swapped
   ;
   ; Register usage:
   ;     r12 - *a
   ;     r13 = *b
   ;
   swapIfLarger:
           push        rbp
           mov         rbp,         rsp
           push        r12
           push        r13
   
           xor         eax,         eax
   
           mov         r12,         [rdi]        ; r12 = *rdi;
           mov         r13,         [rsi]        ; r13 = *rsi;
   
           cmp         r12,         r13
           jg         .done
   
           mov         qword [rdi], r13          ; *rdi = r13
           mov         qword [rsi], r12          ; *rsi = r12
   
           mov         rax,         1            ; will return 1 to indicate swap was performed
   
   .done
           pop         r13
           pop         r12
           leave
           ret
   
   ;
   ; void printArray(long maxSize);
   ;
   ; Print all elements in array 'elements'
   ;
   ; Preconditions: NUM_ELEMENTS > 0
   ;
   ; Register usage:
   ;     rbx = array[i]
   ;     r12 = i
   printArray:
           push        rbp
           mov         rbp,         rsp
           push        rbx
           push        r12
   
           cmp         rdi,         NUM_ELEMENTS
           jl         .done
   
           lea         rbx,         [elements]         ; rbx = array
           xor         r12,         r12                ; i = 0;
   
   .begin_loop:
           lea         rdi,         [printNumberFormat]
           mov         rsi,         [rbx]
           xor         eax,         eax
           call        printf
   
           add         rbx,         ELEMENT_SIZE
           inc         r12
           cmp         r12,         [numElements]
           jnz         .begin_loop
   
           lea         rdi,         [printNewlineFormat]
           xor         eax,         eax
           call        printf
   
   .done:
           xor         eax,         eax
           pop         r12
           pop         rbx
           leave
           ret
   
   ;
   ; void fillArrayRandom(void);
   ;
   ; Fill array 'elements' with random numbers
   ;
   ; Preconditions: NUM_ELEMENTS > 0
   ;
   ; Register usage:
   ;     rbx = array[i]
   ;     r12 = i
   ;
   fillArrayRandom:
           push        rbp
           mov         rbp,         rsp
           push        rbx
           push        r12
   
           lea         rbx,         [elements]        ; rbx = array
           xor         r12,         r12               ; i = 0;
   
   .begin_loop:
           call        random
           mov         qword [rbx], rax
   
           add         rbx,         ELEMENT_SIZE
           inc         r12
           cmp         r12,         [numElements]
           jnz        .begin_loop
   
           xor         eax,         eax
           pop         r12
           pop         rbx
           leave
           ret
   ```

   ```none
   $ ./ex 
   1709660540 1586825103 1982198883 669761537 2083338410 954104676 1655272428 1693831333 1627066843 1854843413 622872129 422586540 1302314433 1507759766 1175135082 36026923 1197766968 353410644 2119533890 1890890775 
   36026923 353410644 422586540 622872129 669761537 954104676 1175135082 1197766968 1302314433 1507759766 1586825103 1627066843 1655272428 1693831333 1709660540 1854843413 1890890775 1982198883 2083338410 2119533890 
   
   $ ./ex 
   1633548261 168011780 1999672145 1087307159 3700492 1250453379 1019383971 1234308604 1678456654 940252344 1281766824 1444413956 1238345346 208791763 1952827705 1809091990 723053415 1463322326 1119744819 202453681 
   3700492 168011780 202453681 208791763 723053415 940252344 1019383971 1087307159 1119744819 1234308604 1238345346 1250453379 1281766824 1444413956 1463322326 1633548261 1678456654 1809091990 1952827705 1999672145 
   ```

3. A Pythagorean triple is a set of three integers `a`, `b`, and `c`, such that
   a<sup>2</sup> + b<sup>2</sup> = c<sup>2</sup>. Write an assembly program
   to print all the Pythagorean triples where c <= 500. Use a function to test
   whether a number is a Pythagorean triple.

   ```none
   I have not yet done this one.
   ```

4. Write an assembly program to keep track of 10 sets of size 1000000.
   Your program should accept the following commands: "add", "union",
   "print", and "quit". The program should have a function to read the
   command string and determine which it is and return 0, 1, 2, or 3
   depending on the string read. After reading "add" your program should
   read a set of numbers from 0 to 9 and an element number from 0 to
   999999 and insert the element into the proper set. You need to have a
   function to add an element to a set.  After reading "union" your program
   should read 2 set numbers and make the first set be equal to the union
   of the 2 sets. Your need to a set union function. After reading "print"
   your program should print all the elements of the set. You can assume
   that the set has only a few elements. After reading "quit" your program
   should exit.

   ```none
   I have not yet done this one.
   ```

5. A sequence of numbers is called bitonic if it consists of an increasing
   sequence followed by a decreasing sequence or if the sequence can be
   rotated until it consists of an increasing sequence followed by a
   decreasing sequence. Write an assembly program to read a sequence of
   integers into an array and print out whether the sequence is bitonic
   or not. The maximum number of elements in the array should be 100.
   You need to write 2 functions: one to read the numbers into the array
   and a second to determine whether the sequence is bitonic. Your
   bitonic test should not actually rotate the array.

   ```none
   I have not yet done this one.
   ```

6. Write an assembly program to read two 8 byte integers with `scanf`
   and compute their greatest common divisor using Euclid's algorithm,
   which is based on the recursive definition:

   ```none
       gcd(a, b) = a                if b = 0
                 = gcd(b, a mod b)  otherwise
   ```

   ```asm
   a               equ       0x61                      ; 'a'
   b               equ       0x62                      ; 'b'
   
   ;==============================================================================
           segment .rodata
   ;==============================================================================
   prompt          db        "Enter %c: ", 0
   scanNumber      db        "%ld", 0
   result          db        "gcd(%ld, %ld) = %ld", 0xa, 0
   
   ;==============================================================================
           segment .text
   ;==============================================================================
           extern printf
           extern scanf
   
           global main
   main:
   .a_stack            equ          0        ; a's offset from the stack pointer
   .b_stack            equ          8        ; b's offset from the stack pointer
   
           push        rbp
           mov         rbp,         rsp
           sub         rsp,         16       ; Allocate room on the stack for a and b
   
           ;----------------------------------------------------------------------
           ;-- Prompt for a
           ;----------------------------------------------------------------------
           lea         rdi,         [prompt]
           mov         rsi,         a
           xor         eax,         eax
           call        printf
   
           ;----------------------------------------------------------------------
           ;-- Read a
           ;----------------------------------------------------------------------
           lea         rdi,         [scanNumber]
           lea         rsi,         qword [rsp + .a_stack]
           xor         eax,         eax
           call        scanf
   
           ;----------------------------------------------------------------------
           ;-- Prompt for b
           ;----------------------------------------------------------------------
           lea         rdi,         [prompt]
           mov         rsi,         b
           xor         eax,         eax
           call        printf
   
           ;----------------------------------------------------------------------
           ;-- Read b
           ;----------------------------------------------------------------------
           lea         rdi,         [scanNumber]
           lea         rsi,         qword [rsp + .b_stack]
           xor         eax,         eax
           call        scanf
   
           ;----------------------------------------------------------------------
           ;-- call gcd(a, b)
           ;----------------------------------------------------------------------
           mov         rdi,         qword [rsp + .a_stack]
           mov         rsi,         qword [rsp + .b_stack]
           call        gcd
   
           ;----------------------------------------------------------------------
           ;-- Print result
           ;----------------------------------------------------------------------
           lea         rdi,         [result]
           mov         rsi,         qword [rsp + .a_stack]
           mov         rdx,         qword [rsp + .b_stack]
           mov         rcx,         rax
           xor         eax,         eax
           call        printf
   
           xor         eax,         eax
           leave
           ret
   
   ;
   ; long gcd(long a, long b);
   ;
   ; Returns the greatest common divisior of a an b using Euclid's algorithm.
   ;
   gcd:
   .a_stack            equ          8
   .b_stack            equ          0

           push        rbp
           mov         rbp,         rsp
           push        rdi
           push        rsi
   
           cmp         rsi,         0       ; if (b == 0)
           je         .answer_a             ;     goto answer_a;
   
           ; For idiv, rdx:rax is the dividend, after operation rax contains
           ; quotient and rdx contains remainder
           mov         rdi,         qword [rsp + .b_stack] ; 1st parm to recusive call is b
   
           mov         rdx,         0
           mov         rax,         qword [rsp + .a_stack]
           idiv        rdi                                 ; a / b
   
           mov         rsi,         rdx                    ; 2nd parm is remainder
   
           call        gcd
           jmp        .done
   
   .answer_a:
           mov         rax,         rdi
   
   .done:
           leave
           ret
   ```

   ```none
   $ ./ex
   Enter a: 138
   Enter b: 1058
   gcd(138, 1058) = 46
   
   $ ./ex 
   Enter a: 581
   Enter b: 835
   gcd(581, 835) = 1
   ```

7. Write an assembly program to read a string of left and right
   parentheses and determine whether the string contains a balanced
   set of parentheses. Your can read the string with `scanf` using
   `"%79s"` into a character array of length 80. A set of parentheses is
   balanced if it is the empty string or if it consists of a left parenthesis
   followed by a sequence of balanced sets and a right parenthesis.  Here's an
   example of a balanced set of parentheses: `"((()())())"`.

   ```asm
   BUFFER_LEN          equ          80
   LEFT_PAREN          equ          0x28        ; '('
   RIGHT_PAREN         equ          0x29        ; ')'
   NL                  equ          0x0a        ; '\n'
   NIL                 equ          0x00        ; '\0'
   
   ;==============================================================================
           segment .rodata
   ;==============================================================================
   promptFormat        db           "Enter a sequence of parentheses: ", NIL
   scanFormat          db           "%79s", 0 ; should be BUFFER_LEN - 1
   resultFormat        db           "The sequence '%s' is %s", NL, NIL
   balanced            db           "balanced", NIL
   notBalanced         db           "not balanced", NIL
   
   ;==============================================================================
           segment .bss
   ;==============================================================================
   buffer              resb         BUFFER_LEN
   
   ;==============================================================================
           segment .text
   ;==============================================================================
           extern printf
           extern scanf
   
           global main
   main:
           push        rbp
           mov         rbp,         rsp
   
           ;----------------------------------------------------------------------
           ;-- Prompt for input
           ;----------------------------------------------------------------------
           lea         rdi,         [promptFormat]
           xor         eax,         eax
           call        printf
   
           ;----------------------------------------------------------------------
           ;-- Read input
           ;----------------------------------------------------------------------
           lea         rdi,         [scanFormat]
           lea         rsi,         [buffer]
           xor         eax,         eax
           call        scanf
   
           ;----------------------------------------------------------------------
           ;-- Determine if balanced
           ;----------------------------------------------------------------------
           call        isBalanced
   
           ;----------------------------------------------------------------------
           ;-- Print result
           ;----------------------------------------------------------------------
           lea         rdi,         [resultFormat]
           lea         rsi,         [buffer]
           lea         rdx,         [balanced]
           lea         rcx,         [notBalanced]   ; not a parameter, used with cmovz
           cmp         rax,         0
           cmovz       rdx,         rcx
           xor         eax,         eax
           call        printf
   
           xor         eax,         eax
           leave
           ret
   
   ;
   ; bool isBalanced(void);
   ;
   ; Determine if the parentheses sequence in 'buffer' is balanced.  Returns
   ; 1 if true, 0 if false.
   ;
   ; Register usage:
   ;     r12 - i
   ;     r13 - current
   ;     r14 - parenDepth
   ;     rax - balanced (0 = false, 1 = true)
   ;
   isBalanced:
           push        rbp
           mov         rbp,         rsp
           push        r12
           push        r13
           push        r14
   
           mov         rax,         1              ; Assume balanced until proven not
           mov         r12,         -1             ; i = -1
           xor         r14,         r14            ; parenDepth = 0
   
   .begin_loop:
           inc         r12                         ; ++i;
           xor         r13,         r13
           mov         r13b,        [buffer + r12] ; current = buffer[i]
           cmp         r13,         NIL            ; if (current == '\0')
           je         .end_loop                    ;     goto end_loop;
           cmp         r13,         RIGHT_PAREN    ; if (current == ')')
           je         .right_paren                 ;     goto right_paren;
           inc         r14                         ; ++parenDepth; /* current == '(' */
           jmp        .begin_loop
   
   .right_paren:
           dec         r14
           ;cmp        r14,         0
           jl         .end_loop
           jmp        .begin_loop
   
   .end_loop:
           ; If the parentheses are balanced, r14 will be 0.  We've already
           ; initialized rax to 1 above, so we can just goto end.  Otherwise
           ; set rax to 0.
           cmp         r14,         0
           je         .end
           mov         rax,         0
   
   .end:
           pop         r14
           pop         r13
           pop         r12
           leave
           ret
   ```

   ```none
   $ ./ex
   Enter a sequence of parentheses: ((()())())
   The sequence '((()())())' is balanced
   $ ./ex
   Enter a sequence of parentheses: (
   The sequence '(' is not balanced
   $ ./ex
   Enter a sequence of parentheses: )(
   The sequence ')(' is not balanced
   $ ./ex
   Enter a sequence of parentheses: (()))())
   The sequence '(()))())' is not balanced
   ```
