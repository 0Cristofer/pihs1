# Trabalho 2 de pihs
# Author: Bruno Cesar e Cristofer Oswald
# 07/08/2017

# Programa que resolve sistemas de equações lineares de N equações com N variaveis

.section .data
titulo:  .asciz "*** Super solucionador de sistemas lineares NxN!!! ***\n"
info1:   .asciz "Vamos começar pela leitura dos dados:\nPor favor insira a ordem (N) da matriz: "
info2:   .asciz "\n\nInsira os dados da equação %d:\n"
infomem: .asciz "\nTotal de memória alocada:\n %d (Matriz entrada) + %d (resultados) + %d (determinantes)\n"
pedex:   .asciz "x%d = "
infosis: .asciz "\nO sistema montado foi\n"
virgula: .asciz " , "
abre:    .asciz "["
fecha:   .asciz "]"
igual:   .asciz " = %d\n"
pedres:  .asciz "Resultado = "
formaint: .asciz "%d"
espaco:   .asciz " "
solucao:  .asciz "Solução: %d\n"
debug_linha:  .asciz "\ndebug: %d\n"
debug_valor:  .asciz "\nvalor: %d\n"
info_fim:     .asciz "Fim da execução!\n"
info_dnv:     .asciz "Deseja executar novamente? (s/n)"
clean_buffer: .string "%*c"
info_det:     .asciz "Impossível resolver, determinante é igual a 0\n"
debug_reduz:  .asciz "Entrou no reduz \n"
debug_laplace: .asciz "Entrou no la place \n"
debug_sarrus: .asciz "Entrou no sarrus \n"
det_princ_s:  .asciz "Determinante principal: %d\n"
det_int_s:    .asciz "Determinante-%d = %d \n"
n:            .int 0 # ordem da matriz
coeficientes: .int 0 # Matriz entrada
reduzida:     .int 0 # Matriz reduzida
i:            .int 1
j:            .int 1
i1:           .int 1
j1:           .int 1
dnv:          .int 0 # input sobre repetir
resultados:   .int 0 # vetor de resultados
determinantes: .int 0 # vetor de determinantes
mat_sub:      .int 0
val_linha:    .int 0
sol:          .int 0
num_col:      .int 0
det_princ:    .int 0
det_tam:      .int 0 # * n
vet_tam:      .int 4 # * n * n  (Size of int)
reduz_tam:    .int 0
res_tam:      .int 0 # * n
aux_ordem:    .int 0 # auxiliar ordem redução

.section .text
.globl main
main:
    jmp inicio

# calcula o determinante de uma matriz NxN. Recebe o ponteiro pro vetor (matriz) como parametro e a ordem da matriz
# retorna o determinante por eax
la_place:
    pushl %ebp # salva o ponteiro base
    movl %esp, %ebp # substiui o ponteiro do frame

    addl $8, %ebp # le o vetor
    movl (%ebp), %edi # move o parametro pro edi
    addl $4, %ebp # le a ordem
    movl (%ebp), %ebx # move o parametro pro edx

    cmpl $3, %ebx
    je calc
    movl %ebx, %ecx
    movl $0, %eax
    movl $1, j
    jne diminui

volta:
    popl %ebp # volta o ponteiro base
    ret

calc:
    pushl %edi
    pushl %ebx

    pushl %edi
    call sarrus
    addl $4, %esp

    popl %ebx
    popl %edi
    jmp volta

diminui:
    pushl %ebx
    pushl %eax
    pushl %edi # backup
    pushl j

    pushl %ebx
    pushl %ecx

    pushl %ebx
    pushl j
    pushl i
    pushl %edi
    call reduz
    addl $16, %esp

    popl %ecx
    popl %ebx
    pushl %ecx
    pushl %esi

    addl $-1, %ebx
    pushl %ebx
    pushl %esi
    call la_place
    addl $8, %esp
    popl %esi
    popl %ecx
    popl j
    pushl %ecx
    pushl %eax # backup do valor do determinante da matriz reduzida
    jmp cont

loopi:
    loop diminui
    jmp volta

cont:
    # Verificando se soma ou subtrai
    movl j, %eax
    andl $1, %eax
    jnz impar

par:
    movl $-1, %eax # Se for par então subtrai
    jmp continua

impar:
    movl $1, %eax # Se for impar então soma

