.data
	A:	.word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
	B:	.word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18
	C:	.word 3, 4, 5, 6, 7, 8, 9, 10 , 11
.text
	# ==============================================
	# a) A = B - C
	lw	$s1, B
	lw	$s2, C
	sub	$s0, $s1, $s2
	
	# ==============================================
	# b) D = (A + B - C)
	add	$t0, $s0, $s1	# = A + B
	sub	$s3, $t0, $s2	# = (A+B) - C
	
	# ==============================================
	# c) F = (A + B) - D
	sub	$s5, $t0, $s3
	
	# ==============================================
	# d) C = A - (B + D)
	add	$t0, $s1, $s3	# B + D
	sub	$s2, $s0, $t0
	
	# ==============================================
	# e) E = (A - (B - C) + F)
	sub	$t0, $s1, $s2	# B - C
	sub	$t0, $s0, $t0	# A - (B - C)
	add	$s4, $t0, $s4
	
	# ==============================================
	# g) A = B[15] - C
	la	$t0, B		# endereco base de B
	
	li	$t1, 15		# i = 15
	sll	$t1, $t1, 2	# i = i*4
	add	$t0, $t0, $t1	# endereco do valor de posicao 15
	lw	$t0, ($t0)	# carrega o dado da memoria para o registrador
	
	sub 	$s0, $t0, $s2
	
	# ==============================================
	# h) B = A[5] + C[3]
	# acessando A[5]
	li	$t0, 5
	sll	$t0, $t0, 2
	la	$t1, A
	add	$t0, $t0, $t1	# endereco A[5]
	lw	$t0, ($t0)	# valor de A[5]
	
	li	$t1, 3
	sll	$t1, $t1, 2
	la	$t2, C
	add	$t1, $t1, $t2
	lw	$t1, ($t1)
	
	add	$s1, $t0, $t1
	
	
	