// Copyright [2022] Caio Prá Silva
#ifndef ARRAY_QUEUE_H
#define ARRAY_QUEUE_H

#include <cstdint>
#include <stdexcept>

namespace structures {

template <typename T>
class ArrayQueue {
 public:
    // construtor padrao simples
    ArrayQueue();

    // construtor com parametro para tamanho
    explicit ArrayQueue(std::size_t max);

    // destrutor
    ~ArrayQueue();

    // enfileirar dados
    void enqueue(const T& data);

    // desenfileirar dado
    T dequeue();

    // retorna ultimo elemento
    T& back();

    // limpa a fila
    void clear();

    // retorna tamanho atual da fila
    std::size_t size();

    // retorna tamanho maximo da fila
    std::size_t max_size();

    // verifica se a fila esta vazia
    bool empty();

    // verifica se a fila esta cheia
    bool full();

 private:
    T* contents;

    std::size_t size_;
    std::size_t max_size_;
    
    int begin_;
    int end_;

    static const auto DEFAULT_SIZE = 10u;
};

}  // namespace structures
#endif

// definição dos métodos

// construtor padrao
template <typename T>
structures::ArrayQueue<T>::ArrayQueue() {
    contents = new T[DEFAULT_SIZE];
    begin_ = 0;
    end_ = -1;
    size_ = 0;
}

// construtor com tamanho customizado
template <typename T>
structures::ArrayQueue<T>::ArrayQueue(std::size_t max) {
    max_size_ = max;
    contents = new T[ma_size_];
    begin_ = 0;
    end_ = -1
    size_ = 0;
}

// destrutor
template <typename T>
structures::ArrayQueue<T>::~ArrayQueue() {
    delete [] contents;
}

// adiciona ao final da fila
template <typename T>
void structures::ArrayQueue<T>::enqueue(const T& data) {
    if (full()) {
        throw std::out_of_range("Fila cheia");
    }

    end_ = (end_ + 1) % max_size_;
    contents[end_] = data;
    size_++;
}


// remove primeiro elemento e "roda" fila
template <typename T>
T structures::ArrayQueue<T>::dequeue() {
    if (empty()) {
        throw std::out_of_range("Fila vazia");
    }

    T data = contents[begin_];
    begin_ = (begin_ + 1) % size_;
    size_--;

    return data;
}

// mostra conteudo no final da fila
template <typename T>
T& structures::ArrayQueue<T>::back() {

}

// limpa a fila
template <typename T>
void structures::ArrayQueue<T>::clear() {

}


// retorna o tamanho atual da fila
template <typename T>
std::size_t structures::ArrayQueue<T>::size() {

}

// retorna o tamanho maximo da fila
template <typename T>
std::size_t structures::ArrayQueue<T>::max_size() {

}

// mostra se a fila esta vazia com um booleano
template <typename T>
bool structures::ArrayQueue<T>::empty() {

}

// mostra se a fila esta cheia com um booleano
template <typename T>
bool structures::ArrayQueue<T>::full() {

}