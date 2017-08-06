# Trabalho 1 de pihs
# Author: Bruno Cesar e Cristofer Oswald
# 06/07/2017

# Programa que resolve sistemas de equações lineares de 3 equações com 3 variaveis
# Valores são inteiros. A solução deve ser feita com o uso de matriz.
# Usar Sarrus para descobrir determinante e Cramer para resolver o sistema.
# Deve-se usar malloc para alocar o espaço para a matriz de coeficiente e de resultados
# A entrada deve ser feita pelo teclado, o programa deve mostrar a matriz lida.
# E também os resultados para x1, x2 e x3, ao fim deve perguntar por nova execução

# Um relatório em word deve ser desenvolvido, nele deve ser explicado o funcionamento
# do programa e apontar os problemas no código.

# 0  4  8
# 12 16 20
# 24 28 32

# Sarrus: (Calculo da determinante)
# l1 = x00 * x11 * x22
# l2 = x01 * x12 * x20
# l3 = x02 * x10 * x21

# l4 = x02 * x11 * x20
# l5 = x00 * x12 * x22
# l6 = x01 * x10 * x22

# A = l1 + l2 + l3

# B = -l4 - l5 - l6

# Det = A + B

# Cramer: (solução do sistema)
# Para aplicar cramer primeiro calcula - se a determinante da matriz (D)
# Depois deve-se calcular os determinantes das matrizes substituidas:
# D1 é o determinante da matriz onde a coluna do X é substituida pelos resultados
# D2 é o determinante da matriz onde a coluna do Y é substituida pelos resultados
# D3 é o equivalente para Z.
# Com estes dados podemos calcular as soluções:
# de x1 : s1 = D1 / D | x2 : s2 = D2 / D | x3 : s3 = D3 / D
# O conjunto solução é o conjunto s = {s1,s2,s3}

# Organização:
# 1) ler os dados e armazenar na matriz e no vetor resultados
# 2) Calcular determinante da matriz
# 3) Montar a matriz-x1 e calcular seu determinante D1
# 4) Montar a matriz-x2 e calcular seu determinante D2
# 5) Montar a matriz-x3 e calcular seu determinante D3
# 6) calcular s1, s2 e s3 e exibir os resultados
# 7) Perguntar se o usuário quer repetir a operação se sim então volte para 1)
# 8) Fim

.section .data
titulo: .asciz "*** Super solucionador de sistemas lineares 3x3! ***\n"
info1: .asciz "Vamos começar pela leitura dos dados:\nPor favor digite os dados da equação 1:\n"
info2: .asciz "\n\nAgora os dados da equação 2:\n"
info3: .asciz "\n\nE finalmente os dados da equação 3:\n"
pedex1: .asciz "x1 = "
pedex2: .asciz "x2 = "
pedex3: .asciz "x3 = "
infosis: .asciz "\nO sistema montado foi\n"
linha: .asciz "[ %d , %d , %d ] = %d\n"
pedres: .asciz "Resultado = "
formaint: .asciz "%d"
solucao: .asciz "Solução: x = %d, y = %d, z = %d\n"
debug_linha: .asciz "\ndebug: %d\n"
debug_valor: .asciz "\nvalor: %d\n"
info_fim: .asciz "Fim da execução!"
info_dnv: .asciz "Deseja executar novamente? (s/n)"
clean_buffer: .string "%*c"
info_det: .asciz "Impossível resolver, determinante é igual a 0\n"

coeficientes: .int 0
n:            .int 0
dnv:          .int 0
resultados:   .int 0
mat_sub:      .int 0
val_linha:    .int 0
sol:          .int 0
det_princ:    .int 0
det_x:        .int 0
det_y:        .int 0
det_z:        .int 0
vet_tam:      .int 36
res_tam:      .int 12

.section .text
.globl main
main:
    jmp inicio

