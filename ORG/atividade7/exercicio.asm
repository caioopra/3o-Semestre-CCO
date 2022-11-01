.data
	GET_SIZE: 	.asciiz "Informe o tamanho das matrizes (N): "
	GET_MATRIX1:	.asciiz "Matriz 1: "
	GET_MATRIX2:	.asciiz "Matriz 2: "
	
	FILE: .asciiz "fout.txt"
	.align 4
	STRING: .space 240

.text
main:
	# ==========================================================================
	# Recebe ordem da matriz
	#	$s0 = ordem da matriz
	# ==========================================================================
	
	# printa mensaegm para informar N
	li	$v0, 4		# 4 = imprimir string
	la	$a0, GET_SIZE
	syscall			# print
	
	# tamanho das matrizes
	li	$v0, 5		# le inteiro do teclado
	syscall
	move	$s0, $v0	# $s0 = ordem da matriz (N)
	
	# ==========================================================================
	# Alocação de memória para as matrizes de entrada
	# 	$s1 = endereço da matriz 1
	#	$s2 = endereço da matriz 2
	#	#s3 = endereco da matriz resultante
	# ==========================================================================
	
	# calcular espaço de memória necessário para cada matriz
	mul	$t0, $s0, $s0	# $t0 = N ** 2
	sll	$t0, $t0, 2	# $t0 * 4 (4 bytes para cada inteiro)
	
	# aloca memoria para as matrizes de entrada
	li	$v0, 9		# 9 = alocação dinamica de memoria
	move	$a0, $s0	# bytes a serem alocados
	syscall
	move	$s1, $v0	# $s1 = endereço da primeira matriz

	li	$v0, 9
	move	$a0, $s0
	syscall
	move	$s2, $v0	# $s2 = endereço da segunda matriz
	add	$s2, $s2, $t0	# $s2 = seu endereço base + qtd armazenada pelo anterior
	subi	$s2, $s2, 4
	
	li	$v0, 9
	move	$a0, $s0
	syscall
	move	$s3, $v0	# $s3 = endereco da matriz resultante
	add	$s3, $s3, $t0
	add	$s3, $s3, $t0
	subi	$s3, $s3, 8
	
	# ==========================================================================	
	# Recebe matrizes do teclado (le valor por valor)
	# ==========================================================================
	# print inicial
	li	$v0, 4
	la	$a0, GET_MATRIX1
	syscall
	
	# valores iniciais e para comparação
	mul	$t0, $s0, $s0	# $t0 = N * N
	move	$t1, $s1	# inicialmente le dados e coloca na matriz 1
	li	$t2, 0		# $t2 = conta quantos valores foram lidos
	li	$t3, 0		# $t3 = quantas matrizes foram lidas
	
	GET_MATRIX_INPUT:
		li	$v0, 5		# ler inteiro do teclado
		syscall
		sw	$v0, ($t1)	# armazena valor lido na matriz
		
		addi	$t2, $t2, 1	# incrementa quantos valores foram lidos
		addi	$t1, $t1, 4	# proxima posicao da matriz
		
		# enquanto nao tiver lido todos os valores para aquela matriz, recebe valores
		bne	$t0, $t2, GET_MATRIX_INPUT
		
		addi	$t3, $t3, 1	# leu uma matriz inteira
		move	$t1, $s2	# troca matriz que vai ler para matriz2
		li	$t2, 0		# reinicia $t2		
		
		# print para pedir para informar segunda matriz
		li	$v0, 4
		la	$a0, GET_MATRIX2	
		syscall

		# caso tenha lido todos os valores da matriz e lido as duas matrizes
		bne	$t3, 2, GET_MATRIX_INPUT

	move	$a0, $s0
	mul	$a0, $a0, $a0		# $a0 = N**2 
	move	$a1, $s1		# $a1 = endereco matriz 1
	move	$a2, $s2		# $a2 = endereco matriz 2
	move	$a3, $s3		# $a3 = endereco matriz resultante
	
	# multiplica as duas matrizes
	jal	MULT_MATRIXES
	
	# converte a matriz resultante em stirng e a salva em .txt
	move	$a0, $s3
	move	$a1, $s0
	jal	ASCII_AND_SAVE
	
	# salvar matrix em arquivo
	OPEN_FILE:
		li	$v0, 13		# abrir arquivo
		la	$a0, FILE
		li	$a1, 1
		li	$a2, 0
		syscall
		move	$s4, $v0	# $s4 = descritor do arquivo
	
	SAVE_STRING_FILE:
		li	$v0, 15
		move	$a0, $s4
		move	$a1, $s3
		li	$a2, 300	# buffer
		syscall
	
	CLOSE_FILE:
		li	$v0, 16
		move	$a0, $s4
		syscall

