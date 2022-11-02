.data
.text
	# programa calcula somatorio de 1 até 5 somando i
	li	$s0, 1		# $s0 = 1
	li	$s1, 0		# $s1 = acumulador da soma
	
	SUM:
		add	$s1, $s1, $s0
		addi	$s0, $s0, 1
		
		ble	$s0, 5, SUM
		
end:
	j	end
	
	