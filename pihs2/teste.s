	.file	"teste.c"
# GNU C11 (Ubuntu 5.4.0-6ubuntu1~16.04.4) version 5.4.0 20160609 (x86_64-linux-gnu)
#	compiled by GNU C version 5.4.0 20160609, GMP version 6.1.0, MPFR version 3.1.4, MPC version 1.0.3
# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed:  -imultiarch x86_64-linux-gnu teste.c -mtune=generic
# -march=x86-64 -fverbose-asm -fstack-protector-strong -Wformat
# -Wformat-security
# options enabled:  -faggressive-loop-optimizations
# -fasynchronous-unwind-tables -fauto-inc-dec -fchkp-check-incomplete-type
# -fchkp-check-read -fchkp-check-write -fchkp-instrument-calls
# -fchkp-narrow-bounds -fchkp-optimize -fchkp-store-bounds
# -fchkp-use-static-bounds -fchkp-use-static-const-bounds
# -fchkp-use-wrappers -fcommon -fdelete-null-pointer-checks
# -fdwarf2-cfi-asm -fearly-inlining -feliminate-unused-debug-types
# -ffunction-cse -fgcse-lm -fgnu-runtime -fgnu-unique -fident
# -finline-atomics -fira-hoist-pressure -fira-share-save-slots
# -fira-share-spill-slots -fivopts -fkeep-static-consts
# -fleading-underscore -flifetime-dse -flto-odr-type-merging -fmath-errno
# -fmerge-debug-strings -fpeephole -fprefetch-loop-arrays
# -freg-struct-return -fsched-critical-path-heuristic
# -fsched-dep-count-heuristic -fsched-group-heuristic -fsched-interblock
# -fsched-last-insn-heuristic -fsched-rank-heuristic -fsched-spec
# -fsched-spec-insn-heuristic -fsched-stalled-insns-dep -fschedule-fusion
# -fsemantic-interposition -fshow-column -fsigned-zeros
# -fsplit-ivs-in-unroller -fstack-protector-strong -fstdarg-opt
# -fstrict-volatile-bitfields -fsync-libcalls -ftrapping-math
# -ftree-coalesce-vars -ftree-cselim -ftree-forwprop -ftree-loop-if-convert
# -ftree-loop-im -ftree-loop-ivcanon -ftree-loop-optimize
# -ftree-parallelize-loops= -ftree-phiprop -ftree-reassoc -ftree-scev-cprop
# -funit-at-a-time -funwind-tables -fverbose-asm -fzero-initialized-in-bss
# -m128bit-long-double -m64 -m80387 -malign-stringops
# -mavx256-split-unaligned-load -mavx256-split-unaligned-store
# -mfancy-math-387 -mfp-ret-in-387 -mfxsr -mglibc -mieee-fp
# -mlong-double-80 -mmmx -mno-sse4 -mpush-args -mred-zone -msse -msse2
# -mtls-direct-seg-refs -mvzeroupper

	.section	.rodata
.LC0:
	.string	"\nPrintando a matriz:"
.LC1:
	.string	"%d "
	.text
	.globl	printaMatriz
	.type	printaMatriz, @function
printaMatriz:
.LFB2:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$32, %rsp	#,
	movq	%rdi, -24(%rbp)	# matriz, matriz
	movl	%esi, -28(%rbp)	# ordem, ordem
	movl	$.LC0, %edi	#,
	call	puts	#
	movl	$0, -8(%rbp)	#, i
	jmp	.L2	#
.L5:
	movl	$0, -4(%rbp)	#, j
	jmp	.L3	#
