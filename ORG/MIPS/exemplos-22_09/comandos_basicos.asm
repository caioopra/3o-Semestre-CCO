.data	# montador coloca na memória de dados tudo que vem nesse trecho
	# declaração de variáveis do programa
	# segmento de dados (RAM) começa no endereço 0x1001000
	LETRA:  .ascii "A"
	NUMERO: .word 25
	HELLO: .asciiz "Oi, alunos de INE5411!"
	
.text # considera como programa e coloca na memória de programa
	addi	$s1, $zero, 1000	# uma forma de inicializar valor em registrador
	addi	$s2, $zero, 250	
	addi	$s3, $zero, 0x10010020
	sub	$t0, $s1, $s2		# t0 = s1 - s2 = 1000 - 250
	sw	$t0, 4($s3)		# endereço absoluto contido em $s3 e colocado 4 words de 8 bits pra frente
	lw	$t1, NUMERO		# coloca o valor de NUMERO no registrador $t1
	
#	addi $v0, $v0, 1		# comando 1: colocar na tela um inteiro, que está em $a0
#	addi $a0, $a0, 10		# valor a ser escrito na tela (10)
#	syscall				# precisa que parametro a ser mostrado na tela esteja em a0 ("argumento"); chamada de função
					# addi é o método tradicional, mas pode-se fazer com li e la que nem abaixo
					
	li 	$v0, 4
	la	$a0, HELLO
	syscall				# irá imprimir a mensagem na tela
	
	li 	$v0, 5			# ler do teclado
	syscall
	move	$t0, $v0		# retorno do que é lido sobrescreve o valor em $v0
	 
	li 	$v0, 1
	la	$a0, ($t0)
	syscall