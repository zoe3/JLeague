## 欠損データの追加
## 使用ライブラリ
library(dplyr)

#データ読込
train <- read.csv("../motodata/train.csv",
                  header=TRUE, stringsAsFactors=FALSE, fileEncoding="utf-8")
train_add <- read.csv("../motodata/train_add.csv",
                      header=TRUE, stringsAsFactors=FALSE, fileEncoding="utf-8")
train <- rbind(train, train_add)

test <- read.csv("../motodata/test.csv",
                 header=TRUE, stringsAsFactors=FALSE, fileEncoding="utf-8")
test_add <- read.csv("../motodata/2014_add.csv",
                 header=TRUE, stringsAsFactors=FALSE, fileEncoding="utf-8")
test <- rbind(test,test_add)

condition <- read.csv("../motodata/condition.csv",
                      header=TRUE, stringsAsFactors=FALSE, fileEncoding="utf-8")
condition_add <- read.csv("../motodata/condition_add.csv",
                      header=TRUE, stringsAsFactors=FALSE, fileEncoding="utf-8")
condition <- rbind(condition, condition_add)

stadium<-read.csv("../motodata/stadium.csv",
                  header=TRUE, stringsAsFactors=FALSE, fileEncoding="utf-8")
sample<-read.csv("../motodata/sample_submit.csv",
                 header=FALSE, stringsAsFactors=FALSE, fileEncoding="utf-8")

str(sample)

str(test)


str(train)

head(train, n=5)

str(test)

str(condition)

head(condition)

str(stadium)

head(stadium, n=5)

str(sample)

anyNA(train)

table(train$stage)

table(train$match)

min(train$id)

max(train$id)

hist(train$y)

table(train$year)

#trainとconditionを対戦カードidを基準に結合
tmp1<-dplyr::left_join(train, condition, by="id")
#testとconditionを対戦カードidを基準に結合
tmp2<-dplyr::left_join(test, condition, by="id")

## 結合したデータをさらにstadiumとスタジアムを基準に結合
## 基準とする変数のチェック
length(unique(train$stadium))

length(unique(stadium$name))

tmp <- anti_join(stadium, tmp1, by=c("name"="stadium"))

print(tmp)

train %>%
    dplyr::filter(grepl("長崎", stadium))


#結合(基準とする変数名が違うので注意)
train_new<-dplyr::left_join(tmp1, stadium, by=c("stadium" = "name"))
test_new<-dplyr::left_join(tmp2, stadium, by=c("stadium" = "name"))

write.table(train_new, file="../data/train_new.csv",
            quote=FALSE, sep=",", row.names=FALSE, col.names=TRUE)
write.table(test_new, file="../data/test_new.csv",
            quote=FALSE, sep=",", row.names=FALSE, col.names=TRUE)
