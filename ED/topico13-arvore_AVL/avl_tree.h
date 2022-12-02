// Copyright [2022] Caio Pra Silva
#ifndef STRUCTURES_AVL_TREE_H
#define STRUCTURES_AVL_TREE_H

#include <algorithm>
#include "array_list.h"

namespace structures {

template <typename T>
class AVLTree {
   public:
    ~AVLTree();

    void insert(const T& data);

    bool remove(const T& data);

    bool contains(const T& data) const;

    bool empty() const;

    std::size_t size() const;

    int height() const;

    ArrayList<T> pre_order() const;

    ArrayList<T> in_order() const;

    ArrayList<T> post_order() const;

   private:
    struct Node {
        explicit Node(const T& data_) {
            data = data_;
        }

        T data;
        int height_;
        Node* left;
        Node* right;

        Node* insert(Node* node, const T &data_) {
            if (node == nullptr) {
                Node* node = new Node(data_);
                return node;
            }
            if (data_ < node->data) {
                // inserindo na esquerda
                node->left = insert(node->left, data_);
            } else if (data_ > node->data) {
                // inserindo na direita
                node->right = insert(node->right, data_);
            } else {
                throw std::out_of_range("Não foi possível inserir o nó.");
            }

            updateHeight(node);

            // valor para o balanceamento
            int balance = abs(node->left->height_ - node->right->height_);

            // rotações
            // simples a esquerda
            if (balance > 1 && data_ < node->left->data) {
                return simpleLeft(node);
            }

            // simples a direita
            if (balance < -1 && data_ > node->right->data) {
                return simpleRight(node);
            }

            // dupla a esquerda
            if (balance > 1 && data_ > node->left->data) {
                doubleLeft(node);
            }

            // dupla a direita
            if (balance < -1 && data_ < node->right->data) {
                doubleRight(node);
            }

            return node;
        }

        Node* remove(const T& data_) {
            Node *node = this;
            if (data_ < node->data) {  // esquerda
                node->left = node->left->remove(data_);
            } else if (data > node->data) {  // direita
                node->right = node->right->remove(data_);
            } else {  // achou o nodo que quer deletar
                if ((node->left == NULL) || (node->right == NULL)) {
                    // tem 1 filho e ve qual filho existe
                    Node *tmp = node->left ?
                                node->left : node->right;

                    // sem filho
                    if (tmp == NULL) {
                        tmp = node;
                        node = NULL;
                    } else {
                        *node = *tmp;  // Copia os dados.
                        delete tmp;
                    }
                } else {
                    // dois filhos
                    Node *tmp = minimum(node->right);
                    // copia o valor para o node atual
                    node->data = tmp->data;
                    // deleta o próximo
                    node->right = node->right->remove(tmp->data);
                }
            }

            // atualizando a altura
            updateHeight(node);

            // verificando se precisa de rotação
            int balanceamento = abs(height(node->left) - height(node->right));

            if (balanceamento > 1) {
                if (
                    (height(node->left->left) -
                    height(node->left->right)) >= 0) {
                    return simpleLeft(node);
                } else if (
                    (height(node->left->left) -
                    height(node->left->right)) < 0) {
                    return doubleLeft(node);
                }
            } else if (balanceamento < -1) {
                if (
                    (height(node->right->left) -
                    height(node->right->right)) <= 0) {
                    return simpleRight(node);
                } else if (
                    (height(node->right->left) -
                    height(node->right->right)) > 0) {
                    return doubleRight(node);
                }
            }

            return node;
        }

        bool contains(const T& data_) const {
            if (data_ == data) {
                return true;
            }
            if (data_ < data && left != nullptr) {
                return left->contains(data);
            } else if (data_ > data && right != nullptr) {
                return right->contains(data);
            }

            return false;
        }

        void updateHeight(Node* node) {
            node->height_ = std::max(height(node->left),
                                     height(node->right)) + 1;
        }

        Node* simpleLeft(Node* k2) {
            Node* k1 = k2->left;

            k2->left = k1->right;
            k1->right = k2;

            // atualizando as alturas
            updateHeight(k1);
            updateHeight(k2);

            return k1;  // nova raíz da subárvore (nodo rotacionado)
        }

        Node* simpleRight(Node* k2) {
            Node* k1 = k2->right;

            k2->right = k1->left;
            k1->left = k2;

            updateHeight(k1);
            updateHeight(k2);

            return k1;
        }

        Node* doubleLeft(Node* k3) {
            // rotação entre k1 e k2
            k3->left = simpleRight(k3->left);
            // rotação entre k3 e k2
            return simpleLeft(k3);
        }

        Node* doubleRight(Node* k3) {
            k3->right = simpleLeft(k3->left);
            return simpleRight(k3);
        }

        void pre_order(ArrayList<T>& v) const {
            // insere a raiz
            v.push_back(data);

            if (left != nullptr) {
                left->pre_order(v);
            }
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

        int height(Node* node) {
            if (node == nullptr) return -1;

            return node->height_;
        }

        // encontra o menor valor da árvore (recursivamente)
        Node* minimum(Node* node) {
            Node* current = node;
            if (node->left != nullptr) {
                return node->minimum(node->left);
            }
            return current;
        }
    };

    Node* root{nullptr};
    std::size_t size_{0u};
};

}  // namespace structures

#endif

template <typename T>
structures::AVLTree<T>::~AVLTree() {
}

template <typename T>
void structures::AVLTree<T>::insert(const T& data) {
    std::cout << "Inserindo" << data << std::endl;
    root = root->insert(root, data);
    size_++;
}

template <typename T>
int structures::AVLTree<T>::height() const {
    return root->height(root);
}

template<typename T>
bool structures::AVLTree<T>::remove(const T& data) {
    if (empty()) {
        throw std::out_of_range("Arvore vazia");
    }

    bool rem = root->remove(data);
    size_--;
    return rem;
}

template <typename T>
bool structures::AVLTree<T>::contains(const T& data) const {
    if (root != nullptr) {
        return root->contains(data);
    } else {
        return false;
    }
}

template <typename T>
bool structures::AVLTree<T>::empty() const {
    return size() == 0 ? true : false;
}

template <typename T>
std::size_t structures::AVLTree<T>::size() const {
    return size_;
}

template <typename T>
structures::ArrayList<T> structures::AVLTree<T>::pre_order() const {
    structures::ArrayList<T> list;
    if (root != nullptr) {
        root->pre_order(list);
    }

    return list;
}

template <typename T>
structures::ArrayList<T> structures::AVLTree<T>::in_order() const {
    structures::ArrayList<T> list;
    if (root != nullptr) {
        root->in_order(list);
    }

    return list;
}

template <typename T>
structures::ArrayList<T> structures::AVLTree<T>::post_order() const {
    structures::ArrayList<T> list;
    if (root != nullptr) {
        root->post_order(list);
    }

    return list;
}