# calcula o determinante de uma matriz. recebe o pontiro pro vetor da matriz como parametro
# e "retorna" o determinante a partir do registrador eax
calc_det:
    pushl %ebp # salva o ponteiro base
    movl %esp, %ebp # substiui o ponteiro do frame

    addl $8, %ebp # le ao vetor
    movl (%ebp), %edi # move o parametro pro edi

    movl $0, %ecx # inicializa ecx

    # linha 1
    movl (%edi), %eax # move o valor de 0, 0 para eax
    addl $16, %edi # vai para a posição 1, 1
    movl (%edi), %ebx # move o valor da posição 1, 1 apra ebx
    mul %ebx # multiplica eax por ebx
    addl $16, %edi # vai para a posição 2, 2
    movl (%edi), %ebx # move o valor da posição 2, 2 apra ebx
    mul %ebx # multiplica eax por ebx
    addl %eax, %ecx

    subl $28, %edi # vai para a posição 0, 1
    movl (%edi), %eax # move o valor de 0, 1 para eax
    addl $16, %edi # vai para a posição 1, 2
    movl (%edi), %ebx # move o valor da posição 1, 2 apra ebx
    mul %ebx # multiplica eax por ebx
    addl $4, %edi # vai para a posição 2, 0
    movl (%edi), %ebx # move o valor da posição 2, 0 apra ebx
    mul %ebx # multiplica eax por ebx
    addl %eax, %ecx

    subl $16, %edi # vai para a posição 0, 2
    movl (%edi), %eax # move o valor de 0, 2 para eax
    addl $4, %edi # vai para a posição 1, 0
    movl (%edi), %ebx # move o valor da posição 1, 0 apra ebx
    mul %ebx # multiplica eax por ebx
    addl $16, %edi # vai para a posição 2, 1
    movl (%edi), %ebx # move o valor da posição 2, 1 apra ebx
    mul %ebx # multiplica eax por ebx
    addl %eax, %ecx

    # linha 2

    subl $20, %edi # vai para a posição 0, 2
    movl (%edi), %eax # move o valor de 0, 2 para eax
    addl $8, %edi # vai para a posição 1, 1
    movl (%edi), %ebx # move o valor da posição 1, 1 apra ebx
    mul %ebx # multiplica eax por ebx
    addl $8, %edi # vai para a posição 2, 0
    movl (%edi), %ebx # move o valor da posição 2, 0 apra ebx
    mul %ebx # multiplica eax por ebx
    subl %eax, %ecx

    subl $20, %edi # vai para a posição 0, 1
    movl (%edi), %eax # move o valor de 0, 1 para eax
    addl $8, %edi # vai para a posição 1, 0
    movl (%edi), %ebx # move o valor da posição 1, 0 apra ebx
    mul %ebx # multiplica eax por ebx
    addl $20, %edi # vai para a posição 2, 2
    movl (%edi), %ebx # move o valor da posição 2, 2 apra ebx
    mul %ebx # multiplica eax por ebx
    subl %eax, %ecx

    subl $32, %edi # vai para a posição 0, 0
    movl (%edi), %eax # move o valor de 0, 0 para eax
    addl $20, %edi # vai para a posição 1, 2
    movl (%edi), %ebx # move o valor da posição 1, 2 apra ebx
    mul %ebx # multiplica eax por ebx
    addl $8, %edi # vai para a posição 2, 1
    movl (%edi), %ebx # move o valor da posição 2, 1 apra ebx
    mul %ebx # multiplica eax por ebx
    subl %eax, %ecx

    movl %ecx, %eax # coloca o valor do determinante no eax

    popl %ebp # volta o ponteiro base
    ret

# recebe o ponteiro pro vetor do vetor (matriz), a coluna que vai ser substituida e a coluna de origem
substitui_coluna:
    pushl %ebp # salva o ponteiro base
    movl %esp, %ebp # substiui o ponteiro do frame

    addl $8, %ebp # le a matriz
    movl (%ebp), %edi # move o parametro pro edi
    addl $4, %ebp # le o numero da coluna
    movl (%ebp), %ebx # move o parametro pro edx
    addl $4, %ebp # le o vetor a ser colocado no destino
    movl (%ebp), %esi # move o parametro pro esi

    movl $4, %ecx # inicia ecx com 4
    movl %ebx, %eax # move o numero da coluna pro eax
    mul %ecx # multiplica eax por ecx
    movl %eax, %ecx # move o resultado pro ecx

    # substitui o primeiro valor
    addl %ecx, %edi # coloca o ponteiro do vetor (matriz) no elemento inicial
    movl (%esi), %ebx # move o valor do vetor de resultados no ebx
    movl %ebx, (%edi) # substitui o valor apontado por edi pelo valor de ebx

    addl $4, %esi # avança para o próximo resultado

    addl $12, %edi # pula pra próxima linha
    movl (%esi), %ebx
    movl %ebx, (%edi)

    addl $4, %esi

    addl $12, %edi
    movl (%esi), %ebx
    movl %ebx, (%edi)

    popl %ebp # volta o ponteiro base
    ret

