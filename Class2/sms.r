sms_raw <- read.csv("sms_spam.csv", stringsAsFactors = FALSE)

#examina a edtrutura de dados
str(sms_raw)   

#converte para o tipo factor 
sms_raw$type <- factor(sms_raw$type)

#examina o tipo da variavel
str(sms_raw$type)  
table(sms_raw$type)

#biblioteca que manipula palavras com caracteres especiais
library(tm)
#Cria uma coletania de textos armazenada a partir de sms_raw$text
sms_corpus <-VCorpus(VectorSource(sms_raw$text))

#verifica as duas primeiras linhas de sms_corpus
print(sms_corpus)
inspect(sms_corpus[1:2])

#vizualizar as mensagens
as.character(sms_corpus[[1]])
lapply(sms_corpus[1:2], as.character)

#limpa formatacao das msgs (maiusculas, acentos, numerias, conjuncoes...)
sms_corpus_clean <- tm_map(sms_corpus, content_transformer(tolower))

as.character(sms_corpus[[1]])
as.character(sms_corpus_clean[[1]])

#remove numeros
sms_corpus_clean<- tm_map(sms_corpus_clean, removeNumbers)

sms_corpus_clean <- tm_map(sms_corpus_clean, removeWords, stopwords())

#remove pontuacoes
sms_corpus_clean <- tm_map(sms_corpus_clean, removePunctuation)

sms_corpus_clean <- tm_map(sms_corpus_clean, stemDocument)

#elimina espacos a mais
sms_corpus_clean <- tm_map(sms_corpus_clean, stripWhitespace)

lapply(sms_corpus[1:3], as.character)
lapply(sms_corpus_clean[1:3], as.character)

#transformando textos em palavras (DocumentTermMatrix)

sms_dtm <- DocumentTermMatrix(sms_corpus_clean)
sms_dtm

#Criando conjunto de dados para treinamento e teste
sms_dtm_train <- sms_dtm[1:4169, ]
sms_dtm_test <- sms_dtm[4170:5559, ]

sms_train_labels <- sms_raw[1:4169, ]$type
sms_test_labes <- sms_raw[4170:5559, ]$type

#verifica se a proporcao de spam eh similar
prop.table(table(sms_train_labels))
prop.table(table(sms_test_labes))

#vizualizacao em nuvem de palavras
library(wordcloud)
wordcloud(sms_corpus_clean, min.freq = 50, random.order = FALSE)

#separa entre ham e spam
spam <- subset(sms_raw, type == "spam")
ham <- subset(sms_raw, type == "ham")

wordcloud(spam$text, max.words = 40, scale = c(3, 0.5))
wordcloud(ham$text, max.words = 40, scale = c(3, 0.5))

#remove palavras menos frquentes
findFreqTerms(sms_dtm_train, 5)
#salva as mais frequentes em um vetor
sms_freq_words <- findFreqTerms(sms_dtm_train, 5)
str(sms_freq_words)

sms_dtm_freq_train <- sms_dtm_train[ , sms_freq_words]
sms_dtm_freq_test <- sms_dtm_test[ , sms_freq_words]

sms_dtm_freq_train

convert_counts <- function(x){
  x <- ifelse(x > 0, "Yes", "No")
}

#apply() convert_counts() to columns of train/test data
sms_train <- apply(sms_dtm_freq_train, MARGIN = 2, convert_counts)
sms_test <- apply(sms_dtm_freq_test, MARGIN = 2, convert_counts)

#treinando modelo
library(e1071)
sms_classifier <- naiveBayes(sms_train, sms_train_labels)

#predicao dos dados
sms_test_pred <- predict(sms_classifier, sms_test)

library(gmodels)
CrossTable(sms_test_pred, sms_test_labes,
           prop.chisq = FALSE, prop.t = FALSE, prop.r = FALSE,
           dnn = c('predicted', 'actual'))

#utilizando estimador de laplace
sms_classifier2 <- naiveBayes(sms_train, sms_train_labels, laplace = 1)
sms_test_pred2 <- predict(sms_classifier2, sms_test)
CrossTable(sms_test_pred2, sms_test_labes,
           prop.chisq = FALSE, prop.t = FALSE, prop.r = FALSE,
           dnn = c('predicted', 'actual'))