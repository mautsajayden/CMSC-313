	.file	"hexdump.c"
	.text
	.section	.rodata
.LC0:
	.string	"%08lx "
.LC1:
	.string	"%02x "
.LC2:
	.string	"   "
.LC3:
	.string	"|"
	.text
	.globl	print_row
	.type	print_row, @function
print_row:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, -36(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movl	$0, -4(%rbp)
	jmp	.L2
.L5:
	movl	-4(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jge	.L3
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movl	%eax, %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	jmp	.L4
.L3:
	movl	$.LC2, %edi
	movl	$0, %eax
	call	printf
.L4:
	addl	$1, -4(%rbp)
.L2:
	cmpl	$15, -4(%rbp)
	jle	.L5
	movl	$124, %edi
	call	putchar
	movl	$0, -4(%rbp)
	jmp	.L6
.L9:
	call	__ctype_b_loc
	movq	(%rax), %rdx
	movl	-4(%rbp), %eax
	movslq	%eax, %rcx
	movq	-32(%rbp), %rax
	addq	%rcx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	addq	%rax, %rax
	addq	%rdx, %rax
	movzwl	(%rax), %eax
	movzwl	%ax, %eax
	andl	$16384, %eax
	testl	%eax, %eax
	je	.L7
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-32(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movzbl	%al, %eax
	movl	%eax, %edi
	call	putchar
	jmp	.L8
.L7:
	movl	$46, %edi
	call	putchar
.L8:
	addl	$1, -4(%rbp)
.L6:
	movl	-4(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jl	.L9
	movl	$.LC3, %edi
	call	puts
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	print_row, .-print_row
	.section	.rodata
.LC4:
	.string	"Usage: %s <filename>\n"
.LC5:
	.string	"rb"
.LC6:
	.string	"fread"
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movl	%edi, -52(%rbp)
	movq	%rsi, -64(%rbp)
	movq	$0, -8(%rbp)
	cmpl	$2, -52(%rbp)
	je	.L11
	movq	-64(%rbp), %rax
	movq	(%rax), %rdx
	movq	stderr(%rip), %rax
	movl	$.LC4, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf
	movl	$1, %eax
	jmp	.L17
.L11:
	movq	-64(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movl	$.LC5, %esi
	movq	%rax, %rdi
	call	fopen
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.L14
	movq	-64(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	perror
	movl	$1, %eax
	jmp	.L17
.L15:
	movl	-20(%rbp), %edx
	leaq	-48(%rbp), %rcx
	movq	-8(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	print_row
	movl	-20(%rbp), %eax
	cltq
	addq	%rax, -8(%rbp)
.L14:
	movq	-16(%rbp), %rdx
	leaq	-48(%rbp), %rax
	movq	%rdx, %rcx
	movl	$16, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	call	fread
	movl	%eax, -20(%rbp)
	cmpl	$0, -20(%rbp)
	jg	.L15
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	ferror
	testl	%eax, %eax
	je	.L16
	movl	$.LC6, %edi
	call	perror
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	fclose
	movl	$1, %eax
	jmp	.L17
.L16:
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	fclose
	movl	$0, %eax
.L17:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.ident	"GCC: (GNU) 11.5.0 20240719 (Red Hat 11.5.0-5)"
	.section	.note.GNU-stack,"",@progbits
