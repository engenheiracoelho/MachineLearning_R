# importa o arquivo CSV
wbcd <- read.csv("wisc_bc_data.csv", stringsAsFactors = FALSE)

# examina a estrutura do data frame 'wbcd'
str(wbcd)

# remove o ID do data frame
wbcd <- wbcd[-1]

# tabela dos diagnósticos
table(wbcd$diagnosis)

# recodificando o diagnóstico como fator
wbcd$diagnosis <- factor(wbcd$diagnosis, levels = c("B", "M"),
                         labels = c("Bening", "Malignant"))

# tabela ou proporção com rótulos mais informativos
round(prop.table(table(wbcd$diagnosis)) * 100, digits = 1)

# Detalha informações sobre os dados
summary(wbcd[c("radius_mean", "area_mean", "smoothness_mean")])

# Cria uma função normalizadora
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

# teste da função
normalize(c(1, 2, 3, 4, 5))
normalize(c(10, 20, 30, 40, 50))

# normalize the wbcd data
wbcd_n <- as.data.frame(lapply(wbcd[2:31], normalize))

#teste sem normalizar os dados
#wbcd_n <- wbcd[2:31]
# confirma se a normalização funcionou
summary(wbcd_n$area_mean)

## cria dados de treinamento e teste
wbcd_train <- wbcd_n[1:469, ]
wbcd_test <- wbcd_n[470:569, ]

# cria variáveis que receberão as predições
wbcd_train_labels <- wbcd[1:469, 1]
wbcd_test_labels <- wbcd[470:569, 1]

# carrega a biblioteca "classe"
library(class)

wbcd_test_pred = knn(train = wbcd_train, test = wbcd_test, 
                     cl = wbcd_train_labels, k = 21)

# carrega a biblioteca "gmodels"
library(gmodels)

# cria uma tabela cruzada entre as predições e os valores corretos
CrossTable(x = wbcd_test_labels, y = wbcd_test_pred, prop.chisq = FALSE)