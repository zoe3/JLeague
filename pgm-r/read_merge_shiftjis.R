#使用ライブラリ
library(dplyr)

#データ読込
train<-read.csv("../motodata/train.csv",
                header=TRUE, stringsAsFactors=FALSE, fileEncoding="utf-8")
test<-read.csv("../motodata/test.csv",
               header=TRUE, stringsAsFactors=FALSE, fileEncoding="utf-8")
condition<-read.csv("../motodata/condition.csv",
                    header=TRUE, stringsAsFactors=FALSE, fileEncoding="utf-8")
stadium<-read.csv("../motodata/stadium.csv",
                  header=TRUE, stringsAsFactors=FALSE, fileEncoding="utf-8")
sample<-read.csv("../motodata/sample_submit.csv",
                 header=FALSE, stringsAsFactors=FALSE, fileEncoding="utf-8")

#trainとconditionを対戦カードidを基準に結合
tmp1<-dplyr::left_join(train, condition, by="id")
#testとconditionを対戦カードidを基準に結合
tmp2<-dplyr::left_join(test, condition, by="id")


#結合(基準とする変数名が違うので注意)
train_new<-dplyr::left_join(tmp1, stadium, by=c("stadium" = "name"))
test_new<-dplyr::left_join(tmp2, stadium, by=c("stadium" = "name"))

write.table(train_new, file="../data/train_new.csv",
            quote=FALSE, sep=",", row.names=FALSE, col.names=TRUE)
write.table(test_new, file="../data/test_new.csv",
            quote=FALSE, sep=",", row.names=FALSE, col.names=TRUE)
