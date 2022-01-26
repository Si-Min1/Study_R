### 패키지 맛보기
install.packages('cowsay') # 아래 경로에 깔림
# The downloaded binary packages are in
#        C:\Users\admin\AppData\Local\Temp\Rtmp6B62FF\downloaded_packages

library(cowsay) # 내 R폴더로 들고옴


by_name_list = c('cat', 'longcat', 'longtailcat')

for(by_name in 1:by_name_list){
	say('.	     아쎄이!', by = by_name)
	}

for(index in length(by_name_list)){
	say('.	     아쎄이!', by = by_name_list[index])
	}

help(say)



# -------------------------------------
install.packages('reshape2')
library(reshape2)

# 데이터 파악 : 변수위 성격과 해설
# total_bill : 전체 지불비용
# tip : tip 비용
# sex : 성별 (
# smoker : 흡연석 / 비흡연석
# day : 날짜
# time : 방문시간
# size : 방문인원

# N/A데이터 확인
sum(is.na(tips))


for(i in 1:length(tips)){
	if (class(tips[,i] == 'factor')){
		print(unique(tips[,i])	
	}
}


### 가설과 검증 ###
# 1번 가설: 성별(독립변수, x값)에 따르는 tips(종속변수,y값)의 비용은 같다
#		y값에 유의미한 변화를 주는 x값은 무엇인가?
#		0가설 (귀무가설)
#		검증을 통해서 비용은 같다 -> 귀무가설을 채택
#		비용이 다르다 -> 귀무가설 기각/ 대립가설 채택
#		pvalue값을 동해 확인함. (집계할때 딱히 필요없긴함)
#		일반적인 가설검증은 데이터집계를 통해서 비교

str(tips)

for( i in 3:7){
	print(paste('---',names(tips)[i],'---'),sep='')
	print(table(tips[,i]))
	}


table(tips[,3]) # 성별의 빈도수, 전체데이터에서 발생횟수
table(tips[,4])

din=subset(tips,time == 'Dinner')
lun=subset(tips,time == 'Lunch')

male=subset(tips,sex == 'Male')
female=subset(tips,sex == 'Female')


table(tips$time, tips$day)				# 저녁에 많이옴

table(tips$sex)

colMeans(din[c('total_bill', 'tip', 'size')])
colMeans(lun[c('total_bill', 'tip', 'size')])

colSums(din[c('total_bill', 'tip', 'size')])
colSums(lun[c('total_bill', 'tip', 'size')])

par(mfrow=c(2,1))
plot(din$tip)
plot(lun$tip)

tmp = subset(male,day == 'Sun')
summary(tmp)
tmp

# --- 성별 별 ---
colMeans(male[c('total_bill', 'tip', 'size')])
colMeans(female[c('total_bill', 'tip', 'size')])

summary(male)
summary(female)

par(mfrow=c(1,1))
plot(male$tip, main='F of Tips')
plot(female$tip)

plot(male$size, main='F of Tips')
plot(female$size)

plot(tips[,1])
plot(tips[,1], tips[,2])
plot(tips[,7], tips[,2])

colNum = c(1,2,7)
par(mfrow= c(3,1))

for(i in colNum){
	plot(tips[,i], main = names(tips)[i])}


# --- mtcars 상관도----
mtcars
str(mtcars)

plot(mtcars[,c(1,3,5,6)])
tmp = c()

# 피어슨 상관 계수 (-1 ~ 1) 보통은 0.7이상이면 관련도 있다
cor(mtcars[,c(1,3,5,6)])
cor(tips) # 문자 데이터 있으면 ㄴㄴ해


# 머신러닝(기계학습)은 독립변수(x)들과 종속변수(y)의 분석을 통한 예측, 분류이다.
# 상관도,pvalue등 다양한 방법이 있음. y값은 1개변수, x값은 1개이상
# ex) y = 기숙사 당첨 , x1 = 집과의 거리, x2 = 성적 등등

# 상관계수 
# 독립변수끼리는 상관도가 높으면 안됨 (서로에게 영향을 많이주면 1개가 쓸모없던가 그럼) 
# 상관도가 너무 높은 경우를 다중공선성이라고 하는데

# VIF(분산팽창지수)가 10 이상 나오는걸 의미한다.
# 이런경우 x변수중 하나 제거하고, VIF를 다시확인해서 y값에 영향을 준다 하는것만 남을때까지 반복

install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)
chart.Correlation(mtcars, histogram=TRUE, pch=19)
tmp = tips[,c(2,1,7)]
chart.Correlation(tmp, histogram=TRUE, pch=19) # 상관도 뜨긴하는데 공식은 잘 몰?루
# 상관계수는 0에 가까울수록 y값에 영향을 주지 못한다.







# END