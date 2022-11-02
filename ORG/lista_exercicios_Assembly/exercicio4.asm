.data
.text
	li	$s0, 0x10010020		# endereco de base do vetor
	
	li	$s1, 0			# $s1 = index de acesso
	li	$t0, 1
	sw	$t0, ($s0)
	
	# index = 1
	addi	$s1, $s1, 1		# i = 1
	sll	$t1, $s1, 2		# 4 * i
	add	$t1, $t1, $s0		# endereco [1]
	
	li	$t0, 3
	sw	$t0, ($t1)
	
	# index = 2
	addi	$s1, $s1, 1		# i + 1
	sll	$t1, $s1, 2
	add	$t1, $t1, $s0
	
	li	$t0, 2
	sw	$t0, ($t1)
	
	# ...