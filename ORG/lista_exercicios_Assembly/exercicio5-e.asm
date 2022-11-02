.data
	a_value:	.word 1
	b_value:	.word 2
	
.text
	#  if (a < b)  a = a + 1  \ else b = b + 1
	lw	$s0, a_value
	lw	$s1, b_value

	bge	$s0, $s1, ELSE
	addi	$s0, $s0, 1
	sw	$s0, a_value
	j	END
	
	ELSE:
		addi	$s1, $s1, 1
		sw	$s1, b_value

END:
	j 	END