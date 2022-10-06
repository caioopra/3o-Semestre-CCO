#include <stdio.h>
#include <stdlib.h>

int global;

void compute(int arg) {
	if (arg < 2) {
		printf("arg: %i, global: %i\n", arg, global);
		global += arg;
	} else {
		compute(arg - 1);
		compute(arg - 2);
	}
}


int main(int argc, char** argv) {
	global = 0;

	if (argc < 2) {
		printf("%s n_threads x1 x2 ... xn\n", argv[0]);
		return 1;
	}

	compute(atoi(argv[1]));
	printf("teste: %i", global);
	return 0;
}
