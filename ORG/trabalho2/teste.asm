.data
	BOAS_VINDAS: .asciiz 	"----GERENCIADOR DE FIGURINHAS----"
	MENU_ESCOLHA: .asciiz 	" Escolha uma das op��es abaixo: "
	OPCAO_ADICIONAR_FIGURINHA: .asciiz 	"1- Adicionar figurinha � cole��o."
	OPCAO_RESETAR: .asciiz 	"2- Recome�e seu �lbum do zero." 
	OPCAO_SAIR: .asciiz 	"3- Sair do programa."
	CONFIRMA_RESET: .asciiz 	" Voc� tem certeza que quer excluir seu progresso e come�ar de novo? (A��o PERMANENTE)"
	INSTRUI_USUARIO_RESET1: .asciiz 	"1- N�o."
	INSTRUI_USUARIO_RESET2: .asciiz 	"2- Sim."
	RESET_CONCLUIDO: .asciiz 	"Reset conclu�do com sucesso!"
	INVALIDA: .asciiz 	"Entrada Inv�lida."
	SAINDO: .asciiz 	"----SAINDO DO GERENCIADOR----"
	DIGITE_FIGURINHA: .asciiz 	"Digite a figurinha para adiciona-l� em seu �lbum: "
	INSTRUI_FIGURINHA: .asciiz	"Formato XXX00. Ex: QAT01, BRA07, JPN19, POR20"
	FIGURINHA_NAO_ENCONTRADA: .asciiz	"A figurinha N�O existe ou J� FOI adicionada na sua cole��o!"
	FIGURINHA_SUCESSO: .asciiz	"Figurinha adicionada com SUCESSO!"
	
	arquivo_referencia: .asciiz	"missing_cards.txt"
	arquivo_colecao: .asciiz	"collection.txt"
	
	#Decisao: Reset na memoria de dados.
	#(Se um reset em um .txt fosse excluido, n seria mais possivel realizar o reset)
	LINHA_RESET1: .asciiz 	"QAT01 QAT02 QAT03 QAT04 QAT05 QAT06 QAT07 QAT08 QAT09 QAT10 QAT11 QAT12 QAT13 QAT14 QAT15 QAT16 QAT17 QAT18 QAT19 QAT20"
	LINHA_RESET2: .asciiz 	"ECU01 ECU02 ECU03 ECU04 ECU05 ECU06 ECU07 ECU08 ECU09 ECU10 ECU11 ECU12 ECU13 ECU14 ECU15 ECU16 ECU17 ECU18 ECU19 ECU20"
	LINHA_RESET3: .asciiz 	"SEN01 SEN02 SEN03 SEN04 SEN05 SEN06 SEN07 SEN08 SEN09 SEN10 SEN11 SEN12 SEN13 SEN14 SEN15 SEN16 SEN17 SEN18 SEN19 SEN20"
	LINHA_RESET4: .asciiz 	"NED01 NED02 NED03 NED04 NED05 NED06 NED07 NED08 NED09 NED10 NED11 NED12 NED13 NED14 NED15 NED16 NED17 NED18 NED19 NED20"
	LINHA_RESET5: .asciiz 	"ENG01 ENG02 ENG03 ENG04 ENG05 ENG06 ENG07 ENG08 ENG09 ENG10 ENG11 ENG12 ENG13 ENG14 ENG15 ENG16 ENG17 ENG18 ENG19 ENG20"
	LINHA_RESET6: .asciiz 	"IRN01 IRN02 IRN03 IRN04 IRN05 IRN06 IRN07 IRN08 IRN09 IRN10 IRN11 IRN12 IRN13 IRN14 IRN15 IRN16 IRN17 IRN18 IRN19 IRN20"
	LINHA_RESET7: .asciiz 	"USA01 USA02 USA03 USA04 USA05 USA06 USA07 USA08 USA09 USA10 USA11 USA12 USA13 USA14 USA15 USA16 USA17 USA18 USA19 USA20"
	LINHA_RESET8: .asciiz 	"WAL01 WAL02 WAL03 WAL04 WAL05 WAL06 WAL07 WAL08 WAL09 WAL10 WAL11 WAL12 WAL13 WAL14 WAL15 WAL16 WAL17 WAL18 WAL19 WAL20"
	LINHA_RESET9: .asciiz 	"ARG01 ARG02 ARG03 ARG04 ARG05 ARG06 ARG07 ARG08 ARG09 ARG10 ARG11 ARG12 ARG13 ARG14 ARG15 ARG16 ARG17 ARG18 ARG19 ARG20"
	LINHA_RESET10: .asciiz	"KSA01 KSA02 KSA03 KSA04 KSA05 KSA06 KSA07 KSA08 KSA09 KSA10 KSA11 KSA12 KSA13 KSA14 KSA15 KSA16 KSA17 KSA18 KSA19 KSA20"
	LINHA_RESET11: .asciiz	"MEX01 MEX02 MEX03 MEX04 MEX05 MEX06 MEX07 MEX08 MEX09 MEX10 MEX11 MEX12 MEX13 MEX14 MEX15 MEX16 MEX17 MEX18 MEX19 MEX20"
	LINHA_RESET12: .asciiz 	"POL01 POL02 POL03 POL04 POL05 POL06 POL07 POL08 POL09 POL10 POL11 POL12 POL13 POL14 POL15 POL16 POL17 POL18 POL19 POL20"
	LINHA_RESET13: .asciiz 	"FRA01 FRA02 FRA03 FRA04 FRA05 FRA06 FRA07 FRA08 FRA09 FRA10 FRA11 FRA12 FRA13 FRA14 FRA15 FRA16 FRA17 FRA18 FRA19 FRA20"
	LINHA_RESET14: .asciiz 	"AUS01 AUS02 AUS03 AUS04 AUS05 AUS06 AUS07 AUS08 AUS09 AUS10 AUS11 AUS12 AUS13 AUS14 AUS15 AUS16 AUS17 AUS18 AUS19 AUS20"
	LINHA_RESET15: .asciiz 	"DEN01 DEN02 DEN03 DEN04 DEN05 DEN06 DEN07 DEN08 DEN09 DEN10 DEN11 DEN12 DEN13 DEN14 DEN15 DEN16 DEN17 DEN18 DEN19 DEN20"
	LINHA_RESET16: .asciiz 	"TUN01 TUN02 TUN03 TUN04 TUN05 TUN06 TUN07 TUN08 TUN09 TUN10 TUN11 TUN12 TUN13 TUN14 TUN15 TUN16 TUN17 TUN18 TUN19 TUN20"
	LINHA_RESET17: .asciiz 	"ESP01 ESP02 ESP03 ESP04 ESP05 ESP06 ESP07 ESP08 ESP09 ESP10 ESP11 ESP12 ESP13 ESP14 ESP15 ESP16 ESP17 ESP18 ESP19 ESP20"
	LINHA_RESET18: .asciiz 	"CRC01 CRC02 CRC03 CRC04 CRC05 CRC06 CRC07 CRC08 CRC09 CRC10 CRC11 CRC12 CRC13 CRC14 CRC15 CRC16 CRC17 CRC18 CRC19 CRC20"
	LINHA_RESET19: .asciiz 	"GER01 GER02 GER03 GER04 GER05 GER06 GER07 GER08 GER09 GER10 GER11 GER12 GER13 GER14 GER15 GER16 GER17 GER18 GER19 GER20"
	LINHA_RESET20: .asciiz 	"JPN01 JPN02 JPN03 JPN04 JPN05 JPN06 JPN07 JPN08 JPN09 JPN10 JPN11 JPN12 JPN13 JPN14 JPN15 JPN16 JPN17 JPN18 JPN19 JPN20"
	LINHA_RESET21: .asciiz 	"BEL01 BEL02 BEL03 BEL04 BEL05 BEL06 BEL07 BEL08 BEL09 BEL10 BEL11 BEL12 BEL13 BEL14 BEL15 BEL16 BEL17 BEL18 BEL19 BEL20"
	LINHA_RESET22: .asciiz 	"CAN01 CAN02 CAN03 CAN04 CAN05 CAN06 CAN07 CAN08 CAN09 CAN10 CAN11 CAN12 CAN13 CAN14 CAN15 CAN16 CAN17 CAN18 CAN19 CAN20"
	LINHA_RESET23: .asciiz 	"MAR01 MAR02 MAR03 MAR04 MAR05 MAR06 MAR07 MAR08 MAR09 MAR10 MAR11 MAR12 MAR13 MAR14 MAR15 MAR16 MAR17 MAR18 MAR19 MAR20"
	LINHA_RESET24: .asciiz 	"CRO01 CRO02 CRO03 CRO04 CRO05 CRO06 CRO07 CRO08 CRO09 CRO10 CRO11 CRO12 CRO13 CRO14 CRO15 CRO16 CRO17 CRO18 CRO19 CRO20"
	LINHA_RESET25: .asciiz 	"BRA01 BRA02 BRA03 BRA04 BRA05 BRA06 BRA07 BRA08 BRA09 BRA10 BRA11 BRA12 BRA13 BRA14 BRA15 BRA16 BRA17 BRA18 BRA19 BRA20"
	LINHA_RESET26: .asciiz 	"SRB01 SRB02 SRB03 SRB04 SRB05 SRB06 SRB07 SRB08 SRB09 SRB10 SRB11 SRB12 SRB13 SRB14 SRB15 SRB16 SRB17 SRB18 SRB19 SRB20"
	LINHA_RESET27: .asciiz 	"SUI01 SUI02 SUI03 SUI04 SUI05 SUI06 SUI07 SUI08 SUI09 SUI10 SUI11 SUI12 SUI13 SUI14 SUI15 SUI16 SUI17 SUI18 SUI19 SUI20"
	LINHA_RESET28: .asciiz 	"CMR01 CMR02 CMR03 CMR04 CMR05 CMR06 CMR07 CMR08 CMR09 CMR10 CMR11 CMR12 CMR13 CMR14 CMR15 CMR16 CMR17 CMR18 CMR19 CMR20"
	LINHA_RESET29: .asciiz 	"POR01 POR02 POR03 POR04 POR05 POR06 POR07 POR08 POR09 POR10 POR11 POR12 POR13 POR14 POR15 POR16 POR17 POR18 POR19 POR20"
	LINHA_RESET30: .asciiz 	"GHA01 GHA02 GHA03 GHA04 GHA05 GHA06 GHA07 GHA08 GHA09 GHA10 GHA11 GHA12 GHA13 GHA14 GHA15 GHA16 GHA17 GHA18 GHA19 GHA20"
	LINHA_RESET31: .asciiz 	"URU01 URU02 URU03 URU04 URU05 URU06 URU07 URU08 URU09 URU10 URU11 URU12 URU13 URU14 URU15 URU16 URU17 URU18 URU19 URU20"
	LINHA_RESET32: .asciiz 	"KOR01 KOR02 KOR03 KOR04 KOR05 KOR06 KOR07 KOR08 KOR09 KOR10 KOR11 KOR12 KOR13 KOR14 KOR15 KOR16 KOR17 KOR18 KOR19 KOR20"
        RESET_COLLECTION: .asciiz  "                                                                                                                       "            
	NEW_LINE: .word	10
	
	INPUT_FIGURINHA: .asciiz "      "
	
	
	COLLECTION: .space 3840
	MISSING_CARDS: .space 3840
	REWRITE_COLLECTION: .space 3840
	
