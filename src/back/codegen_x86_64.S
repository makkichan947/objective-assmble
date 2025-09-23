    .section .text
    .global codegen_x86_64
    .extern file_buf
    .extern file_len
    .extern ref_print_demo

codegen_x86_64:
    push %rbp
    mov %rsp, %rbp

    lea header(%rip), %rsi
    mov $header_len, %rdx
    mov $1, %rax
    mov $1, %rdi
    syscall

    mov file_buf(%rip), %rsi
    mov file_len(%rip), %rcx
    test %rcx, %rcx
    jz cg_done

loop1:
    movzbq (%rsi), %rax
    cmp $0, %rax
    je cg_done
    cmp $10, %rax
    je newline
    cmp $'&', %rax
    je do_ref
    cmp $'^', %rax
    je do_deref
    # default: write this character
    mov $1, %rax
    mov $1, %rdi
    mov %rsi, %rsi
    mov $1, %rdx
    syscall
    inc %rsi
    dec %rcx
    jmp loop1

do_ref:
    # demo: call ref_print_demo with 1234
    mov $1234, %rdi
    call ref_print_demo
    inc %rsi
    dec %rcx
    jmp loop1

do_deref:
    mov $5678, %rdi
    call ref_print_demo
    inc %rsi
    dec %rcx
    jmp loop1

newline:
    # write newline
    lea nl(%rip), %rsi
    mov $1, %rax
    mov $1, %rdi
    mov $1, %rdx
    syscall
    inc %rsi
    dec %rcx
    jmp loop1

cg_done:
    pop %rbp
    ret

    .section .rodata
header:
    .ascii ";; objective-assmble generated (expanded demo)\n"
header_len = . - header

nl:
    .ascii "\n"