.L4:
	movl	-8(%rbp), %eax	# i, tmp95
	cltq
	leaq	0(,%rax,8), %rdx	#, D.2930
	movq	-24(%rbp), %rax	# matriz, tmp96
	addq	%rdx, %rax	# D.2930, D.2931
	movq	(%rax), %rax	# *_13, D.2932
	movl	-4(%rbp), %edx	# j, tmp97
	movslq	%edx, %rdx	# tmp97, D.2930
	salq	$2, %rdx	#, D.2930
	addq	%rdx, %rax	# D.2930, D.2932
	movl	(%rax), %eax	# *_17, D.2933
	movl	%eax, %esi	# D.2933,
	movl	$.LC1, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
	addl	$1, -4(%rbp)	#, j
.L3:
	movl	-4(%rbp), %eax	# j, tmp98
	cmpl	-28(%rbp), %eax	# ordem, tmp98
	jl	.L4	#,
	movl	$10, %edi	#,
	call	putchar	#
	addl	$1, -8(%rbp)	#, i
.L2:
	movl	-8(%rbp), %eax	# i, tmp99
	cmpl	-28(%rbp), %eax	# ordem, tmp99
	jl	.L5	#,
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	printaMatriz, .-printaMatriz
	.globl	reduz
	.type	reduz, @function
reduz:
.LFB3:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	pushq	%rbx	#
	subq	$72, %rsp	#,
	.cfi_offset 3, -24
	movq	%rdi, -56(%rbp)	# matriz, matriz
	movl	%esi, -60(%rbp)	# notj, notj
	movl	%edx, -64(%rbp)	# noti, noti
	movl	%ecx, -68(%rbp)	# ordem, ordem
	movl	$0, -36(%rbp)	#, newi
	movl	$0, -32(%rbp)	#, newj
	movl	-68(%rbp), %eax	# ordem, tmp113
	subl	$1, %eax	#, tmp112
	movl	%eax, -28(%rbp)	# tmp112, red
	movl	-28(%rbp), %eax	# red, tmp114
	cltq
	salq	$3, %rax	#, D.2936
	movq	%rax, %rdi	# D.2936,
	call	malloc	#
	movq	%rax, -24(%rbp)	# tmp115, reduzida
	movl	$0, -44(%rbp)	#, i
	jmp	.L7	#
.L8:
	movl	-44(%rbp), %eax	# i, tmp116
	cltq
	leaq	0(,%rax,8), %rdx	#, D.2936
	movq	-24(%rbp), %rax	# reduzida, tmp117
	leaq	(%rdx,%rax), %rbx	#, D.2937
	movl	-28(%rbp), %eax	# red, tmp118
	cltq
	salq	$2, %rax	#, D.2936
	movq	%rax, %rdi	# D.2936,
	call	malloc	#
	movq	%rax, (%rbx)	# D.2938, *_27
	addl	$1, -44(%rbp)	#, i
.L7:
	movl	-44(%rbp), %eax	# i, tmp120
	cmpl	-28(%rbp), %eax	# red, tmp120
	jl	.L8	#,
	movl	$0, -44(%rbp)	#, i
	jmp	.L9	#
.L15:
	movl	-44(%rbp), %eax	# i, tmp121
	cmpl	-64(%rbp), %eax	# noti, tmp121
	je	.L16	#,
	movl	$0, -40(%rbp)	#, j
	jmp	.L12	#
.L14:
	movl	-40(%rbp), %eax	# j, tmp122
	cmpl	-60(%rbp), %eax	# notj, tmp122
	je	.L13	#,
	movl	-36(%rbp), %eax	# newi, tmp123
	cltq
	leaq	0(,%rax,8), %rdx	#, D.2936
	movq	-24(%rbp), %rax	# reduzida, tmp124
	addq	%rdx, %rax	# D.2936, D.2937
	movq	(%rax), %rax	# *_40, D.2939
	movl	-32(%rbp), %edx	# newj, tmp125
	movslq	%edx, %rdx	# tmp125, D.2936
	salq	$2, %rdx	#, D.2936
	addq	%rax, %rdx	# D.2939, D.2939
	movl	-44(%rbp), %eax	# i, tmp126
	cltq
	leaq	0(,%rax,8), %rcx	#, D.2936
	movq	-56(%rbp), %rax	# matriz, tmp127
	addq	%rcx, %rax	# D.2936, D.2937
	movq	(%rax), %rax	# *_48, D.2939
	movl	-40(%rbp), %ecx	# j, tmp128
	movslq	%ecx, %rcx	# tmp128, D.2936
	salq	$2, %rcx	#, D.2936
	addq	%rcx, %rax	# D.2936, D.2939
	movl	(%rax), %eax	# *_52, D.2940
	movl	%eax, (%rdx)	# D.2940, *_44
	addl	$1, -32(%rbp)	#, newj
