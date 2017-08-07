#include <stdio.h>
#include <stdlib.h>

/* newi = 0
# newj = 0
# noti = %eax
# notj = %ebx
#
# for i < n:
#   if(i == noti) continue
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

void reduz(int** matriz, int notj, int noti, int ordem){
    int i,j;
    int newi = 0;
    int newj = 0;

    int** reduzida;
    int red = ordem -1;

    // Aloca a matriz reduzida
    reduzida = malloc(sizeof(int*) * red);
    for(i = 0; i < red; i++){
        reduzida[i] = malloc(sizeof(int) * red);
    }

    for(i = 0; i < ordem; i++){
        if(i == noti) continue;
        for(j = 0; j < ordem; j++){
            if(j != notj){
                reduzida[newi][newj] = matriz[i][j];
                newj++;
            }
        }
        newi++;
        newj = 0;
    }

    printaMatriz(reduzida, red);

}

void lerDados(int** matriz, int ordem){
    int i,j;

    printf("\n Lendo a matriz:\n");

    for(i = 0; i < ordem; i++){
        printf("\nLinha %d: ", i+1);
        for(j = 0; j < ordem; j++){
            scanf("%d", &matriz[i][j]);
        }
    }
}

int main(){
    int ordem, i,j;
    int** matriz;

    printf("Insira a ordem: ");
    scanf("%d",&ordem);

    matriz = malloc(sizeof(int*) * ordem);

    for(i = 0; i < ordem; i++){
        matriz[i] = malloc(sizeof(int) * ordem);
    }

    lerDados(matriz,ordem);
    printaMatriz(matriz,ordem);

    printf("Iniciando as reduções:\n");
    for(i = 0; i < ordem; i++){
        for(j = 0; j < ordem; j++){
            printf("Redução em %d - %d :", j, i);
            reduz(matriz,i,j,ordem);
            printf("\n");
        }
    }

    return 0;
}
