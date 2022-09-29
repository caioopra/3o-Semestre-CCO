#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void* thread(void* arg) {
    printf("Thread iniciada!\n");
    fflush(stdout);

    return 0;
}

int main(int argc, char** argv) {
    if (argc != 2) {
        printf("Argumento de entrada necessário: %s <num. threads>\n", argv[0]);
        return -1;
    }

    int numero_threads = atoi(argv[1]);

    pthread_t threads[numero_threads];

    // criando as n threads
    for (int i = 0; i < numero_threads; i++) {
        pthread_create(&threads[i], NULL, thread, NULL);
    }

    // valores de retorno ignorados = NULL
    // obriga thread pai esperar as threads filhas executarem (espera seu retorno)
    for (int i = 0; i < numero_threads; i++) {
        pthread_join(threads[i], NULL);
    }

    printf("Thread principal finalizada!\n");

    return 0;
}