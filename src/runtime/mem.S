    .section .bss
    .lcomm heap_area, 131072
    .lcomm heap_ptr, 8

    .section .text
    .global mem_alloc
mem_alloc:
    mov heap_ptr(%rip), %rax
    cmp $0, %rax
    jne .use
    lea heap_area(%rip), %rax
.use:
    mov %rax, %rdi
    mov %rsi, %rcx
    add %rcx, %rax
    mov %rax, heap_ptr(%rip)
    ret