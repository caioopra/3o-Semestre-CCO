.data
	FILE: .asciiz "fout.dat"
	
	.align 0
	BUFFER: .space 120
	
	.align 2
	ARRAY: .word 0 0 0 0 0 0 0 0 0 0	

.text
main:
	la 	$s0, BUFFER		# $s0 = endereco de BUFFER
	la 	$s1, ARRAY		# $s1 = endereço de ARRAY

	li	$s2, 0 			# $s2 = byte do buffer
	li	$s6, 0 			# vai incrementando para salvar na memória

	# abertura do arquivo
	li 	$v0, 13 
	la 	$a0, FILE 		# $a0 = endereco do nome do arquivo
	li	$a1, 0
	syscall		
			
	move 	$s7, $v0 		# $s7 = descritor do arquivo
	
	# le o arquivo
	move 	$a0, $s7
	li 	$v0, 14 		# leitura de arquivo
	la	$a1, BUFFER
	li 	$a2, 120
	syscall

	jal	CONVERT_ASCII_TO_INT	# inicia procedimento
	
	# fechar o arquivo
	li 	$v0, 16			# comando para fechar o arquivo
	move 	$a0, $s7
	syscall	

# fim da execução do programa
end:
	j	end
	
CONVERT_ASCII_TO_INT:
	# salvamento de $sp e $a
	addi 	$sp, $sp, -12	
	sw	$ra, 8($sp)
	sw	$a0, 4($sp)
	sw	$a1, 0($sp)		
	
	li 	$v0, 4 				# escrita no terminal
	la	$a0, BUFFER			# mostrar string no terminal
	syscall

	TESTS:
		# vai para o final ao ler os 10 valores
		bge 	$s6, 10, PROCEDURE_END

		add 	$t0, $s0, $s2
		lb 	$t2, ($t0)			# $t2 = valor ASCII
	
		# verificações para o valor lido
		beq 	$t2, 32, IS_SPACE 			# verifica se o valor é um espaço em branco
		beq 	$t2, 48, IS_ZERO 			# vefifica se o valor é zero
		beq 	$t2, 43, IS_POSITIVE			# verifica se o valor é positivo (+ na frente)
		beq 	$t2, 45, IS_NEGATIVE	  		# verifica se o valor é negativo (- na frente)

		li 	$v0, 4			# escrever no terminal.
		la 	$a0, 8($s0) 		# string
		syscall

	IS_SPACE:
		addi 	$s2, $s2, 1 		# vai para proximo byte
		j 	TESTS
	

	IS_ZERO:
		add 	$t0, $s0, $s2
		lb 	$t2, ($t0)		# $t2 = valor ASCII

		addi 	$t2, $t2, -48		# ASCII para int
	
		add 	$t1, $s1, $s6		# valor absoluto
		lw 	$t0, ($t1)
		sw 	$t2, ($t1)
		addi 	$s6, $s6, 4
		addi 	$s2, $s2, 1	

		j 	TESTS


	IS_POSITIVE:
		addi 	$s2, $s2, 1 		# $s2 = numero lido (positivo)
	
		add 	$t0, $s0, $s2 
		lb 	$t2, ($t0)		# $t2 = valor em ASCII

		addi 	$t2, $t2, -48		# $t2 =  valor int
	
		add 	$t1, $s1, $s6		# calculando o valor absoluto p o resultado
		lw 	$t0, ($t1)
		sw 	$t2, ($t1)		# salva o valor agora em int
	
		addi 	$s6, $s6, 4 		# proxima posicao de memoria
		addi 	$s2, $s2, 1 		# proximo valor

		j TESTS

	IS_NEGATIVE: 
		addi 	$s2, $s2, 1
	
		add 	$t0, $s0, $s2
		lb 	$t2, ($t0)
	
		addi 	$t2, $t2, -48
		mul  	$t2, $t2, -1		# valor * -1
		
		add 	$t1, $s1, $s6
		lw 	$t0, ($t1)
		sw 	$t2, ($t1)
	
		addi 	$s6, $s6, 4 
		addi 	$s2, $s2, 1 				

		j TESTS

	PROCEDURE_END:  			# restaura registradores e atualiza $sp
		lw	$a1, 0($sp)
		lw	$a0, 4($sp)
		lw	$ra, 8($sp)
		addi 	$sp, $sp, 12
		jr	$ra				
	# FIM DO PROCEDIMENTO
