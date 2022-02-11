library(tidyverse)
library(patchwork)

# Usando a base de dados mtcars, gere os seguintes gráficos:

# Um gráfico de boxplot com as variaveis gear no eixo x, disp no eixo y e group = gear.
# Esse gráfico deve ser salvo na variável p1.
# p1 <- ggplot(mtcars) + geom_boxplot(aes(gear, disp, group = gear))

# Um gráfico de dispersao das variaveis mpg no eixo x e disp no eixo y.
# Esse gráfico deve ser salvo na variável p2.

p2 <- ggplot(mtcars, aes(x = mpg, y = disp)) + geom_point()
p2

# Um gráfico usando o geom_smooth para ajustar uma curva para as informacões de
# disp no eixo x e qsec no eixo y.
# Esse gráfico deve ser salvo na variável p3


# Um gráfico de barras da coluna carb
# Esse gráfico deve ser salvo na variável p3


# Com o pacote patchwork gere uma visualizacao de dados em que os gráficos salvos
# nas variaveis p1, p2 e p3 fiquem lado a lado e o gráfico salvo na variável p4
# fique logo abaixo deles.