# recebe o ponteiro pro começo da linha a ser lida e o ponteiro para a posição no vetor de respostas
le_linha:
    pushl %ebp # salva o ponteiro base
    movl %esp, %ebp # substiui o ponteiro do frame

    addl $8, %ebp # le a linha
    movl (%ebp), %edi # move o parametro pro edi
    addl $4, %ebp # le a posição no vetor
    movl (%ebp), %esi # move o parametro pro esi

    pushl %edi # backup

    pushl $pedex1
    call printf
    addl $4, %esp

    # le x1
    pushl %edi
    pushl $formaint
    call scanf
    addl $8, %esp

    popl %edi # recupera o edi
    addl $4, %edi # move o ponteiro pra poxima posição

    pushl %edi

    pushl $pedex2
    call printf
    addl $4, %esp

    # le x2
    pushl %edi
    pushl $formaint
    call scanf
    addl $8, %esp

    popl %edi
    addl $4, %edi

    # não precisa de backup porque não vai usar mais

    pushl $pedex3
    call printf
    addl $4, %esp

    # le x3
    pushl %edi
    pushl $formaint
    call scanf
    addl $8, %esp # não precisa pegar o valor de edi mais

    pushl $pedres
    call printf
    addl $4, %esp

    # le a resposta
    pushl %esi
    pushl $formaint
    call scanf
    addl $8, %esp

    popl %ebp
    ret

# recebe o ponteiro pro começo da linha a ser mostrada e o ponteiro para a posição no vetor de respostas
mostra_linha:
    pushl %ebp # salva o ponteiro base
    movl %esp, %ebp # substiui o ponteiro do frame

    addl $8, %ebp # le a linha
    movl (%ebp), %edi # move o parametro pro edi
    addl $4, %ebp # le a posição no vetor
    movl (%ebp), %esi # move o parametro pro esi

    pushl (%esi) # empilha o resultado

    addl $8, %edi # empilha primeiro o x3
    pushl (%edi)

    subl $4, %edi # volta para o x2
    pushl (%edi)

    subl $4, %edi # volta para o x1
    pushl (%edi)

    pushl $linha
    call printf
    addl $20, %esp

    popl %ebp
    ret

# recebe o ponteiro pro vetor com os coeficientes e o vetor de resultados
mostra_sistema:
    pushl %ebp # salva o ponteiro base
    movl %esp, %ebp # substiui o ponteiro do frame

    addl $8, %ebp # le a linha
    movl (%ebp), %edi # move o parametro pro edi
    addl $4, %ebp # le o vetor a ser colocado no destino
    movl (%ebp), %esi # move o parametro pro esi

    # backup dos dados
    pushl %edi
    pushl %esi

    pushl $infosis
    call printf
    addl $4, %esp

    # le o backup
    popl %esi
    popl %edi

    # faz novo backup
    pushl %edi
    pushl %esi

    # empilha os parâmetros
    pushl %esi
    pushl %edi
    call mostra_linha
    addl $8, %esp

    # le o backup
    popl %esi
    popl %edi

    addl $12, %edi # pula pra proxima linha
    addl $4, %esi # pula pro proximo resultado

    # faz novo backup
    pushl %edi
    pushl %esi

    # empilha os parâmetros
    pushl %esi
    pushl %edi
    call mostra_linha
    addl $8, %esp

    # le o backup
    popl %esi
    popl %edi

    addl $12, %edi # pula pra proxima linha
    addl $4, %esi # pula pro proximo resultado

    # não precisa de backup no final

    # empilha os parâmetros
    pushl %esi
    pushl %edi
    call mostra_linha
    addl $8, %esp

    popl %ebp
    ret

# recebe o ponteiro para o vetor com a solução
mostra_sol:
    pushl %ebp # salva o ponteiro base
    movl %esp, %ebp # substiui o ponteiro do frame

    addl $8, %ebp # le o vetor
    movl (%ebp), %edi # move o parametro pro edi

    addl $8, %edi # move o ponteiro para a ultima posição
    pushl (%edi)

    subl $4, %edi # vai para a segunda
    pushl (%edi)

    subl $4, %edi # vai para a primeira
    pushl (%edi)

    pushl $solucao
    call printf
    addl $16, %esp

    popl %ebp
    ret

