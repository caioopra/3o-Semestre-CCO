# ===============================================
# reproduzir os programas para Assembly
# a e b com valores quais quando nao esspecificado
# ===============================================
.data
	a_value: .word 10
	b_value: .word 2
.text
	jal	EX_A

	# b) if (a >= b) b = b + 1
	lw	$s0, a_value
	lw	$s1, b_value
	
	blt	$s0, $s1, FIM_B
	addi	$s1, $s1, 1
	sw	$s1, b_value
	
	FIM_B:
		jal	LIMPA_REGS
	
end:
	j	end
	

EX_A:
	addi	$sp, $sp, -4
	sw	$ra, ($sp)
	
	# a) if (a > b) a = a + 1
	lw	$s0, a_value
	lw	$s1, b_value
	
	ble	$s0, $s1, FIM_A
	addi	$s0, $s0, 1
	sw	$s0, a_value
	
	FIM_A:
		jal	LIMPA_REGS
		
		lw	$ra, ($sp)
		addi	$sp, $sp, 4
		jr	$ra
		
	
	
# limpa os registradores $s0 - $s2
LIMPA_REGS:
	addi	$sp, $sp, -4
	sw	$ra, ($sp)

	move	$s0, $zero
	move	$s1, $zero
	move 	$s2, $zero
	
	lw	$ra, ($sp)
	addi	$sp, $sp, 4
	
	jr	$ra