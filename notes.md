[CPU MODE: PROTECTED; MEMORY MODEL: FLAT]

### Tools to install:
- `sudo apt install nasm build-essential`
- `sudo apt install gdb`

### General Commands:
- Find CPU Details:
  - `lscpu`
  - `cat /proc/cpuinfo`

---

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
