.data 
	.align 2	
	buffer: .space 20
	
.text
	li	$v0, 8
	la	$a0, buffer
	li	$a1, 20
	syscall
	move	$t0, $a0		# string salva em $t0
	
	move	$a0, $t0
	li	$v0, 4
	syscall		# PRINT
	
	la	$t0, buffer
	lb	$a0, ($t0)
	li	$v0, 11
	syscall
	 
	la	$t0, buffer
	lb	$a0, 1($t0)
	li	$v0, 11
	syscall
	
	
	
	
END:
	j 	END
	