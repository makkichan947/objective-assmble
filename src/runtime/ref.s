    .section .text
    .global ref_print_demo
ref_print_demo:
    # rdi = value (number)
    push %rbp
    mov %rsp, %rbp
    mov %rdi, %rax

    # print prefix "DEREF: "
    lea deref_msg(%rip), %rsi
    mov $deref_len, %rdx
    mov $1, %rax
    mov $1, %rdi
    syscall

    # convert number in rax to ascii on stack and write (simple)
    mov %rax, %r8
    lea numbuf(%rip), %rsi
    mov $0, %rcx
    cmp $0, %r8
    jne .conv
    movb $'0', (%rsi)
    mov $1, %rdx
    mov $1, %rax
    mov $1, %rdi
    mov %rsi, %rsi
    syscall
    jmp .done
.conv:
    # naive conversion, not robust
    mov $0, %rcx
.loop:
    mov $10, %rbx
    xor %rdx, %rdx
    div %rbx
    add $'0', %dl
    mov %dl, (%rsi,%rcx)
    inc %rcx
    cmp $0, %rax
    jne .loop
    # write buffer (reverse)
    lea numbuf(%rip), %rsi
    mov %rcx, %rdx
    mov $1, %rax
    mov $1, %rdi
    syscall

.done:
    # newline
    lea nl(%rip), %rsi
    mov $1, %rdx
    mov $1, %rax
    mov $1, %rdi
    syscall

    pop %rbp
    ret

    .section .rodata
deref_msg:
    .ascii "DEREF: "
deref_len = . - deref_msg
nl:
    .ascii "\n"

    .section .bss
    .lcomm numbuf, 32
