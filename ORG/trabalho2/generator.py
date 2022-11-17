paises = ["QAT", "ECU", "SEN", "NED", "ENG", "IRN", "USA", "WAL", "ARG", "KSA", "MEX", "POL", "FRA", "AUS", "DEN", "TUN", "ESP", "CRC", "GET", "JPN", "BEL", "CAN", "MAR", "CRO", "BRA", "SRB", "SUI", "CMR", "POR", "GHA", "URU", "KOR"]

with open("faltando.txt", "a") as file:
	for pais in paises:
		for i in range(20):
			if i < 9:
				value = f"0{i+1}"
			else:
				value = str(i+1)
			file.write(f"{pais}-{value} ")
		file.write("\n")
