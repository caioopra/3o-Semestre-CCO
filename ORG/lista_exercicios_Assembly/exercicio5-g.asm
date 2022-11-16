# g)	a = 1
#	b = 2
#	for (i = 0; i < 5; i++) {
#		a = b + 1
#		b = b + 3
#	}
#

.data
	a_value:	.word 1
	b_value:	.word 2
	
.text
	lw	$s0, a_value
	lw	$s1, b_value
	li	$t0, 0		# i = 0
	
	LOOP:
		bge	$t0, 5, END_F
		add	$s0, $s1, 1
		addi	$s1, $s1, 3
		
		addi	$t0, $t0, 1
		
		j 	LOOP

	END_F:
		sw	$s0, a_value
		sw	$s1, b_value
	
END:
	j	END
