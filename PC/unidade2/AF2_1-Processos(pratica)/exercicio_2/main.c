#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

//                          (principal)
//                               |
//              +----------------+--------------+
//              |                               |
//           filho_1                         filho_2
//              |                               |
//    +---------+-----------+          +--------+--------+
//    |         |           |          |        |        |
// neto_1_1  neto_1_2  neto_1_3     neto_2_1 neto_2_2 neto_2_3

// ~~~ printfs  ~~~
//      principal (ao finalizar): "Processo principal %d finalizado\n"
// filhos e netos (ao finalizar): "Processo %d finalizado\n"
//    filhos e netos (ao inciar): "Processo %d, filho de %d\n"

// Obs:
// - netos devem esperar 5 segundos antes de imprmir a mensagem de finalizado (e terminar)
// - pais devem esperar pelos seu descendentes diretos antes de terminar
void create_grandchild(int quantidade) {
    for (int i = 0; i < quantidade; i++) {
        if (fork() == 0) {
            printf("Processo %d, filho de %d\n", getpid(), getppid());
            sleep(5);
            
            fflush(stdout);
            printf("Processo %d finalizado\n", getpid()); 
        
            exit(0);
            break;
        }
    }
    while(wait(NULL) >= 0);
}

void create_child(int quantidade) {
    for (int i = 0; i < quantidade; i++) {
        if (fork() == 0) {
            printf("Processo %d, filho de %d\n", getpid(), getppid());
            fflush(stdout);

            create_grandchild(3);

            printf("Processo %d finalizado\n", getpid()); 

            exit(0);
            break;
        }
    }
    while(wait(NULL) >=0);
    printf("Processo principal %d finalizado\n", getpid());
}


int main(int argc, char** argv) {
    // ....

    /*************************************************
     * Dicas:                                        *
     * 1. Leia as intruções antes do main().         *
     * 2. Faça os prints exatamente como solicitado. *
     * 3. Espere o término dos filhos                *
     *************************************************/

    create_child(2);

    return 0;
}
