    .section .bss
    .lcomm file_buf, 131072
    .lcomm file_len, 8

    .section .text
    .global read_file
read_file:
    push %rbp
    mov %rsp, %rbp
    mov %rdi, %rsi
    mov (%rsi), %rdi

    mov $2, %rax
    xor %rsi, %rsi
    xor %rdx, %rdx
    syscall
    cmp $0, %rax
    js rf_err
    mov %rax, %r12

    mov $0, %rax
    mov %r12, %rdi
    lea file_buf(%rip), %rsi
    mov $131072, %rdx
    syscall
    cmp $0, %rax
    js rf_err
    mov %rax, file_len(%rip)

    mov $3, %rax
    mov %r12, %rdi
    syscall

    pop %rbp
    ret

rf_err:
    lea rfmsg(%rip), %rsi
    mov $rfmsg_len, %rdx
    mov $1, %rax
    mov $1, %rdi
    syscall
    mov $60, %rax
    mov $1, %rdi
    syscall

    .section .rodata
rfmsg:
    .ascii "read_file failed\n"
rfmsg_len = . - rfmsg
