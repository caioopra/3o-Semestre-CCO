.data
	a_value:	.word 0
	b_value:	.word 0
	c_value:	.word 5
	
.text
	# while (a < c) { a = a + 1 \ b = b + 2 }
	lw	$s0, a_value
	lw	$s1, b_value
	lw	$s2, c_value
	
	LOOP:
		bge	$s0, $s2, END_F
		addi	$s0, $s0, 1
		addi	$s1, $s1, 2
		j	LOOP
		
	END_F:
		sw	$s0, a_value
		sw	$s1, b_value

END:
	j 	END