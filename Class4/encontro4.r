#### Linear Regression -------------------


## Example: Predicting Medical Expenses ----
## Step 2: Exploring and preparing the data ----
insurance <- read.csv("insurance.csv", stringsAsFactors = TRUE)
str(insurance)

# tables
table(insurance$region)
table(insurance$sex)
table(insurance$smoker)

# exploring relationships among features: correlation matrix
cor(insurance[c("age", "bmi", "children", "expenses")])

# visualing relationships among features: scatterplot matrix
pairs(insurance[c("age", "bmi", "children", "expenses")])

# more informative scatterplot matrix
library(psych)
pairs.panels(insurance[c("age", "bmi", "children", "expenses")])

## Step 3: Training a model on the data ----
ins_model <- lm(expenses ~ age + children + bmi + sex + smoker + region,
                data = insurance)
ins_model <- lm(expenses ~ ., data = insurance) # this is equivalent to above

# see the estimated beta coefficients
ins_model

## Step 4: Evaluating model performance ----
# see more detail about the estimated beta coefficients
summary(ins_model)
