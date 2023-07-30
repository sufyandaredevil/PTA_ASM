OS : LINUX (KUBUNTU)  
OS ARCHITECTURE: x86 (32 Bit)  
CPU MODE: PROTECTED  
MEMORY MODEL: FLAT  

### Fundamental Data Types:
- Byte - 8 bits
- Word - 16 bits
- Double Word - 32 bits
- Quad Word - 64 bits
- Double Quad Word - 128 bits
  > **NOTE:**
  >  - **Unsigned data type** consumes all the space available 
  >  - **Signed data type** uses the Most Significant Bit as the Sign Bit

### Tools to install:
- `sudo apt install nasm build-essential`
- `sudo apt install gdb`

### NASM MISC:
- Consider the following example:
  > Define byte 0xAA, 0xBB, 0xCC, OxDD with the label message:
  > ``` asm
  > message db 0xAA, 0xBB, 0xCC, OxDD
  >```
  > Here:
  > - `mov eax, message` - moves **address** into eax
  > - `mov eax, [message]` - moves **value** into eax

### Help MISC:
- View available System call functions:
  - `cat /usr/include/i386-linux-gnu/asm/unistd32.h`

- Open documentation for a specific Syscall:
  - `man 2 <syscall_func>`
    - example: `man 2 write`

- Open documentation for a specific C Library Function:
  - `man 3 <syscall_func>`
    - example: `man 3 printf`

- Assemble using NASM:
  - `nasm -f elf32 -o <out_file.o> <in_file.asm>`

- Linking using GNU Linker:
  - `ld -o <out_file> <in_obj_file.o>`

- Linking using GCC Linker:
  - `gcc <in_obj_file.o>`

-  Display program's machine code and disassembled code:
  - `objdump -d <program_name> -M intel`

- Get all shellcode on binary file from objdump:
  - `objdump -d ./<program_name>|grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'`

- To find the opcode equivalent - `msf-nasm_shell`

### General Commands:
- Find CPU Details:
  - `lscpu`
  - `cat /proc/cpuinfo`

- View Process Organization:
  - `cat /proc/<pid>/maps`
  - `pmap -d <pid>`

### GDB Examinination MISC:
- Examine String:
  - `x/s`
- Examine HEX:
  - `x/x`
- Examine 8 consecutive bytes in HEX:
  - `x/8xb`
- Examine WORD in HEX:
  - `x/xh`
- Examine DWORD in HEX:
  - `x/xw`
- Examine and disassemble `n` consecutive bytes as instructions:
  - `x/[<n>]i 0x<memory_address>`

### GDB Commands:
- To open GDB and debug a program:
  - `gdb <program_name>`
    - example: `gdb /bin/bash`
  - `-q` - for quiet mode

- Set Breakpoint for main function
  - `break main`

- Set Breakpoint using immediate memory address value:
  - `break *<memory_address>`
    - example: `break *0x0804a018`

- Run the program:
  - `run`

- Lookup CPU registers
  - `info registers`

- Print FLAGS:
  - `p|print $eflags`

- Print register's content:
  - `print/x $<register_name>`
    - example: `print/x $eax`

- Display register's content whenever program stops at a breakpoint or while stepping through:
  - `display/x $<register_name>`
    - example: `display/x $eax`

- Print disassembled code from Instruction Poiinter:
  - `disassemble $eip`

- Display all registers:
  - `info all-registers`

- Switch disassemble syntax to intel:
  - `set disassembly-flavor intel`

- Process map within GDB:
  - `info proc mappings`

- Step through instructions:
  - `stepi`

- Examine memory and print location as string:
  - `x/s <memory_address>`
    - example: `x/s 0x80490a4`
    > **NOTE:** Here `s` in `x/s` is denoting gdb to print it as a String

- Examine something that's pointing to a memory address
  - `x/xh <memory_address>`
    > **NOTE:** Here `h` in `x/h` is denoting gdb to print it as a WORD(2 Bytes)
    >
    > Example:
      > If asm contains the code:
      > ``` asm 
      > push DWORD [sample]
      >```
      > And disassembled code contains:
      > ``` asm 
      > push DWORD PTR ds: 0x80490b0
      >```
      > Then, during gdbugging we can use: `x/xh 0x80490b0` to find what value is present at that memory address


- View different functions:
  - `info functions`
    > **NOTE:** Useful if we don't have any info about the binary we're debugging

- Print the elfheader:
  - `shell readelf -h <program_name>`
    - example: `shell readelf -h /bin/bash`
    > **NOTE:** Here `shell` helps to execute available linux programs for the purpose of helping with the debugging process. Here we've used `readelf`. This can also bee used to find the entrypoint if no funcions are found.

- Print the equivalent c source (if any):
  - `shell cat <in_file>`
    - example: `shell cat shellcode.c`

- Print the variables from .data, .bss section:
  - `info variables`

- Print the value(s) of a variable:
  - `x/[<n>]xb <address>|&<var_name>`
    - example: `x/xb 0x80490a4`
    - example: `x/xb &var1`
    - example: `x/3xb &var2` (for retrieving sequence of 3 bytes)
    > **NOTE:** Here the **address**, **var_name** can be found using the `info variables` command

- Print the address of a variable:
  - `print [/x] &<var_name>`
    - example: `print &var4`

- Defining a hook to print certain values whenever program stops in a breakpoint or when stepping through:
  > - `define hook-stop`
  > - `print/x $eax`
  > - `print/x $ebx`
  > - `print/x $ecx`
  > - `x/8xb &sample`
  > - `disassemble $eip,+10`
  > - `end`
  > ---
  > **Explanation:**
  > - `print/x $eax, $ebx, $ecx` will print the hexadecimal value(`x`) of those registers
  > - `x/8xb &sample` will examine `8` bytes(`x`) of memory content in hexadecimal (`x`) starting from the address of the `sample` variable. The `/8xb` specifies the format, where `8` is the number of units to display (`8` bytes in this case), `x` represents hexadecimal format, and `b` stands for bytes
  > - `disassemble $eip,+10` will disassemble for the next `10` bytes of instructions starting from the current value of the `$eip`
  > - The `end` statement is used to indicate that the hook-stop command block is complete, and the defined behavior should end at that point.
  > ---
  > Further we use `nexti` to single step through the program by pressing `ENTER` key and pressing `C|c` to continue running the remaining program without debugging
