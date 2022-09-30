// Copyright [2022] Caio Pra Silva
#ifndef STRUCTURES_LINKED_LIST_H
#define STRUCTURES_LINKED_LIST_H

#include <cstdint>

namespace structures {

// classe que define a estrutura de lista encadeada
template <typename T>
class LinkedList {
 public:
    // Construtor padrão de LinkedList (sem parametros)
    LinkedList();

    // destrutor para classe LinkedList
    ~LinkedList();

    // função para limpar a lista
    void clear();

    // função para inserir elemento no final da lista
    void push_back(const T& data);

    // insere elemento  no começo da lista
    void push_front(const T& data);

    /* insere em qualquer posição da lista
       @param data: valor a ser inserido
       @param pos: posição para inserir o dado
    */
    void insert(const T& data, std::size_t index);

    /*
        Insere de forma ordenada na lista
        @param data: valor que quer inserir na lista
    */
    void insert_sorted(const T& data);

    /*
        Acessa elemento na posição indicada da lista
        @param index: index do valor que quer acessar
    */
    T& at(std::size_t index);

    /*
        Remove valor de índice e retorna o valor
        @param index: index do valor que quer retirar
        @return saida: valor retirado
    */
    T pop(std::size_t index);

    // Retira valor do final da lista e o retorna
    T pop_back();

    // Retira valor do começo da lista e o retorna
    T pop_front();

    /*
        Remove dado específico da lista
        @param data? valor a ser removido
    */
    void remove(const T& data);

    // verifica se a lista está vazia
    bool empty() const;

    /*
        Verifica se a lista conteḿ um valor determinado
        @param data: valor que quer procurar para verificar se está na lista
    */
    bool contains(const T& data) const;

    /*
        Procura e retorna índice de dado
        @param data: dado a ser prcurado dentro dos elementos da lista
        @return index: índice do dado ou size_ caso não o encontre
    */
    std::size_t find(const T& data) const;

    /*
        Retorna tamanho atual da lista
        @return size: tamanho da lista
    */
    std::size_t size() const;

 private:
    class Node {  // Elemento
     public:
        explicit Node(const T& data) : data_{data} {}

        Node(const T& data, Node* next) : data_{data},
                                          next_{next} {}

        T& data() {  // getter: dado
            return data_;
        }

        const T& data() const {  // getter const: dado
            return data_;
        }

        Node* next() {  // getter: próximo
            return next_;
        }

        const Node* next() const {  // getter const: próximo
            return next_;
        }

        void next(Node* node) {  // setter: próximo
            next_ = node;
        }

     private:
        T data_;
        Node* next_{nullptr};
    };

    Node* end() {  // último nodo da lista
        auto it = head;
        for (auto i = 1u; i < size(); ++i) {
            it = it->next();
        }
        return it;
    }

    // head é ponteiro para o primeiro elemento
    Node* head{nullptr};
    std::size_t size_{0u};
};

}  // namespace structures

#endif

template <typename T>
structures::LinkedList<T>::LinkedList() {
    head = nullptr;
    size_ = 0;
}

template <typename T>
structures::LinkedList<T>::~LinkedList() {
    clear();
}

template <typename T>
void structures::LinkedList<T>::clear() {
    while (!empty()) {
        pop_front();
    }
}

template <typename T>
void structures::LinkedList<T>::push_back(const T& data) {
    if (empty()) {
        return push_front(data);
    }

    Node* p = head;
    Node* novo = new Node(data);
    novo->next(nullptr);

    while (p->next() != nullptr) {
        p = p->next();
    }

    p->next(novo);
    size_++;
}

template <typename T>
void structures::LinkedList<T>::push_front(const T& data) {
    Node* novo = new Node(data);
    novo->next(head);

    head = novo;
    size_++;
}

template <typename T>
void structures::LinkedList<T>::insert(const T& data, std::size_t index) {
    if ((index > size_) || index < 0) {
        throw std::out_of_range("Index inválido");
    }

    if (index == 0) {
        return push_front(data);
    }

    if (index == size_) {
        return push_back(data);
    }

    Node* p = head;

    // a cada passo, p aponta para o pxoimo node
    // aponta para uma posicao antes da que quer inserir
    for (int i = 1; i < static_cast<int>(index); i++) {
        p = p->next();
    }

    Node* novo = new Node(data);
    novo->next(p->next());
    p->next(novo);

    size_++;
}

