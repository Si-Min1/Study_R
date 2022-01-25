# 메모리에 존재하는 변수 삭제
rm(list=ls())

#메모리에 들어있는 변수 확인
ls()[]

# 데이터 로드 factor은 기준으로 잡을법한 값특) 느림
# string to factor(char)
# df = read.csv(dir()[6], stringsAsFactors = TRUE)

# 쓸부분만 떼와서 저장하고 메모리 비우고 다시 불러오기
filename = '전국무인교통단속카메라표준데이터.csv'
df = read.csv(filename)
df = read.csv(dir()[7])
str(df)

df1 = df[,c(1:9)]
str(df1)



table(df1[,2])
data.frame(table(df1[,2]))
summary(df1)


write.csv(df1, '임시.csv')
df = read.csv('임시.csv')
df
names(df)[1] : str(names(df)[1])
summary(df[,1])

### 기술통계
### N/A값 확인

# sum(is.na(df[,7]))

colName=names(df)
colName

count = length(colName)
for (i in 1:count){
	print(colName[i])
	print(sum(is.na(df[,i])))
	}

#### 결측치 패키지 ####
# install.packages('naniar')
library(naniar) # 패키지 불러오기
naniar::miss_case_summary(df) # case 행 기준
naniar::miss_var_summary(df)	#
naniar::vis_miss(df) #
naniar::gg_miss_var(df)	#
naniar::gg_miss_upset(df)	#


install.packages('VIM')
library(VIM);
VIM::aggr(df)


install.packages('Amelia') # 기본
library(Amelia)
missmap(df)

# 결과 저장
savePlot(missmap(df))
# or
png("plot.png",width=2000,height=4000,res=500)
plot(df)

dev.off()





# END