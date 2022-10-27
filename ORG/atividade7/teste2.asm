.data
	file: .asciiz "array.txt"		#arquivo de saida
	.align 2
	array: .word 100 200 135 1 -1 -3 0 1 73 6     	#array salvo na memória
	.align 0
	array_ascii: .space 240			#espaço de 40 bytes para escrever os dígitos em ascii
	
.text

# ================================
# PROGRAMA PRINCIPAL
# ================================
	la $s1, array 			#s1 tem o endereço do array na memória
	la $s2, array_ascii		#s2 tem o endereço do array_ascii
	li $s3, 0			#s3 é o contador que vai de 0 a 10

loop:	mul $t0, $s3, 4			#t0 é o endereço relativo do array
	add $t0, $s1, $t0		#t0 é o endereço absoluto do array no elemento cujo índice é s3 
	lw $t0, 0($t0)			#t0 guarda array[$s3]
	
	move $a0, $t0			#passando array[$s3] como parâmetro
	add $s7, $s6, $s7			#s7 incrementa s6
	mul $t0, $s7, 4			#t0 é endereço relativo de array_ascii
	add $t0, $s2, $t0		#t0 é endereço absoluto de array_ascii
	
	addi $a1, $t0, 0		#passando endereço de array_ascii[$s3] como parâmetro
	
	li $s6, 0
	jal convert_int_ascii		#chama o método de conversao
	
	addi $s3, $s3, 1		#s3 incrementa

	blt $s3, 10, loop		#se s3 for menor que 10, deve repetir o loop
	j escrever_arquivo

# ===================================
# ROTINA DE CONVERTER INT EM ASCII
# ===================================
convert_int_ascii:
	addi $sp, $sp, -12		#prepara push para salvar a0 e a1 na pilha
	sw $ra, 8($sp)			#salva o retorno
	sw $a0, 4($sp)			#salva a0 - array[$s3]
	sw $a1, 0($sp)			#salva a1
	
	lw $a0, 4($sp)			#a0 é array[$s3]
	lw $a1, 0($sp)			#a1 é endereço de array_ascii[$s3]

teste_sinal:	
	beq $a0, 0, salva_zero		#se o número for zero
	bgt $a0, 0, salva_pos		#se o número for positivo

salva_neg:
	li $t0, 45			#hífen em ASCII
	sw $t0, 0($a1)
	mul $a0, $a0, -1 		#multiplica array[s3] por -1
	j loop_conta_digitos		

salva_zero:
	li $t0, 32			#nem + nem -
	sw $t0, 0($a1)			#salva espaço em array[s3]
	j loop_conta_digitos

salva_pos:
	li $t0, 43			# + em ASCII
	
	sw $t0, 0($a1)			#salva - ou + em array_ascii[s3]

	li $s5, 0			#contador de dígitos do número
	move $t2, $a0			#move valor de a0 para t2

loop_conta_digitos:
	addi $s5, $s5, 1		#incrementa um dígito
	divu $t2, $t2, 10		#divide array[$s3] por 10
	
	bgt $t2, 0, loop_conta_digitos	#se chegar em zero, acaba a contagem de dígitos
					#senão volta para o loop

	#addi $v0, $s5, 1		#retorno do procedimento
	li $t6, 1			#contador de sígitos salvos
	addi $s6, $s5, 2		#move o número de dígitos para s6
	
loop_salva_memoria:
	li $t3, 1
	move $t4, $s5
	
loop_calcula_potencia:
	subi $t4, $t4, 1
	beq $t4, 0, calcula_digito
	mul $t3, $t3, 10
	j loop_calcula_potencia
	
calcula_digito:
	divu $t5, $a0, $t3		#t5 é numero a0 dividido pela potência de 10
	mul $t1, $t5, $t3		#t5 recebe multiplicação do quociente pelo divisor

	addi $t5, $t5, 48		#transforma inteiro em ASCII
	mul $t7, $t6, 4
	add $t7, $t7, $a1		#t7 é endereço absoluto de array_ascii
	sw $t5, 0($t7)			#salva valor da divisão em array_ascii[s3 + t6]
	
	sub $a0, $a0, $t1		#atualiza a0 -> 135 - 100 = 35
	
	addi $t6, $t6, 1		#incrementa contador de dígitos salvos 
	subi $s5, $s5, 1		#agora a0 tem um digito a menos
	bne $s5, 0, loop_salva_memoria 	#se não chegar em zero, repete o loop de salvamento
	addi $t7, $t7, 4		#endereço absoluto para o espaço
	li $t1, 32			#caractere de espaço em ASCII
	sw $t1, 0($t7)			#salva espaço
	
retorna_stack:
	#sw $t1, 8($a1)
	lw $a1, 0($sp)
	lw $a0, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra

# FIM DO PROCEDIMENTO
# ==================	


# ==================
# ESCRTA EM ARQUIVO
# ==================
escrever_arquivo:
	li $v0, 13 			# Comando para abrir novo arquivo. 
	la $a0, file 			# Carrega nome do arquivo a ser aberto. 
	li $a1, 1 			# Aberto para escrita (flags são 0: read, 1: write).
	li $a2, 0 			# Modo ignorado (neste caso). 
	syscall 			# Abre arquivo (descritor do arquivo é colocado em $v0).
	move $s7, $v0 			# Salva o descritor do arquivo para uso no fechamento, por exemplo
	
	li $v0, 15 			# Comando para escrever no arquivo. 
	move $a0, $s7			# Descritor do arquivo é passado. 
	la $a1, array_ascii 		# Endereço do buffer do qual será copiado para o arquivo. 
	li $a2, 240	 		# Tamanho do buffer (hardcoded). 
	syscall 			# Escreve no arquivo.
	
	li $v0, 16 			# Comando para fechamento do arquivo. 
	move $a0, $s7			# Descritor do arquivo é passado.
	syscall 			# Arquivo é fechado pelo sistema operacional.