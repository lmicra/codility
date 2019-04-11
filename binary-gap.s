# -----------------------------------------------------------------------------
#   int16_t binary_gap(int32_t a)
# -----------------------------------------------------------------------------

    .global  binary_gap

    .text
binary_gap: # RDI, RSI, RDX, RCX, R8, R9, XMM0–7
    mov   %rdi, %rax
    bsf   %eax, %ecx
    jz    _exit

    test  %ecx, %ecx
    jz    _l2

    inc   %ecx
_l1:
    shr   %eax
    loop  _l1

_l2:
    bsr   %eax, %ecx
    test  %ecx, %ecx
    jz    _exit

_l3a:
    xor   %edx, %edx
_l3b:
    shr   %eax
    jc    _l4
    inc   %edx
    loop  _l3b
    inc   %ecx

_l4:
    cmp   %edx, %ebx
    jge   _l5
    mov   %edx, %ebx
_l5:
    loop  _l3a

    mov   %ebx, %eax

_exit:
    ret
