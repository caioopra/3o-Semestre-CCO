#include <iostream>
#include <iomanip>
#include <cmath>

using namespace std;

long double calcular_xm(long double a, long double b) {
    return (a + b) / 2;
}

long double funcao(long double x) {
    return exp(x) - (2 * cos(x));
}

int main(void) {
    const double erro_admitido = pow(10, -15);

    long double a = 0;
    long double b = 2;
    long double xm = calcular_xm(a, b);
    long double erro = abs(a - b);

    long double funcao_a, funcao_xm;
    while (erro > erro_admitido) {
        xm = calcular_xm(a, b);
        funcao_a = funcao(a);
        funcao_xm = funcao(xm);

        if (funcao_xm == 0) {
            return xm;
        }

        if (funcao_a * funcao_xm < 0) {
            b = xm;
        } else {
            a = xm;
        }

        erro = abs(a - b);
    }

    cout << setprecision(15);
    cout << "Valor de xm: " << xm << endl;
    cout << " Erro: " << erro << endl;

    return 0;
}