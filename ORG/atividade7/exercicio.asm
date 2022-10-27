.data
	GET_SIZE: 	.asciiz "Informe o tamanho das matrizes (N): "
	GET_MATRIX1:	.asciiz "MAtriz 1: "
	GET_MATRIX2:	.asciiz "Matriz 2: "
	BREAK_LINE:	.asciiz "\n"
	
	FILE: .asciiz "fout.txt"
	.align 4
	STRING: .space 240
	
	.align 4
	result: .asciiz "                                    "

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
	jal	ASCII_AND_SAVE
	
# ==========================================================================
# FIM DO PROGRAMA
# ==========================================================================
end:
	j	end

# ==========================================================================

# ==========================================================================	
# Procedimento que realiza a multiplicação da matriz 1 pela matriz 2
# Salva o valor na matriz resultante em memória
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
	# 	$a0 = N**2
	#	$a1 = matriz 1
	#	$a2 = matriz 2
	#	$a3 = matriz resultante
	# ==========================================================================
	
	li	$s3, 0			# $s3 = linha (inicialmente 0)
	
	VERIFY_END:
		beq	$s3, $s0, MULT_END_1	# se linha == ordem da matriz, chegou ao final da multiplicacao
		li	$s4, 0			# $s4 = coluna (=0 para reiniciar seu valor)
		
	NEXT_ROW:
		beq	$s4, $s0, MULT_END_2	# se coluna == N, aumenta valor da linha
		li	$s6, 0			# $s6 = acumulador de somas
		j	CALCULATE_VALUE
		
	STORE_RESULT:
		mul  	$t3, $s3, $s0       	# t3 = linha * 3			=> TROCAR POR $S0?
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
        	mul  	$t5, $s3, $s0		# $t5 = linha * 3			=> TROCAR POR $S0?
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
	
		#mult	$t5, $t7
		#mflo	$t7
	        mul  	$t7, $t5, $t7        	# $t7 = $t5 * $t7 (valores acessados nas matrizes A e B)
	        add  	$s6, $s6, $t7       	# soma = soma + $t7

        	addi 	$s5, $s5, 1          	# i += 1
        	j	CALCULATE_VALUE
        	
        MULT_END_2:
        	addi	$s3, $s3, 1		# linha ++
        	j 	VERIFY_END
        
        # ==========================================================================
        # Restaura registradores e volta ao programa principal
        # ==========================================================================
        MULT_END_1:
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
# ==========================================================================	
ASCII_AND_SAVE:
	# salva valores de $ra e $s0 - $s3 usados na função principal (PUSH)
	addi	$sp, $sp, -20
	sw	$ra, 16($sp)		# salva $ra
	sw	$s0, 12($sp)		# salva $s0 - $s3
	sw	$s1, 8($sp)
	sw	$s2, 4($sp)
	sw	$s3, 0($sp)
	
	# ==========================================================================
	move	$s0, $a0		# $s0 = numero de iterações (tamanho da matriz)
	li	$s1, 0			# $s1 = conta quantos numeros foram lidos
	li	$s2, 0			# $s2 = indice do ARRAY (i=0)
	li	$s3, 0			# $s3 = indice da STRING (j=0)
	li	$t0, 0			# $t0 = conta quantos digitos um numero tem (reiniciado para cada numero lido)
	la	$s5, STRING

	# executa os labels abaixo para cada valor do vetor
	# le o valor da matriz
	READ_NUMBER:
		beq	$s1, $s0, CONVERSION_END	# caso tenha lido todos valores, escreve em arquivo
		
		mul	$t1, $s2, 4			# i * 4
		add	$t1, $t1, $a3			# ARRAY[i * 4]
		lw	$t1, 0($t1)			# $t1 = valor lido em ARRAY[i]

		move	$t2, $t1			# $t2 = $t1
		
		bgt	$t1, 0, GREATER_T_ZERO		# coloca + caso for positivo
		blt	$t1, 0, LESS_T_ZERO		# coloca - caso for negativo
		# se nao for nenhum dos dois, não colca sinal
		j	COUNT_DIGITS

		LESS_T_ZERO:
			li	$t3, 45			# "-"
			mul	$t1, $t1, -1
			j 	STORE_SIGNAL
		
		GREATER_T_ZERO:
			li	$t3, 43			# "+"
			j 	STORE_SIGNAL
		
		STORE_SIGNAL:
			mul	$t4, $s3, 4		# j * 4
			add	$t5, $t4, $s5		# STRING[j]
			addi	$s3, $s3, 1		# aumenta 1 no indice de STRING (j)
			
			sw	$t3, 0($t5)		# armazena +/-
			j	COUNT_DIGITS
			
			

	# conta quantos digitos o valor lido possui para fazer a conversao para ASCII
	# $t0 conta quantos digitos possui e coloca no buffer
	COUNT_DIGITS:
	
		# primeiramente faz divisões sucessivas por 10 até ter valor 0
		# quando o valor for 0, terminou de achar dígitos válidos e pode salvar o valor
		addi	$t0, $t0, 1		# $t0 = qtd de dígitos do numero
		div	$t2, $t2, 10		# $t2 = $t2 / 10
		
		bne	$t2, 0, COUNT_DIGITS	# enquanto valor for diferente de 0, conta

	STORE_NUMBER: 
		move	$t4, $t1
		li	$t3, 1			# $t3 = potencia de 10 de quantos dígitos o valor possui-1
		
		beq	$t0, 1, STORE		# se só tiver 1 dígito, pode pular para armazenar
		move	$t2, $t0
		# calcula a potencia de 10 se necessario
		TEN_POWER_I:
			mul	$t3, $t2, 10		# $t3 = valor da potencia de 10 (-1)
			
			bne	$t3, 0, NOT_POWER_ONE
			beq	$t3, 1, NOT_POWER_ONE
			li	$t3, 1
			
			NOT_POWER_ONE:
				subi	$t2, $t2, 1		# $t2 = auxiliar para potencia
				blt	$t2, 0, STORE			
				bne	$t2, 0, TEN_POWER_I

		
		STORE:
			# sai do laço com $t3 valendo 10 ^ i-1
			div	$t4, $t4, $t3 		# valor / 10 ^ (i -1)
			
			# prepara valor para proxima iteração ($t1 - $t3*(10^i-1)
			mul	$t5, $t3, $t4		# $t3 * 10^i-1
			sub	$t5, $t1, $t5		# $t5 = $t1 - $t5  => valor para proxima iteracao

			add	$t4, $t4, 48		# soma 48 para transpor para ASCII
		
			# salva o valor dentro de STRING
			mul	$t6, $s3, 4
			add	$t6, $t6, $s5		# STRING[4*j]

			sw	$t4, 0($t6)		# salva ARRAY[i] em STRING[j]
	
		# subtraindo 1 conta quantos dígitos do numero foram escritos
		subi	$t0, $t0, 1
		addi	$s3, $s3, 1		# j++
		move	$t4, $t5		# $t4 = proximo valor do numero lido
		bne	$t0, 0, TEN_POWER_I 	# se não tiver escrito todos, converte de novo com outra potencia
	
	# prepara valores para proximo valor
	NEXT_VALUE:
		# salvando espaco em branco:
		li	$t3, 32			# 32 para colocar espaco em braco
		mul	$t7, $s3, 4
		add	$t7, $t7, $s5
		 
		sw	$t3, ($t7)		# salva em STRING[i+j]
		addi	$s3, $s3, 1		# j++
		
		# incrementa valores para proxima iteracao
		addi	$s2, $s2, 1		# i++
		add	$s1, $s1, 1		# aumenta quantos numeros foram lidos e escritos
		j	READ_NUMBER
	
	CONVERSION_END:
		OPEN_FILE:
			li	$v0, 13		# abrir arquivo
			la	$a0, FILE
			li	$a1, 1
			li	$a2, 0
			syscall
			move 	$s6, $v0	# $s6 = descritor do arquivo
			
		SAVE_STRING_FILE:
			li	$v0, 15		# escrever em arquivo
			move	$a0, $s6
			move	$a1, $s5	# move string para $a1
			li	$a2, 300	# tamanho para buffer
			syscall
			
		CLOSE_FILE:
			li	$v0, 16		# fecha arquivo
			move	$a0, $s6
			syscall
	
		lw	$s3, 0($sp)
		lw	$s2, 4($sp)
		sw	$s1, 8($sp)
		sw	$s0, 12($sp)
		sw	$ra, 16($sp)
		
		addi	$sp, $sp, 20
		jr	$ra
	
	# FIM DO PROCEDIMENTO
