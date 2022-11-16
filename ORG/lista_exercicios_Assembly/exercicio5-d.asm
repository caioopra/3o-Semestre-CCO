.data
	a_value:	.word 2
	b_value:	.word 2
	
.text
	# if (a == b) b = a
	lw	$s0, a_value
	lw	$s1, b_value
	
	bne	$s0, $s1, END
	sw	$s1, a_value

END:
	j 	END
