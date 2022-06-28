library(tidyverse)

# データの読み込み 
browser = read.csv("./examples/web-browsers.csv")
browser %>% head()

# ------------------------------------------------------------------------------
# nonparametric bootstrap
# ------------------------------------------------------------------------------

B <- 1000 # ブートストラップサンプル数
mub <- c() # 再標本の平均の格納先

for (b in 1:B){
    samp_b = sample.int(nrow(browser), replace=TRUE) # 再標本
    mub <- c(mub, mean(browser$spend[samp_b])) # 再標本の平均を計算して格納
}

sd(mub) # 標本平均の分散
