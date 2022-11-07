#include <stdio.h>
#include <stdlib.h>
#include <conio.h>

int main(void) {
    int matrix[3][3] = {0, 1, 2, 3, 4, 5, 6, 7, 8};
    int row, column;

    for (row = 0; row < 3; row++) {
        for (column = 0; column < 3; column++) {
            printf("%d ", matrix[row][column]);
        }
        printf("\n");
    }
}