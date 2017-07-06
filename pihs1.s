# Trabalho 1 de phis
# Author: Bruno Cesar e Cristofer Oswald
# 6/7/17

# Programa que resolve sistemas de equações lineares de 3 equações com 3 variaveis
# Valores são inteiros. A solução deve ser feita com o uso de matriz.
# Usar Sarrus para descobrir determinante e Cramer para resolver o sistema.
# Deve-se usar malloc para alocar o espaço para a matriz de coeficiente e de resultados
# A entrada deve ser feita pelo teclado, o programa deve mostrar a matriz lida.
# E também os resultados para x1, x2 e x3, ao fim deve perguntar por nova execução

# Um relatório em word deve ser desenvolvido, nele deve ser explicado o funcionamento
# do programa e apontar os problemas no código.

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
# Para aplicar cramer primeiro calculasse a determinante da matriz (D)
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
info1: .asciz "Vamos começar pela leitura dos dados:\n Por favor digite os dados da equação 1:\n"
info2: .asciz "\n\nAgora os dados da equação 2:\n"
info3: .asciz "\n\nE finalmente os dados da equação 3:"
pedx1: .asciz "x1 = "
pedx2: .asciz "x2 = "
pedx3: .asciz "x3 = "
pedres: .asciz "Resultado = "
