.data
	# NOMES DOS AQUIROVS
	OBTIDAS:	.asciiz "obtidas.txt"
	FALTANDO:	.asciiz "faltando.txt"
	
	# PRINTS
	INITIAL_P:	.asciiz "Bem-vindo ao programa de controle de figurinhas da Copa 2022!\n\n"
	
	GET_OP_P:	.asciiz "Digite a operacao�o desejada:\n"
	GET_OP_P_CONS:	.asciiz	"   - 0: consultar figurinhas obtidas e faltando.\n"
	GET_OP_P_INST:	.asciiz	"   - 1: inserir figurinha adquirida.\n"
	GET_OP_P_QUIT:	.asciiz "   - 9: fechar o programa.\n"
	
	PRINT_INFO_OBTIDAS: 	.asciiz "\nFigurinhas obtidas (se nao houver numero ao lado, ainda nao a possui):\n"
	PRINT_INFO_FALTANDO: 	.asciiz "\nFigurinhas faltando (se nao houver numero ao lado, ja a possui):\n"
	
	FAILED_INPUT_PRINT: 	.asciiz "Codigo da figurinha informada invalida!\n"
	
	INSERT_INCOMPLETE:	.asciiz "Opera��o de inser��o incompleta. :("
	
	FIM_EXECUCAO:		.asciiz "Encerrando execu��o do sistema."
	
	INVALID_OPERATION_PRINT: .asciiz "Operacao inserida invalida, insira um numero entre os disponiveis no menu."

	.align 2
	PAISES:		.asciiz "QAT ECU SEN NED ENG IRN USA WAL ARG KSA MEX POL FRA AUS DEN TUN ESP CRC GET JPN BEL CAN MAR CRO BRA SRB SUI CMR POR GHA URU KOR"

	.align 2
	INPUT_BUFFER:  	.space 8

	.align 2
	TEMPORARY_BUFFER: .space 3		# usado para identificar sigla de um pais
	.align 2
	TEMPORARY_NUMBER_BUFFER: .space 2	# usado para identificar nũmero da figurinha que quer inserir
	
	.align 2
	REWRITE_FILE_BUFFER: .space 4512	# 32 paises * (20 figurinhas * 7 caracteres + 1 EOL)
	
	.align 2
	WRITE_LINE_BUFFER: .space 141		# armazena uma linha do arquivo

.text
main:
	la	$a0, INITIAL_P
	jal	PRINT
	
	# looping principal do programa
	MAIN_LOOP:
		jal	PRINT_MENU
		jal	READ_INT			# oepracao desejada
		move	$a0, $v0			# $a0 = inteiro com a operacao a ser decodificada
		jal	EXECUTE_OPERATION		# $a0 ja� carregado com a operacao
		move	$s0, $v0
		
		beq	$s0, -1, INVALID_OPERATION		# -1 = encerrar execucao
		beq	$s0, 0, EXIT_PROGRAM
		
		j	MAIN_LOOP
		
	INVALID_OPERATION:
		la	$a0, INVALID_OPERATION_PRINT
		jal 	PRINT
		j	MAIN_LOOP
	
	EXIT_PROGRAM:
		la	$a0, FIM_EXECUCAO
		jal	PRINT
		j 	END
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
	addi	$sp, $sp, -12
	sw	$ra, 8($sp)
	sw	$a0, 4($sp)
	sw	$a1, 0($sp)
	
	li	$v0, 13
	# $a0 já carregado com o endereço do arquiv
	# $a1 já carregado com modo de abertura
	li	$a2, 0
	syscall
	
	# $v0 já possui descritor do arquivo
	lw	$ra, 8($sp)
	lw	$a0, 4($sp)
	lw	$a1, 0($sp)
	addi	$sp, $sp, 12

	jr	$ra
# FIM DE OPEN_FILE	
# =================================================

