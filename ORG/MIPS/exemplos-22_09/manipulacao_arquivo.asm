.data
	FOUT: .asciiz "testout.txt"
	BUFFER: .asciiz "Exmplo de texto escrito no arquivo"

.text
	# abrindo arquivo para ser escrito
	li 	$v0, 13		# comando 13: abrir novo arquivo
	la	$a0, FOUT	# carrega o nome do arquivo que quer abrir
	li 	$a1, 1		# abre para escrita (0: read, 1: write)
	li	$a2, 0		# modo ignorado (nesse caso)
	syscall			# abre o arquivo (descritor do arquivo colocado em $v0)
	move	$s6, $v0	# salva descritor do arquivo, como para fechar depois
	
	# escrevendo no arquivo
	li 	$v0, 15		# comando 15: escrever no arquivo
	move	$a0, $s6	# passa o descritor do arquivo
	la	$a1, BUFFER	# endereço do buffer do qual vai copiar para o arquivo
	li	$a2, 44		# tamanho do buffer (hardcoded)
	syscall			# escreve no arquivo
	
	# fechando o arquivo depois de escrever nele
	li	$v0, 16		# comando 16: fecha arquivo
	move 	$a0, $s6	# descritor do arquivo passado
	syscall