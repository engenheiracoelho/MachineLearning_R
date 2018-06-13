wine = read.csv("wine.csv")
model1 = lm(Price ~ AGST, data=wine)
summary(model1)

model2 = lm(Price ~ AGST + HarvestRain, data=wine)
summary(model2)

model3 = lm(Price ~ AGST + HarvestRain + WinterRain, data=wine)
summary(model3)

model4 = lm(Price ~ AGST + HarvestRain + WinterRain + Age + FrancePop, data=wine)
summary(model4)

# retirando todas as variáveis não significativas de uma vez
model5 = lm(Price ~ AGST + HarvestRain + WinterRain, data=wine)
summary(model5)

# retirando as variáveis que não são significativas (Retirar uma variável por vez)
model6 = lm(Price ~ AGST + HarvestRain + WinterRain + Age, data=wine)
summary(model6)

# calculando a correlação de todas as variáveis em wine
cor(wine) # pode observar que este modelo tem um problema de multicolinearidade, ou seja, 
# existe pelo menos duas variáveis que são muito correlacionadas no conjunto de dados.
