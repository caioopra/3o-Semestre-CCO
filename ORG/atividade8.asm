.data
	GET_N: 	.asciiz "Valor de N: "
	GET_P: 	.asciiz "Valor de P: "
	INVALID:.asciiz "Valor inválido, insira novamente!"
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
		

# ==============================================
# Calcula a combinação de N, P a P
#	$a0 = N
#	$a1 = P
#	$v0 = retorno do valor obtido
# ==============================================
CALCULATE_COMBINATION:

	
		
	