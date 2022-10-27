.data
	fout: .asciiz "produto.txt"
	.align 4
	resultado:	.asciiz "                                    "
.text 

# ===============================================================================================
# Abre um arquivo para ser escrito.
# ===============================================================================================
li	$v0, 13			# Comando para abrir novo arquivo.
la	$a0, fout		# Carrega o nome do arquivo a ser aberto.
li	$a1, 1			# Aberto para escrita (0: lêr; 1: escrever).
li	$a2, 0			# Modo ignorado (neste caso).
syscall				# Chamada de sistema. Descritor do arquivo é colocado em $v0.
move	$s6, $v0		# Salva descritor do arquivo para uso no fechamento posterior.


li 	$v0, 5		# le tamanho da matriz
syscall
move 	$s0, $v0
move	$t8, $s0	# setando $t8 como n

mult 	$s0, $s0	# calcula espaco para a matriz resultante
mflo	$s0

li 	$v0, 9		# aloca espaco para a matriz resultante
move	$a0, $s0
syscall
move	$s2, $v0	# $s2 = matriz resultante

li	$t0, 2		# calcula espaco para as matrizes de entrada
mult 	$s0, $t0
mflo	$t0

li 	$v0, 9		# aloca espaco para as entradas
move	$a0, $t0
syscall
move	$s0, $v0	# $s0 = matrizes de entrada

li	$t1, 4			# calcula repeticoes do loop
mult	$t1, $t0
mflo	$t2
li	$t0, 0
li	$t1, 0

ler_matrizes:
	add $t1, $s0, $t0	# soma posicao do array com 4

	li $v0, 5		# le valor do teclado
	syscall
	move $s1, $v0
	sw $s1, ($t1)		# salva valor lido no array

	addi $t0, $t0, 4	# soma a variavel
	bne $t0, $t2, ler_matrizes	# volta para o loop

jal multiplicar

jal transferir

li $v0, 15
move $a0, $s6
la $a1, resultado
li $a2, 500
syscall
# ===============================================================================================
# Após transferir o buffer para o arquvio, o código abaixo fecha o arquivo com uma chamada no SO.
# ===============================================================================================	
li	$v0, 16			# Comando para fechamento do arquivo.
move	$a0, $s6		# Passa o descritor do arquivo que será fechado.
syscall				# Arquivo é fechado pelo Sistema Operacional.

j end

transferir:
	addi	$sp, $sp, -4		# Prepara PUSH para salvar dados de a0 e a1 (usados na rotina principal!)
	sw	$ra, 8($sp)		# Salva retorno - Stack Pointer.
	la 	$t0, ($s2)
	la	$s2, resultado

	li	$s5, 4			#repeticoes do loop
	mult	$s5, $t8
	mflo	$s5
	mult	$s5, $t8
	mflo	$s5

	li 	$t1, 0
	li	$t4, 0
	li 	$t9, 10
	li 	$t6, 10
	
	LOOP_CONVERSAO:
		lw 	$t2, ($t0)		# carrego o valor
		blt	$t2, $t6, deu		# vejo se é menor que $t6
		addi	$t4, $t4, -4		# ajusto stack
		addi	$sp, $sp, -4
		div	$t2, $t2, $t6		# divido por $t6
		sw	$t2, ($sp)		# guardo valor na stack

		mult	$t6, $t9
		mflo	$t6
		
		j LOOP_CONVERSAO

		deu:
			li 	$t6, 10
			beq	$t4, 0, consertada
		
			conserta_stack:
				lw	$t8, ($sp)	# carrego o valor da stack
				lw	$s3, -4($sp)	# valor anterior da stack
				mult	$s3, $t6
				li 	$s3, 0
				sw	$s3, -4($sp)	# limpa o valor anterior
				mflo	$s3		# multiplica por 10
				sub	$t8, $t8, $s3	# tira do atual, pra ficar com uma unidade
				addi	$t8, $t8, 48	# ascii
				sw	$t8, ($s2)	# guardo o valor da stack
				addi 	$t4, $t4, 4
				addi	$sp, $sp, 4	# somo 4 na stack
				addi 	$s2, $s2, 4
				bne	$t4, 0, conserta_stack	# se ainda houver coisa na stack, continua

				lw	$s3, -4($sp)	# valor anterior da stack
				mult	$s3, $t6
				mflo	$s3		# multiplica por 10
				lw 	$t2, ($t0)
				sub	$t2, $t2, $s3
			consertada:
				addi 	$t2, $t2, 48
				sw 	$t2, ($s2)
				addi	$s2, $s2, 4

				li 	$t2, 47		# "/" que separa os valores
				sw	$t2, ($s2)
				addi 	$s2, $s2, 4
	
				addi 	$t0, $t0, 4
				addi	$t1, $t1, 4
				addi 	$t2, $t2, 4	# endereco novo
				
				bne 	$t1, $s5, LOOP_CONVERSAO

	lw	$ra, 8($sp)		# Restaura $ra.
	addi	$sp, $sp, 4		# Atualiza $SP (neste exemplo foi apenas um registrador - $ra$).
	jr	$ra			# Retorna do procedimento para o programa principal.

