# データの読み込み
data("airquality")
airquality

# 通常の回帰
fit <- glm(Ozone ~ ., data=airquality)
summary(fit)

# HC回帰
library(AER)
bvar <- vcovHC(fit)
round(bvar, 1)

sqrt(bvar['Wind', 'Wind'])

# bootstrap
B <- 10000
beta <- vector(length = B)
n <- nrow(airquality)

for(b in 1:B){
    bs = sample.int(n, n, replace = TRUE)
    bsfit <- lm(Ozone ~ ., data=airquality, subset = bs)
    beta[b] <- coef(bsfit)['Wind']
}

sd(beta)
