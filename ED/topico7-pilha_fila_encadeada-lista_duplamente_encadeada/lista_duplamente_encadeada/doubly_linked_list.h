// Copyright [2022] Caio Prá Silva
#ifndef STRUCTURES_DOUBLY_LINKED_LIST_H
#define STRUCTURES_DOUBLY_LINKED_LIST_H

#include <cstdint>
namespace structures {

template <typename T>
class DoublyLinkedList {
 public:
    DoublyLinkedList();
    ~DoublyLinkedList();
    void clear();

    void push_back(const T& data);                  // insere no fim
    void push_front(const T& data);                 // insere no início
    void insert(const T& data, std::size_t index);  // insere na posição
    void insert_sorted(const T& data);              // insere em ordem

    T pop(std::size_t index);    // retira da posição
    T pop_back();                // retira do fim
    T pop_front();               // retira do início
    void remove(const T& data);  // retira específico

    bool empty() const;                  // lista vazia
    bool contains(const T& data) const;  // contém

    T& at(std::size_t index);       // acesso a um elemento (checando limites)
    const T& at(std::size_t index) const;  // getter constante a um elemento

    std::size_t find(const T& data) const;  // posição de um dado
    std::size_t size() const;               // tamanho

 private:
    class Node {  // elemento
     public:
        explicit Node(const T& data) : data_{data} {}
        Node(const T& data, Node* next) : data_{data},
                                          next_{next} {}
        Node(const T& data, Node* prev, Node* next) : data_{data},
                                                       next_{next},
                                                       prev_{prev} {}

        T& data() {  // getter, devolve dado armazenado
            return data_;
        }

        const T& data() const {  // getter, retorna dado como constante
            return data_;
        }

        Node* prev() {  // getter para ponteiro do Node anterior
            return prev_;
        }
        const Node* prev() const {  // getter para ponteiro anterior como const
            return prev_;
        }
        void prev(Node* node) {  // setter do ponteiro prev
            prev_ = node;
        }

        Node* next() {  // getter do proximo ponteiro
            return next_;
        }
        const Node* next() const {  // getter do proximo ponteiro como const
            return next_;
        }
        void next(Node* node) {  // setter do ponteiro next
            next_ = node;
        }

     private:
        T data_;
        Node* prev_;
        Node* next_;
    };

    Node* head;  // primeiro da lista
    Node* tail;  // ultimo da lista
    std::size_t size_;
};

}  // namespace structures

#endif

template <typename T>
structures::DoublyLinkedList<T>::DoublyLinkedList() {
    head = nullptr;
    tail = nullptr;
    size_ = 0;
}

template <typename T>
structures::DoublyLinkedList<T>::~DoublyLinkedList() {
    clear();
}

template <typename T>
void structures::DoublyLinkedList<T>::clear() {
    while (!empty()) {
        pop_front();
    }
}

template <typename T>
void structures::DoublyLinkedList<T>::push_back(const T& data) {
    Node* new_node = new Node(data);
    new_node->prev(tail);
    new_node->next(nullptr);

    if (new_node->prev() != nullptr) {
        tail->next(new_node);
    } else {
        head = new_node;
    }
    tail = new_node;

    size_++;
}

template <typename T>
void structures::DoublyLinkedList<T>::push_front(const T& data) {
    Node* new_node = new Node(data, head);
    new_node->prev(nullptr);

    head = new_node;
    if (new_node->next() != nullptr) {  // se não for o unico node
        // faz o que está na sua frente apontar para o novo
        new_node->next()->prev(new_node);
    } else {
        tail = new_node;
    }

    size_++;
}

template <typename T>
void structures::DoublyLinkedList<T>::insert(const T& data, std::size_t index) {
    if (index > size_ || index < 0) {
        throw std::out_of_range("Index invalido");
    } else if (index == 0) {
        return push_front(data);
    }

    Node* new_node = new Node(data);
    Node* p = head;

    // vai ate o anterior ao indice que quer inserir
    for (std::size_t i = 0; i < index - 1; i++) {
        p = p->next();
    }

    new_node->next(p->next());

    if (new_node->next() != nullptr) {
        new_node->next()->prev(new_node);
    }

    p->next(new_node);
    new_node->prev(p);

    size_++;
}

