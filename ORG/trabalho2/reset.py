paises = [
    "QAT",
    "ECU",
    "SEN",
    "NED",
    "ENG",
    "IRN",
    "USA",
    "WAL",
    "ARG",
    "KSA",
    "MEX",
    "POL",
    "FRA",
    "AUS",
    "DEN",
    "TUN",
    "ESP",
    "CRC",
    "GET",
    "JPN",
    "BEL",
    "CAN",
    "MAR",
    "CRO",
    "BRA",
    "SRB",
    "SUI",
    "CMR",
    "POR",
    "GHA",
    "URU",
    "KOR",
]


def obtidas():
    with open("obtidas.txt", "w") as file:
        for pais in paises:
            for _ in range(20):
                file.write(f"{pais}-   ")
            file.write("\n")


def faltando():
    with open("faltando.txt", "w") as file:
        for pais in paises:
            for i in range(20):
                if i < 9:
                    value = f"0{i+1}"
                else:
                    value = str(i + 1)
                file.write(f"{pais}-{value} ")
            file.write("\n")


if __name__ == "__main__":
    obtidas()
    faltando()
    print("Arquivos de figurinhas obtidas e faltando reiniciados!")
