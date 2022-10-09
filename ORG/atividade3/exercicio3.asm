.data
	MATRIZ_ORIGINAL:	.word 1, 2, 0, 1, -1, -3, 0, 1, 3, 6, 1, 3, 2, 4, 0, 3
	.align 	4
	MATRIZ_TRANSPOSTA:	.space 64
	FILE:	.asciiz "file.dat"

.text
	li	$s0, 0		# i = 0
	li	$s1, 0		# j = 0

	la	$s2, MATRIZ_ORIGINAL
	la 	$s3, MATRIZ_TRANSPOSTA

	###################
	# soma 4 no j (4 * j para realizar menos instruções)
	LOOP:
		sll	$t0, $s0, 2		# i * 4
		add 	$t0, $t0, $s1		# 4i + j

		sll	$t1, $s1, 2		# j * 4
		add	$t1, $t1, $s0		# 4j + i

		sll 	$t0, $t0, 2		# 4 * (4i + j)
		sll	$t1, $t1, 2		# 4 * (i + 4j)

		add  	$t0, $s2, $t0		# calcula o valor a ser acessado na matriz original
		add	$t1, $s3, $t1		# calcula o valor para escrever na matriz transposta

		lw	$t2, ($t0)		# matriz_original[4i + j]
		addi	$t2, $t2, 48		# adiciona 48 para transpor os valores para ASCII
		sw	$t2, ($t1)		# matriz_transposta[i + 4j]

		addi	$s1, $s1, 1		 # j++

		beq	$s1, 4, INCREMENTO_I	 # se j == 3 incrementa o i e continua o cálculo
		j	LOOP

	# incrementa o valor de i e zera j
	INCREMENTO_I:
		addi 	$s0, $s0, 1
		li	$s1, 0

		bne	$s0, 4, LOOP		 # se i != 3, loop continua
	
	
	# abre arquivo para escrita
	li	$v0, 13		# abre novo arquivo
	la	$a0, FILE	# nome do arquivo que quer abrir
	li	$a1, 1		# modo de escrita no arquivo
	li	$a2, 0

	syscall			# abre o arquivo, descritor em $v0
	move	$s4, $v0	# descritor do aquirvo em $s4
	
	la	$s3, MATRIZ_TRANSPOSTA



ESCREVE_NO_ARQUIVO:
	li	$v0, 15		# escrever em arquivo
	move	$a0, $s4	# descritor do arquivo
	la	$a1, MATRIZ_TRANSPOSTA
	li	$a2, 64		# tamanho do buffer
	syscall			# escreve no arquivo
	

FECHA_ARQUIVO:
	li	$v0, 16		# fecha arquivo
	move	$a0, $s4	# descritor do arquivo que quer fechar
	syscall

FIM:
	