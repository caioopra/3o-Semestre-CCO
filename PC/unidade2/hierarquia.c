#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main(int argc, char **argv) {
    fork();
    fork();
    fork();

    printf("Processo\n");
    return 0;
}
