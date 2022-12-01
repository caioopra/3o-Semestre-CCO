.data
	.align 2
	teste: .asciiz "STRING"
	.align 2
	buffer: .space 10
	
.text
	la	$s0, teste
	lb	$s1, ($s0)
	
	li	$v0, 4
	move	$a0, $s1
	
	sb	$a0, buffer	

	lb	$s1, 1($s0)
	la	$s2, buffer
	addi	$s2, $s2, 1
	sb	$s1, ($s2)	
		
	la	$a0, buffer
	syscall