# =================================================
#			PRINT_MENU
# Procedimento que mostra o menu de opções no console
# =================================================
PRINT_MENU:
	move	$t0, $ra		# "salva" $ra

	la	$a0, GET_OP_P
	jal	PRINT
	la	$a0, GET_OP_P_CONS
	jal	PRINT
	la	$a0, GET_OP_P_INST
	jal	PRINT
	la	$a0, GET_OP_P_QUIT
	jal	PRINT

	move	$ra, $t0
	jr	$ra
	
# FIM DE PRINT_MENU

# =================================================
#			READ_STRING
# Procedimento que lê string do teclado
#	- $v0 = endereço da string lida
# =================================================
READ_STRING:
	addi	$sp, $sp, -12
	sw	$ra, 8($sp)
	sw	$a0, 4($sp)
	sw	$a1, 0($sp)

	li	$v0, 8			# ler string do console
	la	$a0, INPUT_BUFFER	# buffer da leitura
	li	$a1, 8			# bytes para a string (máximo 8 bytes, precisaria apeans de 6 pelo formato da entrada)
	syscall
	
	move	$v0, $a0

	lw	$ra, 8($sp)
	lw	$a0, 4($sp)
	lw	$a1, 0($sp)
	addi	$sp, $sp, 12

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
	addi	$sp, $sp, -8
	sw	$ra, 4($sp)
	sw	$a0, 0($sp)

	li	$v0, 4
	syscall
	
	lw	$ra, 4($sp)
	lw	$a0, 0($sp)
	addi	$sp, $sp, 8

	jr	$ra
# FIM DE PRINT
# =================================================


