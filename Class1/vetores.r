#criacao de vetores e atribuindo valores
subject_name <- c("John Doe", "Jane Doe", "Steve GRaves")
temperature <- c(98.1, 98.6, 101.4)
flu_status <- c(FALSE, FALSE, TRUE)

#acessando elementos do vetor
temperature[2]

temperature[2:3]

temperature[-2]

#retorna valores com retorno TRUE
temperature[c(TRUE, TRUE, FALSE)]

#adiciona vetor de genero
gender <- factor(c("MALE","FEMALE","MALE"))
gender #printa

#adiciona tipo sanguineo
#primeiro sao os dados que contem (amostras) e depois os niveis (tipos)
blood <- factor(c("O", "AB", "A"),
                levels = c("A", "B", "AB", "O")) #rotulos
blood #printa

#adcionando fator de ordenamento
sintomas <- factor(c("SEVERE", "MILD", "MODERATE"),
                  levels = c("MILD", "MODERATE", "SEVERE"),
                  ordered = TRUE)

#verifica sintomas maiores que MODERATE de factor
sintomas > "MODERATE"

#matriz de litas
#caso nao seja especificado, o R converte doas as strings para 
#fatores (variaveis categoricas)
pt_data <- data.frame(subject_name, temperature, flu_status, gender,
                      blood, sintomas, stringsAsFactors = FALSE)

pt_data