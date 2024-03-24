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
    subq    $64, %rsp
    .seh_stackalloc    64
    .seh_endprologue
    call    __main
    movl    $1, -32(%rbp)
    movl    $2, -28(%rbp)
    movl    $3, -24(%rbp)
    movl    $4, -20(%rbp)
    movl    $5, -16(%rbp)
    movl    $5, -4(%rbp)
    movl    -32(%rbp), %eax
    movl    %eax, %edx
    leaq    .first(%rip), %rcx
    call    printf
    movl    -4(%rbp), %eax
    subl    $1, %eax
    cltq
    movl    -32(%rbp,%rax,4), %eax
    movl    %eax, %edx
    leaq    .last(%rip), %rcx
    call    printf
    movl    $0, %eax
    addq    $64, %rsp
    popq    %rbp
    ret
    .seh_endproc

