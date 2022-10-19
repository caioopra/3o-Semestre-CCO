.data
	INITIAL_PRINT1:	.asciiz "Coeficiente de x: "
	NEWLINE:	.asciiz "\n "
	INITIAL_PRINT2:	.asciiz "Termo independente: "
	RESULT:		.word 70
.text
main:
	# =======================
	# lendo valores de entrada do teclado
	# primeiro valor:
	li	$v0, 4		# imprimir string pedindo para informar coeficiente de x
	la	$a0, INITIAL_PRINT1
	syscall
	
	li	$v0, 5		# comando para ler inteiro
	syscall
	move	$s0, $v0	# coeficiente de x armazenado em $s0
	
	# segundo valor:
	li	$v0, 4
	la	$a0, INITIAL_PRINT2
	syscall			# printa segunda mensagem na tela
	
	li	$v0, 5
	syscall
	move	$s1, $v0	# termo independente em $s1
	
	# =======================
	# carrega os argumentos do procedimento
	# ???
	# chama procedimento para calculo da raiz
	
	jal	calcula_raiz

end:
	j end

calcula_raiz:
	# salvando registradores s0 e s1
	addi	$sp,  $sp, -8		# 2 valores * 4
	sw	$s1, 4($sp)
	sw	$s0, 0($sp)

	

