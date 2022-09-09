#include <iostream>
#include "./array_stack.h"

// Copyright [2022] <Caio Prá Silva>
#include "./array_stack.h"

bool verificaChaves(std::string trecho_programa) {
    bool resposta = true;
    int  tamanho  = trecho_programa.length();
    structures::ArrayStack<char> pilha(500);

    for (int i = 0; i < tamanho; i++) {
        // condições de parada dor 'for' podem ser adicionadas...
        if (trecho_programa[i] == '{') {
            pilha.push('{');
        } else if (trecho_programa[i] == '}') {
            if (pilha.empty()) {
                return false;
            }

            pilha.pop();
        }
    }

    if (!pilha.empty()) {
        resposta = false;
    }

    return resposta;
}


int main() {

    return 0;
}