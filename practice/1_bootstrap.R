library(tidyverse)

# データの読み込み 
browser = read.csv("./examples/web-browsers.csv")
browser %>% head()

# -----
# 例1 : ブートストラップ標本平均
# -----

B <- 1000 # ブートストラップサンプル数
mub <- c() # 再標本の平均の格納先

for (b in 1:B){
    samp_b = sample.int(nrow(browser), replace=TRUE) # 再標本
    mub <- c(mub, mean(browser$spend[samp_b])) # 再標本の平均を計算して格納
}

sd(mub) # 標本平均の分散


# -----
# 例2 : 線形回帰
# -----

# 通常の線形回帰
linreg <- glm(log(spend) ~ broadband + anychildren, data = browser)
summary(linreg)

# ブートストラップ推定値
B <- 1000
betas <- c()

for (b in 1:B) {
    samp_b <- sample.int(nrow(browser), replace=TRUE) # 再標本
    reg_b <- glm(log(spend) ~ broadband + anychildren, data = browser[samp_b, ]) # 再標本で回帰
    betas <- rbind(betas, coef(reg_b)) # 係数をbetasに格納
}

betas[1:5, ] # はじめの5回の回帰の係数を表示する
