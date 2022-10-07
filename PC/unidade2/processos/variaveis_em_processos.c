#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int var_global = 0;

int main(int argc, char **argv) {
    int var_local = 0;    

    pid_t pid = fork();

    if (pid == 0) { // filho
        var_local = 2;
        var_global = 1;
    } else {  // pai
        var_local = 50;
        var_global = 100;
    }

    printf("%d %d\n", var_local, var_global);

    return 0;
}
