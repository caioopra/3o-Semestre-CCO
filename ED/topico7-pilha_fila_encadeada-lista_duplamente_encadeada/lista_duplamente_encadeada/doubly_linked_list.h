// Copyright [2022] Caio Prá Silva
#ifndef STRUCTURES_DOUBLY_LINKED_LIST_H
#define STRUCTURES_DOUBLY_LINKED_LIST_H

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

    T& at(std::size_t index);              // acesso a um elemento (checando limites)
    const T& at(std::size_t index) const;  // getter constante a um elemento

    std::size_t find(const T& data) const;  // posição de um dado
    std::size_t size() const;               // tamanho
   private:
    class Node {  // elemento
       public:
        explicit Node(const T& data) : data_{data} {}
        Node(const T& data, Node* next) : data_{data},
                                          next_{next} {}
        Node(const T& data, Node* prev, Node* next); : data_{data},
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
    if (empty()) {
        return push_front(data);
    }

    Node* new_node = new Node(data);
    
    head->prev->next = new_node;
    new_node->next = head;
    
    tail = new_node;
    size_++;
}