.data
	INITIAL_PRINT1:	.asciiz "Coeficiente de x: "
	NEWLINE:	.asciiz "\n "
	INITIAL_PRINT2:	.asciiz "Termo independente: "
	RESULT:		.asciiz	"Raiz da equacao: "
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
	
	move	$a0, $s0	# coeficiente de x como primeiro argumento
	move	$a1, $s1	# temro independente como segundo argumento
	jal	calcula_raiz
	
	move	$s2, $v0	# salva o valor retornado pelo procedimento
	
	# =======================
	# mostrando na tela o resultado
	li	$v0, 4
	la	$a0, RESULT
	syscall
	li	$v0, 1
	la	$a0, ($s2)
	syscall

end:
	j end

# raiz: ax+b = 0 => x = -b/a
calcula_raiz:
	# salvando registradores s0 e s1
	addi	$sp,  $sp, -12		# 2 valores * 4
	sw 	$ra, 8($sp)		# salva valor de $ra
	sw	$s1, 4($sp)
	sw	$s0, 0($sp)

	mul	$t0, $a1, -1		# -1 * b = -b
	div	$t0, $t0, $a0		# t0 = -b / a
	
	mflo	$t0			# armazena 32 LSBs em $t0
	move	$v0, $t0		# armazena resultado no registrador de retorno

	# retorna à execução do programa
	jr	$ra

	

