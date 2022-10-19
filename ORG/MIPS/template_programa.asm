.data
	#
	# ----- Variáveis usadas no programa são armazenadas aqui, no segmento de dados.
	#
	ARRAY: .word 1 2 3 4 5 6 7
	STRING: .asciiz "Frase qualquer..."
	fout: .asciiz "teste.txt"
	
.text
	# ===============================================================================================
	# Início do Programa principal. Deve ser o primeiro a ser declarado no código.
	# ===============================================================================================	
main:
	#
	# ----- O código do programa principal. -----
	#
	li	$s0, 1			# Código que não faz nada útil :-)
	li	$s1, 2			# ''
	move	$s5, $s1		# ''
	
	jal	procedimento		# Aqui é feita a chamada de um procedimento qualquer.

	#li $v0, 10    			# É possivel terminar o programa fazendo chamda de sistema,    
        #syscall  			# mas não é uma solução elegante.	
end:
	j	end			# Após finalizar atividade prevista, programa fica em loop.
	
	# ===============================================================================================
	# Início do Procedimento. Todos os procedimentos devem ser escritos após o final do programa principal
	# ===============================================================================================	
procedimento:
	#
	# ----- Primeiro salvar todos os registradores importantes.-----
	#
	addi	$sp, $sp, -4		# Prepara PUSH para salvar registradores (4 * N_REGISTRADORES).
	sw	$ra, 8($sp)		# Neste exemplo só estamos salvando o Stack Pointer (4 * 1).

	#
	# ----- Aqui entra o código do procedimento em sí. -----
	#
	li	$s2, 3			# Mais código que não faz nada útil :-)
	li	$s3, 4			# ''

	#
	# ----- Restaura registradores antes de voltar para o programa que chamou o procedimento. -----
	lw	$ra, 8($sp)		# Restaura $ra.
	addi	$sp, $sp, 4		# Atualiza $SP (neste exemplo foi apenas um registrador - $ra$).
	jr	$ra			# Retorna do procedimento para o programa principal.
	
	# ===============================================================================================
	# Início do Procedimento. Todos os procedimentos devem ser escritos após o final do programa principal
	# ===============================================================================================	
		
