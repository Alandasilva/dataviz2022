#Conjunto de bibliotecas para ciência de dados 
install.packages("tidyverse")
library(tidyverse)


### Base de dados Cars93 ###
install.packages("MASS")
library(MASS)

df <- Cars93 %>% 
  select(Horsepower, Type, AirBags)

glimpse(df)

# Histograma

ggplot(df, aes(x = Horsepower)) +
  geom_histogram(bins = 10, 
                 color = "black", 
                 fill = "darkorchid4") +
  theme_bw() +
  labs(x = "Frequencia", 
       y = "Horsepower", 
       title = "Potencia")

# Gráfico de barras

ggplot(df, aes(x = Type, fill = AirBags)) +
  geom_bar(position = "stack", 
           color = "black") +
  theme_minimal() +
  scale_fill_brewer(palette = "Purples", 
                    direction = 1) +
  coord_flip()

### Base de dados HairEyeColor ###

dfhair <- data.frame(HairEyeColor)

#Box-plot
ggplot(dfhair, aes(x = as.factor(Sex), y = Freq, 
                   fill = Sex)) +
  theme_minimal() +
  geom_boxplot(
    outlier.colour = "black",
    outlier.shape = 8,
    outlier.size = 4
  ) +
  scale_x_discrete(labels = c("Homem", "Mulher")) +
  labs(
    title = "Boxplot",
    x = "Sexo",
    y = "Frequência",
    subtitle = "HairEyeColor"
  ) +
  scale_fill_manual(values = 
                      c("darkorchid4", "brown2"))

### Base de dados mtcars ###

data(mtcars)
glimpse(mtcars)

# Gráfico de dispersão
ggplot(mtcars, aes(mpg, drat)) +
  geom_point() +
  theme_classic() +
  labs(
    title = "Meu gráfico :)",
    subtitle = "Gráfico de Dispersão",
    x = "MPG",
    y = "Drat",
    caption = "Fonte de dados") +
  geom_smooth(method = "lm", se = TRUE, col="red")

### Base de dados do Gapminder ###

install.packages("gapminder")
library(gapminder)

data(gapminder)
glimpse(gapminder)

# Gráfico de bolha
ggplot(
  gapminder, 
  aes(x = gdpPercap, y=lifeExp, size = pop, colour = country)
) +
  geom_point(show.legend = FALSE, alpha = 0.7) +
  scale_color_viridis_d() +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  labs(x = "PIB per capita", y = "Expectativa de vida (anos)")

### Base de dados do mercado financeiro ###

#Pacote que extrai dados do mercado de ações
install.packages("BatchGetSymbols")
library(BatchGetSymbols)

#Definindo ações para extração de dados
empresas <- c('PETR4.SA', 'CIEL3.SA')
#Definindo a minha série de tempo
first.date <- Sys.Date()-90
last.date <- Sys.Date()
#Inserindo os paramentros para extrair o meu dataframe
temp <- BatchGetSymbols(tickers = empresas,
                        first.date = first.date,
                        last.date = last.date, do.cache=FALSE)

meudataset <- temp$df.tickers
glimpse(meudataset)

# Gráfico de linhas
ggplot(meudataset, 
       aes(x = ref.date, 
           y = volume, 
           color = ticker)) +
  geom_line() +
  labs(
    title = "Série Temporal",
    subtitle = "Ações",
    x = "Data",
    y = "Volume de Ações",
    caption = "Fonte: Bovespa"
  ) +
  theme(legend.position = "bottom") +
  scale_x_date(date_breaks = "2 week")