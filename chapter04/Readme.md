# Exercises

1. Suppose you were given the opportunity to redesign the memory mapping
   hierarchy for a new CPU. We have seen that 4KB pages seem a little small.
   Suppose you made the pages 2<sup>17</sup> = 131072 bytes. How many 64-bit
   pointers would fit in such a pages.

   ```none
   1 page    = 2^17 bytes = 131072 bytes
   1 pointer = 2^3  bytes =      8 bytes

   2^17 / 2^3 = 2^14 = 16384 pointers per page
   ```

2. How many bits would be required for the addressing of a page table?

   ```none
   With 8-byte word addressing:

   log-base-2(16384) = 14 bits
   ```

3. How would you break up the bit fields of virtual addresses?
   ```none
   I haven't done this one yet.
   ```

4. Having much larger pages seems desirable. Let's design a memory mapping
   system with pages of 2<sup>20</sup> = 1048576 bytes but use partial pages
   for memory mapping tables. Design a system with 3 levels of page mapping
   tables with at least 48 bits of usable virtual address space.
   ```none
   I haven't done this one yet.
   ```

5. Suppose a virtual memory address is 0x123456789012. Divide this address into
   the 4 different page table parts and the within page offset. 
   ```none
   I haven't done this one yet.
   ```

6. Suppose a virtual memory address is 0x123456789012. Suppose this happens
   to be an address within a 2MB page. What is the within page offset for this
   address?
   ```none
   I haven't done this one yet.
   ```

7. Write an assembly language program to compute the cost of electricity for
   a home. The cost per kilowatt hour will be an integer number of pennies
   stored in a memory location. The kilowatt hours used will also be an
   integer stored in memory. The bill amount will be $5.00 plus the cost
   per kilowatt hour times the number of kilowatt hours over 1000. You can
   use a conditional move to set the number of hours over 1000 to 0 if the
   number of hourse over 1000 is negative. Move the number of dollars into
   one memory location and the number of pennies into another.
   ```none
   I haven't done this one yet.
   ```
