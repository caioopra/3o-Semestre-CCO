// Copyright [2022] Caio Prá Silva
#include <cstdint>   // std::size_t
#include <stdexcept>  // exceptions

#ifndef STRUCTURES_ARRAY_STACK_H
#define STRUCTURES_ARRAY_STACK_H

namespace structures {

template <typename T>
// definicao da classe Pilha
class ArrayStack {
 public:
    // construtor simples
    ArrayStack();

    // construtor com parametro tamanho
    explicit ArrayStack(std::size_t max);

    // destrutor
    ~ArrayStack();

    // metodo empilha, coloca dado ao começo da pilha
    void push(const T &data);

    // metodo desempilha, remove da pilha e retorna
    T pop();

    // metodo retorna o dado mais ao topo
    T &top();

    // metodo limpa pilja
    void clear();

    // metodo retorna tamanho da pilha
    std::size_t size();

    // metodo retorna capacidade maxima da pilha
    std::size_t max_size();

    // verifica se a pilha esta vazia
    bool empty();

    // verifica se a pilha esta cheia
    bool full();

 private:
    T *contents;
    int top_;
    std::size_t max_size_;

    // com static, todas instancias compartilham o mesmo
    static const auto DEFAULT_SIZE = 10u;
};

}  // namespace structures
#endif

// fim da declaracao (.h)
// --------------------
// definição e implementação dos métodos da classe

// construtor sem definicao do tamanho
template <typename T>
structures::ArrayStack<T>::ArrayStack() {
    contents = new T[DEFAULT_SIZE];
    top_ = -1;
}

// construtor com tamanho definido pelo usuario
template <typename T>
structures::ArrayStack<T>::ArrayStack(std::size_t max) {
    max_size_ = max;
    contents = new T[max_size_];
    top_ = -1;
}

// método destrutor
template <typename T>
structures::ArrayStack<T>::~ArrayStack() {
    delete[] contents;
}

// metodo push para adicionar na pilha; parametro por referencia
template <typename T>
void structures::ArrayStack<T>::push(const T &data) {
    if (full()) {
        throw std::out_of_range("Pilha cheia");
    }
    top_++;
    contents[top_] = data;
}

// metodo pop para remocao e retorno da pilha
template <typename T>
T structures::ArrayStack<T>::pop() {
    if (empty()) {
        throw std::out_of_range("Pilha vazia");
    }
    // variavel auxiliar para armazenar valor do topo da pilha
    T aux;
    aux = contents[top_];
    top_--;

    return aux;
}

// metodo top para verificar qual o valor no topo da lista
template <typename T>
T &structures::ArrayStack<T>::top() {
    if (empty()) {
        throw std::out_of_range("Pilha vazia");
    }

    return contents[top_];
}

// metodo para limpar pilha
template <typename T>
void structures::ArrayStack<T>::clear() {
    top_ = -1;
}

// metodo size para receber tamanho atual da pilha
template <typename T>
std::size_t structures::ArrayStack<T>::size() {
    return top_ + 1;
}

// metodo max_size para receber tamanho maximo da pilha
template <typename T>
std::size_t structures::ArrayStack<T>::max_size() {
    return max_size_;
}

// metodo empty para verificar se a pilha esta vazia
template <typename T>
bool structures::ArrayStack<T>::empty() {
    // pilha considerada vazia se seu topo apontar em "-1"
    return (top_ == -1);
}

// metodo full para verificar se posicao é o tamanho maximo
template <typename T>
bool structures::ArrayStack<T>::full() {
    // casting de std::size_t para inteiro
    return (top_ == static_cast<int>(max_size() - 1));
}