.text
main:
	li	$s6,32    #Espaco em branco em ASCII 

menu:
	#A sequencia de comandos a seguir sao os prints do programa.
	li	$v0, 4
	la	$a0, BOAS_VINDAS
	syscall
	
	li	$a0,10 		#ASCII do LF (Fim de linha)
	li	$v0,11		#Syscall 11 o byte menos significativos de $a0 como um caractere ASCII
	syscall

	li	$v0, 4
	la	$a0, MENU_ESCOLHA
	syscall

	li	$a0,10 		
	li	$v0,11		
	syscall	
	li	$a0,9		#Ascii para tab.	
	li	$v0,11		
	syscall	
	li	$v0, 4
	la	$a0, OPCAO_ADICIONAR_FIGURINHA
	syscall
	
	li	$a0,10 		
	li	$v0,11		
	syscall
	li	$a0,9		#Ascii para tab.	
	li	$v0,11		
	syscall
	li	$v0, 4
	la	$a0, OPCAO_RESETAR
	syscall
	
	li	$a0,10 		
	li	$v0,11		
	syscall
	li	$a0,9			
	li	$v0,11		
	syscall
	li	$v0, 4
	la	$a0, OPCAO_SAIR
	syscall
	
	li	$a0,10 		
	li	$v0,11		
	syscall
	#Le a opcao digitada pelo usuario
	li	$v0,5
	syscall
	move 	$t0,$v0
	
	beq	$t0,1,adicionar_figurinha
	beq	$t0,2,reset
	beq	$t0,3,sair
	
