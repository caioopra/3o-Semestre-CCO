.data
	GET_N: 	.asciiz "Valor de N: "
	GET_P: 	.asciiz "Valor de P: "
	INVALID:.asciiz "Valor inválido, insira novamente!\n"
	RESULT: .asciiz "Resultado da combinação: "
	
.text
main:
	# ==============================================
	# Recebe os valores lidos do teclado
	#	$s0 = N
	#	$s1 = P
	# ==============================================
	GET_INPUTS:
		li	$v0, 4
		la	$a0, GET_N
		syscall
	
		# entrada de N
		li	$v0, 5
		syscall
		move	$s0, $v0		

		li	$v0, 4
		la	$a0, GET_P
		syscall
		
		# entrada de P
		li	$v0, 5
		syscall
		move	$s1, $v0
		
		# verifica se o valor é válido ( N >= P)
		bge	$s0, $s1, CALCULATE
		
		# senão, informa erro e pede novamente as entradas
		li	$v0, 4
		la	$a0, INVALID
		syscall
		j	GET_INPUTS
	
	# ==============================================
	# Chamada de procedimento responsável por realizar o cálculo
	# ==============================================
	CALCULATE:
		move	$a0, $s0
		move	$a1, $s1
		jal	CALCULATE_COMBINATION
	
		move	$s2, $v0
	# mostra mensagem de fim de procedimento e o valor calculado	
	li	$v0, 4
	la	$a0, RESULT
	syscall
	
	move	$a0, $s2
	li	$v0, 1
	syscall
	
END:
	j	END
	

# ==============================================
# Calcula a combinação de N, P a P
#	$a0 = N
#	$a1 = P
#	$v0 = retorno do valor obtido
# ==============================================
CALCULATE_COMBINATION:
	# ==============================================
	# salva os registradores
	# ==============================================
	addi	$sp, $sp, -12
	sw	$ra, 8($sp)
	sw	$a0, 4($sp)
	sw	$a1, 0($sp)
	
	# ==============================================
	# $t0 = N!
	# ==============================================
	jal	FACTORIAL		# $a0 já está carregado com o valor de N
	move	$t0, $v0
	
	# ==============================================
	# $t2 = (N - P)!
	# ==============================================
	# move	$t3, $a0		# salva o valor de N para não ser perdido
	sub	$a0, $a0, $a1
	jal	FACTORIAL
	move	$t2, $v0
	
	# ==============================================
	# $t1 = P!
	# ==============================================
	move	$a0, $a1		# $a0 = P
	jal	FACTORIAL
	move	$t1, $v0
	
	# ==============================================
	# Calcula o valor da combinação
	# ==============================================
	mul	$t1, $t1, $t2		# $t1 = P! * (N - P)!
	div	$t1, $t0, $t1		# $t1 = N! / (P! * (N - P)!)
	
	# ==============================================
	# retorno da função e remove da pilha
	# ==============================================
	END_COMBINATION:
		move	$v0, $t1
		
		lw	$a1, 0($sp)
		lw	$a0, 4($sp)
		lw	$ra, 8($sp)
		addi	$sp, $sp, 12
		
		jr	$ra
	# ==============================================
	# FIM DO PROCEDIMENTO CALCULATE_COMBINATION
	# ==============================================

# ==============================================
# Procedimento de calcula o fatorial de um valor
#	$a0 = valor a ser calculado
#	$v0 = retorna valor do fatorial de $a0
# ==============================================
FACTORIAL:
	addi	$sp, $sp, -8
	sw	$ra, 4($sp)
	sw	$a0, 0($sp)
	
	# ==============================================
	# verifica se calcula o valor ou retorna 1
	# ==============================================
	bgt	$a0, 1, CALCULATE_FACTORIAL		# se $a0 > 1, calcula $a0 * fatorial($a0 - 1)
	
	li	$v0, 1		# caso contrario, retorna 1
	addi	$sp, $sp, 8
	jr	$ra
	
	CALCULATE_FACTORIAL:
		subi	$a0, $a0, 1		# $a0 = $a0 - 1
		jal	FACTORIAL		# chamada recursiva, com valor de argumento $a0 - 1
		
		lw	$a0, ($sp)
		lw	$ra, 4($sp)
		addi	$sp, $sp, 8
		
		mul	$v0, $a0, $v0		# $v0 = $a0 * ($a0 - 1)
		jr	$ra

	# ==============================================
	# FIM DO PROCEDIMENTO FACTORIAL
	# ==============================================
