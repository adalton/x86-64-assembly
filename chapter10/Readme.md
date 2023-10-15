# Exercises

1. Write 2 test programs: one to sort an array of random 4-byte integers
   using bubble sort and a second program to sort an array of random 4-byte
   integers using the `qsort` function from the C library. Your program should
   use the C library function `atol` to convert a number supplied on the
   command line from ASCII to long. This number is the size of the array
   (number of 4-byte integers). Then your program can allocate the array
   using `malloc` and fill the array using `random`. You call qsort like
   this:
   ```c
       qsort(array, n, 4, compare );
   ```

   The second parameter is the number of array elements to sort and the third
   is the size in bytes of each element.  The fourth paramter is the
   address of a comparison function. Your comparison function will accept two
   parameters.  Each will return a pointer to a 4-byte integer. The comparison
   function should return a negative, 0, or positive value based on the ordering
   of the 2 integers.  All you have to do is subtract the second integer from
   the first.

   > one to sort an array of random 4-byte integers using bubble sort
   ```asm
           segment .data
   format                db                "%s", 0x0a, 0
   
           segment .text
           global main
   
           extern atol
           extern free
           extern malloc
           extern printf
           extern qsort
           extern random
   main:
   .array  equ                0
   .size   equ                8
           push               rbp
           mov                rbp,                        rsp
           sub                rsp,                        16
   
           mov                rcx,                        rsi
           mov                rdi,                        [rcx + 8]        ; Skip the command name
           call               atol
   
   ;       The desired array size is now in rax, save a copy on the stack
           mov                [rsp + .size],              rax
   
           mov                rdi,                        rax
           call               create
   
   ;       The pointer to the array is now in rax, save a copy on the stack
           mov                [rsp + .array],             rax
   
   
           mov                rdi,                        [rsp + .array]
           mov                rsi,                        [rsp + .size]
           call               fill
           ; The array is now full of random numbers
   
           mov                rdi,                        [rsp + .array]
           mov                rsi,                        [rsp + .size]
           call               bubbleSort
   
   ;       Print the result
           mov                rdi,                        [rsp + .array]
           mov                rsi,                        [rsp + .size]
           call               print
   
   ;       Release the dynamically allocated memory
           mov                rdi,                        [rsp + .array]
           call                free
   
           xor                eax,                        eax
           leave
           ret
   
   ;
   ; int compare(int* v1, int* v2);
   ;
   compare:
   .first  equ                0
   .second equ                8
           push               rbp
           mov                rbp,                        rsp
           sub                rsp,                        16
   
           mov                [rsp + .first],             rdi
           mov                [rsp + .second],            rsi
           mov                rax,                        [rsp + .first]
           mov                rdx,                        [rax]
           mov                rax,                        [rsp + .second]
           mov                rax,                        [rax]
           sub                rdx,                        rax
   
           mov                rax,                        rdx
           leave
           ret
   
   ;
   ; int* create(int size)
   ;
   ; Creates a dynamically allocated array of quad words of the given size.
   ;
   create:
   .ELEMENT_SIZE              equ                         4                ; Size of each array element
           push               rbp
           mov                rbp,                        rsp
           imul               rdi,                        .ELEMENT_SIZE
           call               malloc
           leave
           ret
   
   ;
   ; void fill(array, size)
   ;
   ; Fills the given array of quad words of the given size with random values.
   ;
   fill:
   .array  equ                 0
   .size   equ                 8
   .i      equ                16
           push               rbp
           mov                rbp,                        rsp
           sub                rsp,                        32
   
           mov                [rsp + .array],             rdi
           mov                [rsp + .size],              rsi
           xor                ecx,                        ecx
   .more   mov                [rsp + .i],                 rcx
           call               random
           mov                ecx,                        [rsp + .i]
           mov                rdi,                        [rsp + .array]
           mov                [rdi + rcx * 4],            eax
           inc                rcx
           cmp                rcx,                        [rsp + .size]
           jl                .more
           leave
           ret
   
   ;
   ; void print(array, size)
   ;
   ; Prints the contents of the given array of the given size to standard output.
   ;
   print:
   .array  equ                 0
   .size   equ                 8
   .i      equ                16
   
           push               rbp
           mov                rbp,                        rsp
           sub                rsp,                        32
           mov                [rsp + .array],             rdi
           mov                [rsp + .size],              rsi
           xor                ecx,                        ecx
           mov                [rsp + .i],                 rcx
   
           segment        .data
   .format:
           db                 "%10d", 0x0a, 0
           segment        .text
   
   .more   lea                rdi,                        [.format]
           mov                rdx,                        [rsp + .array]
           mov                rcx,                        [rsp + .i]
           mov                esi,                        [rdx + rcx * 4]
           mov                [rsp + .i],                 rcx
           call               printf
           mov                rcx,                        [rsp + .i]
           inc                rcx
           mov                [rsp + .i],                 rcx
           cmp                rcx,                        [rsp + .size]
           jl                .more
           leave
           ret
   
   ; void bubbleSort(int* array, const int size)
   ; {
   ;     bool swapped = false;
   ;     int i;
   ;
   ;     do {
   ;         swapped = false;
   ;
   ;         for (i = 0; i < (size - 1); ++i) {
   ;             if (array[i] > array[i + 1]) {
   ;                 array[i] = array[i] ^ array[i + 1];
   ;                 array[i + 1] = array[i] ^ array[i + 1];
   ;                 array[i] = array[i] ^ array[i + 1];
   ;                 swapped = true;
   ;             }
   ;         }
   ;     } while (swapped);
   ; }
   
   bubbleSort:
   .ELEMENT_SIZE              equ                         4                ; Size of each array element
   .array                     equ                         0
   .size                      equ                         .array   + 8
   .swapped                   equ                         .size    + 8
   .i                         equ                         .swapped + 8
   
           push               rbp
           mov                rbp,                        rsp
           sub                rsp,                        32
   
           ; Subtract 1 from rsi (size) since we reference only (size - 1)
           sub                rsi,                        1
   
           ; Save a copy of the parameters on the stack
           mov                [rsp + .array],             rdi
           mov                [rsp + .size],              rsi
   
   .begin_do:
            mov               rsi,                        0
            mov               [rsp + .swapped],           rsi              ; swapped = false
            mov               [rsp + .i],                 rsi              ; i = 0
   
   .for_test:
            cmp               rsi,                        [rsp + .size]    ; i < size
            jge              .end_for
   
   ; .begin_if:
           mov                rdi,                        [rsp + .array]
           mov                edx,                        [rdi + rsi * .ELEMENT_SIZE]
           inc                rsi
           mov                ecx,                        [rdi + rsi * .ELEMENT_SIZE]
           cmp                edx,                        ecx
           jle               .end_if
   
           xor                edx,                        ecx
           xor                ecx,                        edx
           xor                edx,                        ecx
   
           mov                [rdi + rsi * .ELEMENT_SIZE], ecx
           dec                rsi
           mov                [rdi + rsi * .ELEMENT_SIZE], edx
   
           mov                rsi,                        1
           mov                [rsp + .swapped],           rsi              ; swapped = true
   .end_if:
           mov                rsi,                        [rsp + .i]
           inc                rsi
           mov                [rsp + .i],                 rsi              ; i++
           jmp               .for_test
   
   .end_for:
   ;     } while (swapped);
           mov                rsi,                        [rsp + .swapped]
           cmp                rsi,                        0
           jne               .begin_do
   
           leave
           ret
   ```

   > and a second program to sort an array of random 4-byte integers
   > using the `qsort` function from the C library
   ```asm
           segment .data
   format                db                "%s", 0x0a, 0
   
           segment .text
           global main
   
           extern atol
           extern free
           extern malloc
           extern printf
           extern qsort
           extern random
   main:
   .array  equ                0
   .size   equ                8
           push               rbp
           mov                rbp,                        rsp
           sub                rsp,                        16
   
           mov                rcx,                        rsi
           mov                rdi,                        [rcx + 8]        ; Skip the command name
           call               atol
   
   ;       The desired array size is now in rax, save a copy on the stack
           mov                [rsp + .size],              rax
           
           mov                rdi,                        rax
           call               create
   
   ;       The pointer to the array is now in rax, save a copy on the stack
           mov                [rsp + .array],             rax
   
   
           mov                rdi,                        [rsp + .array]
           mov                rsi,                        [rsp + .size]
           call               fill
   ;       The array is now full of random numbers
   
   ;       qsort(array, n, 4, compare);
           mov                rdi,                        [rsp + .array]
           mov                rsi,                        [rsp + .size]
           mov                rdx,                        4
           mov                rcx,                        compare
           call               qsort
   
   ;       Print the result
           mov                rdi,                        [rsp + .array]
           mov                rsi,                        [rsp + .size]
           call               print
   
   ;       Release the dynamically allocated memory
           mov                rdi,                        [rsp + .array]
           call               free
   
           xor                eax,                        eax
           leave
           ret
   
   ;
   ; int compare(int* v1, int* v2);
   ;
   compare:
   .first  equ                0
   .second equ                8
           push               rbp
           mov                rbp,                        rsp
           sub                rsp,                        16
   
           mov                [rsp + .first],             rdi
           mov                [rsp + .second],            rsi
           mov                rax,                        [rsp + .first]
           mov                rdx,                        [rax]
           mov                rax,                        [rsp + .second]
           mov                rax,                        [rax]
           sub                rdx,                        rax
   
           mov                rax,                        rdx
           leave
           ret
   
   ;
   ; int* create(int size)
   ;
   ; Creates a dynamically allocated array of quad words of the given size.
   ;
   create:
   .ELEMENT_SIZE              equ                         4                ; Size of each array element
           push               rbp
           mov                rbp,                        rsp
           imul               rdi,                        .ELEMENT_SIZE
           call               malloc
           leave
           ret
   
   ;
   ; void fill(array, size)
   ;
   ; Fills the given array of quad words of the given size with random values.
   ;
   fill:
   .array  equ                 0
   .size   equ                 8
   .i      equ                16
           push               rbp
           mov                rbp,                        rsp
           sub                rsp,                        32
   
           mov                [rsp + .array],             rdi
           mov                [rsp + .size],              rsi
           xor                ecx,                        ecx
   .more   mov                [rsp + .i],                 rcx
           call               random
           mov                ecx,                        [rsp + .i]
           mov                rdi,                        [rsp + .array]
           mov                [rdi + rcx * 4],            eax
           inc                rcx
           cmp                rcx,                        [rsp + .size]
           jl                .more
           leave
           ret
   
   ;
   ; void print(array, size)
   ;
   ; Prints the contents of the given array of the given size to standard output.
   ;
   print:
   .array  equ                 0
   .size   equ                 8
   .i      equ                16
   
           push               rbp
           mov                rbp,                        rsp
           sub                rsp,                        32
           mov                [rsp + .array],             rdi
           mov                [rsp + .size],              rsi
           xor                ecx,                        ecx
           mov                [rsp + .i],                 rcx
   
           segment        .data
   .format:
           db                 "%10d", 0x0a, 0
           segment        .text
   
   .more   lea                rdi,                        [.format]
           mov                rdx,                        [rsp + .array]
           mov                rcx,                        [rsp + .i]
           mov                esi,                        [rdx + rcx * 4]
           mov                [rsp + .i],                 rcx
           call               printf
           mov                rcx,                        [rsp + .i]
           inc                rcx
           mov                [rsp + .i],                 rcx
           cmp                rcx,                        [rsp + .size]
           jl                .more
           leave
           ret
   
   ```

