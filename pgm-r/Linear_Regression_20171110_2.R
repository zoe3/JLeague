###使用ライブラリ
library(dplyr)

###データ読込(結合したデータ)
train<-read.csv("../data/train_new.csv", #読込ファイル
                header=TRUE, #読込データのヘッダー有無
                stringsAsFactors=FALSE #文字列の読込時の型指定(character)
)
test<-read.csv("../data/test_new.csv",
               header=TRUE,
               stringsAsFactors=FALSE)


## 精度を見たいのでホールドアウト法により構築データと検証データに分ける
## 2012-2013年を構築データとし、2014年の前半を検証データとする。

train_train <- train %>%
    dplyr::filter(year < 2014) %>%
    glimpse
## 1357rec

train_test <- train %>%
    dplyr::filter(year == 2014) %>%
    glimpse
## 364 

###使用変数の作成
#変数選択(目的変数, 気温, 収容人数)
lm_train<-dplyr::select(train_train, y, temperature, capa)
lm_test<-dplyr::select(train_test, temperature, capa)

###重回帰分析
#family:目的変数の確率分布とリンク関数の設定(今回は正規分布と恒等写像)
lm<-glm(y ~ ., data=lm_train_train, family=gaussian(link="identity"))

###testに当てはめ
#type="response"でリンク関数を当てはめる前の値が返ってくる
pred<-predict(lm, lm_test, type="response")

#typeが無指定だとリンク関数を当てはめた値が返ってくる
#link="log"であれば, exp(pred)で予測値を返すことができる

result <- data.frame(y <- train_test$y, pred <- as.integer(pred))

## RMSEの計算
sqrt(mean((train_test$y - pred)^2))

temp <- result %>%
    dplyr::mutate(diff = sqrt((y - pred)^2))

hist(temp[[3]], breaks = "Scott")
