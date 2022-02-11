library(tidyverse)
library(waterfalls)

# O conjunto de dados salvo no objeto salao, contém dados a respeito do fluxo de
# caixa de um salão de cabeleleiros. Com esses dados, gere um gráfico de cascata
# que mostre o fluxo de despesas desse salão. Use o pacote waterfalls.

salao <- data.frame(
  months =
    c(
      "Saldo\nAtual",
      "Cortes",
      "Escovas",
      "Coloracao",
      "Contas",
      "Manicure",
      "Fornecedores",
      "Aluguel"
    ),
  amount = c(1000, 500, 400, 800, 400, 500,-350,-1000)
)


waterfall(salao, calc_total = TRUE) +
  labs(title = "Fluxo de caixa",
       subtitle = "Fevereiro de 2022",
       x = "Descrição",
       y = "Balanço") +
  theme_minimal()

# Utilize o parametro calc_total = TRUE, o que acontece? Adicione  o título
# "Fluxo de caixa", subtítulo "fevereiro de 2022" e as legendas "Descrição" e
# "Balanço" nos eixos x e y, respectivamente.
