.section .rdata,"dr"
.first:
    .ascii "First element: %d\n\0"
.last:
    .ascii "Last element: %d\n\0"

.text
.globl  main
.def    main
.seh_proc   main

main:
    pushq   %rbp
    .seh_pushreg    %rbp
    movq    %rsp, %rbp
    .seh_setframe    %rbp, 0
    subq    $80, %rsp
    .seh_stackalloc   80
    .seh_endprologue
    call    __main
    movl    $0, -4(%rbp)
    jmp .fill
.loop:
    movl    -4(%rbp), %eax
    leal    1(%rax), %edx
    movl    -4(%rbp), %eax
    cltq
    movl    %edx, -48(%rbp, %rax,4)
    addl    $1, -4(%rbp)
.fill:
    cmpl    $9, -4(%rbp)
    jle .loop
    movl    -48(%rbp), %eax
    movl    %eax, %edx
    leaq    .first(%rip), %rax
    movq    %rax, %rcx
    call    printf
    movl    -12(%rbp), %eax
    movl    %eax, %edx
    leaq    .last(%rip), %rax
    movq    %rax, %rcx
    call    printf
    movl    $0, %eax
    addq    $80, %rsp
    popq    %rbp
    ret
    .seh_endproc

