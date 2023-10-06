# Exercises

1. Convert the following integers to binary.
   1. 37
      ```none
      37 / 2 = 18 r1
      18 / 2 =  9 r0
       9 / 2 =  4 r1
       4 / 2 =  2 r0
       2 / 2 =  1 r0
       1 / 2 =  0 r1

      => 100101
      ```

   2. 65
      ```none
      65 / 2 = 32 r1
      32 / 2 = 16 r0
      16 / 2 =  8 r0
       8 / 2 =  4 r0
       4 / 2 =  2 r0
       2 / 2 =  1 r0
       1 / 2 =  0 r1

      => 1000001
      ```
   3. 350
      ```none
      350 / 2 = 175 r0
      175 / 2 =  87 r1
       87 / 2 =  43 r1
       43 / 2 =  21 r1
       21 / 2 =  10 r1
       10 / 2 =   5 r0
        5 / 2 =   2 r1
        2 / 2 =   1 r0
        1 / 2 =   0 r1

      => 101011110
      ```

   4. 427
      ```none
      427 / 2 = 213 r1
      213 / 2 = 106 r1
      106 / 2 =  53 r0
       53 / 2 =  26 r1
       26 / 2 =  13 r0
       13 / 2 =   6 r1
        6 / 2 =   3 r0
        3 / 2 =   1 r1
        1 / 2 =   0 r1

      => 110101011
      ```

2. Convert the following 16-bit signed integers to decimal.
   1. 0000001010101010b
      ```none
        0 x 2^0      = 0 x     1     =   0
        1 x 2^1      = 1 x     2     =   2
        0 x 2^2      = 0 x     4     =   0
        1 x 2^3      = 1 x     8     =   8
        0 x 2^4      = 0 x    16     =   0
        1 x 2^5      = 1 x    32     =  32
        0 x 2^6      = 0 x    64     =   0
        1 x 2^7      = 1 x   128     = 128
        0 x 2^8      = 0 x   256     =   0
        1 x 2^9      = 1 x   512     = 512
        0 x 2^10     = 0 x  1024     =   0
        0 x 2^11     = 0 x  2048     =   0
        0 x 2^12     = 0 x  4096     =   0
        0 x 2^13     = 0 x  8192     =   0
        0 x 2^14     = 0 x 16384     =   0
      + 0 x 2^15     = 0 x 32768     =   0
                                       ---
      =>                               682
      ```

   2. 1111111111101101b
      ```none
        1 x 2^0      = 1 x     1     =     1
        0 x 2^1      = 0 x     2     =     0
        1 x 2^2      = 1 x     4     =     4
        1 x 2^3      = 1 x     8     =     8
        0 x 2^4      = 0 x    16     =     0
        1 x 2^5      = 1 x    32     =    32
        1 x 2^6      = 1 x    64     =    64
        1 x 2^7      = 1 x   128     =   128
        1 x 2^8      = 1 x   256     =   256
        1 x 2^9      = 1 x   512     =   512
        1 x 2^10     = 1 x  1024     =  1024
        1 x 2^11     = 1 x  2048     =  2048
        1 x 2^12     = 1 x  4096     =  4096
        1 x 2^13     = 1 x  8192     =  8192
        1 x 2^14     = 1 x 16384     = 16384
      + 1 x 2^15     = 1 x 32768     = 32768
                                       -----
      =>                               65517
      ```

   3. 0x0101
      ```none
      1 * 16^0     = 1 *    1     =   1
      0 * 16^1     = 0 *   16     =   0
      1 * 16^2     = 1 *  256     = 256
      0 * 16^3     = 0 * 4096     =   0
                                    ---
      =>                            257
      ```

   4. 0xffcc
      ```none
      c * 16^0     = 12 *    1     =    12
      c * 16^1     = 12 *   16     =   192
      f * 16^2     = 15 *  256     =  3840
      f * 16^3     = 15 * 4096     = 61440
                                     -----
      =>                             65484
      ```

3. Convert the following 16-bit unsigned integers to binary.
   1. 0x015a
      ```none
      a * 16^0     = 10 *    1     =  10
      5 * 16^1     =  5 *   16     =  80
      1 * 16^2     =  1 *  256     = 256
      0 * 16^3     =  0 * 4096     =   0
                                     ---
      =>                             346

      346 / 2 = 173 r0
      173 / 2 =  86 r1
       86 / 2 =  43 r0
       43 / 2 =  21 r1
       21 / 2 =  10 r1
       10 / 2 =   5 r0
        5 / 2 =   2 r1
        2 / 2 =   1 r0
        1 / 2 =   0 r1

      => 101011010
      ```

   2. 0xfedc
      ```none
      c * 16^0     = 12 *    1     =    12
      d * 16^1     = 13 *   16     =   208 
      e * 16^2     = 14 *  256     =  3584
      f * 16^3     = 15 * 4096     = 61440
                                     -----
      =>                             65244

      65244 / 2 = 32622 r0
      32622 / 2 = 16311 r0
      16311 / 2 =  8155 r1
       8155 / 2 =  4077 r1
       4077 / 2 =  2038 r1
       2038 / 2 =  1019 r1
       1019 / 2 =   509 r1
        509 / 2 =   254 r1
        254 / 2 =   127 r0
        127 / 2 =    63 r1
         63 / 2 =    31 r1
         31 / 2 =    15 r1
         15 / 2 =     7 r1
          7 / 2 =     3 r1
          3 / 2 =     1 r1
          1 / 2 =     0 r1

      => 1111111011011100
      ```

   3. 0x0101
      ```none
      1 * 16^0     = 1 *    1     =   1
      0 * 16^1     = 0 *   16     =   0 
      1 * 16^2     = 1 *  256     = 256
      0 * 16^3     = 0 * 4096     =   0
                                    ---
      =>                            257

      257 / 2 = 128 r1
      128 / 2 =  64 r0
       64 / 2 =  32 r0
       32 / 2 =  16 r0
       16 / 2 =   8 r0
        8 / 2 =   4 r0
        4 / 2 =   2 r0
        2 / 2 =   1 r0
        1 / 2 =   0 r1

      => 100000001
      ```

   4. 0xacdc
      ```none
      c * 16^0     = 12 *    1     =    12
      d * 16^1     = 13 *   16     =   208 
      c * 16^2     = 12 *  256     =  3072
      a * 16^3     = 10 * 4096     = 40960
                                     -----
      =>                             44252

      44252 / 2 = 22126 r0
      22126 / 2 = 11063 r0
      11063 / 2 =  5531 r1
       5531 / 2 =  2765 r1
       2765 / 2 =  1382 r1
       1382 / 2 =   691 r0
        691 / 2 =   345 r1
        345 / 2 =   172 r1
        172 / 2 =    86 r0
         86 / 2 =    43 r0
         43 / 2 =    21 r1
         21 / 2 =    10 r0
         10 / 2 =     5 r1
          5 / 2 =     2 r1
          2 / 2 =     1 r0
          1 / 2 =     0 r1

      => 1010110011011100
      ```