opcao_invalida:
	li	$a0,10 		
	li	$v0,11		
	syscall
	li	$v0, 4
	la	$a0, INVALIDA
	syscall
	li	$a0,10 		
	li	$v0,11		
	syscall
	
	#Sleep de 1s +-
	li	$v0,32
	li	$a0,1000
	syscall
	
	j 	menu
	
sair:
	li	$v0, 4
	la	$a0, SAINDO
	syscall
	
	li	$v0,10     #Termina a execucao do programa
	syscall
reset:
	li	$v0, 4
	la	$a0, CONFIRMA_RESET
	syscall

	li	$a0,10 		
	li	$v0,11		
	syscall
	li	$a0,9			
	li	$v0,11		
	syscall
	li	$v0, 4
	la	$a0, INSTRUI_USUARIO_RESET1
	syscall
	li	$a0,10 		
	li	$v0,11		
	syscall
	li	$a0,9			
	li	$v0,11		
	syscall
	li	$v0, 4
	la	$a0, INSTRUI_USUARIO_RESET2
	syscall
	li	$a0,10 		
	li	$v0,11		
	syscall
	#Le oq usuario digitou
	li	$v0,5
	syscall
	move 	$t0,$v0
	
	beq	$t0,1,menu
	beq	$t0,2,continua_reset
	
	j	opcao_invalida
	
	continua_reset: 
		#Chama o procedimento que reseta o arquivo.
		jal 	reset_arquivo
	
	
	li	$a0,10 		
	li	$v0,11		
	syscall
	li	$v0, 4
	la	$a0, RESET_CONCLUIDO
	syscall
	li	$a0,10 		
	li	$v0,11		
	syscall
	#Sleep de 1.25s +-
	li	$v0,32
	li	$a0,1250
	syscall
	
	j 	menu
	
	
