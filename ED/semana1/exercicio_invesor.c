#include <stdio.h>
#include <stdlib.h>

int main(void) {
	void inverterVetor(int vetor[], int N);

	int vetor_teste[5] = {1, 2, 3, 4, 5};
	inverterVetor(vetor_teste, 5);

	for (int i = 0; i < 5; i++) {
		printf("%i\n", vetor_teste[i]);
	}

	return 0;
}

void inverterVetor(int vetor[], int N) {
	for (int i = 0; i < N/2; i++) {
		int temp = vetor[N - 1 - i];
		vetor[N - 1 - i] = vetor[i];
		vetor[i] = temp;
	}
}
