#### Linear Regression -------------------

## Example: Predicting Medical Expenses ----
## Step 2: Exploring and preparing the data ----
insurance <- read.csv("insurance.csv", stringsAsFactors = TRUE)
insurance$age2 <- insurance$age^2
insurance$sex2 <- insurance$sex^2
insurance$children2 <- insurance$children^2
insurance$bmi30 <- ifelse(insurance$bmi >= 30,1,0)
str(insurance)

# tables
table(insurance$region)
table(insurance$sex)
table(insurance$smoker)
table(insurance$expenses) #Type of data

# exploring relationships among features: correlation matrix, correlation between 2 features
cor(insurance[c("age", "bmi", "children", "expenses")])

# visualing relationships among features: scatterplot matrix
pairs(insurance[c("age", "bmi", "children", "expenses")])

# more informative scatterplot matrix
library(psych)
pairs.panels(insurance[c("age", "bmi", "children", "expenses")])

## Step 3: Training a model on the data ----
ins_model <- lm(expenses ~ age2 + age + region + children  + children2 + bmi30 + bmi+ sex*smoker + sex2 + smoker*bmi30 + region,
                data = insurance)
#ins_model <- lm(expenses ~ ., data = insurance) # this is equivalent to above

# see the estimated beta coefficients
ins_model

## Step 4: Evaluating model performance ----
# see more detail about the estimated beta coefficients
summary(ins_model)

