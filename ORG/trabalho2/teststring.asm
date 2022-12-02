.data
	.align 2
	INPUT_BUFFER: .asciiz "STRING"
	.align 2
	buffer: .space 10
	
.text
	la	$t0, INPUT_BUFFER		# $t0 = endereco da string de input
	la	$t1, buffer
		
	lb	$t2, ($t0)			# $t1 = primeira letra
	sb	$t2, ($t1)			# escreve primeira letra no buffer

	lb	$t2, 1($t0)			# segunda letra
	sb	$t2, 1($t1)			# escreve letra no segundo byte do buffer
		
	lb	$t2, 2($t0)
	sb	$t2, 2($t1)
	
	lw	$t3, ($t1)
	move	$a0, $t1
	li	$v0, 4
	syscall