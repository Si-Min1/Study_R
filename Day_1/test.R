# 두개 이상을 자료를 갖는 리스트 구조에서
# 파이썬에서는 직업명=['','',''] 초기화는 직업명=[]
# R에서는 직업명=('','','') 초기화는 작업명=c()str
# 스크립트 창에서 작성한 코드는 커서를 그 줄에 두고
# ctrl+R 또는 f5키로 실행 (스튜디오에서는 ctrl + enter)

직업명 = c('과학자','엔지니어','분석관리자','세무사')
채용수 = c(1234,2424,1313,1232)
평균급여 = c(1200,1300,1400,1500)
직업만족도 = c(4.4,4.0,4.3,4.1)


# R에서는 명목변수의 factor가 있음
# 자료형 확인은 str(변수명)으로 확인가능
# factor는 자료split안되지만, 유니크한 레벨을 가지고 있음
# => plot(변수) 했을때 count집계가 가능함
# 문자자료를 factor로 면경하는 방법은 변수 = as.factor(변수)임.
직업명fa = as.factor(직업명)
직업명fa
직업명

str(직업명)
summary(직업명)
summary(직업명fa)
plot(직업명fa)

data=data.frame(직업명,채용수,평균급여,직업만족도)
data

str(data)
summary(data)
plot(data)

data$직업명		#data안에 직업명이 뭐 있나

# strsplit(변수, 변수를 나눌 기준)
SL = 'python /r /colab'
SL2 = c('파이썬/분석가/인공지능', 'C++/open gl/개발자')
temp = strsplit(SL2,'/')
temp
temp[[2]][1] 		# temp[[n번 문장]][n번 조각]
str(temp)
summary(temp)
temp1 = unlist(temp)
temp1
summary(unlist(temp))
plot(SL) # 오류

temp2 = as.factor(temp1)
temp2
summary(temp2)
plot(temp2)
# factor형은 strsplit 안됨 다시 as.character로 바꿔줘야함
# factor형의 레벨은 종류 알려줌











