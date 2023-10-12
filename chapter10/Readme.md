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

   ```none
   I have not yet implemented this.
   ```

2. Write a program to use `qsort` to sort an array of random integers and use
   a binary search function to search for numbers in the array. The size of the
   array should be given as a command line parameter. Your program should use
   `random() % 1000` for values in the array.  This will make it simplier to
   enter values to search for.  After building the array and sortint it,
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
       count[k]++;1
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
