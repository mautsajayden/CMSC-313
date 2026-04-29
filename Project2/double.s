.section .data
    user_input:     .asciz "Enter a number: "
    wordLen  = . - user_input
    num:     .asciz "The double is: "
    numLen  = . - num
    newline:    .asciz "\n"

.section .bss
    input:  .skip 32
    result: .skip 32

.section .text
    .global _start

_start:
    # print user_input
    mov $1,  %rax
    mov $1, %rdi
    lea user_input(%rip),%rsi
    mov $wordLen, %rdx
    syscall

    #input 
    mov $0, %rax
    mov $0, %rdi
    lea input(%rip),  %rsi
    mov $32, %rdx
    syscall

    #convert ASCII to integer
    lea input(%rip),  %rsi
    xor %rax, %rax

convert_loop:
    movzbq (%rsi), %rbx
    cmp $'0', %rbx
    jl  done_convert
    cmp $'9', %rbx
    jg  done_convert
    sub $'0', %rbx
    imul $10, %rax, %rax
    add %rbx, %rax
    inc %rsi
    jmp convert_loop

done_convert:
    # double the number
    add %rax, %rax

    # convert integer to ASCII 
    lea result(%rip), %rsi
    add $31,  %rsi
    movb $0,  (%rsi)
    mov $10,  %rbx

convert_back:
    dec %rsi
    xor %rdx, %rdx
    div %rbx
    add $'0', %dl
    movb %dl, (%rsi)
    test %rax, %rax
    jnz convert_back

    mov %rsi, %r8
    
    lea result(%rip), %rcx
    add $31,   %rcx
    sub %rsi,  %rcx
    mov %rcx,  %r9

    
    mov $1,           %rax
    mov $1,           %rdi
    lea num(%rip), %rsi
    mov $numLen,  %rdx
    syscall

    mov $1,  %rax
    mov $1,  %rdi
    mov %r8, %rsi
    mov %r9, %rdx
    syscall

    mov $1,            %rax
    mov $1,            %rdi
    lea newline(%rip), %rsi
    mov $1,            %rdx
    syscall

    mov $60, %rax
    xor %rdi, %rdi
    syscall