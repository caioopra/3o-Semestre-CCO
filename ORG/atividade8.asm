.data
	GET_N: 	.asciiz "Valor de N: "
	GET_P: 	.asciiz "Valor de P: "
	INVALID:.asciiz "Valor inv�lido, insira novamente!"
	RESULT: .asciiz "Resultado da combina��o: "
	
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
		
		# verifica se o valor � v�lido ( N >= P)
		bge	$s0, $s1, CALCULATE
		
		# sen�o, informa erro e pede novamente as entradas
		li	$v0, 4
		la	$a0, INVALID
		syscall
		j	GET_INPUTS
	
	# ==============================================
	# Chamada de procedimento respons�vel por realizar o c�lculo
	# ==============================================
	CALCULATE:
		move	$a0, $s0
		move	$a1, $s1
		jal	CALCULATE_COMBINATION
		

# ==============================================
# Calcula a combina��o de N, P a P
#	$a0 = N
#	$a1 = P
#	$v0 = retorno do valor obtido
# ==============================================
CALCULATE_COMBINATION:

	
		
	