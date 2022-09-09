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
    int end_;

    static const auto DEFAULT_SIZE = 10u;
};

}  // namespace structures
#endif

// definição dos métodos
template <typename T>
structures::ArrayQueue<T>::ArrayQueue() {
    contents = new T[DEFAULT_SIZE];
    size_ = 0;
    end_ = -1;
}

template <typename T>
structures::ArrayQueue<T>::ArrayQueue(std::size_t max) {
    max_size_ = max;
    contents = new T[DEFAULT_SIZE];
    size_ = 0;
    end_ = -1
}

template <typename T>
structures::ArrayQueue<T>::~ArrayQueue() {
    delete [] contents;
}

template <typename T>
void structures::ArrayQueue<T>::enqueue(const T& data) {
    if (full()) {
        throw std::out_of_range("Fila cheia");
    }

    // !
}