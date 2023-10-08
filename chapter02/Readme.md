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

          => 1b
          ```
        * The fractional part
          ```none
             0.375 * 2 = 0.75  ->  0 is the first digit
             0.75  * 2 = 1.50  ->  1 is the next digit
             0.50  * 2 = 1.00  ->  1 is the next digit

          => .011b
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

                 127 / 2 = 63 r1
                  63 / 2 = 31 r1
                  31 / 2 = 15 r1
                  15 / 2 =  7 r1
                   7 / 2 =  3 r1
                   3 / 2 =  1 r1
                   1 / 2 =  0 r1

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

          => 0b
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

          => .000010101b
          ```
        * Putting things together
          ```none
          0.041015625 = 0.000010101b
          ```
        * Convert to exponential notation
          ```none
          0.000010101b = 1.0101b * 2^(-5)
          ```
        * Break down all the pieces
          * Sign bit: 0
          * Fraction: 01010000000000000000000
          * Exponent:
            ```none
               bias + power-2 exponent
             = 127  + (-5)
             = 122

                 122 / 2 = 61 r0
                  61 / 2 = 30 r1
                  30 / 2 = 15 r0
                  15 / 2 =  7 r1
                   7 / 2 =  3 r1
                   3 / 2 =  1 r1
                   1 / 2 =  1 r1

            => 01111010b
            ```
        * Resulting 32-bit floating point number
          ```none
          0 01111010 01010000000000000000000
          ```

   3. -571.3125
      * Sign bit
        ```none
        The number is negative, so the sign bit is 1.
        ```
      * Convert the number to binary
        * The whole part
          ```none
             571 / 2 = 285 r1
             285 / 2 = 142 r1
             142 / 2 =  71 r0
              71 / 2 =  35 r1
              35 / 2 =  17 r1
              17 / 2 =   8 r1
               8 / 2 =   4 r0
               4 / 2 =   2 r0
               2 / 2 =   1 r0
               1 / 2 =   0 r1

          => 1000111011b
          ```
        * The fractional part
          ```none
             0.3125 * 2 = 0.625  ->  0 is the first digit
             0.625  * 2 = 1.25   ->  1 is the next digit
             0.25   * 2 = 0.50   ->  0 is the next digit
             0.50   * 2 = 1.00   ->  1 is the next digit

          => .0101b
          ```
        * Putting things together
          ```none
          571.3125 = 1000111011.0101b
          ```
        * Convert to exponential notation
          ```none
          1000111011.0101 = 1.0001110110101 * 2^9
          ```
        * Break down all the pieces
          * Sign bit: 1
          * Fraction: 00011101101010000000000
          * Exponent:
            ```none
               bias + power-2 exponent
             = 127  + 9
             = 136

                 136 / 2 = 68 r0
                  68 / 2 = 34 r0
                  34 / 2 = 17 r0
                  17 / 2 =  8 r1
                   8 / 2 =  4 r0
                   4 / 2 =  2 r0
                   2 / 2 =  1 r0
                   1 / 2 =  0 r1

            => 10001000b
            ```
        * Resulting 32-bit floating point number
          ```none
          1 10001000 00011101101010000000000
          ```

   4. 4091.125
      * Sign bit
        ```none
        The number is positive, so the sign bit is 0.
        ```
      * Convert the number to binary
        * The whole part
          ```none
             4091 / 2 = 2045 r1
             2045 / 2 = 1022 r1
             1022 / 2 =  511 r0
              511 / 2 =  255 r1
              255 / 2 =  127 r1
              127 / 2 =   63 r1
               63 / 2 =   31 r1
               31 / 2 =   15 r1
               15 / 2 =    7 r1
                7 / 2 =    3 r1
                3 / 2 =    1 r1
                1 / 2 =    0 r1

          => 111111111011b
          ```
        * The fractional part
          ```none
             0.125 * 2 = 0.25  ->  0 is the first digit
             0.25  * 2 = 0.50  ->  0 is the next digit
             0.50  * 2 = 1.00  ->  1 is the next digit

          => .001b
          ```
        * Putting things together
          ```none
          4091.125 = 111111111011.001b
          ```
        * Convert to exponential notation
          ```none
          111111111011.001 = 1.11111111011001 * 2^11
          ```
        * Break down all the pieces
          * Sign bit: 0
          * Fraction: 11111111011001000000000
          * Exponent:
            ```none
               bias + power-2 exponent
             = 127  + 11
             = 138

                 138 / 2 = 69 r0
                  69 / 2 = 34 r1
                  34 / 2 = 17 r0
                  17 / 2 =  8 r1
                   8 / 2 =  4 r0
                   4 / 2 =  2 r0
                   2 / 2 =  1 r0
                   1 / 2 =  0 r1

            => 10001010b
            ```
        * Resulting 32-bit floating point number
          ```none
          0 10001010 11111111011001000000000
          ```

5. Convert the following numbers from 32-bit floating point to decimal.
   1. 0x3F82000

      Note that 0x3F82000 doesn't represent 32-bits, it represents only 28.
      Normally we'd zero-fill on the left (i.e., 0x03F82000).  I worked
      through the assignment using that and the numbers were ... extreme.
      Instead, I'm going to zero-fill on the right (i.e., 0x3F820000).

      * Convert hex to decimal
        ```none
         0 * 16^0     =  0 *         1     =          0 
         0 * 16^1     =  0 *        16     =          0 
         0 * 16^2     =  0 *       256     =          0
         0 * 16^3     =  0 *      4096     =          0
         2 * 16^4     =  2 *     65536     =     131072
         8 * 16^5     =  8 *   1048576     =    8388608
         F * 16^6     = 15 *  16777216     =  251658240
         3 * 16^7     =  3 * 268435456     =  805306368
                                             ----------
                                             1065484288
        ```
      * Convert decimal to binary
        ```none
        1065484288 / 2 =  532742144 r0
         532742144 / 2 =  266371072 r0
         266371072 / 2 =  133185536 r0
         133185536 / 2 =   66592768 r0
          66592768 / 2 =   33296384 r0
          33296384 / 2 =   16648192 r0
          16648192 / 2 =    8324096 r0
           8324096 / 2 =    4162048 r0
           4162048 / 2 =    2081024 r0
           2081024 / 2 =    1040512 r0
           1040512 / 2 =     520256 r0
            520256 / 2 =     260128 r0
            260128 / 2 =     130064 r0
            130064 / 2 =      65032 r0
             65032 / 2 =      32516 r0
             32516 / 2 =      16258 r0
             16258 / 2 =       8129 r0
              8129 / 2 =       4064 r1
              4064 / 2 =       2032 r0
              2032 / 2 =       1016 r0
              1016 / 2 =        508 r0
               508 / 2 =        254 r0
               254 / 2 =        127 r0
               127 / 2 =         63 r1
                63 / 2 =         31 r1
                31 / 2 =         15 r1
                15 / 2 =          7 r1
                 7 / 2 =          3 r1
                 3 / 2 =          1 r1
                 1 / 2 =          0 r1

        => 111111100000100000000000000000b
        ```
      * Expand binary representation to 32 bits
        ```
        111111100000100000000000000000b  =>  00111111100000100000000000000000b
        ```
      * Split into fields (1 sign bit, 8 exponent bits, 23 fraction bits)
        ```none
        0 01111111 00000100000000000000000
        ```
      * Convert biased exponent to decimal
        ```none
           Biased exponent: 01111111

           1 * 2^0  =  1 *   1  =   1
           1 * 2^1  =  1 *   2  =   2
           1 * 2^2  =  1 *   4  =   4
           1 * 2^3  =  1 *   8  =   8
           1 * 2^4  =  1 *  16  =  16
           1 * 2^5  =  1 *  32  =  32
           1 * 2^6  =  1 *  64  =  64
           0 * 2^7  =  0 * 128  =   0
                                  ---
        =>                        127
        ```
      * Convert biased exponent to exponent
        ```none
         biased-exponent =  bias + power-2 exponent
         127             =  127  + power-2 exponent
        -127               -127
           0             =         power-2 exponent
        ```
      * Apply exponent to fraction (with implied leading 1)
        ```none
           1.00000100000000000000000 * 2^(0)

        => 1.00000100000000000000000
        ```
      * Convert binary to decimal
        ```none
           1 * 2^0      =   1 * 1                           =  1
           0 * 2^(-1)   =   0 * (1/ 2)   =   0 * 0.5        =  0
           0 * 2^(-2)   =   0 * (1/ 4)   =   0 * 0.25       =  0
           0 * 2^(-3)   =   0 * (1/ 8)   =   0 * 0.125      =  0
           0 * 2^(-4)   =   0 * (1/16)   =   0 * 0.0625     =  0
           0 * 2^(-5)   =   0 * (1/32)   =   0 * 0.03125    =  0
           1 * 2^(-6)   =   1 * (1/64)   =   1 * 0.015625   =  0.015625
                                                               --------
        =>                                                     1.015625
        ```
      * Apply the sign bit
        ```none
        The sign bit is 0, so the number is positive.

        Answer: 1.015625
        ```

   2. 0xBF82000
      * Expand to 32-bits
        ```none
        0xBF82000  =>  0xBF820000
        ```
      * Convert hex to decimal
        ```none
         0 * 16^0     =  0 *         1     =          0 
         0 * 16^1     =  0 *        16     =          0 
         0 * 16^2     =  0 *       256     =          0
         0 * 16^3     =  0 *      4096     =          0
         2 * 16^4     =  2 *     65536     =     131072
         8 * 16^5     =  8 *   1048576     =    8388608
         F * 16^6     = 15 *  16777216     =  251658240
         B * 16^7     = 11 * 268435456     = 2952790016
                                             ----------
                                             3212967936
        ```
      * Convert decimal to binary
        ```none
        3212967936 / 2 = 1606483968 r0
        1606483968 / 2 =  803241984 r0
         803241984 / 2 =  401620992 r0
         401620992 / 2 =  200810496 r0
         200810496 / 2 =  100405248 r0
         100405248 / 2 =   50202624 r0
          50202624 / 2 =   25101312 r0
          25101312 / 2 =   12550656 r0
          12550656 / 2 =    6275328 r0
           6275328 / 2 =    3137664 r0
           3137664 / 2 =    1568832 r0
           1568832 / 2 =     784416 r0
            784416 / 2 =     392208 r0
            392208 / 2 =     196104 r0
            196104 / 2 =      98052 r0
             98052 / 2 =      49026 r0
             49026 / 2 =      24513 r0
             24513 / 2 =      12256 r1
             12256 / 2 =       6128 r0
              6128 / 2 =       3064 r0
              3064 / 2 =       1532 r0
              1532 / 2 =        766 r0
               766 / 2 =        383 r0
               383 / 2 =        191 r1
               191 / 2 =         95 r1
                95 / 2 =         47 r1
                47 / 2 =         23 r1
                23 / 2 =         11 r1
                11 / 2 =          5 r1
                 5 / 2 =          2 r1
                 2 / 2 =          1 r0
                 1 / 2 =          0 r1


        => 10111111100000100000000000000000b
        ```
      * Note that we already have 32 bits, no leading zeros needed
      * Split into fields (1 sign bit, 8 exponent bits, 23 fraction bits)
        ```none
        1 01111111 00000100000000000000000
        ```
      * Convert biased exponent to decimal
        ```none
           Biased exponent: 01111111

           1 * 2^0  =  1 *   1  =   1
           1 * 2^1  =  1 *   2  =   2
           1 * 2^2  =  1 *   4  =   4
           1 * 2^3  =  1 *   8  =   8
           1 * 2^4  =  1 *  16  =  16
           1 * 2^5  =  1 *  32  =  32
           1 * 2^6  =  1 *  64  =  64
           0 * 2^7  =  0 * 128  =   0
                                  ---
        =>                        127
        ```
      * Convert biased exponent to exponent
        ```none
         biased-exponent =  bias + power-2 exponent
         127             =  127  + power-2 exponent
        -127               -127
           0             =         power-2 exponent
        ```
      * Apply exponent to fraction (with implied leading 1)
        ```none
           1.00000100000000000000000 * 2^(0)

        => 1.00000100000000000000000
        ```
      * Convert binary to decimal
        ```none
           1 * 2^0      =   1 * 1                           =  1
           0 * 2^(-1)   =   0 * (1/ 2)   =   0 * 0.5        =  0
           0 * 2^(-2)   =   0 * (1/ 4)   =   0 * 0.25       =  0
           0 * 2^(-3)   =   0 * (1/ 8)   =   0 * 0.125      =  0
           0 * 2^(-4)   =   0 * (1/16)   =   0 * 0.0625     =  0
           0 * 2^(-5)   =   0 * (1/32)   =   0 * 0.03125    =  0
           1 * 2^(-6)   =   1 * (1/64)   =   1 * 0.015625   =  0.015625
                                                               --------
        =>                                                     1.015625
        ```
      * Apply the sign bit
        ```none
        The sign bit is 1, so the number is negative.

        Answer: -1.015625
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
