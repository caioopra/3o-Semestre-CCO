#include <iostream>
#include <iomanip>
#include <cmath>

using namespace std;

int main() {
    int x = 2;
    double exato = exp(x);

    double soma = 1;
    long int fatorial = 1;
    cout << setprecision(20);
    double erro = abs(exato - soma);
    double erro_admitido = pow(10.0, -6);  // sao necessarias modificacoes para maior precisao
    cout << erro_admitido << '\n';

    long int i = 1;

    while (erro > erro_admitido) {
        fatorial *= i;
        soma += pow(x, i) / fatorial;
        erro = abs(exato - soma);

        i++;
        cout << "Fatorial " << i << ' ' << fatorial << '\n';
        if (i % 35 == 0) {
            cout << fatorial << ' ' << i << '\n';
            break;
        }
    }

    cout << "Valor da soma: " << soma << "\n";
    cout << "Valor exato  : " << exato << "\n";

    return 0;
}