adicionar_figurinha:
	li	$a0,10 		
	li	$v0,11		
	syscall
	li	$v0, 4
	la	$a0, DIGITE_FIGURINHA
	syscall
	
	li	$a0,10
	li	$v0,11
	syscall
	li	$a0,9
	li	$v0,11
	syscall
	li	$v0,4
	la	$a0, INSTRUI_FIGURINHA
	syscall
	li	$a0,10
	li	$v0,11
	syscall
	
	#Le o input do usuario
	li	$v0,8
	la	$a0, INPUT_FIGURINHA
	li	$a1,6  #tamanho do buffer
	syscall
	li	$a0,10 		#ASCII do LF (Fim de linha)
	li	$v0,11
	syscall
	
	upper_case:
		la	$t2, INPUT_FIGURINHA
		li	$t1,0 #cont para o loop
		loop:
			add	$t0,$t2,$t1
			lb	$t3, 0($t0)        #Carrega caractere a caractere as letras do input do usu�rio
						   #Caso elas sejam minusculas, se tornarao maiusculas
			slti	$t9,$t3,123   #Limita superiormente para caracteres minusculos em ascii
			beq	$t9,0,ending_loop
			slti	$t9,$t3,97    #Limita inferiormente para caracteres minusculos em ascii
			beq	$t9,1,ending_loop
			
			subi	$t3,$t3,32  #Transforma o caractere minusculo em maiusculo
			sb	$t3,0($t0)  #Atualiza na memoria de dados	
			
		ending_loop:		
			beq	$t1,3,out_of_loop
			addi	$t1,$t1,1
			j	loop
		
	out_of_loop:
	
		jal	ler_arquivos		
	
		jal 	remove	#$s7 + endereco base do buffer vai estar com o endereco de onde a carta tem q ser adicionada
				#$s7 = 0 se a carta nao foi encontrada
		beq	$s7,0,nao_achou_volta_menu
	#SE a figurinha existir: tira do missing_cards e p�e no collection
		jal	adiciona	
		jal 	salvar_mudancas

	#MENSAGEM DE SUCESSO
	li	$v0, 4
	la	$a0, FIGURINHA_SUCESSO
	syscall
	li	$a0,10 		
	li	$v0,11		
	syscall
	
	
	
	li	$v0,32
	li	$a0,1500
	syscall
	j	menu
	
	nao_achou_volta_menu:
		li	$v0,32
		li	$a0,1500
		syscall
	
		j 	menu

