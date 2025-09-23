    .section .bss
    .lcomm obj_table, 4096*3  # simple table entries: oid->addr, size, type
    .lcomm obj_next, 8

    .section .text
    .global alloc_object
alloc_object:
    # allocate slot: return oid in rax
    mov obj_next(%rip), %rax
    cmp $0, %rax
    jne .have
    mov $1, %rax
.have:
    mov %rax, %rdi
    inc %rax
    mov %rax, obj_next(%rip)
    ret

    .global free_object
free_object:
    # rdi = oid
    # stub: no-op
    ret

    .global ref_create
ref_create:
    # rdi = target_oid
    call alloc_object
    # demo: return new oid in rax
    ret

    .global ref_deref
ref_deref:
    # rdi = ref_oid
    # demo: echo ref_oid in rax
    mov %rdi, %rax
    ret
