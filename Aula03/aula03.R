library(tidyverse)
#Extensão do Ggplot2 para fazer o gráfico de mapa de árvore
install.packages("treemapify")
library(treemapify)
#Extensão do ggplot2 para análises de correlação e base happy
install.packages("GGally")
library(GGally)
#Pacote com paleta de cores otimizada
install.packages("viridis")
library(viridis)
# Pacote para gerar correlogramas
install.packages("corrplot")
library(corrplot)

### Gráfico de mapa de árvore ###

# dataset G20 do treemap
g20 <- treemapify::G20

glimpse(g20)

#versao 1 - basica
ggplot(g20, aes(area = gdp_mil_usd, fill = hdi)) +
  treemapify::geom_treemap()

# versao2 - adiciona labels para cada caixa do gráfico
ggplot(g20, aes(area = gdp_mil_usd, fill = hdi, label = country)) +
  treemapify::geom_treemap() +
  treemapify::geom_treemap_text(fontface = "italic",
                                colour = "white",
                                place = "centre",
                                grow = TRUE)

# versao 3 - labels continuas versus discretas
#continua
ggplot(g20, aes(area = gdp_mil_usd, fill = hdi, label = country)) +
  treemapify::geom_treemap() +
  treemapify::geom_treemap_text(fontface = "italic",
                                colour = "white",
                                place = "centre",
                                grow = TRUE) +
  scale_fill_viridis_c()

# versao 3 - labels continuas versus discretas
# discreta
ggplot(g20, aes(area = gdp_mil_usd, fill = region, label = country)) +
  treemapify::geom_treemap() +
  treemapify::geom_treemap_text(fontface = "italic",
                                colour = "white",
                                place = "centre",
                                grow = TRUE) +
  scale_fill_brewer() +
  theme(legend.position = "none") # tira a legenda

#### Gráfico de Heatmap - Mapa de calor ###

glimpse(happy)

#freq absoluta das idades
# pre-processa a base e já plota o heatmap pelo número absoluto
happy %>%
  count(age, year) %>% # conta o num de pessoas por idade por ano
  ggplot(aes(age, year, fill = n)) +
  geom_tile() +
  scale_fill_viridis()

# frequencia relativa das idades
happy %>%
  count(age, year) %>%
  group_by(year) %>%
  mutate(total = sum(n), # conta o total de pessoas por ano
         prop = n / total) %>%
  ggplot(aes(age, year, fill = prop)) +
  geom_tile() +
  scale_fill_viridis()

# faceia o heatmap de acordo com as categorias de happy
happy %>%
  drop_na(happy) %>%
  count(age, year, happy) %>%
  group_by(year, happy) %>%
  mutate(total = sum(n),
         prop = n / total) %>%
  ggplot(aes(age, year, fill = prop)) +
  geom_tile() +
  scale_fill_viridis() +
  facet_grid(.~happy)


### Gráfico de Correlograma ###
m <- cor(mtcars) # correlacao entre todas as variaveis

corrplot(m,method="circle")

corrplot(m, method = "color",
         addCoef.col = "black")

corrplot(m, method = "color",
         addCoef.col = "black")

### Matriz de gráficos ###

# passando a base toda
mtcars %>%
  ggpairs()

# passando só algumas colunas
mtcars %>%
  select(drat:am) %>%
  ggpairs()

# especificando as variáveis categóricas
mtcars %>%
  select(drat:am) %>%
  mutate_at(c("vs", "am"), as_factor) %>%
  ggpairs()
