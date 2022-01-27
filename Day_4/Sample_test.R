### 배운거 연습문제 ###
#############################
### read.csv로 한글이 있는 자료 open
getwd()
setwd('C:/Sources/Study_R/Day_4')

df=read.csv('./data_r/cust_order_data.csv',sep='\t',encoding='ANSI',stringsAsFactor = TRUE)
df=read.csv('./data_r/cust_order_data.csv',sep='\t',encoding='ANSI')
#############################
help(read.csv)

tmp = data.frame(table(df[,1]))

head(tmp) #Freq는 횟수

summary(tmp$Freq)
boxplot(tmp$Freq)

table(df[,3])

boxplot(df[,16])


tmp = df$GOODS_NAME
tmp[tmp=='#NAME?'] = NA #NAME? NA값 바꾸기
str(tmp) #아직 #NAME? 이 남아있다고 뜸

subset(tmp,tmp=='#NAME?')


# 날짜 데이터의 경우
# 년-월-일 이라는date타입
# 근데 데이터를 받을땐 20121013이나 2012. 12. 02 처럼 올 수 있음

#팩터 안의 레벨값은 안바뀜, 그래서 캐릭형으로 변경 후 재작업
tmp1=as.factor(as.character(tmp))
str(tmp1)


## [문제 1-1] 데이터 읽기전 메모리 모두 제거 ##

# 메모리 제거
rm(list=ls())
# 메모리상에 존재하는 변수 확인 
ls()[]


## [문제 1-2] 총데이터의 갯수와 변수 성격 확인 ##

# 총 데이터 갯수 (행과 열의 갯수 확인)
length(df)
ncol(df)
nrow(df)

# 각 변수의 데이터 타입 확인
str(df)

# 위로 3개의 데이터만 읽기
head(df,3)

# 변수명(필드명)만 출력
for(i in 1:ncol(df)){
	print(names(df[i]))
	}


## 문제 1-3 아래의 2개 변수(필드)외에 나머지 변수에 대하여 해석

# CUST_SERIAL_NO: 고객번호 / SEX: 고객성별 / AGE: 고객나이 / REG_DATE: 등록일자
# ORDER_DATE: 주문날짜 / ORDER_HOUR: 주문시간 / ORDER_WEEKDAY: 주문요일
# IS_WEEKEND: 주문한날이 주말인가? / GOODS_CODE: 상품코드
# LGROUP: 대분류 / MGROUP: 중분류 / SGROUP: 소분류 / DGROUP: 
# GOOD_NAME: 상품명 / PRICE: 상품가격 / QTY: 구매건수


## 문제 2-1 결측치 확인

# df의 전체 결측치 갯수 확인
sum(is.na(df))

# 각 변수별 결측치 갯수 확인
colSums(is.na(df))


## 문제 2-2 결측치 활용법

# GOODS_NAME값의 '#NAME?'를 NA로 대체하고 제거 하기 위하여
# df$GOODS_NAME을 summary 하여서 #NAME?가 있는지를 확인하여 봄
summary(df$GOODS_NAME) # 데이터 받아올때 Factor로 안받아 오면 안나옴
data.frame(summary(df$GOODS_NAME))

# df$GOODS_NAME 에 자료가 '#NAME?' 인 자료만
# subset으로 추출하여서 제거해도 되는 자료인지 확인하여 봄
subset(df,df$GOODS_NAME=='#NAME?')

# df$GOODS_NAME의 '#NAME?' 인 자료를 'NA' 로 변환하기전
# df$GOODS_NAME 의 NA갯수 확인
sum(is.na(df$GOODS_NAME))

# df$GOODS_NAME의 값이 #NAME?  인 자료에 NA값 할당
df$GOODS_NAME[df$GOODS_NAME=='#NAME?'] <- NA
# 아마 df$GOODS_NAME = [df$GOOOD_NAME != NA,] 도 될듯? NA위치에 '문자'는 되는데

# df$GOODS_NAME 의 NA갯수 재확인
sum(is.na(df$GOODS_NAME))

# 결측치 시각화
library(Amelia)
data.frame(df$GOODS_NAME)
































# END