# ==========================================================================
# FIM DO PROGRAMA
# ==========================================================================
end:
	j	end
# ==========================================================================

# ==========================================================================	
# Procedimento que realiza a multiplicação da matriz 1 pela matriz 2
# Salva o valor na matriz resultante em memória
# 	$a0 = N**2
#	$a1 = matriz 1
#	$a2 = matriz 2
#	$a3 = matriz resultante
# ==========================================================================	
MULT_MATRIXES:
	# salva valores de $ra e $s0 - $s3 usados na função principal (PUSH)
	addi	$sp, $sp, -20
	sw	$ra, 16($sp)		# salva $ra
	sw	$s0, 12($sp)		# salva $s0 - $s3
	sw	$s1, 8($sp)
	sw	$s2, 4($sp)
	sw	$s3, 0($sp)
	
	# ==========================================================================
	# Calculo da multiplicação das matrizes
	# ==========================================================================
	
	li	$s3, 0			# $s3 = linha (inicialmente 0)
	
	VERIFY_END:
		beq	$s3, $s0, MULT_END_2	# se linha == ordem da matriz, chegou ao final da multiplicacao
		li	$s4, 0			# $s4 = coluna (=0 para reiniciar seu valor)
		
	NEXT_ROW:
		beq	$s4, $s0, MULT_END_1	# se coluna == N, aumenta valor da linha
		li	$s6, 0			# $s6 = acumulador de somas
		j	CALCULATE_VALUE
		
	STORE_RESULT:
		mul  	$t3, $s3, $s0       	# t3 = linha * N
        	sll  	$t3, $t3, 2	   	# $t3 = $t3 * 4
        	sll  	$t4, $s4, 2 		# $t4 = coluna * 4
        	add  	$t3, $t3, $t4      	# $t3 = $t3 * $t4 = (linha * 3 * 4) + (coluna * 4)
	        add  	$t3, $t3, $a3
        	sw   	$s6, ($t3)          	# resultante[linha][coluna] = soma
	        addi 	$s4, $s4, 1          	# c += 1

        	li   	$s5, 0               	# i = 0
        	j	NEXT_ROW
        
        CALCULATE_VALUE:
        	beq  	$s5, $s0, STORE_RESULT 	# se i == N, salva o valor resultante e nao realiza o calculo

	        # calcula o endereço de acesso na matriz A
        	mul  	$t5, $s3, $s0		# $t5 = linha * N
	        sll  	$t5, $t5, 2        	# $t5 = $t5 * 4
        	sll  	$t6, $s5, 2 	       	# $t6 = i * 4
	        add  	$t5, $t5, $t6        	# $t5 = (linha * 3 * 4) + (i * 4)
        	add  	$t5, $t5, $a1
	        lw   	$t5, ($t5)		# $t5 = valor acessado da matriz 1

        	# calcula o endereço de acesso na matriz B
	        mul  	$t7, $s5, $s0		# $t7 = i * 3
        	sll  	$t7, $t7, 2 	     	# $t7 = $t7 * 4
	        sll  	$t8, $s4, 2	        # $t8 = coluna * 4
	        add  	$t7, $t7, $t8        	# endereço de acesso na matriz B
		add  	$t7, $t7, $a2
	        lw   	$t7, ($t7)		# valor acessado da matriz 2
	
		mult	$t5, $t7
		mflo	$t7
	        #mul  	$t7, $t5, $t7        	# $t7 = $t5 * $t7 (valores acessados nas matrizes A e B)
	        add  	$s6, $s6, $t7       	# soma = soma + $t7

        	addi 	$s5, $s5, 1          	# i += 1
        	j	CALCULATE_VALUE
        	
        MULT_END_1:
        	addi	$s3, $s3, 1		# linha ++
        	j 	VERIFY_END
        
        # ==========================================================================
        # Restaura registradores e volta ao programa principal
        # ==========================================================================
        MULT_END_2:
		lw	$s3, 0($sp)
		lw	$s2, 4($sp)
		sw	$s1, 8($sp)
		sw	$s0, 12($sp)
		sw	$ra, 16($sp)
		
		addi	$sp, $sp, 20
		jr	$ra
	
	# ==========================================================================
	#
	# FIM DO PROCEDIMENTO MULT_MATRIXES
	#
	# ==========================================================================