# =================================================
#			EXECUTE_OPERATION
# Procedimento que decodifica a entrada da operação e a executa, caso válida
#	- $a0 = valor da operação digitada pelo usuário
#	- $v0 = status (-1 = falhou; 0 = sucesso)
# =================================================
EXECUTE_OPERATION:
	addi	$sp, $sp, -20
	sw	$ra, 16($sp)
	sw	$a0, 12($sp)
	sw	$s0, 8($sp)
	sw	$s1, 4($sp)
	sw	$s2, 0($sp)
	
	
	beq	$a0, 0, EXEC_GET_OBTIDAS
	beq	$a0, 1, EXEC_INSERT_INCOMPLETE
	beq	$a0, 9, EXEC_CLOSE
	
	li	$v0, -1			# status = falha
	j	RETURN_TO_MAIN
	
	# ======================================================
	# mostra no console todas as figurinhas obtidas (as que possuem número)
	EXEC_GET_OBTIDAS:
		li	$t1, 0		# numero de linhas lidas

		la 	$a0, PRINT_INFO_OBTIDAS
		jal	PRINT

		la	$a0, OBTIDAS
		li	$a1, 0		# leitura
		jal	OPEN_FILE
		move	$s0, $v0	# descritor do arquivo com figurinhas obtidas

		
		LOOP_OBTIDAS:
			addi	$t1, $t1, 1		# lendo um país
			bgt	$t1, 32, END_LOOP_OBTIDAS			# se tiver lido todos os 32 já, fim da operação
		
			li	$v0, 14
			move	$a0, $s0
			la	$a1, WRITE_LINE_BUFFER
			li	$a2, 141
			syscall
			
			la	$a0, WRITE_LINE_BUFFER
			jal	PRINT
			
			j	LOOP_OBTIDAS

		END_LOOP_OBTIDAS:
			la	$a0, PRINT_INFO_FALTANDO
			jal	PRINT

			li	$t1, 0
			
			la	$a0, FALTANDO
			li	$a1, 0
			jal 	OPEN_FILE
			move	$s0, $v0
			
		LOOP_FALTANDO:
			addi	$t1, $t1, 1		
			bgt	$t1, 32, END_LOOP_FALTANDO
		
			li	$v0, 14
			move	$a0, $s0
			la	$a1, WRITE_LINE_BUFFER
			li	$a2, 141
			syscall
			
			la	$a0, WRITE_LINE_BUFFER
			jal	PRINT
			
			j	LOOP_FALTANDO

		END_LOOP_FALTANDO:

		li	$v0, 1		# status = sucesso
		j 	RETURN_TO_MAIN
	
	# opera��o de inser��o incompleta
	EXEC_INSERT_INCOMPLETE:
		la	$a0, INSERT_INCOMPLETE
		jal	PRINT
		j	RETURN_TO_MAIN
	
	# ======================================================
	# pede para o usuário digitar o código de uma figurinha que quer adicionar
	EXEC_INSERT:
		jal	READ_STRING
		move	$s0, $v0			# código da figurinha
		
		jal	FIND_COUNTRY_INDEX
		beq	$v0, 0, FAILED_INPUT		# caso codigo invalido
		move	$s1, $v1			# index para encontrar pais na lista .data
		
		la	$a0, OBTIDAS
		li	$a1, 0
		jal	OPEN_FILE
		move	$s2, $v0			# descritor do arquivo FALTANDO

		la	$t1, TEMPORARY_NUMBER_BUFFER
		lb	$t2, ($t1)
		subi	$t2, $t2, 48
		mul	$t2, $t2, 10
		lb	$t3, 1($t1)
		subi	$t3, $t3, 48
		add	$t3, $t3, $t2			# número da figurinha convertido para inteiro (n)
		
		li	$t0, 0				# número de linhas escritas
		li	$t5, 10				# CTE = 10 = EOL
		
		# loop para escrita do arquivo mas com a figurinha inserida
		la	$a1, REWRITE_FILE_BUFFER
		WRITE_LOOP:
			beq	$t0, $s1, ON_COUNTRY_ROW
			blt	$t0, $s1, ROW_LESS_COUNTRY
			bge	$t0, 32, END_WRITE_LOOP
			
			# senão, está em linha após a do pais


			addi	$t0, $t0, 1
			j	WRITE_LOOP

			# escrevve no buffer contendo todas as figurinhas quando está na linha que tem a figurinha do input			
			ON_COUNTRY_ROW:
				# escreve x vezes o valor original
				li	$t7, 0
				move	$a1, $s1	# numero de linhas para pular
				jal	GO_TO_ROW
				# agora o descritor do arquivo está no começo da linha que deseja

				subi	$t8, $t3, 1	# x - 1
				mul	$t8, $t8, 7	# (x-1) * 7
				# escreve o que ler do arquivo (x-1)*7 vezes (x = número da figurinha)
				LOOP_WRITE_ON_COUNTRY_BEFORE_INPUT:		# $s1 = index pra pegar sigla 
					


				LOOP_WRITE_AT_INPUT_POSITION:
						
					addi	$t7, $t7, 1
					j	LOOP_WRITE_ON_COUNTRY_BEFORE_INPUT

				addi	$t0, $t0, 1
				j	WRITE_LOOP

			# escreve no buffer quando está nas linhas anteriores ao do input
			ROW_LESS_COUNTRY:
				move	$a0, $s2
				li	$v0, 14
				la	$a2, 141
				syscall

				addi	$t0, $t0, 1
				addi	$a1, $a1, 140				
				j	WRITE_LOOP

		END_WRITE_LOOP:
		
		j	END_INSERT
		
		FAILED_INPUT:
			la	$a0, FAILED_INPUT_PRINT
			jal	PRINT
		
		END_INSERT:
			li	$v0, 0
			j 	RETURN_TO_MAIN	
	
	
	# ======================================================
	# fecha o programa (não salva por padrão)
	EXEC_CLOSE:
		la	$a0, FIM_EXECUCAO
		jal	PRINT
		li	$v0, 0
		j 	RETURN_TO_MAIN

	RETURN_TO_MAIN:
		lw	$s2, 0($sp)
		lw	$s1, 4($sp)
		lw	$s0, 8($sp)
		lw	$a0, 12($sp)
		lw	$ra, 16($sp)
		addi	$sp, $sp, 20
		
		jr	$ra