.L13:
	addl	$1, -40(%rbp)	#, j
.L12:
	movl	-40(%rbp), %eax	# j, tmp129
	cmpl	-68(%rbp), %eax	# ordem, tmp129
	jl	.L14	#,
	addl	$1, -36(%rbp)	#, newi
	movl	$0, -32(%rbp)	#, newj
	jmp	.L11	#
.L16:
	nop
.L11:
	addl	$1, -44(%rbp)	#, i
.L9:
	movl	-44(%rbp), %eax	# i, tmp130
	cmpl	-68(%rbp), %eax	# ordem, tmp130
	jl	.L15	#,
	movl	-28(%rbp), %edx	# red, tmp131
	movq	-24(%rbp), %rax	# reduzida, tmp132
	movl	%edx, %esi	# tmp131,
	movq	%rax, %rdi	# tmp132,
	call	printaMatriz	#
	nop
	addq	$72, %rsp	#,
	popq	%rbx	#
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	reduz, .-reduz
	.section	.rodata
.LC2:
	.string	"\n Lendo a matriz:"
.LC3:
	.string	"\nLinha %d: "
.LC4:
	.string	"%d"
	.text
	.globl	lerDados
	.type	lerDados, @function
lerDados:
.LFB4:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$32, %rsp	#,
	movq	%rdi, -24(%rbp)	# matriz, matriz
	movl	%esi, -28(%rbp)	# ordem, ordem
	movl	$.LC2, %edi	#,
	call	puts	#
	movl	$0, -8(%rbp)	#, i
	jmp	.L18	#
.L21:
	movl	-8(%rbp), %eax	# i, tmp95
	addl	$1, %eax	#, D.2941
	movl	%eax, %esi	# D.2941,
	movl	$.LC3, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
	movl	$0, -4(%rbp)	#, j
	jmp	.L19	#
.L20:
	movl	-8(%rbp), %eax	# i, tmp96
	cltq
	leaq	0(,%rax,8), %rdx	#, D.2942
	movq	-24(%rbp), %rax	# matriz, tmp97
	addq	%rdx, %rax	# D.2942, D.2943
	movq	(%rax), %rax	# *_15, D.2944
	movl	-4(%rbp), %edx	# j, tmp98
	movslq	%edx, %rdx	# tmp98, D.2942
	salq	$2, %rdx	#, D.2942
	addq	%rdx, %rax	# D.2942, D.2944
	movq	%rax, %rsi	# D.2944,
	movl	$.LC4, %edi	#,
	movl	$0, %eax	#,
	call	__isoc99_scanf	#
	addl	$1, -4(%rbp)	#, j
.L19:
	movl	-4(%rbp), %eax	# j, tmp99
	cmpl	-28(%rbp), %eax	# ordem, tmp99
	jl	.L20	#,
	addl	$1, -8(%rbp)	#, i
.L18:
	movl	-8(%rbp), %eax	# i, tmp100
	cmpl	-28(%rbp), %eax	# ordem, tmp100
	jl	.L21	#,
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	lerDados, .-lerDados
	.section	.rodata
.LC5:
	.string	"Insira a ordem: "
.LC6:
	.string	"Iniciando as redu\303\247\303\265es:"
.LC7:
	.string	"Redu\303\247\303\243o em %d - %d :"
	.text
	.globl	main
	.type	main, @function
