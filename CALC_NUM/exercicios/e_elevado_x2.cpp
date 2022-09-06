#include <iostream>
#include <iomanip>
#include <cmath>

using namespace std;

int main() {
    int x = 2;
    long double erro_admitido = pow(10.0, -15); // valor máximo = 10^-15
    double exato = exp(x);
    
    long double soma = 1;
    long double erro = abs(exato - soma);
    long double fatorial = 1;

    cout << setprecision(20);

    long int i = 1;

    while (erro > erro_admitido) {
        fatorial  *= i;
        soma += pow(x, i) / fatorial;
        erro = abs(exato - soma);

        i++;

        cout << "Fatorial " << i << ' ' << fatorial << '\n';
    }

    cout << "Valor da soma: " << soma << "\n";
    cout << "Valor exato  : " << exato << "\n";

    return 0;
}