template <typename T>
void structures::DoublyLinkedList<T>::insert_sorted(const T& data) {
    if (empty()) {
        return push_front(data);
    }

    Node* current_node = head;

    std::size_t position = 0;
    // verifica se esta antes do ultimo e novo dado é maior
    while (current_node->next() != nullptr && data > current_node->data()) {
        current_node = current_node->next();
        position++;
    }

    if (data > current_node->data()) {
        insert(data, position + 1);
    } else {
        insert(data, position);
    }
}

template <typename T>
T structures::DoublyLinkedList<T>::pop(std::size_t index) {
    // index vazio ou lista vazia
    if (index >= size() || size() < 0) {
        throw std::out_of_range("Index invalido");
    } else if (empty()) {  // else não necessario, apenas para legibilidade
        throw std::out_of_range("Lista vazia");
    }

    if (index == 0) {
        return pop_front();
    }

    // implementação de pop
    Node* previous_node = head;
    for (std::size_t i = 1; i < index; i++) {  // head e vai ao que quer-1
        previous_node = previous_node->next();
    }

    // aux sera o node removido
    Node* aux = previous_node->next();  // aponta para o index desejado
    T saida = aux->data();  // valor do Node no index

    // troca dos ponteiros
    previous_node->next(aux->next());  // anterior apontara para o apos o index

    if (aux->next() != nullptr) {  // caso nao seja o ultimo node
    // depois do removido aponta para o antes dele
        aux->next()->prev(previous_node);
    } else {  // caso a lista esteja vazia
        aux->next()->prev(nullptr);
    }

    delete aux;
    size_--;

    return saida;
}

template <typename T>
T structures::DoublyLinkedList<T>::pop_back() {
    if (empty()) {
        throw std::out_of_range("Lista vazia");
    }

    Node* node = tail;  // inicia no ultimo node
    T saida = node->data();  // pega o dado para retorno
    tail = tail->prev();

    if (tail != nullptr) {
        tail->next(nullptr);
    } else {
        head = nullptr;
    }

    delete node->next();  // deleta o ultimo node
    size_--;

    return saida;
}

template <typename T>
T structures::DoublyLinkedList<T>::pop_front() {
    if (empty()) {
        throw std::out_of_range("Lista vazia");
    }

    Node* aux = head;
    head = aux->next();
    T saida = aux->data();

    if (head != nullptr) {
        head->prev(nullptr);
    } else {
        tail = nullptr;
    }

    delete aux;
    size_--;

    return saida;
}

template <typename T>
void structures::DoublyLinkedList<T>::remove(const T& data) {
    if (empty()) {
        throw std::out_of_range("Lista vazia");
    }

    Node* p = head;
    for (int i = 0; i < static_cast<int>(size()) - 1; i++) {
        if (p->data() == data) {
            pop(i);
            return;
        }
        p = p->next();
    }
}

template <typename T>
bool structures::DoublyLinkedList<T>::empty() const {
    return (size() == 0);
}

template <typename T>
bool structures::DoublyLinkedList<T>::contains(const T& data) const {
    return (find(data) != size());
}

template <typename T>
T& structures::DoublyLinkedList<T>::at(std::size_t index) {
    if (empty()) {
        throw std::out_of_range("Lista vazia");
    } else if (index >= size() || index < 0) {
        throw std::out_of_range("Index invalido");
    }

    Node* p = head;
    for (std::size_t i = 0; i < index; i++) {
        p = p->next();
    }

    return p->data();
}

template <typename T>
const T& structures::DoublyLinkedList<T>::at(std::size_t index) const {
    if (empty()) {
        throw std::out_of_range("Lista vazia");
    } else if (index >= size() || index < 0) {
        throw std::out_of_range("Index invalido");
    }

    Node* p = head;
    for (std::size_t i = 0; i < index; i++) {
        p = p->next();
    }

    return p->data();
}

template <typename T>
std::size_t structures::DoublyLinkedList<T>::find(const T& data) const {
    if (empty()) {
        throw std::out_of_range("Lista vazia");
    }

    Node* node = head;
    for (std::size_t i = 0; i < size(); i++) {
        if (node->data() == data) {
            return i;
        }
        node = node->next();
    }
    return size();
}

template <typename T>
std::size_t structures::DoublyLinkedList<T>::size() const {
    return size_;
}

