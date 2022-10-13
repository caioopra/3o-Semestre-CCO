.data
	MATRIZ_ORIGINAL : 	.word 1, 2, 0, 1, -1, -3, 0, 1, 3, 6, 1, 3, 2, 4, 0, 3
	MATRIZ_TRANSPOSTA:	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	FILE:			.asciiz "fileout.dat"
	.align 4
	MATRIZ_ASCII: .space 128
.text
MAIN:
	la 	$s0, MATRIZ_ORIGINAL		# endereço da matriz original
	la 	$s1, MATRIZ_TRANSPOSTA		# endereço da matriz de resultado
	la 	$s2, MATRIZ_ASCII		# endereco da matriz transposta com ASCII

	li	$s3, 0				# valor inicial para linha
	li	$s4, 0 				# valor iniicial para coluna
	li	$s5, 0 				# contaodr para matriz de resultado
	li 	$s6, 0 				# contador endereço da matriz ascii

	LOOP:
		li	$t0, 0

	LOOP_LINHA: 
		add 	$t1, $s3, $t0		# deslocamento da posicao atual
		add 	$t1, $t1, $s0		# endereco na matriz original
		lw 	$t2, ($t1)		# salva no registrador o valor lido da matriz

		add	$t3, $s1, $s5		# endereço na matriz transposta
		sw	$t2, ($t3) 		# salva o valor lido da original no seu endereco na transposta

		add	$t4, $s2, $s6		# endereco da matriz ASCII

		ble 	$t2, 0, INSERE_NEGATIVO # testa se número a ser convertido é positivo ou negativo

	INSERE_POSITIVO:
	    	li 	$t5, 43			# simbolo +
	    	j 	CONTINUACAO
	
	INSERE_NEGATIVO:
		li 	$t5, 45			# simbolo -
		mul 	$t2, $t2, -1
	    	
	CONTINUACAO:
	   	sw 	$t5, ($t4)
	    	addi 	$t4, $t4, 4
		addi 	$t5, $t2, 48		# +48 para converter o numero na tabela ASCII
		sw 	$t5, ($t4)		# salva o valor convertido
	    
	    	addi $s5, $s5, 4		# proximo endereco na matriz de resultados
	    	addi $s6, $s6, 8 		# proximo endereco na matriz ASCII
	    	addi $t0, $t0, 16
	    	
	    	beq $t0, 64, FIM_LINHA		# ultimo valor de acesso
	    
	    	j LOOP_LINHA
	
	FIM_LINHA: 
		add $s3, $s3, 4			# vai para proxima linha
		beq $s3, 16, ABRE_ARQUIVO	# se linha == 3, no fim do looping, salva no arquivo
		j LOOP				# senao, continua o calculo
	
# procedimentos para manipulação do arquivo
ABRE_ARQUIVO:
	li	$v0, 13		# abre novo arquivo
	la	$a0, FILE	# nome do arquivo que quer abrir
	li	$a1, 1		# modo de escrita no arquivo
	li	$a2, 0

	syscall			# abre o arquivo, descritor em $v0
	move	$s4, $v0	# descritor do aquirvo em $s4

ESCREVE_NO_ARQUIVO:
	li	$v0, 15		# escrever em arquivo
	move	$a0, $s4	# descritor do arquivo
	la	$a1, MATRIZ_ASCII
	li	$a2, 128		# tamanho do buffer
	syscall			# escreve no arquivo

FECHA_ARQUIVO:
	li	$v0, 16		# fecha arquivo
	move	$a0, $s4	# descritor do arquivo que quer fechar
	syscall
	
