// Copyright [2022] Caio Pra Silva

#include <string>
// #include <iostream>

// using namespace std;

class Aluno {
 public:
        Aluno() {}  // construtor
        ~Aluno() {}  // destrutor

        std::string devolveNome() {
            return nome;
        }
        int devolveMatricula() {
            return matricula;
        }
        void escreveNome(std::string nome_) {
            nome = nome_;
        }
        void escreveMatricula(int matricula_) {
            matricula = matricula_;
        }
 private:
        std::string nome;
        int matricula;
};


/*
(1) cria um vetor de 'Alunos' a partir de nomes e matriculas; exemplo:
vetor de nomes: ['Fulano', 'Beltrano', 'Ciclano']
vetor de matriculas: [1010, 2020, 3030]
vetor t alocado de saida: [{'Fulano',1010}, {'Beltrano',2020}, {'Ciclano':3030}]
*/

Aluno *turma(std::string nomes[], int matriculas[], int N) {
    Aluno *t;

    t = new Aluno[N];

    for (int i = 0; i < N; i++) {
        t[i].escreveNome(nomes[i]);
        t[i].escreveMatricula(matriculas[i]);
    }

    return t;
}

/*
(2) cria um novo vetor contendo outros dois vetores de alunos (acrescenta vetor 2 apos o vetor 1); exemplo:
t1 de estrada: [{'Fulano',1010}, {'Beltrano',2020}];  N1 = 2
t2 de entrada: [{'Fulana',7070}, {'Beltrana',8080}, {'Cicrana',9090}];  N2 = 3
tu de saída: [{'Fulano',1010}, {'Beltrano',2020}, {'Fulana',7070}, {'Beltrana',8080}, {'Cicrana':9090}]
*/
Aluno *turmas_uniao(Aluno t1[], Aluno t2[], int N1, int N2) {
    Aluno *tu;

    tu = new Aluno[N1 + N2];

    int quantidade = 0;
    for (int i = 0; i < N1; i++) {
        tu[quantidade].escreveNome(t1[i].devolveNome());
        tu[quantidade].escreveMatricula(t1[i].devolveMatricula());

        quantidade++;
    }
    for (int j = 0; j < N2; j++) {
        tu[quantidade].escreveNome(t2[j].devolveNome());
        tu[quantidade].escreveMatricula(t2[j].devolveMatricula());

        quantidade++;
    }

    return tu;
}

/*
(3) divide uma turma t existente em duas outras (os conteúdos dos ponteiros pt1 e pt2 serão as duas saídas; inicialmente são iguais a 'nullptr'), a primeira com k elementos e a segunda com o restante (N-k elementos); exemplo:
t de entrada: [{'Fulano',1010}, {'Beltrano',2020}, {'Fulana',7070}, {'Beltrana',8080}, {'Cicrana':9090}]
k = 2
conteudo de pt1: [{'Fulano',1010}, {'Beltrano',2020}]
conteudo de pt2: [{'Fulana',7070}, {'Beltrana',8080}, {'Cicrana',9090}]
*/
void turmas_divisao(Aluno t[], int k, int N, Aluno **pt1, Aluno **pt2) {
    Aluno *t1 = new Aluno[k];
    Aluno *t2 = new Aluno[N-k];

    int percorridos = 0;

    for (int i = 0; i < k; i++) {
        t1[i].escreveNome(t[percorridos].devolveNome());
        t1[i].escreveMatricula(t[percorridos].devolveMatricula());

        percorridos++;
    }

    for (int j = 0; j < (N - k); j++) {
        t2[j].escreveNome(t[percorridos].devolveNome());
        t2[j].escreveMatricula(t[percorridos].devolveMatricula());

        percorridos++;
    }

    *pt1 = t1;
    *pt2 = t2;
}




/*
    *** Importante ***

    A função 'main()' não deve ser escrita aqui, pois é parte do código dos testes e já está implementada

*/
