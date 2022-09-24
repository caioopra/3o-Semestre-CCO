#include <iostream>

#include "./array_list.h"

using namespace std;

int main() {
    structures::ArrayList<int> lista(10);
    
    for (int i = 0; i < 10; i++) {
        lista.push_back(i);
    }
    lista.remove(4);

    cout << lista[0] << endl;
    for (int j = 0; j < 9;j++) {
        cout << lista[j];
    }
    cout << endl;


    cout << lista[2] << endl;
    cout << lista[3] << endl;
    cout << lista[4] << endl;
    cout << endl;

    cout << lista.size() << endl;
    cout << lista.contains(4) << endl;
}
