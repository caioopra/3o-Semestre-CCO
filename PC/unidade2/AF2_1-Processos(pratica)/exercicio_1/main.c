#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

//       (pai)
//         |
//    +----+----+
//    |         |
// filho_1   filho_2

// ~~~ printfs  ~~~
// pai (ao criar filho): "Processo pai criou %d\n"
//    pai (ao terminar): "Processo pai finalizado!\n"
//  filhos (ao iniciar): "Processo filho %d criado\n"

// Obs:
// - pai deve esperar pelos filhos antes de terminar!

int main(int argc, char** argv) {
    // ....

    /*************************************************
     * Dicas:                                        *
     * 1. Leia as intruções antes do main().         *
     * 2. Faça os prints exatamente como solicitado. *
     * 3. Espere o término dos filhos                *
     *************************************************/

    int pid1 = fork();

    if (pid1 > 0) {  // ações do processo pai ao primeiro fork
        printf("Processo pai criou %d\n", pid1);
        fflush(stdout);

        int pid2 = fork();
        if (pid2 > 0) {  // ações do processo pai ao segundo fork
            printf("Processo pai criou %d\n", pid2);
            wait(NULL);
            wait(NULL);
            printf("Processo pai finalizado!\n");
        } else if (pid2 == 0) {  // processo filho pid2
            printf("Processo filho %d criado\n", getpid());
        } else {
            printf("Erro na criação do processo filho\n");
        }
    } else if (pid1 == 0) {  // processo filho pid1
        printf("Processo filho %d criado\n", getpid());
    } else {
        printf("Erro na criação do processo filho\n");
    }

    return 0;
}
