#include <stdio.h>
#include <stdlib.h>

/* newi = 0
# newj = 0
# noti = %eax
# notj = %ebx
#
# for i < n:
#   if(i == noti) break
#   for j < n:
#       if(j != notj):
#           reduzida[newi][newj] = matriz[i][j]
#           newj++
#    newi++
#    newj = 0 */

void printaMatriz(int** matriz, int ordem){
    int i,j;

    printf("\nPrintando a matriz:\n");

    for(i = 0; i < ordem; i++){
        for(j = 0; j < ordem; j++){
            printf("%d ", matriz[i][j]);
        }
        printf("\n");
    }
}

void reduz(int** matriz, int j, int i, int ordem){
    int newi = 0;
    int newj = 0;
}
