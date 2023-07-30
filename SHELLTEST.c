#include<stdio.h>
#include<string.h>
unsigned char code[] = \
"\x90"
main(){printf("slen: %d\n",strlen(code));int (*r)() = (int(*)())code;}
r();