2. Write a program to use `qsort` to sort an array of random integers and use
   a binary search function to search for numbers in the array. The size of the
   array should be given as a command line parameter. Your program should use
   `random() % 1000` for values in the array.  This will make it simplier to
   enter values to search for.  After building the array and sorting it,
   your program should enter a loop reading numbers with `scanf` until
   `scanf` fails to return a 1. For each number read, your program should
   call your binary search function and either report that the number was
   found at a particular index or that the number was not found.

   ```none
   I have not yet implemented this.
   ```

3. Write an assembly program to compute the Adler-32 checksum value for the
   sequence of bytes read using `fgets` to read 1 line at a time until end
   of file. The prototype for `fgets` is:

   ```c
       char* fgets(char* s, int size, FILE* fp);
   ```

   The parameter `s` is a character array that should be in the `bss`
   segment. The parameter `size` is the numbe4r of bytes in the array `s`.
   The parameter `fp` is a pointer and you need `stdin`. Place the
   following line in your code to tell the linker about `stdin`:

   ```asm
       extern stdin
   ```

   `fgets` will return the parameter `s` when it succeeds and will return 0
   when it fails. You are to read until it fails. The Adler-32 checksum is
   computed by:

   ```c
   long adler32(char* data, int len)
   {
       long a = 1;
       long b = 0;
       int i;

       for (i = 0; i < len; i++) {
           a = (a + data[i]) % 65521;
           b = (b + a) % 65521;
       }

       return (b << 16) | a;
   }
   ```

   Your code should compute 1 checksum for the entire file. If you use the
   function shown for 1 line, it works for that line, but calling it again
   restarts.

   ```none
   I have not yet implemented this.
   ```

