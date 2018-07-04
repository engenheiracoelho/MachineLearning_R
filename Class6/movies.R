movies <- read.csv("movies.csv")
str(movies)

table(movies$Comedy)
table(movies$Mystery)

generos <- movies[3:20]

set.seed(12345)
movies_cluster <- kmeans(generos, round(sqrt(nrow(movies)/2)))
movies_cluster$size

movies_cluster$centers

movies$cluster <- movies_cluster$cluster

movies[1:10,]

num_cluster_desejado=subset(movies, Title=="Toy Story (1995)")$X

cluster_desejado = subset(movies, cluster==movies$cluster[num_cluster_desejado])

cluster_desejado$Title[1:10]