multiplicar:
	addi	$sp, $sp, -4		# Prepara PUSH para salvar dados de a0 e a1 (usados na rotina principal!)
	sw	$ra, 8($sp)		# Salva retorno - Stack Pointer.

	move	$t9, $s0
	li 	$s3, 0			# carrega o valor inicial de i
	li 	$s4, 0			# carrega o valor inicial de j
	
	li	$t3, 4
	mult	$t3, $t8
	mflo	$t3
	mult	$t3, $t8
	mflo	$t3

	add	$s1, $t9, $t3
	la 	$t7, ($s2)
	
	LOOP:
		li 	$s5, 0 		# reset do valor que sera colocado na matriz resultante
		move 	$t0, $t9	# carregamento dos enderecos das matrizes		
		move 	$t1, $s1
		li 	$t5, 0		# reset da variavel auxiliar que controla o WHILE

		WHILE:				#loop onde ocorre o calculo
			lw 	$t2, ($t0)		# carregamento dos valores
			lw 	$t3, ($t1)
			mult 	$t2, $t3		# calculo e acumulacao
			mflo 	$t4
			add 	$s5, $s5, $t4
			addi	$t0, $t0, 4	# calculo das posicoes dos proximos valores
			
			li 	$t3, 4
			mult	$t3, $t8
			mflo	$t3
			add	$t1, $t1, $t3

			addi	$t5, $t5, 1	# variavel auxiliar
			subi	$t3, $t8, 1
			bleu 	$t5, $t3, WHILE 	# loop precisa acontecer 3 vezes (matriz 3x3)

		sw 	$s5, ($t7)		# armazenamento do valor calculado na posicao da matriz resultante	
		addi 	$t7, $t7, 4 	# calcula onde o proximo valor vai ser colocado
		addi	$s1, $s1, 4 	# ajusta as colunas
		addi 	$t6, $t6, 1	# controle do laco de repeticao (auxiliar)
		beq 	$t6, $t8, INCREMENTA_BASES
		j 	LOOP

	INCREMENTA_BASES:		# aqui sao redefinidos os enderecos que precisamos acessar
					# para o calculo dos loops acima

		li	$t3, 4
		mult	$t3, $t8
		mflo	$t3

		li 	$t6, 0		# reset da variavel auxiliar
		add 	$t9, $t9, $t3	# (endereco da matriz 1) + 12 -> avancar para proxima linha
		mult	$t3, $t8
		mflo	$t3
		add	$s1, $s0, $t3
		addi 	$s7, $s7, 1	# variavel auxiliar para controlar o fim do programa
		bne 	$s7, $t8, LOOP 	# volta ao loop caso ainda seja necessario (matriz 3x3)

		lw	$ra, 8($sp)		# Restaura $ra.
		addi	$sp, $sp, 4		# Atualiza $SP (neste exemplo foi apenas um registrador - $ra$).
		jr	$ra			# Retorna do procedimento para o programa principal.

end:
