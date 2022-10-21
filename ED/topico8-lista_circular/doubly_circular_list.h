// Copyright [2022] Caio Pra Silva
#ifndef DOUBLY_CIRCULAR_LIST
#define DOUBLY_CIRCULAR_LIST

#include <cstdint>

namespace structures {

template<typename T>
class DoublyCircularList {
 public:
    DoublyCircularList();
    ~DoublyCircularList();

    void clear();

    void push_back(const T& data);  // insere no fim
    void push_front(const T& data);  // insere no início
    void insert(const T& data, std::size_t index);  // insere na posição
    void insert_sorted(const T& data);  // insere em ordem

    T pop(std::size_t index);  // retira da posição
    T pop_back();  // retira do fim
    T pop_front();  // retira do início
    void remove(const T& data);  // retira específico

    bool empty() const;  // lista vazia
    bool contains(const T& data) const;  // contém

    T& at(std::size_t index);  // acesso a um elemento (checando limites)
    const T& at(std::size_t index) const;  // getter constante a um elemento

    std::size_t find(const T& data) const;  // posição de um dado
    std::size_t size() const;  // tamanho

 private:
    class Node {
     public:
        explicit Node(const T& data): data_{data}
                                      {}
        Node(const T& data, Node* next): data_{data},
                                         next_{next}
                                         {}

        Node(const T& data, Node* prev, Node* next): data_{data},
                                                     next_{next},
                                                     prev_{prev}
                                                     {}

        // getter dado
        T& data() {
            return data_;
        }
        const T& data() const {
            return data_;
        }

        Node* prev() {
            return prev_;
        }
        const Node* prev() const {
            return prev_;
        }

        void prev(Node* node) {
            prev_ = node;
        }

        Node* next() {
            return next_;
        }
        const Node* next() const {
            return next_;
        }

        void next(Node* node) {
            next_ = node;
        }

     private:
        T data_;
        Node* prev_;
        Node* next_;
    };

    Node* head;
    std::size_t size_;
};

}  // namespace structures
#endif

template <typename T>
structures::DoublyCircularList<T>::DoublyCircularList() {
    head = new Node(0);  // no sentinela
    size_ = 0;
}

template <typename T>
structures::DoublyCircularList<T>::~DoublyCircularList() {
    clear();
    delete head;   // caso limpe a lista, remove até o sentinela
}

template <typename T>
void structures::DoublyCircularList<T>::clear() {
    while (size_ > 0) {
        pop_front();
    }
}

template <typename T>
void structures::DoublyCircularList<T>::push_back(const T& data) {
    insert(data, size_);
}

template <typename T>
void structures::DoublyCircularList<T>::push_front(const T& data) {
    Node* new_node = new Node(data);

    if (new_node == nullptr) {
        throw std::out_of_range("Lista cheia");
    }

    // se vazio, head aponta para o novo e o novo para head
    if (empty()) {
        new_node->next(head);
        head->prev(new_node);
    } else {
        new_node->next(head->next());
    }

    new_node->prev(head);  // sempre aponta seu prev para head
    head->next(new_node);  // head sempre vai apontar para o inserido na frente

    size_++;
}

template <typename T>
void structures::DoublyCircularList<T>::insert(const T& data,
                                               std::size_t index) {
    if (index > size_ || index < 0) {
        throw std::out_of_range("posicao invalida");
    }
    if (index == 0) {
        return push_front(data);
    }

    Node* new_node = new Node(data);
    if (new_node == nullptr) {
        throw std::out_of_range("Lista cheia");
    }

    Node* p = head->next();
    for (std::size_t i = 0; i < index - 1; i++) {
        p = p->next();
    }

    new_node->next(p->next());
    new_node->next()->prev(new_node);

    p->next(new_node);
    new_node->prev(p);

    size_++;
}

template<typename T>
void structures::DoublyCircularList<T>::insert_sorted(const T& data) {
    if (empty()) {
        push_front(data);
    }

    Node* node = head->next();
    std::size_t position = 0;
    while (node->next() != head && data > node->data()) {
        node = node->next();
        position++;
    }
    if (data > node->data()) {
        insert(data, position + 1);
    } else {
        insert(data, position);
    }
}

template<typename T>
T structures::DoublyCircularList<T>::pop(std::size_t index) {
    if (index >= size_ || index < 0) {
        throw std::out_of_range("posicao invalida");
    } else if (index == 0) {
        return pop_front();
    }

    Node* p = head->next();
    for (std::size_t i = 0; i < index - 1; i++) {
        p = p->next();
    }

    Node* eliminate = p->next();
    T saida = eliminate->data();

    p->next(eliminate->next());
    eliminate->next()->prev(p);
    size_--;

    delete eliminate;
    return saida;
}

template<typename T>
T structures::DoublyCircularList<T>::pop_back() {
    return pop(size_ - 1);
}

template<typename T>
T structures::DoublyCircularList<T>::pop_front() {
    if (empty()) {
        throw std::out_of_range("lista vazia");
    }

    Node* eliminate = head->next();
    T info_back = eliminate->data();

    head->next(eliminate->next());
    eliminate->next()->prev(head);

    size_--;
    delete eliminate;

    return info_back;
}

template<typename T>
void structures::DoublyCircularList<T>::remove(const T& data) {
    pop(find(data));
}

template<typename T>
bool structures::DoublyCircularList<T>::empty() const {
    return (size_ == 0);
}

template<typename T>
bool structures::DoublyCircularList<T>::contains(const T& data) const {
    return (find(data) != size_);
}

template<typename T>
T& structures::DoublyCircularList<T>::at(std::size_t index) {
    if (empty()) {
        throw std::out_of_range("lista vazia");
    } else if (index > size_ || index < 0) {
        throw std::out_of_range("posicao invalida");
    }
    Node* node = head->next();
    for (std::size_t i = 0; i < index; i++) {
        node = node->next();
    }
    return node->data();
}

template<typename T>
const T& structures::DoublyCircularList<T>::at(std::size_t index) const {
    if (empty()) {
        throw std::out_of_range("lista vazia");
    } else if (index > size_ || index < 0) {
        throw std::out_of_range("posicao invalida");
    }
    Node* node = head->next();
    for (std::size_t i = 0; i < index; i++) {
        node = node->next();
    }
    return node->data();
}

template<typename T>
std::size_t structures::DoublyCircularList<T>::find(const T& data) const {
    Node* node = head->next();
    for (std::size_t i = 0; i < size_; i++) {
        if (data == node->data()) {
            return i;
        }
        node = node->next();
    }
    return size_;
}

template<typename T>
std::size_t structures::DoublyCircularList<T>::size() const {
    return size_;
}