4. Convert the following numbers to 32-bit floating point.
   1. 1.375
      * Sign bit
        ```none
        The number is positive, so the sign bit is 0.
        ```
      * Convert the number to binary
        * The whole part
          ```none
             1 / 2 = 0 r1

          => 1
          ```
        * The fractional part
          ```none
             0.375 * 2 = 0.75  ->  0 is the first digit
             0.75  * 2 = 1.50  ->  1 is the next digit
             0.50  * 2 = 1.00  ->  1 is the next digit

          => .011
          ```
        * Putting things together
          ```none
          1.375 = 1.011b
          ```
        * Convert to exponential notation
          ```none
          It's already in that form  => 1.011 * 2^0
          ```
        * Break down all the pieces
          * Sign bit: 0
          * Fraction: 01100000000000000000000
          * Exponent:
            ```none
               bias + power-2 exponent
             = 127  + 0
             = 127

            => 01111111b
            ```
        * Resulting 32-bit floating point number
          ```none
          0 01111111 01100000000000000000000
          ```

   2. 0.041015625
      * Sign bit
        ```none
        The number is positive, so the sign bit is 0.
        ```
      * Convert the number to binary
        * The whole part
          ```none
             0 / 2 = 0 r0

          => 0
          ```
        * The fractional part
          ```none
             0.041015625 * 2 = 0.08203125  ->  0 is the first digit
             0.08203125  * 2 = 0.1640625   ->  0 is the next digit
             0.1640625   * 2 = 0.328125    ->  0 is the next digit
             0.328125    * 2 = 0.65625     ->  0 is the next digit
             0.65625     * 2 = 1.3125      ->  1 is the next digit
             0.3125      * 2 = 0.625       ->  0 is the next digit
             0.625       * 2 = 1.25        ->  1 is the next digit
             0.25        * 2 = 0.50        ->  0 is the next digit
             0.50        * 2 = 1.00        ->  1 is the next digit

          => .000010101
          ```
        * Putting things together
          ```none
          0.041015625 = 0.000010101b
          ```
        * Convert to exponential notation
          ```none
          0.000010101b =  1.0101b * 2^(-5)
          ```
        * Break down all the pieces
          * Sign bit: 0
          * Fraction: 01010000000000000000000
          * Exponent:
            ```none
               bias + power-2 exponent
             = 127  + (-5)
             = 122

            => 01111010b
            ```
        * Resulting 32-bit floating point number
          ```none
          0 01111010 01010000000000000000000
          ```

   3. -571.3125
      ```none
      ```

   4. 4091.125
      ```none
      ```

5. Convert the following numbers from 32-bit floating point to decimal.
   1. 0x3F82000
      ```none
      ```

   2. 0xBF82000
      ```none
      ```

   3. 0x4F84000
      ```none
      ```

   4. 0x3C86000
      ```none
      ```

6. Perform the binary addition of the 2 unsigned integers below. Show
   each carry as a 1 above the proper position.

   ```none
     0010010110010111
   + 1110110111101011
   ------------------
   ```

   Solution:
   ```none
     111 11 111111111
      0010010110010111
   +  1110110111101011
   -------------------
      0001001110000010
   ```

   Note that the addition overflowed 16 bits, so the last (leftmost) carry
   is lost.  Had these integers been represented with more than 16 bits, then
   the answer would have been `10001001110000010`.

7. Perform the binary multiplication of the following unsigned binary numbers.
   Show each row where a 1 is multiplied times the top number. You may omit
   rows where a 0 is multiplied times the top.

   ```none
     1011001011
   x    1101101
   ------------
   ```

   Solution:
   ```none
             1011001011
           x    1101101
           ------------
             1011001011
            0000000000-
           1011001011--
          1011001011---
         0000000000----
      + 1011001011-----
        ---------------

         1 1  1
      1111011010111
             1011001011
            0000000000-
           1011001011--
          1011001011---
         0000000000----
        1011001011-----
     + 1011001011------
       ----------------
   =>  0011000001101111
   ```

   Note that the multiplication overflowed 16 bits, so the last (leftmost) carry
   is lost.  Had these integers been represented with more than 16 bits, then
   the answer would have been `10011000001101111`.

8. Write an assembly "program" (data only) defining data values using `dw`
   and `dd` for all the numbers in exercise 1-4.

   ```
   I have not yet done this one.
   ```