template <typename T>
void structures::LinkedList<T>::insert_sorted(const T& data) {
    if (empty()) {
        return push_front(data);
    }

    Node* p = head;
    Node* q = nullptr;

    while (p != nullptr && data > p->data()) {
        q = p;
        p = p->next();
    }

    if (q != nullptr) {           // entrou no while e passou do primeiro nodo
        Node* novo = new Node(data);
        novo->next(p);      // novno node aponta para seu proximo
        q->next(novo);      // ponteiro anterior ao novo nó apontar para ele
    } else {                // insere no início por ser menor do que os valores
        return push_front(data);  // altera head para apontar para ele
    }

    size_++;
}

template <typename T>
T& structures::LinkedList<T>::at(std::size_t index) {
    if (empty()) {
        throw std::out_of_range("Lista vazia");
    }

    if (index >= size()) {
        throw std::out_of_range("Index inválido");
    }

    Node* p = head;

    for (int i = 0; i < static_cast<int>(index); i++) {
        p = p->next();
    }

    return (p->data());
}

template <typename T>
T structures::LinkedList<T>::pop(std::size_t index) {
    if (empty()) {
        throw std::out_of_range("Lista vazia");
    }

    if (index < 0 || index >= size()) {
        throw std::out_of_range("Index inválido");
    }

    if (size() == 1) {
        return pop_front();
    }

    if (static_cast<int>(index) == (static_cast<int>(size()) - 1)) {
        return pop_back();
    }

    Node* p = head;

    for (int i = 1; i < static_cast<int>(index); i++) {
        p = p->next();
    }

    Node* aux = p->next();
    T saida = aux->data();

    // mudar o ponteiro, pulando o que vai ser removido
    p->next(aux->next());
    delete aux;

    size_--;
    return saida;
}

template <typename T>
T structures::LinkedList<T>::pop_back() {
    if (empty()) {
        throw std::out_of_range("Lista vazia");
    }

    if (size_ == 1) {
        return pop_front();
    }

    Node* p = head;
    for (int i = 1; i < static_cast<int>(size())-1; i++) {
        p = p->next();
    }

    T saida = p->next()->data();

    delete p->next();
    p->next(nullptr);
    size_--;

    return saida;
}

template <typename T>
T structures::LinkedList<T>::pop_front() {
    if (empty()) {
        throw std::out_of_range("Lista vazia");
    }

    Node* aux = head;  // endereco do primeiro elemento
    head = aux->next();  // assim ou head=head->next()
    T saida = aux->data();

    delete aux;
    size_--;

    return saida;
}

template <typename T>
void structures::LinkedList<T>::remove(const T& data) {
    if (empty()) {
        throw std::out_of_range("Lista vazia");
    }

    Node* p = head;
    for (int i = 0; i < static_cast<int>(size()); i++) {
        if (p->data() == data) {
            pop(i);
            return;
        }
        p = p->next();
    }
    // pop(find(data));
}

template <typename T>
bool structures::LinkedList<T>::empty() const {
    return (size() == 0);
}

template <typename T>
bool structures::LinkedList<T>::contains(const T& data) const {
    if (empty()) {
        throw std::out_of_range("Lista vazia");
    }

    Node* p = head;
    for (int i = 0; i < static_cast<int>(size()); i++) {
        if (p->data() == data) {
            return true;
        }

        p = p->next();
    }

    return false;
}

template <typename T>
std::size_t structures::LinkedList<T>::find(const T& data) const {
    if (empty()) {
        throw std::out_of_range("Lista vazia");
    }

    Node* p = head;
    for (int i = 0; i < static_cast<int>(size()); i++) {
        if (p->data() == data) {
            return (std::size_t(i));
        }
        p = p->next();
    }
    return size();
}

template <typename T>
std::size_t structures::LinkedList<T>::size() const {
    return size_;
}
