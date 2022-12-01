// Copyright [2022] Caio Pra Silva
#ifndef STRUCTURES_ARRAY_LIST_H
#define STRUCTURES_ARRAY_LIST_H

#include <cstdint>

namespace structures {

template <typename T>
class ArrayList {
 public:
    ArrayList();
    explicit ArrayList(std::size_t max_size);
    ~ArrayList();

    void clear();
    void push_back(const T& data);
    void push_front(const T& data);
    void insert(const T& data, std::size_t index);
    void insert_sorted(const T& data);
    T pop(std::size_t index);
    T pop_back();
    T pop_front();
    void remove(const T& data);
    bool full() const;
    bool empty() const;
    bool contains(const T& data) const;
    std::size_t find(const T& data) const;
    std::size_t size() const;
    std::size_t max_size() const;
    T& at(std::size_t index);
    T& operator[](std::size_t index);
    const T& at(std::size_t index) const; 
    const T& operator[](std::size_t index) const;
    // descricao do 'operator []' na FAQ da disciplina

 private:
    T* contents;
    std::size_t size_;
    std::size_t max_size_;

    static const auto DEFAULT_MAX = 10u;
};

}  // namespace structures

#endif

// método construtor simples
template <typename T>
structures::ArrayList<T>::ArrayList() {
    max_size_ = DEFAULT_MAX;
    contents = new T[DEFAULT_MAX];
    size_ = 0;
}

// método construtor com tamanho customizado
template <typename T>
structures::ArrayList<T>::ArrayList(std::size_t max) {
    max_size_ = max;
    contents = new T[max_size_];
    size_ = 0;
}

// método destrutor
template <typename T>
structures::ArrayList<T>::~ArrayList() {
    delete[] contents;
}

// limpa a lista
template <typename T>
void structures::ArrayList<T>::clear() {
    size_ = 0;
}

// insere no final da lista
template <typename T>
void structures::ArrayList<T>::push_back(const T& data) {
    if (full()) {
        throw std::out_of_range("Lista cheia");
    }

    contents[size_] = data;
    size_++;
}

//  insere dado no começo da lsita
template <typename T>
void structures::ArrayList<T>::push_front(const T& data) {
    if (full()) {
        throw std::out_of_range("Lista cheia");
    }

    size_++;

    for (int i = size_ - 1; i > 0; i--) {
        contents[i] = contents[i - 1];
    }

    contents[0] = data;
}

// insere dado em índice especificado
template <typename T>
void structures::ArrayList<T>::insert(const T& data, std::size_t index) {
    if (full()) {
        throw std::out_of_range("Lista cheia");
    }

    if (index > size_ || index < 0) {
        throw std::out_of_range("Posição inválida");
    }

    if (index == 0) {
        return push_front(data);
    } else if (index == size_) {
        return push_back(data);
    }

    size_++;

    for (int i = size_ - 1; i > static_cast<int>(index); i--) {
        contents[i] = contents[i - 1];
    }

    contents[index] = data;
}

// inserer dado de forma a deixar a lista ordenada
template <typename T>
void structures::ArrayList<T>::insert_sorted(const T& data) {
    if (full()) {
        throw std::out_of_range("Lista cheia");
    }

    int i = 0;
    while (i < static_cast<int>(size_) && contents[i] < data) {
        i++;
    }

    insert(data, i);
}

// retira dado de index da lista e corrige buracos
template <typename T>
T structures::ArrayList<T>::pop(std::size_t index) {
    if (empty()) {
        throw std::out_of_range("Lista vazia");
    }

    if (index > size_ - 1) {
        throw std::out_of_range("Índice inválido");
    }

    size_--;
    T aux = contents[index];

    for (int i = index; i < static_cast<int>(size_); i++) {
        contents[i] = contents[i + 1];
    }

    return aux;
}

// remove dado da ultima posicao
template <typename T>
T structures::ArrayList<T>::pop_back() {
    if (empty()) {
        throw std::out_of_range("Lista vazia");
    }

    size_--;
    return contents[size_];
}

// remove dado da primeira posicao
template <typename T>
T structures::ArrayList<T>::pop_front() {
    if (empty()) {
        throw std::out_of_range("Lista vazia");
    }

    T value = contents[0];
    size_--;

    for (int i = 0; i < static_cast<int>(size_); i++) {
        contents[i] = contents[i + 1];
    }

    return value;
}

// procura dado na lista e o remove
template <typename T>
void structures::ArrayList<T>::remove(const T& data) {
    if (empty()) {
        throw std::out_of_range("lista vazia");
    }
    for (int i = 0; (std::size_t)i < size_; i++) {
        if (contents[i] == data) {
            pop(i);
    }
}
}

// verifica se a lista esta cheia
template <typename T>
bool structures::ArrayList<T>::full() const {
    return (size_ == max_size_);
}

// retorna se a lista esta vazia
template <typename T>
bool structures::ArrayList<T>::empty() const {
    return (size_ == 0);
}

// verifica se dado está dentro da lista
template <typename T>
bool structures::ArrayList<T>::contains(const T& data) const {
    if (empty()) {
        throw std::out_of_range("Lista vazia");
    }

    for (int i = 0; i < static_cast<int>(size_); i++) {
        if (contents[i] == data) {
            return true;
        }
    }
    return false;
}

// procura posicao de dado na lista
template <typename T>
std::size_t structures::ArrayList<T>::find(const T& data) const {
    if (empty()) {
        throw std::out_of_range("Lista vazia");
    }

    for (int i = 0; i < static_cast<int>(size_); i++) {
        if (contents[i] == data) {
            return i;
        }
    }

    return size_;
}

// retorna tamanho atual da lista
template <typename T>
std::size_t structures::ArrayList<T>::size() const {
    return size_;
}

// retorna tamanho maximo da lista
template <typename T>
std::size_t structures::ArrayList<T>::max_size() const {
    return max_size_;
}

// retorna o dado que está em determonado index
template <typename T>
T& structures::ArrayList<T>::at(std::size_t index) {
    if (empty()) {
        throw std::out_of_range("Lista vazia");
    }

    if (index > size_ - 1) {
        throw std::out_of_range("Index invalido!");
    }

    return contents[index];
}

// operador []
template <typename T>
T& structures::ArrayList<T>::operator[](std::size_t index) {
    // verificações?
    if (index > size_ - 1) {
        throw std::out_of_range("Index invalido!");
    }

    return contents[index];
}

// retorna uma constante com o dado de determinado index
template <typename T>
const T& structures::ArrayList<T>::at(std::size_t index) const {
    if (index > size_ - 1) {
        throw std::out_of_range("Index invalido!");
    }

    return contents[index];
}

// retorna com opperador[] de forma constante
template <typename T>
const T& structures::ArrayList<T>::operator[](std::size_t index) const {
    if (index > size_ - 1) {
        throw std::out_of_range("Index invalido!");
    }

    return contents[index];
}
// const após método indica que a função não pode modificar atributos do objeto