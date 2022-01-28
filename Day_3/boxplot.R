### 데이터 이상치 박스플롯 시각화 분석###
## 박스플롯쓰는 이유 이상치 확인하기 위해서 사용함

str(tips)

tt=subset(tips,tip<6)
tt

summary(tt)

boxplot(tip ~ day, data = tips) # 날짜별로 팁을 보겟다, 어디서? 팁s 데이타에서

tmp = subset(tt,day=='Sat')
tmp1 = subset(tt,day=='Fri')

par(mfrow=c(2,2))
boxplot(tip ~ size, data = tt)
boxplot(tip ~ sex, data = tt)
boxplot(tip ~ time, data = tt)
boxplot(tip ~ day, data = tt)

boxplot(tip ~ size, data = tmp1)
boxplot(tip ~ sex, data = tmp1)
boxplot(tip ~ time, data = tmp1)
boxplot(tip ~ day, data = tmp1)

### mtcars ###
str(mtcars)

par(mfrow=c(1,2))
### 연비(mpg)를 알아보자

### 기어수
# 3에서 4로갈때는 양으로 가는데 4에서 5로갈때 음으로 내려감
boxplot(mtcars$mpg ~ mtcars$gear)
plot(mtcars$mpg ~ mtcars$gear)
# 허나 0.48정도의 상관 계수를 가진다
cor(mtcars$mpg, mtcars$gear)


## 엔진
# 0에서 이상치 하나 발견, 평균값이 아래쪽에 처진걸 보아 아래쪽에 데이터 몰려있음
boxplot(mtcars$mpg ~ mtcars$vs)
plot(mtcars$mpg ~ mtcars$vs)

cor(mtcars$mpg, mtcars$vs)
# 위 두결과로 대체로 1자형엔진이(vs.1)dl V자형 엔진(vs.0)보다 연비가 높은 경향을 보인다.

### am=1 스틱, am=0 오토
boxplot(mtcars$mpg ~ mtcars$am)
plot(mtcars$mpg ~ mtcars$am)

cor(mtcars$mpg, mtcars$am)
# 스틱이 오토보다 연비가 높다

### 이 작업 넘모 귀찮아서 패키지 쓴다 카더라
























# END