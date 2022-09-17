#include <stdio.h>
#include <unistd.h>
#include <sys/wait.h>

int main(int argc, char **argv) {
	pid_t pid;
	pid = fork();

	if (pid >= 0) {  //se for positivo criou processo
		if (pid == 0) {
			printf("Processo filho\n");
	 	} else {
			printf("Processo pai\n");
			wait(NULL);  // faz esperar p3lo rilho 
		}
		return 0;
	} else {
		printf("Erro na criação do processo");
		return 1;
	}
}
