# 장바구니 분석	

install.packages("arules")
library(arules) #read.transactions()함수 제공

setwd('C:/Sources/Study_R/Day_4')


# 용어: 트랜잭션 파일 (변동성 있는 파일 추가 및 수정되는)
# 용어: 마스터파일(변동이 없는 (회원가입 시 받는 정보)들이 들어오는 파일)

# 트랜잭션 객체 생성.

tran <- read.transactions("./data_r/tran.txt", format="basket", sep=",") 
tran = read.transactions('./data_r/tran.txt', format='basket', sep=',')
tran # 4개의 트랜잭션과 7개의 항목(상품) 생성

str(tran)
class(tran)
					   # 지지도 0.3이상,신뢰도 0.1이상
rule<- apriori(tran, parameter = list(supp=0.3, conf=0.1)) # 16 rule
inspect(rule) # 규칙 보기
[6] {넥타이(A),셔츠(B) 신뢰도}
	  넥타이와 셔츠의 지지도/ 넥타이의 지지도
	  0.5/0.5
[7] {셔츠(A),넥타이(B) 신뢰도}
	  셔츠와 넥타이의 지지도/ 셔츠의 지지도
	  0.5/0.75 => 0.6666
tran@data


### 시각화 패키지 ###
install.packages("arulesViz") 
library(arulesViz) 






### END