#procedimento usado no reset
reset_arquivo:
		li	$v0,13
		la	$a0,arquivo_referencia  #Nome do arquivo a ser aberto
		li	$a1,1
		li	$a2,0
		syscall
		move	$t0,$v0
	
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET1
		li	$a2, 119 #Tamanho do buffer
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 #Tamanho do buffer
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET2
		li	$a2, 119 #Tamanho do buffer
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 #Tamanho do buffer
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET3
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET4
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET5
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET6
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET7
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET8
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET9
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET10
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET11
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET12
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET13
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET14
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET15
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET16
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET17
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET18
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET19
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET20
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET21
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET22
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET23
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET24
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET25
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET26
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET27
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET28
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET29
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET30
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET31
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
		
		li	$v0,15
		move	$a0,$t0
		la	$a1,LINHA_RESET32
		li	$a2, 119 
		syscall
		li	$v0,15
		move	$a0,$t0
		la	$a1,NEW_LINE
		li	$a2, 1 
		syscall
	
		
		#Fecha o arquivo missing_cards.txt
		li	$v0,16
		move	$a0,$t0
		syscall
		
		
		#Abre o collection.txt
		li	$v0,13
		la	$a0,arquivo_colecao  #Nome do arquivo a ser aberto
		li	$a1,1
		li	$a2,0
		syscall
		move	$t0,$v0
		
		
		#isso vai acontecer 32 vezes
		li	$t1,1 #cont para 32
		
		reset_collection_loop:
			li	$v0,15
			move	$a0,$t0
			la	$a1,REWRITE_COLLECTION
			li	$a2, 119 
			syscall
			li	$v0,15
			move	$a0,$t0
			la	$a1,NEW_LINE
			li	$a2, 1 
			syscall
		
			addi	$t1,$t1,1
			beq	$t1,32,out_reset_collection_loop
			j	reset_collection_loop
			
		out_reset_collection_loop:
			
			#Fecha o arquivo collection.txt
			li	$v0,16
			move	$a0,$t0
			syscall
		
	
		#Fim do procedimento
		jr	$ra
	
	
ler_arquivos:   #le os arquivos missing_cards.txt e collection.txt e salva os seus conteudos na memoria

	#Primeiro l� o collection.txt
	li	$v0,13
	la	$a0,arquivo_colecao
	li	$a1,0
	syscall
	move 	$t0,$v0
	
	li	$v0,14
	move	$a0,$t0
	la	$a1, COLLECTION
	la	$a2, 3840
	syscall
	
	li	$v0,16
	move	$a0,$t0
	syscall



	#Agora l� o missing_cards.txt
	li	$v0,13
	la	$a0,arquivo_referencia
	li	$a1,0
	syscall
	move 	$t0,$v0
	
	li	$v0,14
	move	$a0,$t0
	la	$a1, MISSING_CARDS
	la	$a2, 3840
	syscall
	
	li	$v0,16
	move	$a0,$t0
	syscall
	
	
	jr 	$ra
	
	 
