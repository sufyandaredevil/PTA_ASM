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

### Help MISC:
- System call definitions:
  - `cat /usr/include/i386-linux-gnu/asm/unistd32.h`

- Open documentation for a specific syscall:
  - `man 2 <syscall_func>`
    - example: `man 2 write`

- Assemble using NASM:
  - `nasm -f elf32 -o <out_file.o> <in_file.asm>`

- Linking using GNU Linker:
  - `ld -o <out_file> <in_obj_file.o>`

### General Commands:
- Find CPU Details:
  - `lscpu`
  - `cat /proc/cpuinfo`

- View Process Organization:
  - `cat /proc/<pid>/maps`
  - `pmap -d <pid>`

### GDB Commands:
- To open GDB and debug a program:
  - `gdb <program_name>`
    - example: `gdb /bin/bash`

- Breakpoint for main function
  - `break main`

- Run the program:
  - `run`

- Lookup CPU registers
  - `info registers`

- Print register's content:
  - `display /x $<register_name>`
    - example: `display /x $eax`

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

