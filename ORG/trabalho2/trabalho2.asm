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
	TEMPORARY_BUFFER: .space 3

.text
main:
	la	$a0, INITIAL_P
	jal	PRINT




	# EXEMPLO DE ENTRADA DO TECLADO E PRINT
	jal	READ_STRING
	move	$t0, $v0
	
	move	$a0, $t0
	jal	PRINT

	
	
	
	


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
#			FIND_COUNTRY
# Procedimento que identifica o país informado da string de input
#	- $v0 = 1, caso seja encontrado um país válido
#	        0, caso não encontre um país
#	- $v1 (caso $v0=1) = index para encontrar o país na lista pronta em .data
# =================================================
FIND_COUNTRY:
	# percorre os 3 primeiros caractéres da string para formar a sigla
	li	$t0, 0

	SPLIT_LOOP:
		