# FIM DE EXECUTE_OPERATION
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
	addi	$sp, $sp, -4
	sw	$ra, ($sp)	
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
	
	# salvando o número da figurinha em TEMPORARY_NUMBER_BUFFER
	la	$t5, TEMPORARY_NUMBER_BUFFER
	lb	$t2, 4($t0)
	sb	$t2, 0($t5)
	lb	$t2, 5($t0)
	sb	$t2, 1($t5)					
	
	# procura a sigla encontrada no vetor com todas as siglas
	GET_INDEX:
		li	$t0, 0				# contador da posicao da sigla no vetor
		lw	$t1, ($t1)			# sigla lida
		la	$t2, PAISES			# endereco base para o vetor dos paises
		lw	$t3, ($t2)			# primeira sigla
		# volta para o looping sempre que a sigla nao corresponder a que foi lida
		SEARCH_LOOP:
			beq	$t1, $t3, FOUND		# se a sigla do input for igual a do vetor, encontrou
			bge	$t0, 32,  NOT_FOUND	# se já tiver percorrido todos os países, não tem o país
			# senao
			addi	$t0, $t0, 1
			addi	$t2, $t2, 4		# endereco da proxima sigla do vetor (prox. end. de memoria)
			lw	$t3, ($t2)		# proxima sigla
			j	SEARCH_LOOP

		FOUND:
			li 	$v0, 1
			move	$v1, $t0
			j	END_SEARCH

		NOT_FOUND:
			li	$v0, 0
			j 	END_SEARCH

	END_SEARCH:
	lw	$ra, ($sp)
	addi	$sp, $sp, 4
	jr	$ra

# FIM DE FIND_COUNTRY_INDEX
# =================================================


# =================================================
#			GO_TO_ROW
# Vai até a linha correspondente ao país da sigla
# 	- $a0 = descritor do arquivo
#	- $a1 = quantidade de linhas que precisa pular no arquivo
# =================================================	
GO_TO_ROW:
	# prepara a pilha
	addi	$sp, $sp, -20
	sw	$ra, 16($sp)
	sw	$a1, 12($sp)
	sw	$a0, 8($sp)
	sw	$s1, 4($sp)
	sw	$s0, 0($sp)
	
	# ASCII 10 = quebra de lina
	move	$s7, $a1	# quantidade de linhas a serem puladsa (CTE)
	li	$t0, 0		# $t0 = byte lido
	li	$t1, 0		# $t1 = quantidade de "EF" encontrados
	
	# reinicia o buffer temporário
	sw	$zero, TEMPORARY_BUFFER
	
	SEARCH_EF_LOOP:
		# quando igualam os valores, está na linha desejada no arquivo
		beq	$t1, $s7, ON_ROW

		# lendo o arquivo byte a byte	
		READ_LINE_LOOP:
			li	$v0, 14				# 14 = ler arquivo
			# $a0 contém o descritor do arquivo
			la	$a1, TEMPORARY_BUFFER
			la	$a2, 1				# tamanho do buffer
			syscall					# le e escreve byte no buffer
	
			lb 	$s0, ($a1)			# le o buffer
			bne	$s0, 10, READ_LINE_LOOP
			# caso tenha achado EOL:
			addi	$t1, $t1, 1			# num EF lidos ++
			j	SEARCH_EF_LOOP			# verifica se já viu todos que precisava e volta ao loop se preciso
			

	# quando encontrar a quantidade de quebra de linhas
	ON_ROW:
		move	$v0, $a0			# retorna mesmo descritor do arquivo apenas para garantir que está no arquivo correto
			
	END_GO_TO_ROW:
		lw	$s0, 0($sp)
		lw	$s1, 4($sp)
		lw	$a0, 8($sp)
		lw	$a1, 12($sp)
		lw	$ra, 16($sp)
		addi	$sp, $sp, 20
 
		jr	$ra
# FIM DE GO_TO_ROW
# =================================================
