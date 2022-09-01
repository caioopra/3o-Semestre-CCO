#include <iostream>
#include <cmath>

using namespace std;

int main() {
    int x = 2;
    double exato = exp(x);

    double soma = 1;
    int fatorial = 1;
    double erro = abs(exato - soma);
    double erro_admitido = pow(10, -5);  // sao necessarias modificacoes para maior precisao

    int i = 1;
    cout << "Valor e: " << exato << "\n";

    while (erro > erro_admitido) {
        fatorial *= i;
        soma += (pow(x, i) / fatorial);
        erro = abs(exato - soma);

        i++;
    }

    cout << "Valor da soma: " << soma << "\n";
    cout << "Valor exato  : " << exato << "\n";

    return 0;
}