continua:
    popl %edx
    popl %ecx
    popl %edi
    pushl %edi
    pushl %ecx


    # recupero o determinante e multiplico pelo resultado da potencia
    mul %edx

    pushl %ebx
    pushl %eax

    addl $-1, j
    movl j, %eax
    movl $4, %ebx
    mul %ebx
    addl %eax, %edi

    popl %eax
    popl %ebx

    # move o valor do elemento da matriz e multiplica pelo cofator
    movl (%edi), %ebx
    mul %ebx

    popl %ecx

    # recupera o valor da linha anterior e soma com a atual
    popl %edi
    popl %edx
    addl %edx, %eax

    # anda na matriz
    popl %ebx
    addl $2, j

    jmp loopi


# Reduz em 1 a ordem da matriz recebida
# Recebe a matriz, i e j do elemeto a ser ignorado, e a ordem da matriz
# retorna a matriz por %esi
reduz:
    pushl %ebp # salva o ponteiro base
    movl %esp, %ebp # substiui o ponteiro do frame

    addl $8, %ebp # le a matriz
    movl (%ebp), %edi # move o parametro pro edi
    addl $4, %ebp # i
    movl (%ebp), %eax # move o parametro pro edx
    addl $4, %ebp # j
    movl (%ebp), %ebx # move o parametro pro edx
    addl $4, %ebp # ordem
    movl (%ebp), %edx # move o parametro pro edx

    # backup
    pushl %edi # Matriz
    pushl %eax # i
    pushl %ebx # j
    pushl %edx

    addl $-1, %edx

    pushl %edx

    movl $4, %eax
    pushl %edx
    mul %edx
    pop %edx
    mul %edx
    movl %eax, reduz_tam # reduz_tam tem agora 4 * n-1 * n-1 = tamanho da matriz reduzida (em bytes)

    # Aloca a matriz
    pushl reduz_tam
    call malloc
    addl $4, %esp
    movl %eax, reduzida
    movl reduzida, %esi

    # Recupera backup
    popl %edx # ordem -1
    popl %ecx # ordem
    popl %ebx
    popl %eax
    popl %edi

    # Ecx tem a ordem da nova matriz
    movl $1, i1
    movl $1, j1

    movl %ecx, aux_ordem
fori:
    cmpl i1, %eax
    je pula
    pushl %eax # salva noti
    pushl %ecx # salva loopi
    movl aux_ordem, %ecx

forj:
    cmpl j1, %ebx
    je pula2
    movl (%edi), %eax
    movl %eax, (%esi)
    addl $4, %esi

pula2:
    incl j1
    addl $4, %edi
    loop forj
    popl %ecx # rec loopi
    jmp fimi

pula:
    movl aux_ordem, %edx
    pushl %eax # bk noti
    movl $4, %eax
    mul %edx
    addl %eax, %edi

fimi:
    popl %eax # rec noti
    incl i1
    movl $1, j1
    loop fori

    movl reduzida, %esi

    popl %ebp
    ret


# calcula o determinante de uma matriz. recebe o pontiro pro vetor da matriz como parametro
# e "retorna" o determinante a partir do registrador eax
sarrus:
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
    addl %ecx, %edi # coloca o ponteiro do vetor (matriz) no elemento inicial
    movl n, %ecx

subs:
    # substitui o primeiro valor
    movl (%esi), %ebx # move o valor do vetor de resultados no ebx
    movl %ebx, (%edi) # substitui o valor apontado por edi pelo valor de ebx

    addl $4, %esi # avança para o próximo resultado

    movl n, %eax
    movl $4, %edx
    mul %edx
    addl %eax, %edi # pula pra próxima linha

    loop subs

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

    movl n, %ecx # Contador do loop
    movl $1, %ebx # Contador para o print

loop_le_var:
        # backups
        pushl %ebx
        pushl %ecx
        pushl %edi

        # Le a linha x
        pushl %ebx
        pushl $pedex
        call printf
        addl $8, %esp

        pushl %edi
        pushl $formaint
        call scanf
        addl $8, %esp

        # Recupera os backups
        popl %edi
        popl %ecx
        popl %ebx

        addl $4, %edi # move o ponteiro pra poxima posição
        addl $1, %ebx

    loop loop_le_var

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

    pushl %esi
    pushl %edi

    # [
    pushl $abre
    call printf
    addl $4, %esp

    popl %edi

    movl n, %ecx # Contador de loop