# ==========================================================================	
# Procedimento que converte uma matriz salva em memória para ASCII
# Após convertida a matriz, salva em arquivo .txt
#	$a0 = endereco da matriz resultante
#	$a1 = N (ordem da matriz)
# ==========================================================================	
ASCII_AND_SAVE:
	# salva valores de $ra e $a0 e $a1
	addi	$sp, $sp, -12
	sw 	$ra, 8($sp)
	sw	$a0, 4($sp)
	sw 	$a1, 0($sp)
	
	# valores iniciais para os registradores a serem usados
	li	$t0, 0				# $t0 = percorre a matriz
	mul 	$t2, $a1, $a1			# $t2 = N**2

	sll	$t8, $t2, 2
	add 	$t3, $a0, $t8			# $t3 = percorre STRING
	
	LOAD_VALUE:	
		sll	$t1, $t0, 2
		add 	$t1, $t1, $a0		# endereco na matriz
		lw 	$t1, 0($t1)		# $t1 = valor lido da matriz
	
	VERIFY_SIGNAL:	
		beq 	$t1, 0, STORE_ZERO
		bgt 	$t1, 0, STORE_POSITIVE

	# se nao for positivo ou zero, sinal = -
	STORE_NEGATIVE:
		li	$t4, 45			# $t4 = sinal (-)
		sw 	$t4, 0($t3)		# armazena sinal
		addi 	$t3, $t3, 4		# vai para proxima posicao
		mul 	$t1, $t1, -1 		# modulo do valor lido
		j 	COUNT_DIGITS		

	# se zero, sem sinal
	STORE_ZERO:
		li 	$t4, 32			# espaco em branco
		sw 	$t4, 0($t3)
		addi 	$t3, $t3, 4
		j 	COUNT_DIGITS

	# se positivo, sinal = +
	STORE_POSITIVE:
		li 	$t4, 43			# $t4 = sinal (+)
		sw 	$t4, 0($t3)
		addi 	$t3, $t3, 4

	COUNT_DIGITS:
		li 	$s5, 0			# $s5 = numero de digitos no numero (durante calculo)
		move 	$s7, $t1		# $s7 = valor
		
	COUNT_DIGITS_LOOP:
		addi 	$s5, $s5, 1		# +1 digito
		divu 	$s7, $s7, 10		# divide valor lido por 10
		
		bgt 	$s7, 0, COUNT_DIGITS_LOOP	# enquanto diferente de 0, ha digitos para aumentar

	LOOP_STORE:
		li 	$t4, 1			# $t4 = potencia de 10
		move 	$t5, $s5		# $t5 = numero de digitos


	CALCULATE_POWER:
		subi 	$t5, $t5, 1		# um digito lido
		beq 	$t5, 0, CALCULATE_DIGIT  # caso zero, calcula
	
		mul 	$t4, $t4, 10
		j 	CALCULATE_POWER
	
	CALCULATE_DIGIT:
		divu 	$t9, $t1, $t4		# $t9 = numerot / potencia 10
		mul 	$t6, $t9, $t4		# $t6 = (numero/potencia 10) * potencia 10

		addi 	$t9, $t9, 48		# $t9 = valor convertido em ASCII
	
		sw 	$t9, ($t3)		# salva valor ASCII
		addi 	$t3, $t3, 4		# proxima posicao
	
		sub 	$t1, $t1, $t6		# atualiza valor (1234 - 1000 = 234)
	
		addi 	$t6, $t6, 1		# +1 digito salvo
		subi 	$s5, $s5, 1
	
	bne 	$s5, 0, LOOP_STORE
	li 	$t7, 32				# espaco em branco
	sw 	$t7, ($t3)
	addi 	$t3, $t3, 4

	addi 	$t0, $t0, 1
	blt 	$t0, $t2, LOAD_VALUE
	
	PROCEDURE_END:
		lw 	$a1, 0($sp)
		lw	$a0, 4($sp)
		lw 	$ra, 8($sp)
		addi 	$sp, $sp, 12
		jr	$ra
	
	# ==========================================================================
	#
	# FIM DO PROCEDIMENTO ASCII_AND_SAVE
	#
	# ==========================================================================
