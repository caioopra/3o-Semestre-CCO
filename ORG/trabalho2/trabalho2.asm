.data
	# NOMES DOS AQUIROVS
	OBTIDAS:	.asciiz "obtidas.txt"
	FALTANDO:	.asciiz "faltando.txt"
	
	# PRINTS
	INITIAL_P:	.asciiz "Bem-vindo ao programa de controle de figurinhas da Copa 2022!"
	
	GET_OP_P:	.asciiz "Digite a operação desejada:"
	GET_OP_P_CONS:	.asciiz	"   - 0: consultar figurinhas possuídas."
	GET_OP_P_INST:	.asciiz	"   - 1: inserir figurinha adquirida."
	GET_OP_P_SAVE:	.asciiz	"   - 2: atualizar arquivo."
	GET_OP_P_QUIT:	.asciiz "   - 9: fechar o programa (NAO ESQUECA DE SALVAR O ARQUIVO!)."


	PAISES:		.asciiz "QAT ECU SEN NED ENG IRN USA WAL ARG KSA MEX POL FRA AUS DEN TUN ESP CRC GET JPN BEL CAN MAR CRO BRA SRB SUI CMR POR GHA URU KOR"

	.align 2
	INPUT_BUFFER:  	.space 8

	.align 2
	TEMPORARY_BUFFER: .space 3	# usado para identificar sigla de um pais

.text
main:
	la	$a0, INITIAL_P
	jal	PRINT




	# EXEMPLO DE ENTRADA DO TECLADO E PRINT
	jal	READ_STRING
	move	$t0, $v0
	
	move	$a0, $t0
	jal	PRINT

	jal	FIND_COUNTRY_INDEX
	


END:
	j	END


# =================================================
#			OPEN_FILE
# Procedimento que abre arquivo.txt
# 	- $a0 = nome do arquivo (arquivos.txt no .data)
#	- $a1 = modo de abertura do arquivo:
#		-> 0 para leitura, 1 para escrita
#	- $v0 = retorna identificador do arquivo
# =================================================
OPEN_FILE:
	li	$v0, 13
	# $a0 já carregado com o endereço do arquiv
	# $a1 já carregado com modo de abertura
	li	$a2, 0
	syscall
	
	# $v0 já possui descritor do arquivo
	jr	$ra
# FIM DE OPEN_FILE	
# =================================================


# =================================================
#			READ_STRING
# Procedimento que lê string do teclado
#	- $v0 = endereço da string lida
# =================================================
READ_STRING:
	li	$v0, 8			# ler string do console
	la	$a0, INPUT_BUFFER	# buffer da leitura
	li	$a1, 8			# bytes para a string (máximo 8 bytes, precisaria apeans de 6 pelo formato da entrada)
	syscall
	
	move	$v0, $a0

	jr	$ra
# FIM DE READ_STRING	
# =================================================


# =================================================
#			READ_INT
# Procedimento que lê inteiro do teclado
#	- $v0 = valor do inteiro lido
# =================================================
READ_INT:
	li	$v0, 5
	syscall
	# $v0 já contém valor do inteiro lido

	jr	$ra
# FIM DE READ_INT
# =================================================


# =================================================
#			PRINT
# Procedimento que mostra string na tela
#	- $a0 = string a ser mostrada (endereço)
# =================================================
PRINT:
	li	$v0, 4
	syscall
	jr	$ra
# FIM DE PRINT
# =================================================


# =================================================
#			FIND_COUNTRY_INDEX
# Procedimento que identifica o pais informado da string de input
#	(nao precisa de argumentos, consegue acessar diretamente pelo endereco)
#	- $v0 = 1, caso seja encontrado um pais valido
#	        0, caso nao encontre um pais
#	- $v1 (caso $v0=1) = index para encontrar o pai na lista pronta em .data
# =================================================
FIND_COUNTRY_INDEX:	
	# escreve em TEMPORARY_BUFFER as 3 letras que formam a sigla do pais
	GET_INITIALS:
		la	$t0, INPUT_BUFFER		# $t0 = endereco da string de input
		la	$t1, TEMPORARY_BUFFER
		
		lb	$t2, ($t0)			# $t1 = primeira letra
		sb	$t2, ($t1)			# escreve primeira letra no buffer

		lb	$t2, 1($t0)			# segunda letra
		sb	$t2, 1($t1)			# escreve letra no segundo byte do buffer
		
		lb	$t2, 2($t0)
		sb	$t2, 2($t1)
		li	$t2, 0x20
		sb	$t2, 3($t1)
		
		# DEBUG: printa a sigla lida
		#move	$a0, $t1
		#li	$v0, 4
		#syscall
	
	# procura a sigla encontrada no vetor com todas as siglas
	GET_INDEX:
		li	$t0, 0				# contador da posicao da sigla no vetor
		lw	$t1, ($t1)			# sigla lida
		la	$t2, PAISES			# endereco base para o vetor dos paises
		lw	$t3, ($t2)			# primeira sigla
		# volta para o looping sempre que a sigla nao corresponder a que foi lida
		SEARCH_LOOP:
			beq	$t1, $t3, FOUND		# se a sigla do input for igual a do vetor, encontrou
			# senao
			addi	$t0, $t0, 1
			addi	$t2, $t2, 4		# endereco da proxima sigla do vetor (prox. end. de memoria)
			lw	$t3, ($t2)		# proxima sigla
			j	SEARCH_LOOP

		FOUND:
			move	$a0, $t2
			li	$v0, 4
			syscall			


	

		
		