main:
.LFB5:
	.cfi_startproc
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	pushq	%rbx	#
	subq	$40, %rsp	#,
	.cfi_offset 3, -24
	movq	%fs:40, %rax	#, tmp118
	movq	%rax, -24(%rbp)	# tmp118, D.2952
	xorl	%eax, %eax	# tmp118
	movl	$.LC5, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
	leaq	-44(%rbp), %rax	#, tmp105
	movq	%rax, %rsi	# tmp105,
	movl	$.LC4, %edi	#,
	movl	$0, %eax	#,
	call	__isoc99_scanf	#
	movl	-44(%rbp), %eax	# ordem, D.2948
	cltq
	salq	$3, %rax	#, D.2949
	movq	%rax, %rdi	# D.2949,
	call	malloc	#
	movq	%rax, -32(%rbp)	# tmp106, matriz
	movl	$0, -40(%rbp)	#, i
	jmp	.L23	#
.L24:
	movl	-40(%rbp), %eax	# i, tmp107
	cltq
	leaq	0(,%rax,8), %rdx	#, D.2949
	movq	-32(%rbp), %rax	# matriz, tmp108
	leaq	(%rdx,%rax), %rbx	#, D.2950
	movl	-44(%rbp), %eax	# ordem, D.2948
	cltq
	salq	$2, %rax	#, D.2949
	movq	%rax, %rdi	# D.2949,
	call	malloc	#
	movq	%rax, (%rbx)	# D.2951, *_19
	addl	$1, -40(%rbp)	#, i
.L23:
	movl	-44(%rbp), %eax	# ordem, D.2948
	cmpl	%eax, -40(%rbp)	# D.2948, i
	jl	.L24	#,
	movl	-44(%rbp), %edx	# ordem, D.2948
	movq	-32(%rbp), %rax	# matriz, tmp110
	movl	%edx, %esi	# D.2948,
	movq	%rax, %rdi	# tmp110,
	call	lerDados	#
	movl	-44(%rbp), %edx	# ordem, D.2948
	movq	-32(%rbp), %rax	# matriz, tmp111
	movl	%edx, %esi	# D.2948,
	movq	%rax, %rdi	# tmp111,
	call	printaMatriz	#
	movl	$.LC6, %edi	#,
	call	puts	#
	movl	$0, -40(%rbp)	#, i
	jmp	.L25	#
.L28:
	movl	$0, -36(%rbp)	#, j
	jmp	.L26	#
.L27:
	movl	-40(%rbp), %edx	# i, tmp112
	movl	-36(%rbp), %eax	# j, tmp113
	movl	%eax, %esi	# tmp113,
	movl	$.LC7, %edi	#,
	movl	$0, %eax	#,
	call	printf	#
	movl	-44(%rbp), %ecx	# ordem, D.2948
	movl	-36(%rbp), %edx	# j, tmp114
	movl	-40(%rbp), %esi	# i, tmp115
	movq	-32(%rbp), %rax	# matriz, tmp116
	movq	%rax, %rdi	# tmp116,
	call	reduz	#
	movl	$10, %edi	#,
	call	putchar	#
	addl	$1, -36(%rbp)	#, j
.L26:
	movl	-44(%rbp), %eax	# ordem, D.2948
	cmpl	%eax, -36(%rbp)	# D.2948, j
	jl	.L27	#,
	addl	$1, -40(%rbp)	#, i
.L25:
	movl	-44(%rbp), %eax	# ordem, D.2948
	cmpl	%eax, -40(%rbp)	# D.2948, i
	jl	.L28	#,
	movl	$0, %eax	#, D.2948
	movq	-24(%rbp), %rbx	# D.2952, tmp119
	xorq	%fs:40, %rbx	#, tmp119
	je	.L30	#,
	call	__stack_chk_fail	#
.L30:
	addq	$40, %rsp	#,
	popq	%rbx	#
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
