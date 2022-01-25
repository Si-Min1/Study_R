# R의 내장된데이터 mtcars (연비관련)
mtcars

str(mtcars)
head(mtcars, 3)

summary(mtcars)
plot(mtcars$mpg)
mtcars$cyl
factor(mtcars$cyl)
summary(factor(mtcars$cyl))
names(summary(factor(mtcars$cyl)))
levels(factor(mtcars$cyl)) # 위와 같은 명령
unique(mtcars$cyl)

temp = summary(factor(mtcars$cyl))
temp
names(temp)=c('4cyl', '6cyl', '8cyl')
temp


# split(자료, 기준) 리스트작업
tmp = split(mtcars, mtcars$cyl)
str(tmp)
tmp[[1]]
split(tmp[[1]],tmp[[1]]$am)
# split(tmp[[1]],tmp[[1]][9]) # 대충 알아서


