#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

// função executada pelas threads filhas
// printa seu identificador, recebido como argumento
void* thread(void* argumento) {
    printf("Thread %d inicializada!\n", *((int*)argumento));
    fflush(stdout);

    return 0;
}

int main(int argc, char** argv) {
    if (argc != 2) {
        printf("Sintaxe correta: %s <numero de threads>\n", argv[0]);

        return -1;
    }

    int numero_threads = atoi(argv[1]);

    pthread_t threads[numero_threads];
    int id_threads[numero_threads];

    // criando as threads usando id único como argumento
    for (int i = 0; i < numero_threads; i++) {
        id_threads[i] = i;

        /*
            - &threads[i]: identificador retornado pela criação de uma thread
            - NULL: setar atributos (nesse caso, com valores padrão)
            - thread: rotina que a thread vai executar
            - (void *)&threads[i]: argumento passado para a rotina; precisa ser do tipo void *
        */
        pthread_create(&threads[i], NULL, thread, (void*)&id_threads[i]);
    }

    for (int i = 0; i < numero_threads; i++) {
        // NULL para não aramazenar valor de retorno
        pthread_join(threads[i], NULL);
    }

    printf("Thread principal finalizada\n");

    return 0;
}