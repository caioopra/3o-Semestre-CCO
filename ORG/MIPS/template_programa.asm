.data
	#
	# ----- Vari�veis usadas no programa s�o armazenadas aqui, no segmento de dados.
	#
	ARRAY: .word 1 2 3 4 5 6 7
	STRING: .asciiz "Frase qualquer..."
	fout: .asciiz "teste.txt"
	
.text
	# ===============================================================================================
	# In�cio do Programa principal. Deve ser o primeiro a ser declarado no c�digo.
	# ===============================================================================================	
main:
	#
	# ----- O c�digo do programa principal. -----
	#
	li	$s0, 1			# C�digo que n�o faz nada �til :-)
	li	$s1, 2			# ''
	move	$s5, $s1		# ''
	
	jal	procedimento		# Aqui � feita a chamada de um procedimento qualquer.

	#li $v0, 10    			# � possivel terminar o programa fazendo chamda de sistema,    
        #syscall  			# mas n�o � uma solu��o elegante.	
end:
	j	end			# Ap�s finalizar atividade prevista, programa fica em loop.
	
	# ===============================================================================================
	# In�cio do Procedimento. Todos os procedimentos devem ser escritos ap�s o final do programa principal
	# ===============================================================================================	
procedimento:
	#
	# ----- Primeiro salvar todos os registradores importantes.-----
	#
	addi	$sp, $sp, -4		# Prepara PUSH para salvar registradores (4 * N_REGISTRADORES).
	sw	$ra, 8($sp)		# Neste exemplo s� estamos salvando o Stack Pointer (4 * 1).

	#
	# ----- Aqui entra o c�digo do procedimento em s�. -----
	#
	li	$s2, 3			# Mais c�digo que n�o faz nada �til :-)
	li	$s3, 4			# ''

	#
	# ----- Restaura registradores antes de voltar para o programa que chamou o procedimento. -----
	lw	$ra, 8($sp)		# Restaura $ra.
	addi	$sp, $sp, 4		# Atualiza $SP (neste exemplo foi apenas um registrador - $ra$).
	jr	$ra			# Retorna do procedimento para o programa principal.
	
	# ===============================================================================================
	# In�cio do Procedimento. Todos os procedimentos devem ser escritos ap�s o final do programa principal
	# ===============================================================================================	
		
