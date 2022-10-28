.data
	# print inicial
	GET_N: .asciiz "Informe o valor de N: "
	GET_A_MATRIX: .asciiz "Matriz A: "
	GET_B_MATRIX: .asciiz "Matriz B: "
	NEW_LINE:     .asciiz "\n"
	
.text
main:	
	# le valor por valor de cada matriz

	# calculo da quantidade espacos de memoria reservados
	li	$t0, 5
	mul	$t0, $t0, $t0	
	sll	$t0, $t0, 2
	
	move	$a0, $t0
	li	$v0, 9
	syscall			# 9 = valor para reservar memoria
	
	move	$t1, $v0	# endereco reservado
	sw	$t0, 96($t1)	# salva no ultimo endereco (N=5)
