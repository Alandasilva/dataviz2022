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
install.packages("gapminder")
library(gapminder)
# install.packages("devtools")
devtools::install_github("thomasp85/patchwork")
library(patchwork)

### Gráfico de bolhas ###
data(gapminder)
glimpse(gapminder)

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
  scale_fill_viridis()+
  theme_minimal()


# frequencia relativa das idades
df <- happy %>%
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

corrplot(m, order = 'AOE', col = COL2('RdBu', 10))

### Matriz de gráficos ###

# passando a base toda
df_mtcars <- mtcars
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


### Gráfico de cascada ###

#dados
balance <- data.frame(event =
                        c("Starting\nCash", "Sales", "Refunds",
                          "Payouts", "Court\nLosses", "Court\nWins", "Contracts", "End\nCash"),
                      change = c(2000, 3400, -1100, -100, -6600, 3800, 1400, 2800))

# o saldo depois de cada movimentacão financeira, usado para traçar o ponto de partida da barra
balance$balance <- cumsum(c(0, balance$change[-nrow(balance)]))
# o tempo em que cada movimentacao financeira foi feita, para mantermos a ordem delas
balance$time <- 1:nrow(balance)
# a direcao do fluxo financeiro: aumento ou diminuicao
balance$flow <- factor(sign(balance$change))


ggplot(balance) +
  geom_rect(aes(xmin = time - 0.45, xmax = time + 0.45,
                ymin = balance, ymax = balance + change, fill = flow)) +
  geom_text(aes(x = time, y = pmin(balance, balance + change) - 50, label = paste0("$",change))) +
  scale_y_continuous("Balance", labels=scales::dollar_format()) +
  theme(legend.position = "none")

# usando o pacote waterfall que simplifica bastante a criacão desse gráfico

balance <- data.frame(event =
                        c("Starting\nCash", "Sales", "Refunds",
                          "Payouts", "Court\nLosses", "Court\nWins", "Contracts", "End\nCash"),
                      change = c(2000, 3400, -1100, -100, -6600, 3800, 1400, 2800))

#install.packages("waterfalls")
library(waterfalls)
waterfall(balance)
waterfall(balance, calc_total = TRUE)

waterfall(balance, calc_total = TRUE) +
  labs(title = "Fluxo de caixa",
       subtitle = "Fevereiro de 2022",
       x = "Descrição",
       y = "Balanço") +
  theme_minimal()

### Pacote patchwork ####

df <- mtcars
p <- ggplot(df)

a <- p +
  aes(mpg, disp, col = as.factor(vs)) +
  geom_smooth(se = F) +
  geom_point()

b <- p +
  aes(disp, gear, group = gear) +
  geom_boxplot()

c <- p +
  aes(hp) +
  stat_density(geom = "area") +
  coord_cartesian(expand = 0)

# adiciona ggplots adicionando-os com +
a + b + c

# | especifica adição lado a lado
a | c

# / é para adicionar gráficos sob o gráfico anterior
b / c

# usando parênteses para agrupar gráficos e +, | e / para adicionar os grupos
(a | b) / c

# usando parênteses para agrupar gráficos e +, | e / para adicionar os grupos
(a | b) / c +
  plot_annotation(tag_levels = "A") &
  theme(legend.position = "none")