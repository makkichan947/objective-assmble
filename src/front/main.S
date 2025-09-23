    .section .text
    .global _start
    .extern read_file
    .extern codegen_x86_64
    .extern exit_success

_start:
    mov (%rsp), %rdi        # argc
    lea 8(%rsp), %rsi       # argv
    cmp $1, %rdi
    jle no_arg
    mov (%rsi), %rax
    add $8, %rsi
    mov (%rsi), %rdi

    call read_file
    call codegen_x86_64
    call exit_success

no_arg:
    lea usage(%rip), %rsi
    mov $usage_len, %rdx
    mov $1, %rax
    mov $1, %rdi
    syscall
    mov $60, %rax
    mov $1, %rdi
    syscall

    .section .rodata
usage:
    .ascii "Usage: oasm <source.oasm>\n"
usage_len = . - usage
