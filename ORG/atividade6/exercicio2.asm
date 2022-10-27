.data
	.align 2
	ARRAY:	.word 99 -2 32 4 5 6 7 8 9 -10
	FILE: 	.asciiz "fout.dat"
	.align 4
	STRING: .space 240

.text
main:
	# -------------------------------
	# abre arquivo
	li	$v0, 13		# abre arquivo
	la	$a0, FILE	# carrega o nome do arquivo
	li	$a1, 1		# modo de escrita de arquivo
	li	$a2, 0
	syscall
	move	$s6, $v0		# = $s6 contem descritor do arquivo para fechar
	
	# -------------------------------
	# chama procedimento para converter os dados do array
	la	$s4, ARRAY		# $s4 = endereço de memória de ARRAY
	la	$s5, STRING		# $s5 = endereço de memória de STRING
	
	# escreve os numeros no buffer STRING (em ascii)
	jal 	convert_numbers
	
	# -------------------------------
	# salva STRING em arquivo
	li	$v0, 15			# escrever em arquivo
	move	$a0, $s6		# descritor do arquivo aberto
	la	$a1, STRING		# conteudo que deve ser escrito (ascii)
	li	$a2, 300		# tamanho do buffer
	syscall
	
	# -------------------------------
	# fecha arquivo
	li	$v0, 16
	move	$a0, $s6		# descritor do arquivo que quer fechar
	syscall

# FIM DO PROGRAMA
end:
	j	end

# converte numero lido do array em ascii
convert_numbers:
	# -------------------------------
	# PUSH
	addi	$sp, $sp, -12
	sw	$ra, 8($sp)
	sw	$a0, 4($sp)
	sw	$a1, 0($sp)
	# -------------------------------

	li	$s0, 10		# $s0 = numero de iterações (tamanho do array)
	li	$s1, 0		# $s1 = conta quantos numeros foram lidos
	li	$s2, 0		# $s2 = indice do ARRAY (i=0)
	li	$s3, 0		# $s3 = indice da STRING (j=0)
	li	$t0, 0		# $t0 = conta quantos digitos um numero tem (reiniciado para cada numero lido)

	# executa os labels abaixo para cada valor do vetor
	# le o valor do vetor[i]
	READ_NUMBER:
		beq	$s1, $s0, CONVERSION_END	# caso tenha lido todos valores, escreve em arquivo
		
		mul	$t1, $s2, 4			# i * 4
		add	$t1, $t1, $s4			# ARRAY[i * 4]
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
	COUNT_DIGITS:					# FUNCIONANDO!
	
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
		# restaura $a e $ra
		lw	$a1, 0($sp)
		lw	$a0, 4($sp)
		lw	$ra, 8($sp)
		addi	$sp, $sp, 12		# atualiza $sp
		jr	$ra
	# FIM DO PROCEDIMENTO
	
		
			
			
		
		
		