remove:
	#Vai carregar cada caracter do input em registradores diferentes. ($t5 at� $t9 respectivamente)
	la	$t0,INPUT_FIGURINHA
	lb	$t5,0($t0)
	addi	$t0,$t0,1
	lb	$t6,0($t0)
	addi	$t0,$t0,1
	lb	$t7,0($t0)
	addi	$t0,$t0,1
	lb	$t8,0($t0)
	addi	$t0,$t0,1
	lb	$t9,0($t0)
			
	
	#PRIMEIRO O BUFFER MISSING_CARDS SERA VARRIDO
	li	$t1,0	#Cont para as letras da palavra
		
	la	$t0,MISSING_CARDS
	move	$s7,$t0
	addi	$s7,$s7,3835
	
	lendo_caracter:
		add	$t4,$t0,$t1
		lb	$t3,0($t4)
		
		bne	$t3,$t5,caracter_diferente
		
		addi	$t1,$t1,1
		add	$t4,$t0,$t1
		lb	$t3,0($t4)
		bne	$t3,$t6,caracter_diferente
		
		addi	$t1,$t1,1
		add	$t4,$t0,$t1
		lb	$t3,0($t4)
		bne	$t3,$t7,caracter_diferente
		
		addi	$t1,$t1,1
		add	$t4,$t0,$t1
		lb	$t3,0($t4)
		bne	$t3,$t8,caracter_diferente
		
		addi	$t1,$t1,1
		add	$t4,$t0,$t1
		lb	$t3,0($t4)
		bne	$t3,$t9,caracter_diferente
		
		#Se chegou ate aqui eh pq todos os caracteres sao iguais.
		#Aqui tem que ter a logica para excluir do arquivo ($t0 contem o inicio da carta)
				#guarda o t0 para ser usado ao adicionar a carta no collection.txt
				#usar para trocar por espa�os em branco
		li	$t1,0
		add	$t4,$t0,$t1
		sb	$s6,0($t4)
		addi	$t1,$t1,1
	
		add	$t4,$t0,$t1
		sb	$s6,0($t4)
		addi	$t1,$t1,1
		
		add	$t4,$t0,$t1
		sb	$s6,0($t4)
		addi	$t1,$t1,1
		
		add	$t4,$t0,$t1
		sb	$s6,0($t4)
		addi	$t1,$t1,1
		
		add	$t4,$t0,$t1
		sb	$s6,0($t4)
		addi	$t1,$t1,1
		
		move	$s7,$t0	
		la	$t0,MISSING_CARDS
		sub	$s7,$s7,$t0			
		
		jr	$ra
	caracter_diferente:
		li	$t1,0
		addi	$t0,$t0,6 #Vai para onde come�a a proxima carta 
		
		slt 	$t2,$t0,$s7   #3835 eh onde come�a a ultima carta
					#entao se $t0<3835, continua o loop
		beq	$t2,0,nao_encontrou			
		
		j 	lendo_caracter
		
		
		
	nao_encontrou:	
		#mensagem dizendo que a carta ja foi adicionada ou eh inexistente
		li	$v0, 4
		la	$a0, FIGURINHA_NAO_ENCONTRADA
		syscall
		li	$a0,10 		#ASCII do LF (Fim de linha)
		li	$v0,11
		syscall
		
		li	$s7,0
		jr 	$ra
		
adiciona:
	#Vai carregar cada caracter do input em registradores diferentes. ($t5 at� $t9 respectivamente)
	la	$t0,INPUT_FIGURINHA
	lb	$t5,0($t0)
	addi	$t0,$t0,1
	lb	$t6,0($t0)
	addi	$t0,$t0,1
	lb	$t7,0($t0)
	addi	$t0,$t0,1
	lb	$t8,0($t0)
	addi	$t0,$t0,1
	lb	$t9,0($t0)



	la	$t0,COLLECTION
	add	$t0,$t0,$s7	#Endereco para a carta
	li	$t1,0
	#logica para escrever no arquivo
	
	add	$t4,$t1,$t0
	sb	$t5,0($t4)
	addi	$t1,$t1,1
	
	add	$t4,$t1,$t0
	sb	$t6,0($t4)
	addi	$t1,$t1,1
	
	add	$t4,$t1,$t0
	sb	$t7,0($t4)
	addi	$t1,$t1,1
	
	add	$t4,$t1,$t0
	sb	$t8,0($t4)
	addi	$t1,$t1,1
	
	add	$t4,$t1,$t0
	sb	$t9,0($t4)
	
	
	jr	$ra
	
		
salvar_mudancas:

	#SALVA MUDANCAS NO missing_cards.txt
	li	$v0,13
	la	$a0, arquivo_referencia
	li	$a1, 1
	li	$a2,0
	syscall
	move 	$t0,$v0
	
	li	$v0,15
	move	$a0,$t0
	la	$a1, MISSING_CARDS
	li	$a2, 3840
	syscall
	
	li	$v0,16
	move	$a0,$t0
	syscall
	
	
	
	
	#SALVA MUDANCAS NO collection.txt
	li	$v0,13
	la	$a0, arquivo_colecao
	li	$a1, 1
	li	$a2,0
	syscall
	move 	$t0,$v0
	
	li	$v0,15
	move	$a0,$t0
	la	$a1, COLLECTION
	li	$a2, 3840
	syscall
	
	li	$v0,16
	move	$a0,$t0
	syscall


	jr	$ra
	
	
	


	