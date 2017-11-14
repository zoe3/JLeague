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

###使用変数の作成
#変数選択(目的変数, 気温, 収容人数)
lm_train<-dplyr::select(train, y, temperature, capa)
lm_test<-dplyr::select(test, temperature, capa)


###重回帰分析
#family:目的変数の確率分布とリンク関数の設定(今回は正規分布と恒等写像)
lm<-glm(y ~ ., data=lm_train, family=gaussian(link="identity"))

###testに当てはめ
#type="response"でリンク関数を当てはめる前の値が返ってくる
pred<-predict(lm, lm_test, type="response")

#typeが無指定だとリンク関数を当てはめた値が返ってくる
#link="log"であれば, exp(pred)で予測値を返すことができる

###submit形式に整える
submit<-data.frame(test[,"id"], pred)

###CSV出力(ヘッダーなし)
write.table(submit, file="../submit/submit_20171110_1_lm.csv",
            quote=FALSE, sep=",", row.names=FALSE, col.names=FALSE)