inicio:
    pushl $titulo
    call printf
    addl $4, %esp

    # aloca o vetor de coeficientes
    movl vet_tam, %ecx
    pushl %ecx
    call malloc
    addl $4, %esp
    movl %eax, coeficientes
    movl coeficientes, %edi

    # aloca o vetor de resultados
    movl res_tam, %ecx
    pushl %ecx
    call malloc
    addl $4, %esp
    movl %eax, resultados
    movl resultados, %esi

    # aloca o vetor de coeficientes substituidos
    movl vet_tam, %ecx
    pushl %ecx
    call malloc
    addl $4, %esp
    movl %eax, mat_sub

    # aloca o vetor da solução
    movl vet_tam, %ecx
    pushl %ecx
    call malloc
    addl $4, %esp
    movl %eax, sol

    # backup dos dados
    pushl %edi
    pushl %esi

    pushl $info1
    call printf
    addl $4, %esp

    # empilha os parametros
    pushl %esi
    pushl %edi
    call le_linha
    addl $8, %esp

    # desempilha o backup
    popl %esi
    popl %edi

    addl $12, %edi # pula pra próxima linha
    addl $4, %esi # pula pro próximo campo

    # backup dos dados
    pushl %edi
    pushl %esi

    pushl $info2
    call printf
    addl $4, %esp

    # empilha os parametros
    pushl %esi
    pushl %edi
    call le_linha
    addl $8, %esp

    # desempilha o backup
    popl %esi
    popl %edi

    addl $12, %edi # pula pra próxima linha
    addl $4, %esi # pula pro próximo campo

    # backup dos dados
    pushl %edi
    pushl %esi

    pushl $info3
    call printf
    addl $4, %esp

    # empilha os parametros
    pushl %esi
    pushl %edi
    call le_linha
    addl $8, %esp

    # desempilha o backup
    popl %esi
    popl %edi

    subl $24, %edi # retorna pro inicio do vetor
    subl $8, %esi # retorna pro inicio do vetor

    # backup dos dados
    pushl %edi
    pushl %esi

    # empilha os parametros
    pushl %esi
    pushl %edi
    call mostra_sistema
    addl $8, %esp

    # desempilha o backup
    popl %esi
    popl %edi

    # aqui o sistema está lido e edi aponta para o começo dos coeficientes e esi para o começo dos resultados

    # backup dos dados
    pushl %edi
    pushl %esi

    pushl %edi
    call calc_det
    addl $4, %esp
    movl %eax, det_princ

    cmpl $0, %eax
    jz erro_det

    # desempilha o backup
    popl %esi
    popl %edi

    # ponteiros em seus lugares e det_princ tem o valor do determinante

    # backup dos dados
    pushl %edi
    pushl %esi

    # copia o vetor de coeficientes para o vetor que será usado para o calculo das outras determinantes
    pushl vet_tam
    pushl coeficientes
    pushl mat_sub
    call memcpy
    addl $12, %esp

    # desempilha o backup
    popl %esi
    popl %edi

    # ponteiros em seus lugares e mat_sub aponta pro vetor copiado

    # backup dos dados
    pushl %edi
    pushl %esi

    # substitui a coluna pelos resultados
    pushl %esi
    pushl $0
    pushl mat_sub
    call substitui_coluna
    addl $12, %esp

    # calcula o Dx
    pushl mat_sub
    call calc_det
    addl $4, %esp
    movl %eax, det_x

    # copia o vetor de coeficientes para o vetor que será usado para o calculo das outras determinantes
    pushl vet_tam
    pushl coeficientes
    pushl mat_sub
    call memcpy
    addl $12, %esp

    # desempilha o backup
    popl %esi
    popl %edi

    # backup dos dados
    pushl %edi
    pushl %esi

    # substitui a coluna pelos resultados
    pushl %esi
    pushl $1
    pushl mat_sub
    call substitui_coluna
    addl $12, %esp

    # calcula o Dy
    pushl mat_sub
    call calc_det
    addl $4, %esp
    movl %eax, det_y

    # copia o vetor de coeficientes para o vetor que será usado para o calculo das outras determinantes
    pushl vet_tam
    pushl coeficientes
    pushl mat_sub
    call memcpy
    addl $12, %esp

    # desempilha o backup
    popl %esi
    popl %edi

    # backup dos dados
    pushl %edi
    pushl %esi

    # substitui a coluna pelos resultados
    pushl %esi
    pushl $2
    pushl mat_sub
    call substitui_coluna
    addl $12, %esp

    # calcula o Dz
    pushl mat_sub
    call calc_det
    addl $4, %esp
    movl %eax, det_z

    movl sol, %edi # move o vetor de soluções pro edi

    # calcula a solução de x
    movl det_x, %eax
    movl det_princ, %ebx
    cltd
    idiv %ebx
    movl %eax, (%edi)

    addl $4, %edi # avança o edi pra próxima posição

    # calcula a solução de y
    movl det_y, %eax
    movl det_princ, %ebx
    cltd
    idiv %ebx
    movl %eax, (%edi)

    addl $4, %edi

    # calcula a solução de z
    movl det_z, %eax
    movl det_princ, %ebx
    cltd
    idiv %ebx
    movl %eax, (%edi)

    subl $8, %edi # volta o edi pro começo do vetor

    # imprime a solução
    pushl %edi
    call mostra_sol
    addl $4, %esp

verifica:
    # Libera ambos os vetores
    call free
    addl $4, %esp

    call free
    addl $4, %esp

    pushl $info_dnv
    call printf
    pushl $clean_buffer
    call scanf
    addl $8, %esp
    call getchar
    cmpl $'s', %eax
    jz inicio

fim:
    pushl $info_fim
    call printf
    addl $4, %esp

    pushl $0
    call exit

erro_det:
    pushl $info_det
    call printf
    add $4, %esp
    jmp verifica
