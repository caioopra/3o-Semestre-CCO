#include <iostream>
using namespace std;

class Car {
    public:
        string marca;
        string modelo;
        int ano;

        Car(string marca_i, string modelo_i, int ano_i) {
            marca = marca_i;
            modelo = modelo_i;
            ano = ano_i;
        }
};

int main() {
    Car carro1 = Car("marca", "modelo", 2000);
    cout << "Carro1: " << carro1.marca << " " << carro1.modelo << " " << carro1.ano;
}