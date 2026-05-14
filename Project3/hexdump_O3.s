	.file	"hexdump.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%08lx "
.LC1:
	.string	"%02x "
.LC2:
	.string	"   "
.LC3:
	.string	"|"
	.text
	.p2align 4
	.globl	print_row
	.type	print_row, @function
print_row:
.LFB13:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	xorl	%eax, %eax
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	movl	%edx, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rsi, %rbp
	movq	%rdi, %rsi
	movl	$.LC0, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	xorl	%ebx, %ebx
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	call	printf
	jmp	.L4
	.p2align 4,,10
	.p2align 3
.L16:
	movzbl	0(%rbp,%rbx), %esi
	movl	$.LC1, %edi
	xorl	%eax, %eax
	addq	$1, %rbx
	call	printf
	cmpq	$16, %rbx
	je	.L15
.L4:
	cmpl	%ebx, %r12d
	jg	.L16
	movl	$.LC2, %edi
	xorl	%eax, %eax
	addq	$1, %rbx
	call	printf
	cmpq	$16, %rbx
	jne	.L4
.L15:
	movl	$124, %edi
	call	putchar
	testl	%r12d, %r12d
	jle	.L9
	call	__ctype_b_loc
	movq	%rbp, %rbx
	movq	%rax, %r13
	leal	-1(%r12), %eax
	leaq	1(%rbp,%rax), %rbp
	.p2align 4,,10
	.p2align 3
.L8:
	movzbl	(%rbx), %edx
	movq	0(%r13), %rax
	movq	stdout(%rip), %rsi
	movq	%rdx, %rdi
	testb	$64, 1(%rax,%rdx,2)
	jne	.L13
	movl	$46, %edi
.L13:
	call	putc
	addq	$1, %rbx
	cmpq	%rbx, %rbp
	jne	.L8
.L9:
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	movl	$.LC3, %edi
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	jmp	puts
	.cfi_endproc
.LFE13:
	.size	print_row, .-print_row
	.section	.rodata.str1.1
.LC4:
	.string	"Usage: %s <filename>\n"
.LC5:
	.string	"rb"
.LC6:
	.string	"fread"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB14:
	.cfi_startproc
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rsi, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 64
	cmpl	$2, %edi
	je	.L18
	movq	(%rsi), %rdx
	movq	stderr(%rip), %rdi
	xorl	%eax, %eax
	movl	$.LC4, %esi
	movl	$1, %r13d
	call	fprintf
.L17:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movl	%r13d, %eax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L18:
	.cfi_restore_state
	movq	8(%rsi), %rdi
	movl	$.LC5, %esi
	xorl	%ebp, %ebp
	call	fopen
	movq	%rax, %r12
	testq	%rax, %rax
	jne	.L20
	movq	8(%rbx), %rdi
	movl	$1, %r13d
	call	perror
	jmp	.L17
	.p2align 4,,10
	.p2align 3
.L21:
	movq	%rbp, %rdi
	movq	%rsp, %rsi
	movslq	%ebx, %rbx
	call	print_row
	addq	%rbx, %rbp
.L20:
	movl	$16, %edx
	movq	%r12, %rcx
	movl	$1, %esi
	movq	%rsp, %rdi
	call	fread
	movq	%rax, %rbx
	movl	%eax, %edx
	testl	%eax, %eax
	jg	.L21
	movq	%r12, %rdi
	call	ferror
	movl	%eax, %r13d
	testl	%eax, %eax
	jne	.L26
	movq	%r12, %rdi
	call	fclose
	jmp	.L17
.L26:
	movl	$.LC6, %edi
	movl	$1, %r13d
	call	perror
	movq	%r12, %rdi
	call	fclose
	jmp	.L17
	.cfi_endproc
.LFE14:
	.size	main, .-main
	.ident	"GCC: (GNU) 11.5.0 20240719 (Red Hat 11.5.0-5)"
	.section	.note.GNU-stack,"",@progbits
