// Copyright [2022] Caio Pra Silva

#ifndef BINARY_TREE_H
#define BINARY_TREE_H

#include <cstdint>
#include "array_list.h"


namespace structures {

template<typename T>
class BinaryTree {
  public:
    // Construtor da classe BinaryTree
    BinaryTree();
    
    // Destrutor da classe BinaryTree
    ~BinaryTree();

    /**
     * @brief Insere dado na árvore
     * 
     * @param data: dado a ser inserido
     */
    void insert(const T& data);

    /**
     * @brief Remove dado de dentro da árvore
     * 
     * @param data: dado a ser removido
     */
    void remove(const T& data);

    /**
     * @brief Verifica se dado está dentro da árvore
     * 
     * @param data: Dado que quer verificar se está na árvore
     * @return true caso esteja na árvore
     * @return false caso não esteja na árvore
     */
    bool contains(const T& data) const;

    /**
    * @brief verifica se árvore está vazia 
    * 
    * @return true: se árvore estiver vazia
    * @return false: se houver dado na árvore
    */
    bool empty() const;

    /**
     * @brief Retorna quantidade de elementos na árvore
     * 
     * @return std::size_t: quantidade de elementos
     */
    std::size_t size() const;

    /**
     * @brief Retorna os dados em ordem "pre-order"
     *        ou seja, na ordem, raiz, esquerda e direita
     * 
     * @return ArrayList<T>: ArrayList contendo os dados
     */
    ArrayList<T> pre_order() const;

    /**
     * @brief Retorna os dados em ordem "ir-order"
     *        ou seja, na ordem esquerda, raiz e direita
     * 
     * @return ArrayList<T>: ArrayList contendo os dados
     */
    ArrayList<T> in_order() const;

    /**
     * @brief Retorna os dados em ordem "post-order
     *        ou seja, na ordem esquerda, direita e raiz
     * 
     * @return ArrayList<T>: ArrayList contendo os dados
     */
    ArrayList<T> post_order() const;

  private:
    struct Node {
        explicit Node(const T& data_) {
            data = data_;
        }

        T data;
        Node* left{nullptr};
        Node* right{nullptr};

        // insere novo nó
        void insert(const T& data_) {
            if (data_ < data) {
                // insereção na esquerda
                if (left == nullptr) {
                    left = new Node(data_);
                } else {
                    left->insert(data_);
                }
            } else {
                // insereção na direita
                if (right == nullptr) {
                    right = new Node(data_);
                } else {
                    right->insert(data_);
                }
            }
        }

        Node* remove(const T& data_) {
            if (data_ < data) {
                // dado que quer remover esta a esquerda
                if (left != nullptr) {
                    left = left->remove(data_);
                    return this;
                } else {    
                    return nullptr;
                }
            } else if (data_ > data) {
                // dado que quer remover esta a direita
                if (right != nullptr) {
                    right = right->remove(data_);
                    return this;
                } else {
                    return nullptr;
                }
            } else {  // caso tenha achado o dado
                if (right != nullptr && left != nullptr) {
                    // dois filhos
                    Node* temporary = right->minimum();
                    data = temporary->data;
                    right = right->remove(data);

                    return this;
                } else if (right != nullptr) {
                    // apenas filho a direita
                    Node* temporary = right;
                    delete this;

                    return temporary;
                } else if (left != nullptr) {
                    Node* temporary = left;
                    delete this;

                    return temporary;
                } else {
                    // folha
                    delete this;
                    return nullptr;
                }
            }
        }

        bool contains(const T& data_) const {
            if (data_ == data) {
                return true;
            } else if (data_ < data && left != nullptr) {
                // se dado for menor e houver como ir para esquerda
                return left->contains(data_);
            } else if (data_ > data && right != nullptr) {
                return right->contains(data_);
            }

            return false;
        }

        void pre_order(ArrayList<T>& v) const {
            // inserer a raiz
            v.push_back(data);

            // esquerda
            if (left != nullptr) {
                left->pre_order(v);
            }

            // direita
            if (right != nullptr) {
                right->pre_order(v);
            }
        }

        void in_order(ArrayList<T>& v) const {
            if (left != nullptr) {
                left->in_order(v);
            }
            v.push_back(data);
            if (right != nullptr) {
                right->in_order(v);
            }
        }

        void post_order(ArrayList<T>& v) const {
            if (left != nullptr) {
                left->post_order(v);
            }
            if (right != nullptr) {
                right->post_order(v);
            }
            v.push_back(data);
        }

        // retorna dado mais a esquerda da arvore
        Node* minimum() {
            if (left == nullptr) {
                return this;
            } else {
                return left->minimum();
            }
        }
    };

    Node* root{nullptr};
    std::size_t size_{0};
};

}  // namespace structures

#endif

template <typename T>
structures::BinaryTree<T>::~BinaryTree() {
    root = nullptr;
    size_ = 0;
}

// cria ArryList contendo todos os nodos (nesse caso, com pre_order)
// deleta os dados contindos na lista e os remove da lista
template <typename T>
structures::BinaryTree<T>::~BinaryTree() {
    if (root != nullptr) {
        structures::ArrayList<T> nodes_list = pre_order();

        while (nodes_list.empty() == false) {
            remove(nodes_list.pop_back());
        }
    }
}

template <typename T>
void structures::BinaryTree<T>::insert(const T& data) {
    if (contains(data)) {
        throw std::out_of_range("Elemento já está na árvore");
    }

    if (root != nullptr) {
        root->insert(data);     // Node tem metodo de insercao
    } else {
        root = new Node(data);
    }

    size_++;
}

template <typename T>
void structures::BinaryTree<T>::remove(const T& data) {
    if (root == nullptr) {
        throw std::out_of_range("Árvore vazia");
    } else if (!contains(data)) {
        throw std::out_of_range("Dado não está contido na árvore");
    }

    root->remove(data);
    size_--;
}

template <typename T>
bool structures::BinaryTree<T>::contains(const T& data) const {
    if (root != nullptr) {
        return root->contains(data);
    } else {
        return false;
    }
}

template <typename T>
bool structures::BinaryTree<T>::empty() const {
    return (size_ == 0);
}

template <typename T>
std::size_t structures::BinaryTree<T>::size() const {
    return size_;
}

template <typename T>
structures::ArrayList<T> structures::BinaryTree<T>::pre_order() const {
    structures::ArrayList<T> v;

    if (root != nullptr) {
        root->pre_order(v);
    }

    return v;
}

template <typename T>
structures::ArrayList<T> structures::BinaryTree<T>::in_order() const {
    structures::ArrayList<T> v;

    if (root != nullptr) {
        root->in_order(v);
    }

    return v;
}

template <typename T>
structures::ArrayList<T> structures::BinaryTree<T>::post_order() const {
    structures::ArrayList<T> v;

    if (root != nullptr) {
        root->post_order(v);
    }

    return v;
}
