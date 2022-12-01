// Copyright [2022] Caio Pra Silva
#ifndef STRUCTURES_AVL_TREE_H
#define STRUCTURES_AVL_TREE_H

#include "array_list.h"
#include <algorithm>

namespace structures {

template <typename T>
class AVLTree {
   public:
    ~AVLTree();

    void insert(const T& data);

    void remove(const T& data);

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

        /* ALGORITMO RECURSIVO NÃO USADO
        
        void insert(const T& data_, Node* arv, Node* pai) {
            Node* arv_rodada;

            // se for uma folha
            if (arv == NULL) {
                // aloca novo nodo
                Node* arv = new Node(data);
                if (arv == NULL)
                    throw std::out_of_range("Erro ao criar o nodo");

                arv->data = data_;
                arv->right = NULL;
                arv->left = NULL;
            } else {
                if (data_ < arv->data) {
                    arv->left = insert(data_, arv->left, arv);

                    if (height(arv->left) - height(arv->right) > 1) {  // desequilibrou
                        // verifica o tipo de rotação que precisa fazer
                        if (data_ < arv->left->data) {
                            arv_rodada = simpleLeft(arv);
                        } else {
                            arv_rodada = simpleRight(arv);
                        }

                        // pai aponta para k2
                        if (pai->left == arv) {
                            pai->left = arv_rodada;
                        } else {
                            pai->right = arv_rodada;
                        }
                    } else {
                        updateHeight(arv);
                    }
                } else {  // esoelha algoritmo a cima
                    if (data_ > arv->data_) {
                        arv->right = insert(dat_, arv->right, arv);

                        if (height(arv->right) - height(arv->left) > 1) {
                            if (data_ < arv->right->data) {
                                arv_rodada = simpleLeft(arv);
                            } else {
                                arv_rodada = simpleRight(arv);
                            }

                            // pai apontando para k2
                            if (pai->right == arv) {
                                pai->right = arv_rodada;
                            } else {
                                pai->left = arv_rodada;
                            }
                        } else {
                            updateHeight(arv);
                        }
                    } else {
                        throw std::out_of_range("Erro: chave já está na árvore!");
                    }
                }
            }
            return arv;
        }
        */

        void insert(Node* raiz, T& data_) {
            
        }

        bool remove(const T& data_) {
            Node* node = this;
            Node* temporary;

            if (data_ < node->data) {  // vai para esquerda
                node->left = node->left->remove(data_);
            } else if (data_ > node->data) {  // vai para direita
                node->right = node->right->remove(data_);
            } else {  // esse é o nodo que quer deletar
                if (node->right == nullptr && node->left == nullptr) {
                    // nao tem filho
                    temporary = node;
                    node = NULL;
                } else if ((node->left != nullptr) && (node->right == nullptr)) {
                    // aponta para o filho a esquerda
                    temporary = node->left;
                    *node = *temporary;  // copia o dado
                } else if ((node->left == nullptr) && (node->right != nullptr)) {
                    // aponta para o filho a direita
                    temporary = node->right;
                    *node = *temporary;  // copiando o dado
                } else {
                    // se tiver dois filhos
                    // recebe o menor da direita
                    temporary = minimum(node->right);
                    // copia o valor para o nodo atual (sobrescrever)
                    node->data = tmp->data;
                    // deleta o próximo
                    node->right = node->right->remove(temporary->data);
                }
            }
            if (node == nullptr) {
                return node;
            }

            // atualizando a altura
            updateHeight(node);

            // verificando se precisa de rotação
            int balanceamento = height(node->left) - height(node->right);

            if (balanceamento > 1) {
                if ((height(node->left->left) - height(node->left->right)) >= 0) {
                    return simpleLeft(node);
                } else if ((height(node->left->left) - height(node->left->right)) < 0) {
                    return doubleLeft(node);
                }
            } else if (balanceamento < -1) {
                if ((height(node->right->left) - height(node->right->right)) <= 0) {
                    return simpleRight(node);
                } else if ((height(node->right->left) - height(node->right->right)) > 0) {
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
            node->height_ = std::max(height(node->left), height(node->right)) + 1;
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
            return now;
        }
    };

    Node* root{nullptr};
    std::size_t size_;
};

}  // namespace structures

#endif

template <typename T>
structures::AVLTree<T>::~AVLTree() {
}

template <typename T>
void structures::AVLTree<T>::insert(const T& data) {
    Node* node = root;

    
    root = root->insert(root, data);
    size_++;
}

template <typename T>
int structures::AVLTree<T>::height() const {
    return root->height();
}
