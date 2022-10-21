.data
	ARRAY:	.asciiz "1 2 3 4 5 6 7 8 9 10"
	FILE: 	.asciiz "fout.dat"
	STRING: .asciiz "               "

.text
main:
	# -------------------------------
	# abre arquivo
	li	$v0, 13		# abre arquivo
	la	$a0, FILE	# carrega o nome do arquivo
	li	$a1, 1		# modo de escrita de arquivo
	li	$a2, 0
	syscall
	move	$s6, $v0	# $s6 contem descritor do arquivo para fechar
	
	# -------------------------------
	# chama procedimento para converter os dados do array
	# escreve os numeros no buffer STRING (em ascii)
	jal 	convert_numbers
	
	# -------------------------------
	# salva STRING em arquivo
	li	$v0, 15		# escrever em arquivo
	move	$a0, $s6	# descritor do arquivo aberto
	la	$a1, STRING	# conteudo que deve ser escrito (ascii)
	li	$a2, 44		# tamanho do buffer
	syscall
	
	# -------------------------------
	# fecha arquivo
	li	$v0, 16
	move	$a0, $s6	# descritor do arquivo que quer fechar
	syscall

# FIM DO PROGRAMA
end:
	j	end

# converte numero lido do array em ascii
convert_numbers:
	
	# conta quantos digitos o valor lido possui para fazer a conversão para ASCII
	COUNT_DIGITS: