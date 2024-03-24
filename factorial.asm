	.text
.section .rdata, "dr"

.format:
    .ascii "%d! = %lld\n\0"  # Format string for printing factorials

.text
.globl main
.seh_proc main
main:
    pushq %rbp
    .seh_pushreg %rbp
    movq %rsp, %rbp
    subq $48, %rsp
    .seh_stackalloc 48
    .seh_endprologue

    movl $10, -16(%rbp)     # Number of factorials to calculate
    movq $1, -8(%rbp)       # Initialize factorial
    movl $1, -12(%rbp)      # Initialize counter

loop_start:
    movl -12(%rbp), %eax    # Load counter into %eax
    cltq                    # Sign-extend %eax into %rax
    movq -8(%rbp), %rdx     # Load factorial into %rdx
    imulq %rdx, %rax        # Multiply current factorial by counter
    movq %rax, -8(%rbp)     # Store the new factorial
    movq -8(%rbp), %rdx     # Load factorial into %rdx
    movl -12(%rbp), %eax    # Load counter into %eax
    movq %rdx, %r8          # Move factorial into %r8
    movl %eax, %edx         # Move counter into %edx
    leaq .format(%rip), %rax   # Load format string address
    movq %rax, %rcx         # Move format string address into %rcx
    call printf             # Call printf to print factorial

    addl $1, -12(%rbp)      # Increment counter
    movl -12(%rbp), %eax    # Load counter into %eax
    cmpl -16(%rbp), %eax    # Check if we have reached the limit
    jle loop_start          # If not, continue looping

    movl $0, %eax           # Return 0
    addq $48, %rsp          # Clean up stack
    popq %rbp
    ret
.seh_endproc

