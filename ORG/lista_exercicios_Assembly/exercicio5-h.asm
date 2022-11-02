# h) switch(a) {
#    	case 1:
#		b = c + 1
#		break
#	case 2:
#		b = c + 2
#		break
#	default:
#		b = c
#		break; }

.data
	a_value:	.word 1
	b_value:	.word 2
	c_value:	.word 3
.text
	lw	$s0, a_value
	lw	$s1, b_value
	lw	$s2, c_value
	
	beq	$s0, 1, CASE_1
	beq	$s0, 2, CASE_2
	
	# default
	move	$s1, $s2
	j	END
	
	CASE_1:
		addi	$s1, $s2, 1
		j	END
	
	CASE_2:
		addi	$s1, $s2, 2
		j	END
	
	sw	$s1, b_value
END:
	j	END
	
	