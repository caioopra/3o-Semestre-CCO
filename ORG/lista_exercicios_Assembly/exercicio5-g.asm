# g)	while (a < c) {
#		a = a + 1
#		b = b + 2; }
.data
	a_value:	.word 0
	b_value:	.word 0
	c_value:	.word 5
	
.text
	lw	$s0, a_value
	lw	$s1, b_value
	lw	$s2, c_value
	
	LOOP:
		bge	$s0, $s2, END
		addi	$s0, $s0, 1
		addi	$s1, $s1, 2
		
		j 	LOOP
	
END:
	j	END