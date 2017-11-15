###�g�p���C�u����
library(dplyr)

###�f�[�^�Ǎ�(���������f�[�^)
train<-read.csv("../data/train_new.csv", #�Ǎ��t�@�C��
                header=TRUE, #�Ǎ��f�[�^�̃w�b�_�[�L��
                stringsAsFactors=FALSE #������̓Ǎ����̌^�w��(character)
)
test<-read.csv("../data/test_new.csv",
               header=TRUE,
               stringsAsFactors=FALSE)

###�g�p�ϐ��̍쐬
#�ϐ��I��(�ړI�ϐ�, �C��, ���e�l��)
lm_train<-dplyr::select(train, y, temperature, capa)
lm_test<-dplyr::select(test, temperature, capa)


###�d��A����
#family:�ړI�ϐ��̊m�����z�ƃ����N�֐��̐ݒ�(����͐��K���z�ƍP���ʑ�)
lm<-glm(y ~ ., data=lm_train, family=gaussian(link="identity"))

###test�ɓ��Ă͂�
#type="response"�Ń����N�֐��𓖂Ă͂߂�O�̒l���Ԃ��Ă���
pred<-predict(lm, lm_test, type="response")

#type�����w�肾�ƃ����N�֐��𓖂Ă͂߂��l���Ԃ��Ă���
#link="log"�ł����, exp(pred)�ŗ\���l��Ԃ����Ƃ��ł���

###submit�`���ɐ�����
submit<-data.frame(test[,"id"], pred)

###CSV�o��(�w�b�_�[�Ȃ�)
write.table(submit, file="../submit/submit_20171110_1_lm.csv",
            quote=FALSE, sep=",", row.names=FALSE, col.names=FALSE)