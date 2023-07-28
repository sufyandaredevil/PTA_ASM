; HelloWorld.asm
; Author: Ahmed Sufyan


global _start ; letting the linker know the entry point using a label / _start identifier

section .text ; .text section where where code will be placed

_start: ; label _start

        ; print hello world on the screen using the write() syscall function (`man 2 write` for more info)
        ; (to get the syscall number we can refer /usr/include/i386-linux-gnu/asm/unistd_32.h file)
        ; eax always should have the syscall no when generating interrupt/return value to it, ebx,ecx,edx,esi,edi used for passing arguments(If greater then structures are used)
        mov eax, 0x4 ; syscall no 4; write(arg1, arg2, arg3) 
        mov ebx, 0x1 ; arg1(file descriptor): set to stdout 1 (terminal)
        mov ecx, message ; arg2(*buffer): pointing ecx to buffer `message`
        mov edx, mlen ; arg3(buffer_size): integer denoting length of the string `message`
        int 0x80 ; generate an interrupt

        ; exit the program gracefully
        mov eax, 0x1 ; syscall no 1; exit(arg1)
        mov ebx, 0x5 ; arg1(status): an integer for returning a status code
        int 0x80



section .data ; .data section where data will be placed

        message: db "Hello World!" ; label(message) for the defined byte(db) `Hello World!`
        mlen equ $-message ; contains the string length of the above message
