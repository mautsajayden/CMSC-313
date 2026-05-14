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
	.globl	print_row
	.type	print_row, @function
print_row:
.LFB13:
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
	subq	$8, %rsp
	.cfi_def_cfa_offset 48
	movq	%rsi, %r13
	movl	%edx, %ebp
	movq	%rdi, %rsi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %ebx
	jmp	.L4
.L2:
	movl	$.LC2, %edi
	movl	$0, %eax
	call	printf
.L3:
	addq	$1, %rbx
	cmpq	$16, %rbx
	je	.L12
.L4:
	cmpl	%ebx, %ebp
	jle	.L2
	movzbl	0(%r13,%rbx), %esi
	movl	$.LC1, %edi
	movl	$0, %eax
	call	printf
	jmp	.L3
.L12:
	movl	$124, %edi
	call	putchar
	testl	%ebp, %ebp
	jle	.L5
	call	__ctype_b_loc
	movq	%rax, %r12
	movq	%r13, %rbx
	leal	-1(%rbp), %eax
	leaq	1(%r13,%rax), %rbp
	jmp	.L8
.L6:
	movq	stdout(%rip), %rsi
	movl	$46, %edi
	call	putc
.L7:
	addq	$1, %rbx
	cmpq	%rbp, %rbx
	je	.L5
.L8:
	movzbl	(%rbx), %edi
	movzbl	%dil, %edx
	movq	(%r12), %rax
	testb	$64, 1(%rax,%rdx,2)
	je	.L6
	movzbl	%dil, %edi
	movq	stdout(%rip), %rsi
	call	putc
	jmp	.L7
.L5:
	movl	$.LC3, %edi
	call	puts
	addq	$8, %rsp
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
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
	.text
	.globl	main
	.type	main, @function
main:
.LFB14:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$16, %rsp
	.cfi_def_cfa_offset 48
	movq	%rsi, %rbx
	cmpl	$2, %edi
	je	.L14
	movq	(%rsi), %rdx
	movl	$.LC4, %esi
	movq	stderr(%rip), %rdi
	movl	$0, %eax
	call	fprintf
	movl	$1, %ebx
.L13:
	movl	%ebx, %eax
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L14:
	.cfi_restore_state
	movq	8(%rsi), %rdi
	movl	$.LC5, %esi
	call	fopen
	movq	%rax, %r12
	movl	$0, %ebp
	testq	%rax, %rax
	jne	.L16
	movq	8(%rbx), %rdi
	call	perror
	movl	$1, %ebx
	jmp	.L13
.L17:
	movq	%rsp, %rsi
	movq	%rbp, %rdi
	call	print_row
	movslq	%ebx, %rbx
	addq	%rbx, %rbp
.L16:
	movq	%r12, %rcx
	movl	$16, %edx
	movl	$1, %esi
	movq	%rsp, %rdi
	call	fread
	movq	%rax, %rbx
	movl	%eax, %edx
	testl	%eax, %eax
	jg	.L17
	movq	%r12, %rdi
	call	ferror
	movl	%eax, %ebx
	testl	%eax, %eax
	jne	.L22
	movq	%r12, %rdi
	call	fclose
	jmp	.L13
.L22:
	movl	$.LC6, %edi
	call	perror
	movq	%r12, %rdi
	call	fclose
	movl	$1, %ebx
	jmp	.L13
	.cfi_endproc
.LFE14:
	.size	main, .-main
	.ident	"GCC: (GNU) 11.5.0 20240719 (Red Hat 11.5.0-5)"
	.section	.note.GNU-stack,"",@progbits
