#include <stdio.h>
#include <stdlib.h>
#include <conio.h>

#define ROW 5
#define COL 5

int main(void)
{
	int data[5][5];
	for (int i = 0; i < ROW; i++) {
        for (int j = i; j >= 0; j--) {
            data[j][i] = rand() % 100 + 1;
        }
    }

	// opcao 2
	// for (int i = 0; i < COL; i++) {
    //     for (int j = i; j < ROW; j++) {
    //         data[i][j] = rand() % 100 + 1;
    //     }
    // }

	// opcao 3
	// for (int i = 0; i < ROW; i++) {
    //     for (int j = i; j < COL; j++) {
    //         data[i][j] = rand() % 100 + 1;
    //     }
    // }

	printf("%d %d %d %d %d\n", data[0][0], data[0][1], data[0][2], data[0][3], data[0][4]);
	printf("%d %d %d %d %d\n", data[1][0], data[1][1], data[1][2], data[1][3], data[1][4]);
	printf("%d %d %d %d %d\n", data[2][0], data[2][1], data[2][2], data[2][3], data[2][4]);
	printf("%d %d %d %d %d\n", data[3][0], data[3][1], data[3][2], data[3][3], data[3][4]);
	printf("%d %d %d %d %d\n", data[4][0], data[4][1], data[4][2], data[4][3], data[1][4]);

	return 0;
}
