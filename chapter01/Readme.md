# Exercises

1. Enter the assembly language program from this chapter and assemble and
   link it. Then execute the program from the command line and enter
   `"echo $?"`.  By convention in UNIX systems, a non-zero status from a
   program indicates an error. Change the program to yield a 0 status.

   ```asm
       segment .text
       global  _start ; _start is the entry point the linker expects
   
   _start:
       mov eax, 60    ; 60 is the exit syscall number
       mov edi,  0    ; the status value to return
       syscall        ; execute the system call number stored in eax
       end
   ```

2. Modify the assembly program to define `main` rather than `start`.
   Assemble it and link it using `ebe`. What is the difference in size of the
   executables?

   ```asm
       segment .text
       global  main
   
   main:
       mov eax, 60 ; 60 is the exit syscall number
       mov edi,  0 ; the status value to return
       syscall     ; execute the system call number stored in eax
       end
   ```

   I'm using `yasm` + `ld` instead of `ebe`.  To change the entry point from
   `_start` to `main`, I needed to use `gcc` to finish the linking.  I used
   `-nostdlib` to avoid including glibc.  The executable is larger because
   is includes support for dynamic linking.

   Executable sizes:
   ```none
   $ ls -l exercise_[12]
   -rwxr-xr-x 1 user group  5224 Sep 24 14:24 exercise_1
   -rwxr-xr-x 1 user group 13920 Sep 24 14:24 exercise_2
   ```

   Symbols for the program that defines `_start`:
   ```none
   $ readelf -a exercise_1
   ELF Header:
     Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00
     Class:                             ELF64
     Data:                              2's complement, little endian
     Version:                           1 (current)
     OS/ABI:                            UNIX - System V
     ABI Version:                       0
     Type:                              EXEC (Executable file)
     Machine:                           Advanced Micro Devices X86-64
     Version:                           0x1
     Entry point address:               0x401000
     Start of program headers:          64 (bytes into file)
     Start of section headers:          4648 (bytes into file)
     Flags:                             0x0
     Size of this header:               64 (bytes)
     Size of program headers:           56 (bytes)
     Number of program headers:         2
     Size of section headers:           64 (bytes)
     Number of section headers:         9
     Section header string table index: 8
   
   Section Headers:
     [Nr] Name              Type             Address           Offset
          Size              EntSize          Flags  Link  Info  Align
     [ 0]                   NULL             0000000000000000  00000000
          0000000000000000  0000000000000000           0     0     0
     [ 1] .text             PROGBITS         0000000000401000  00001000
          000000000000000c  0000000000000000  AX       0     0     16
     [ 2] .debug_aranges    PROGBITS         0000000000000000  00001010
          0000000000000030  0000000000000000           0     0     16
     [ 3] .debug_info       PROGBITS         0000000000000000  00001040
          0000000000000067  0000000000000000           0     0     1
     [ 4] .debug_abbrev     PROGBITS         0000000000000000  000010a7
          0000000000000014  0000000000000000           0     0     1
     [ 5] .debug_line       PROGBITS         0000000000000000  000010bb
          0000000000000042  0000000000000000           0     0     1
     [ 6] .symtab           SYMTAB           0000000000000000  00001100
          00000000000000a8  0000000000000018           7     3     8
     [ 7] .strtab           STRTAB           0000000000000000  000011a8
          0000000000000026  0000000000000000           0     0     1
     [ 8] .shstrtab         STRTAB           0000000000000000  000011ce
          0000000000000056  0000000000000000           0     0     1
   Key to Flags:
     W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
     L (link order), O (extra OS processing required), G (group), T (TLS),
     C (compressed), x (unknown), o (OS specific), E (exclude),
     D (mbind), l (large), p (processor specific)
   
   There are no section groups in this file.
   
   Program Headers:
     Type           Offset             VirtAddr           PhysAddr
                    FileSiz            MemSiz              Flags  Align
     LOAD           0x0000000000000000 0x0000000000400000 0x0000000000400000
                    0x00000000000000b0 0x00000000000000b0  R      0x1000
     LOAD           0x0000000000001000 0x0000000000401000 0x0000000000401000
                    0x000000000000000c 0x000000000000000c  R E    0x1000
   
    Section to Segment mapping:
     Segment Sections...
      00
      01     .text
   
   There is no dynamic section in this file.
   
   There are no relocations in this file.
   No processor specific unwind information to decode
   
   Symbol table '.symtab' contains 7 entries:
      Num:    Value          Size Type    Bind   Vis      Ndx Name
        0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
        1: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS exercise_1.s
        2: 000000000040100c     0 NOTYPE  LOCAL  DEFAULT    1 end
        3: 0000000000401000     0 NOTYPE  GLOBAL DEFAULT    1 _start
        4: 0000000000402000     0 NOTYPE  GLOBAL DEFAULT    1 __bss_start
        5: 0000000000402000     0 NOTYPE  GLOBAL DEFAULT    1 _edata
        6: 0000000000402000     0 NOTYPE  GLOBAL DEFAULT    1 _end
   
   No version information found in this file.
   ```

   Symbols for the program that defines `main`:
   ```none
   $ readelf -a exercise_2
   ELF Header:
     Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00 
     Class:                             ELF64
     Data:                              2's complement, little endian
     Version:                           1 (current)
     OS/ABI:                            UNIX - System V
     ABI Version:                       0
     Type:                              DYN (Position-Independent Executable file)
     Machine:                           Advanced Micro Devices X86-64
     Version:                           0x1
     Entry point address:               0x1000
     Start of program headers:          64 (bytes into file)
     Start of section headers:          12960 (bytes into file)
     Flags:                             0x0
     Size of this header:               64 (bytes)
     Size of program headers:           56 (bytes)
     Number of program headers:         8
     Size of section headers:           64 (bytes)
     Number of section headers:         15
     Section header string table index: 14
   
   Section Headers:
     [Nr] Name              Type             Address           Offset
          Size              EntSize          Flags  Link  Info  Align
     [ 0]                   NULL             0000000000000000  00000000
          0000000000000000  0000000000000000           0     0     0
     [ 1] .interp           PROGBITS         0000000000000200  00000200
          000000000000001c  0000000000000000   A       0     0     1
     [ 2] .gnu.hash         GNU_HASH         0000000000000220  00000220
          000000000000001c  0000000000000000   A       3     0     8
     [ 3] .dynsym           DYNSYM           0000000000000240  00000240
          0000000000000018  0000000000000018   A       4     1     8
     [ 4] .dynstr           STRTAB           0000000000000258  00000258
          0000000000000001  0000000000000000   A       0     0     1
     [ 5] .text             PROGBITS         0000000000001000  00001000
          000000000000000c  0000000000000000  AX       0     0     16
     [ 6] .eh_frame         PROGBITS         0000000000002000  00002000
          0000000000000000  0000000000000000   A       0     0     8
     [ 7] .dynamic          DYNAMIC          0000000000002f30  00002f30
          00000000000000d0  0000000000000010  WA       4     0     8
     [ 8] .debug_aranges    PROGBITS         0000000000000000  00003000
          0000000000000030  0000000000000000           0     0     16
     [ 9] .debug_info       PROGBITS         0000000000000000  00003030
          0000000000000067  0000000000000000           0     0     1
     [10] .debug_abbrev     PROGBITS         0000000000000000  00003097
          0000000000000014  0000000000000000           0     0     1
     [11] .debug_line       PROGBITS         0000000000000000  000030ab
          0000000000000042  0000000000000000           0     0     1
     [12] .symtab           SYMTAB           0000000000000000  000030f0
          00000000000000f0  0000000000000018          13     5     8
     [13] .strtab           STRTAB           0000000000000000  000031e0
          0000000000000034  0000000000000000           0     0     1
     [14] .shstrtab         STRTAB           0000000000000000  00003214
          000000000000008b  0000000000000000           0     0     1
   Key to Flags:
     W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
     L (link order), O (extra OS processing required), G (group), T (TLS),
     C (compressed), x (unknown), o (OS specific), E (exclude),
     D (mbind), l (large), p (processor specific)
   
   There are no section groups in this file.
   
   Program Headers:
     Type           Offset             VirtAddr           PhysAddr
                    FileSiz            MemSiz              Flags  Align
     PHDR           0x0000000000000040 0x0000000000000040 0x0000000000000040
                    0x00000000000001c0 0x00000000000001c0  R      0x8
     INTERP         0x0000000000000200 0x0000000000000200 0x0000000000000200
                    0x000000000000001c 0x000000000000001c  R      0x1
         [Requesting program interpreter: /lib64/ld-linux-x86-64.so.2]
     LOAD           0x0000000000000000 0x0000000000000000 0x0000000000000000
                    0x0000000000000259 0x0000000000000259  R      0x1000
     LOAD           0x0000000000001000 0x0000000000001000 0x0000000000001000
                    0x000000000000000c 0x000000000000000c  R E    0x1000
     LOAD           0x0000000000002000 0x0000000000002000 0x0000000000002000
                    0x0000000000000000 0x0000000000000000  R      0x1000
     LOAD           0x0000000000002f30 0x0000000000002f30 0x0000000000002f30
                    0x00000000000000d0 0x00000000000000d0  RW     0x1000
     DYNAMIC        0x0000000000002f30 0x0000000000002f30 0x0000000000002f30
                    0x00000000000000d0 0x00000000000000d0  RW     0x8
     GNU_RELRO      0x0000000000002f30 0x0000000000002f30 0x0000000000002f30
                    0x00000000000000d0 0x00000000000000d0  R      0x1
   
    Section to Segment mapping:
     Segment Sections...
      00     
      01     .interp 
      02     .interp .gnu.hash .dynsym .dynstr 
      03     .text 
      04     .eh_frame 
      05     .dynamic 
      06     .dynamic 
      07     .dynamic 
   
   Dynamic section at offset 0x2f30 contains 8 entries:
     Tag        Type                         Name/Value
    0x000000006ffffef5 (GNU_HASH)           0x220
    0x0000000000000005 (STRTAB)             0x258
    0x0000000000000006 (SYMTAB)             0x240
    0x000000000000000a (STRSZ)              1 (bytes)
    0x000000000000000b (SYMENT)             24 (bytes)
    0x0000000000000015 (DEBUG)              0x0
    0x000000006ffffffb (FLAGS_1)            Flags: PIE
    0x0000000000000000 (NULL)               0x0
   
   There are no relocations in this file.
   No processor specific unwind information to decode
   
   Symbol table '.dynsym' contains 1 entry:
      Num:    Value          Size Type    Bind   Vis      Ndx Name
        0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND 
   
   Symbol table '.symtab' contains 10 entries:
      Num:    Value          Size Type    Bind   Vis      Ndx Name
        0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND 
        1: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS exercise_2.s
        2: 000000000000100c     0 NOTYPE  LOCAL  DEFAULT    5 end
        3: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS 
        4: 0000000000002f30     0 OBJECT  LOCAL  DEFAULT    7 _DYNAMIC
        5: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND _start
        6: 0000000000003000     0 NOTYPE  GLOBAL DEFAULT    7 __bss_start
        7: 0000000000001000     0 NOTYPE  GLOBAL DEFAULT    5 main
        8: 0000000000003000     0 NOTYPE  GLOBAL DEFAULT    7 _edata
        9: 0000000000003000     0 NOTYPE  GLOBAL DEFAULT    7 _end
   
   No version information found in this file.
   ```

3. In C and many other languages, 0 means false and 1 (or non-zero) means true.
   In the shell 0 for the status of a process means success and non-zero means
   an error.  Shell `if` statements essentially use 0 for true.  Why did the
   writer of the first shell decide to use 0 for true?

   A process return status communicates more than a true/false value -- it
   communicates two pieces of information: (1) was the operation successful?
   and (2) if not, what was the failure mode?  In case (2), there can be more
   than one failure mode.  The writer of the first shell used 0 for success,
   allowing program writers to use non-zero values to encode their failure
   modes.
