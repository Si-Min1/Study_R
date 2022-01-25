# 영문 텍스트분석에 특화된 tm패키지등에 매트릭스 사용
# konlpy 패키지
# ===========================================

# 빈도수분석(모든설문지에서 많이나온 단어수로 이슈응 찾음) => 시각화:워드클라우드
# p1 + p2 = c('강아지', '산책', '강아지', '목욕', 강아지'...)
# ===========================================

########################################
###		 데이터 형 변환
### 1. char 을 factor로 변환 (크게크게 구분 지을 수 있을만한거)
### 시도명 시군구명 설치년도 제한속도같은거 위경도는 각각다르니 비추
### 
### 2. 숫자를 factor로 변환하는 파생변수
### 덮어쓸지 새로변수를 만들지
########################################

df[,6] = factor(df[,6])
df$시도명 = factor(df$시도명)
df$시군구명 = factor(df$시군구명)
# 원하면 df[,3]해도 됨

summary(df)
levels(df[,2])

df$설치연도Factor = factor(df$설치연도)
plot(df[,24])
df$제한속도F = factor(df$제한속도)
table(df$제한속도F)



dir()
getwd()

filename = '전국무인교통단속카메라표준데이터.csv'
df = read.csv(filename)

head(df)
str(df)

barplot(table(df$시도명))


# 시도명은 01(서울), 03, 10, 9
df.01 = subset(df, df$시도명 == '10')
df.01

# 시군구에 하나만 보이긴 하는데
head(df.01)
str(df.01)

# 한 종류만 있는게 맞나? 하면서 확인
summary(factor(df.01$소재지지번주소))
table(df.01$소재지지번주소)
unique(df.01$소재지지번주소)
# 셋다 가능



########################################
### 2. 컬럼명 정리
### names(df)작업해서 인덱싱번호에다가 컬럼명 변경
### names(df) = c(' ',' ')
### 문자연결
### paste("char1", "char2",sep='') # sep 안해주면 강제 공백
########################################
names(df)[1] = 'camNum'
names(df)[25]= 'limitSpeed'

names(df)

names(df)[1] = names(df)[1]

names(df)[1] = paste(names(df)[1],'-bu',sep='')
str(df)


########################################
### 3. 필요한 컬럼만 모아서 별도의 데이터셋 제작
### 첫째 불필요 데이터 컬럼 제거
### 둘째 분석하고자 하는 내용에 맞게끔 새로운 데이터프레임표 구상
########################################

names(df)

df1 = df[,c(2, 3, 4, 7, 11, 13, 14 ,16)]
str(df1)
df_ex1=df[,c(10, 11, 13, 14)] # 위도 경도를 이용한 지도만들기
str(df_ex1)

########################################
### 4. 조건에 맞는 자료만 필터링
### subset을 이용
### 따로 패키지가 있긴함 일단 연습
########################################
str(df1)
# 단속구분을 unique하게 받기
unique(df1$단속구분)

# 안나오면 한번 테이블로 뭐 있는지 확인
table(df1$시군구명)

# str(df1)으로 데이터 계속 확인
# subset을 이용하여 단속구분이 1인 자료만 필터링 하기
df1.sub = subset(df1, 단속구분 == '1')
df1.sub
# subset을 이용하여 제한속도가 50인 자료만 필터링 하기
df1.sub1 = subset(df1, 제한속도 == 50)
df1.sub1
# subset을 이용하여 단속구분이 1이면서 시군구명이 강남구인 자료
df1.sub2 = subset(df1, 단속구분 == '1' & 시군구명 == '강남구')
df1.sub2

########################################
### 5. 자료셋을 새로 제작해서 .csv파일로 저장
########################################
# select='경기도'
# tmp=subset(df1, 시도명 == select)

sido=unique(df1$시도명)
sido

count = length(sido)
count
temp에는 파일내용이 들어감
fileName에는 파일 제목 및 위치와 확장자 명
row.names 는 안해도 되긴함
for(idx in 1:count){
	temp=subset(df1, 시도명 == sido[idx])
	fileName = paste('./저장/',sido[idx],'.csv',sep = '')
	
	write.csv(temp, fileName, row.names = TRUE)
	} # write.csv(.csv파일에 들어갈 내용, 파일명 및 생성위치 지정)	

# 디렉토리(폴더) 생성 dir.create(폴더명)
# getwd() setwd()로 wd이동

tmp=unique(df[,2])
tmp
tmp=unique(df$시도명)


# ========== 176p 복습용 ============
str(df)

ma = df$제한속도
nrow(ma)
ncol(ma)	# 그냥 1줄 있는거라 둘 다 안나옴
length(ma)	# 길이로 알려달라
mean(ma)	# 바로 계산 들가도 됨

mm = df[,c(10:11)] # 위 경도 들고옴

mm
nrow(mm)


rowSums(mm) # N/A값 있긴한데 나오긴 하니까
colSums(mm) # 이건 N/A값 빼던가 해야함












#
