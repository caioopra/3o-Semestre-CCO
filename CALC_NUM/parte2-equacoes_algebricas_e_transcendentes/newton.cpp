#include <iostream>
#include <iomanip>
#include <cmath>

/*
    Problemas do metodo de Newton:
        Necessidade de fornecer um valor inicial proximo da raiz
        Necessidade de calcular a derivada de forma analítica
    Pode-se usar método da secante, variação do de Newton (ao=proximação da derivada)
*/
using namespace std;

long double function(long double x) {
    return exp(x) - (2 * cos(x));
}

long double derivative(long double x) {
    return exp(x) + (2 * sin(x));
}

int main() {
    long double x0 = 0;
    long double fx = function(x0);
    long double erro_admitido = pow(10, -15);

    long double xk = 0;
    long double dx;

    while (abs(fx) > erro_admitido) {
        dx = derivative(x0);
        xk = x0 - fx / dx;

        x0 = xk;
        fx = function(x0);
    }
    
    cout << setprecision(15);
    cout << "x0 = " << x0 << endl;
}