4. Write a test program to evaluate how well the hashing function below
   works.

   ```c
   int multipliers[] = {
       123456789,
       234567891,
       345678912,
       456789123,
       567891234,
       678912345,
       789123456,
       891234567,
   };

   int hash(unsigned char* s)
   {
       unsigned long h = 0;
       int i = 0;

       for(i = 0; s[i]; i++) {
           h = h + s[i] * multipliers[i % 8];
       }

       return h % 99991;
   }
   ```

   Your test program should read a collection of strings using `scanf` with
   the format string `"79s"` where you are reading into a character array of
   80 bytes. Your program should read until `scanf` fails to return 1.  As it
   reads each string it should call `hash` (written in assembly) to get a
   number `h` from 0 to 99990. It should increment location `h` of an array
   of integers of size 99991. After entering all the data, this array contains
   a count of how many words mapped to each location in the array. What we want
   to know is how many of these array entries have 0 entries, how many have
   1 entry, how many many have 2 entries, etc. When multiple words map to the
   same location, it is called a "collision".  So the next step is to go
   through the array collision counts and increment another array by the
   index there.  There should be no more than 1000 collisions, so this could be
   done using:

   ```c
   for (i = 0; i < 99991; i++) {
       int k = collisions[i];
       if (k > 999) {
           k = 999;
       }
       count[k]++;
   }
   ```

   After the previous loop the `count` array has interesting data. Use a loop
   to step through this array and print the index and the value for all
   non-zero locations. An interesting file to test is `"/usr/share/dict/words"`.
   Write an assembly program to read a sequence of integers using `scanf`
   and determine if the first number entered can be formed as a sum of some of
   the other numbers and print a solution if it exists. You can assume that
   there will be no more than 20 numbers. Suppose the numbers are 20, 12, 6, 3,
   and 5. Then 20 + 12 + 3 + 5. Suppose the numbers are 25, 11, 17, and 3.
   In this case there are no solutions.

   ```none
   I have not yet implemented this.
   ```