loop_print:
        pushl %ecx
        pushl %edi

        # Printa o valor
        pushl (%edi)
        pushl $formaint
        call printf
        addl $8, %esp

        # Printa " , "
        pushl $virgula
        call printf
        addl $4, %esp

        popl %edi
        addl $4, %edi # Anda o vetor pra próxima posição

        popl %ecx

    loop loop_print

    # ]
    pushl $fecha
    call printf
    addl $4, %esp

    popl %esi

    # Printa o resultado
    pushl (%esi)
    pushl $igual
    call printf
    addl $8, %esp

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

    movl n, %ecx # Contador de loop

    loop_printa_linha:
        # faz novo backup
        pushl %ecx
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
        popl %ecx

        addl res_tam, %edi # pula pra proxima linha

        addl $4, %esi # pula pro proximo resultado

        loop loop_printa_linha

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

# Recebe o ponteiro para a matriz
le_sistema:
    pushl %ebp # salva o ponteiro base
    movl %esp, %ebp # substiui o ponteiro do frame

    addl $8, %ebp # le o vetor
    movl (%ebp), %edi # move o parametro pro edi

    addl $4, %ebp # le o vetor
    movl (%ebp), %esi # move o parametro pro edi

    movl $1, %eax # Contador de linhas para o print
    movl n, %ecx # Contador de loops

loop_le_linha:
        pushl %eax
        pushl %ecx
        pushl %edi
        pushl %esi

        # Printa mensagem de "Insira linha X:"
        pushl %eax
        pushl $info2
        call printf
        addl $8, %esp

        # empilha os parametros
        pushl %esi
        pushl %edi
        call le_linha
        addl $8, %esp

        # desempilha o backup
        popl %esi
        popl %edi
        popl %ecx
        popl %eax

        addl res_tam, %edi # pula pra próxima linha
        addl $4, %esi # pula pro próximo campo

        addl $1, %eax

    loop loop_le_linha

    popl %ebp
    ret

# Main
inicio:
    movl $3, n

    pushl $titulo
    call printf
    addl $4, %esp

    pushl $info1
    call printf
    addl $4, %esp

    pushl $n
    pushl $formaint
    call scanf
    addl $8, %esp

    movl n, %ebx
    movl vet_tam, %eax # vet_tam inicia com 4 (size of int)
    mul %ebx
    movl %eax, res_tam # res_tam tem agora 4 * n
    movl %eax, det_tam # det_tam tem agora 4 * n
    mul %ebx
    movl %eax, vet_tam # vet_tam tem agora 4 * n * n = tamanho da matriz (em bytes)

    # Aloca a matriz
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

    pushl res_tam
    call malloc
    addl $4, %esp
    movl %eax, determinantes

    # Printa informações sobre memoria alocada
    pushl res_tam
    pushl det_tam
    pushl vet_tam
    pushl $infomem
    call printf
    addl $16, %esp

    # aloca o vetor de coeficientes substituidos
    movl vet_tam, %ecx
    pushl %ecx
    call malloc
    addl $4, %esp
    movl %eax, mat_sub

    # aloca o vetor da solução
    movl res_tam, %ecx
    pushl %ecx
    call malloc
    addl $4, %esp
    movl %eax, sol

    # backups
    pushl %esi
    pushl %edi

    pushl %esi
    pushl %edi
    call le_sistema
    addl $8, %esp

    # recupera backup
    popl %edi
    popl %esi

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

    pushl n
    pushl %edi
    call la_place
    addl $8, %esp
    movl %eax, det_princ

    cmpl $0, %eax
    jz erro_det

    # Printa o determinante principal
    pushl det_princ
    pushl $det_princ_s
    call printf
    addl $8, %esp

    # desempilha o backup
    popl %esi
    popl %edi

    # ponteiros em seus lugares e det_princ tem o valor do determinante

    movl n, %ecx
    pushl determinantes
calc_dets:
    # backup dos dados
    pushl %ecx
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
    pushl num_col
    pushl mat_sub
    call substitui_coluna
    addl $12, %esp

    # calcula o Dn
    pushl n
    pushl mat_sub
    call la_place
    addl $8, %esp
    movl determinantes, %edi
    movl %eax, (%edi)

    # Printa os determinantes intermediários
    pushl %eax
    pushl num_col
    pushl $det_int_s
    call printf
    addl $12, %esp

    incl num_col
    addl $4, %edi
    movl %edi, determinantes

    popl %esi
    popl %edi
    popl %ecx

    loop calc_dets

    popl determinantes

    movl n, %ecx
calc_res:
    pushl %ecx

    movl determinantes, %edi

    # calcula a solução de n
    movl (%edi), %eax
    movl det_princ, %ebx
    cltd
    idiv %ebx

    addl $4, determinantes

    pushl %eax
    pushl $solucao
    call printf
    addl $8, %esp

    popl %ecx
    loop calc_res

verifica:
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
