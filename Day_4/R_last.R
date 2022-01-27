### 배운거 연습문제 ###
#############################
### read.csv로 한글이 있는 자료 open
getwd()
setwd('C:/Sources/Study_R/Day_4')

ls()
rm(list=ls())

df=read.csv('./data_r/cust_order_data.csv',sep='\t',encoding='ANSI',stringsAsFactor = TRUE)
df=read.csv('./data_r/cust_order_data.csv',sep='\t',encoding='ANSI')



# CUST_SERIAL_NO: 고객번호 / SEX: 고객성별 / AGE: 고객나이 / REG_DATE: 등록일자
# ORDER_DATE: 주문날짜 / ORDER_HOUR: 주문시간 / ORDER_WEEKDAY: 주문요일
# IS_WEEKEND: 주문한날이 주말인가? / GOODS_CODE: 상품코드
# LGROUP: 대분류 / MGROUP: 중분류 / SGROUP: 소분류 / DGROUP: 
# GOOD_NAME: 상품명 / PRICE: 상품가격 / QTY: 구매건수



# 일부 데이터에 값이 아닌 *가 들어가 있는 경우가 있어서 사용할 수 없는 데이터는 제거한다.
df <- df[df$SEX != "*",]

tail(df$SEX)
# 계속 *이 factor상태에선 레벨단위에 남아있어서 char형으로 바꿨다가 돌리기
df$SEX=as.factor(as.character(df$SEX))

str(df)
data.frame(head(df,10))

#구매일자, 성별, 구매 건수만 추출하여 별도의 데이터 프레임을 만든다.
sex1 = subset(df, select=c(ORDER_DATE,SEX,QTY))
head(sex1)
str(sex1)

# 구매일자에서 월 정보만 추출하기 위한 lubridate 라이브러리를 설치한다
install.packages('lubridate')
library(lubridate)


# ORDER_DATE 열에 저장되어 있는 날짜를 이용하여 month 함수로
# 월만 추출해서 month 라는 새로운 열을 추가한다. 
sex2 = cbind(sex1, month=month(sex1$ORDER_DATE))
head(sex2,5)

# 데이터 조작을 위해 reshape2 라이브러리를 설치한다.
install.packages('reshape2')
library(reshape2)

# 성별로 구분하여 월별 구매 건수의 총합을 구해서 확인한다.
dcast(sex2, SEX ~ month, value.var = 'QTY', sum)


# F나 M 대신 female, male이라고 표시하기 위해서
# 변환 함수를 만들어서 적용하여 gender라는 열을 추가한다
# 아니 왜 전부 female이 되냐
changeGender <- function(x){ 
	if (x[2] == "M") {
		return('male') 
	}
	else {
		return('female') 
	}
}
str(sex2)
sex2$gender = apply(sex2,2,changeGender)
table(sex2$gender)
tail(sex2)


### 화면 출력 ###
library(ggplot2)

# 성별 별로 월별 구매 건수를 누적 막대 그래프로 표시한다
# 결과가 이상한거 같기도하고
qplot(month,data=sex2,geom='bar',fill=SEX)

#이거는 왜 맞지
ggplot(sex2,aes(month))+geom_bar()+facet_wrap(~SEX)


## 연령대 구매 건수

#구매일자, 나이, 구매 건수 만 추출하여 별도의 데이터 프레임을 만든다.
age1 <- subset(df, select=c(ORDER_DATE,AGE,QTY))
head(age1)

# ORDER_DATE 열에 저장되어 있는 날짜를 이용하여 month 함수로
# '월만 추출'해서 month 라는 새로운 열을 추가한다. 

# cbind()는 column bind의 약자입니다.  
# cbind()도 열 결합을 하려고 하면 서로 결합하려는 두 데이터셋의 관측치가
# 행이 서로 동일 대상이어야만 하고, 행의 갯수가 서로 같아야만 합니다. 
age2 <- cbind(age1, month=month(age1$ORDER_DATE))
head(age2)

#연령별로 구분하여 월별 구매 건수의 총합을 구해서 확인한다.
	    # 나이를행 월을 열로해서 구매건수를 합해서 보여줘라
dcast(age2, AGE~month, value.var='QTY',sum)

# 그래프에 표시할 때, 10대, 20대, 30대와 같이
# 표시될 수 있도록 나이에 “대＂를 붙여서 ages라는 열을 추가한다.
age2 <- cbind(age2, ages=paste(age2$AGE,"대"))
head(age2)

# 연령 별로 월별 구매 건수를 누적 막대 그래프로 표시한다
qplot(month,data=age2,geom='bar',fill=ages)

# 연령 별로 월별 구매 건수를 별도의 막대 그래프로 표시한다
ggplot(age2,aes(month))+geom_bar()+facet_wrap(~AGE)


## 성별/연령대 구매 건수

#구매일자, 성별, 나이, 구매 건수만 추출하여 별도의 데이터 프레임을 만든다.
sexage1 <- subset(df,select=c(ORDER_DATE,SEX,AGE,QTY))
head(sexage1)

library(plyr)
# ddply() 함수를 사용하여 날짜, 성별, 나이로 그룹을 지어 구매 수량을 합쳐서 확인한다
sexage2 <- ddply(sexage1, .(ORDER_DATE,SEX,AGE), summarize, Sum_F=sum(QTY))
head(sexage2)

# month() 함수로 월만 추출하여 month 열을 추가하고, ages 열에는 나이에 “대＂를 붙여서 추가한다.
sexage3 <- cbind(sexage2, month=month(sexage2$ORDER_DATE))
sexage3 <- cbind(sexage3, ages=paste(sexage3$AGE,"대"))
head(sexage3)

# 성별과 연령을 기준으로 월별 구매 건수를 별도의 막대 그래프로 표시한다.
ggplot(sexage3,aes(month))+geom_bar()+facet_wrap(~SEX+ages)


## 연령대/성별 구매 건수 (리버스)

sexage4 <- ddply(sexage1, .(ORDER_DATE,AGE,SEX), summarise, Sum_F=sum(QTY))

sexage5 <- cbind(sexage4, month=month(sexage4$ORDER_DATE))
sexage5 <- cbind(sexage5, ages=paste(sexage5$AGE,"대"))

ggplot(sexage3,aes(month))+geom_bar()+facet_wrap(~ages+SEX)


## 월별 고객단위 구매금액

# 구매일자, 고객 번호, 구매 금액 만 추출하여 별도의 데이터 프레임을 만든다.
cust1 <- subset(df, select=c(ORDER_DATE,CUST_SERIAL_NO,PRICE))
head(cust1)













par(mfrow=c(1,2))
### END ###