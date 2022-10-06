.data
	MATRIZ_A:	.word 1, 2, 3, 0, 1, 4, 0, 0, 1
	MATRIZ_B:	.word 1, -2, 5, 0, 1, -4, 0, 0, 1
	MATRIZ_RESULTANTE:	.space 9
.text
	la	$s0, MATRIZ_A		# endereco base da matriz A
	la	$s1, MATRIZ_B		# endereço base da matriz B
	la	$s2, MATRIZ_RESULTANTE  # endereço base da matriz resultante

   	li   	$s3, 0               	# linha = 0

	VERIFICA_FIM:
        	beq  	$s3, 3, FIM		# se linha == 3, finaliza o programa
		li   	$s4, 0          	# coluna = 0 (reinicia o valor da coluna)

	PROX_LINHA:
        	beq  	$s4, 3, mult_end2	# se coluna = 3, aumenta o valor da linha
        	li   	$s6, 0               	# soma = 0
        	j    	CALCULA_VALOR

	SALVA_RESULTANTE:
		mul  	$t3, $s3, 3       	# t3 = linha * 3
        	sll  	$t3, $t3, 2	   	# $t3 = $t3 * 4
        	sll  	$t4, $s4, 2 		# $t4 = coluna * 4
        	add  	$t3, $t3, $t4      	# $t3 = $t3 * $t4 = (linha * 3 * 4) + (coluna * 4)
	        add  	$t3, $t3, $s2
        	sw   	$s6, ($t3)          	# resultante[linha][coluna] = soma
	        addi 	$s4, $s4, 1          	# c += 1

        	li   	$s5, 0               	# i = 0
        	j    	PROX_LINHA

    	CALCULA_VALOR:
      	  	beq  $s5, 3, SALVA_RESULTANTE 	# se i == 3, salva o valor resultante e nao realiza o calculo

	        # calcula o endereço de acesso na matriz A
        	mul  	$t5, $s3, 3		# $t5 = linha * 3
	        sll  	$t5, $t5, 2        	# $t5 = $t5 * 4
        	sll  	$t6, $s5, 2 	       	# $t6 = i * 4
	        add  	$t5, $t5, $t6        	# $t5 = (linha * 3 * 4) + (i * 4)
        	add  	$t5, $t5, $s0
	        lw   	$t5, ($t5)			# $t5 = valor acessado da matriz A

        	# calcula o endereço de acesso na matriz B
	        mul  	$t7, $s5, 3		# $t7 = i * 3
        	sll  	$t7, $t7, 2 	     	# $t7 = $t7 * 4
	        sll  	$t8, $s4, 2	        # $t8 = coluna * 4
	        add  	$t7, $t7, $t8        	# endereço de acesso na matriz B
		add  	$t7, $t7, $s1
	        lw   	$t7, ($t7)			# valor acessado da matriz B
	
	        mul  	$t7, $t5, $t7        	# $t7 = $t5 * $t7 (valores acessados nas matrizes A e B)
	        add  	$s6, $s6, $t7       	# soma = soma + $t7

        	addi 	$s5, $s5, 1          	# i += 1
        	j    	CALCULA_VALOR

    	mult_end2:
        	addi 	$s3, $s3, 1          	# linha += 1
        	j    	VERIFICA_FIM
    	
    	FIM:
    	
