# Pacotes a serem usados
library(tidyverse)

# Importa o arquivo csv para o objeto df_titanic
df_titanic <- read_csv("../Dados/titanic.csv")

# Seleciona os sobreviventes.
df_titanic %>% filter(sobreviveu == "sim")

# Cria um objeto e atribui a ele as linhas com os sobreviventes.
sobreviventes <- df_titanic %>% filter(sobreviveu == "sim")

# Crianças com menos de 12 anos que sobreviveram.
criancas_sobreviventes <- df_titanic %>% 
  filter(sobreviveu == "sim" & idade < 12)

# Embarque realizado nos locais: Southampton ou Queenstow.
embarque <- df_titanic %>% filter(embarque == "Southampton" |
                                    embarque == "Queenstow")

# A instrução acima pode ser reescrita com o operador %in%:
embarque <- df_titanic %>% filter(embarque %in% c("Southampton", "Queenstow"))

# Pessoas sem informação de local de embarque.
# is.na() - função que retorna TRUE se o valor for NA e FALSE se não for.
sem_embarque <- df_titanic %>% filter(is.na(embarque))

# Pessoas que tem "Elizabeth" em qualquer posição do campo nome.
# str_detect - função que retorna TRUE se detectou o valor dado e 
# FALSE, caso não tenha encontrado.
nome <- df_titanic %>% filter(str_detect(nome, "Elizabeth"))

# Ordena por ordem crescente da coluna nome.
passageiros_ordenados <- df_titanic %>% arrange(nome)
passageiros_ordenados

# Seleciona as colunas indicadas.
df_titanic %>% select(nome, idade, classe, embarque)

# Altera a coluna tarifa para o valor da tarifa em reais.
tarifa_conversao <- df_titanic %>% mutate(tarifa = tarifa * 5.37)

# Retorna a coluna tarifa para o valor da época.
tarifa_conversao <- df_titanic %>% mutate(tarifa = tarifa / 5.37)

# Calcula a média da variável idade
# na.rm = TRUE remove os NAs
df_titanic %>% summarize(mean(idade, na.rm=TRUE))

# Calcula: número de mulheres, mediana geral da tarifa e número de passageiros.
# No caso abaixo a função sum() retorna o número de mulheres. 
# A função n() mostra o número de linhas (em cada grupo) e 
# costuma ser bastante usada com o summarize.
df_titanic %>% 
  summarize(
    mulheres = sum(sexo == "feminino", na.rm = TRUE),
    mediana_tarifa = median(tarifa, na.rm = TRUE),
    num_passageiros = n())

# Agrupa pela variável sobreviveu e calcula
# o número de passageiros por grupo (sim/nao).
df_titanic %>% 
  group_by(sobreviveu) %>% 
  summarize(num_passageiros = n())

# Agrupa pelo local de embarque e calcula a mediana da tarifa de cada grupo.
df_titanic %>% 
  group_by(embarque) %>% 
  summarize(mediana_tarifa = median(tarifa, na.rm = TRUE))

