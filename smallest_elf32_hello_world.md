```bash
$ cat hello.s
```
```asm
global _start

section .text
_start:
	xor edx, edx ; mov edx, len
	mov dl, len
	mov ecx, msg
	xor ebx, ebx ; mov ebx, 1
	inc ebx
	xor eax, eax ; mov eax, 4
	mov al, 4
	int 0x80
	xor ebx, ebx ; mov ebx, 0
	xor eax, eax ; mov eax, 1
	inc eax
	int 0x80

; section .rodata
msg:	db	'Hello, World!', 10
len:	equ $-msg
```

```bash
$ ls -l small.out 
-rwxrwxr-x 1 user user 123 abr 12 12:15 small.out

$ xxd -c 8 small.out 
00000000: 7f45 4c46 0101 0100  .ELF....
00000008: 0000 0000 0000 0000  ........
00000010: 0200 0300 0100 0000  ........
00000018: 5480 0408 3400 0000  T...4...
00000020: 0000 0000 0000 0000  ........
00000028: 3400 2000 0100 0000  4. .....
00000030: 0000 0000 0100 0000  ........
00000038: 5400 0000 5480 0408  T...T...
00000040: 5480 0408 2700 0000  T...'...
00000048: 2700 0000 0700 0000  '.......
00000050: 0400 0000 31d2 b20e  ....1...
00000058: b96d 8004 0831 db43  .m...1.C
00000060: 31c0 b004 cd80 31db  1.....1.
00000068: 31c0 40cd 8048 656c  1.@..Hel
00000070: 6c6f 2c20 576f 726c  lo, Worl
00000078: 6421 0a              d!.
```

```bash
$ readelf -a ./small.out
```
```
ELF Header:
  Magic:   7f 45 4c 46 01 01 01 00 00 00 00 00 00 00 00 00 
  Class:                             ELF32
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           Intel 80386
  Version:                           0x1
  Entry point address:               0x8048054
  Start of program headers:          52 (bytes into file)
  Start of section headers:          0 (bytes into file)
  Flags:                             0x0
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         1
  Size of section headers:           0 (bytes)
  Number of section headers:         0
  Section header string table index: 0

There are no sections in this file.

There are no sections to group in this file.

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  LOAD           0x000054 0x08048054 0x08048054 0x00027 0x00027 RWE 0x4

There is no dynamic section in this file.

There are no relocations in this file.

The decoding of unwind sections for machine type Intel 80386 is not currently supported.

Dynamic symbol information is not available for displaying symbols.

No version information found in this file.
```


```bash
$ dumpelf ./small.out
```
```c
#include <elf.h>

/*
 * ELF dump of './small.out'
 *     123 (0x7B) bytes
 */

Elf32_Dyn dumpedelf_dyn_0[];
struct {
	Elf32_Ehdr ehdr;
	Elf32_Phdr phdrs[1];
	Elf32_Shdr shdrs[0];
	Elf32_Dyn *dyns;
} dumpedelf_0 = {

.ehdr = {
	.e_ident = { /* (EI_NIDENT bytes) */
		/* [0] EI_MAG:        */ 0x7F,'E','L','F',
		/* [4] EI_CLASS:      */ 1 , /* (ELFCLASS32) */
		/* [5] EI_DATA:       */ 1 , /* (ELFDATA2LSB) */
		/* [6] EI_VERSION:    */ 1 , /* (EV_CURRENT) */
		/* [7] EI_OSABI:      */ 0 , /* (ELFOSABI_NONE) */
		/* [8] EI_ABIVERSION: */ 0 ,
		/* [9-15] EI_PAD:     */ 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
	},
	.e_type      = 2          , /* (ET_EXEC) */
	.e_machine   = 3          , /* (EM_386) */
	.e_version   = 1          , /* (EV_CURRENT) */
	.e_entry     = 0x8048054  , /* (start address at runtime) */
	.e_phoff     = 52         , /* (bytes into file) */
	.e_shoff     = 0          , /* (bytes into file) */
	.e_flags     = 0x0        ,
	.e_ehsize    = 52         , /* (bytes) */
	.e_phentsize = 32         , /* (bytes) */
	.e_phnum     = 1          , /* (program headers) */
	.e_shentsize = 0          , /* (bytes) */
	.e_shnum     = 0          , /* (section headers) */
	.e_shstrndx  = 0         
},

.phdrs = {
/* Program Header #0 0x34 */
{
	.p_type   = 1          , /* [PT_LOAD] */
	.p_offset = 84         , /* (bytes into file) */
	.p_vaddr  = 0x8048054  , /* (virtual addr at runtime) */
	.p_paddr  = 0x8048054  , /* (physical addr at runtime) */
	.p_filesz = 39         , /* (bytes in file) */
	.p_memsz  = 39         , /* (bytes in mem at runtime) */
	.p_flags  = 0x7        , /* PF_R | PF_W | PF_X */
	.p_align  = 4          , /* (min mem alignment in bytes) */
},
},

.shdrs = {
 /* no section headers ! */ },

.dyns = dumpedelf_dyn_0,
};
Elf32_Dyn dumpedelf_dyn_0[] = {
 /* no dynamic tags ! */ };
```
