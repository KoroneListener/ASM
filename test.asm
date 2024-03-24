 .text
.section .rdata, "dr"

.LC0:
    .ascii "Hello, world!\0"
.text
.globl  main
.seh_proc   main
main:
    pushq %rbp
    .seh_pushreg    %rbp
    movq    %rsp, %rbp
    subq    $32, %rsp
    .seh_stackalloc 32
    .seh_endprologue
    call    __main
    leaq    .LC0(%rip), %rax
    movq    %rax, %rcx
    call    puts
    addq    $32, %rsp
    popq    %rbp
    ret
.seh_endproc
.ident  "GCC"
