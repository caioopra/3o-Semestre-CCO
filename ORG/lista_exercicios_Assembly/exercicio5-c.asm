.data
	a_value:	.word 2
	b_value:	.word 2
	
.text
	lw	$s0, a_value
	lw	$s1, b_value
	
	bgt	$s0, $s1, END
	addi	$s0, $s0, 1
	sw	$s0, a_value

END:
	j 	END