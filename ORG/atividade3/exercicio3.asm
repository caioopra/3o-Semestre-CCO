.data
	FILE:	.asciiz "file.dat"
	.align 	4
	MATRIZ_TRANSPOSTA:	.space 16

.text
	# abre arquivo para escrita
	li	$v0, 13		# abre novo arquivo
	la	$a0, FILE	# nome do arquivo que quer abrir
	li	$a1, 1		# modo de escrita no arquivo
	li	$a2, 0

	syscall			# abre o arquivo, descritor em $v0
	move	$s4, $v0	# descritor do aquirvo em $s4
	
	la	$s3, MATRIZ_TRANSPOSTA
	addi	$t0, $t0, 48
	add	$t1, $t1, 49
	sw	$t0, ($s3)
	sw	$t1, 4($s3)

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