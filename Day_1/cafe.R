cafe <- list(espresso = c(4,5,3,6,5,4,7),
			americano = c(63, 68, 64, 68, 72, 89, 94),
			latte = c(61, 70, 59, 71, 71, 92, 88),
			price = c(2.0, 2.5, 3.0),
			menu = c('espresso', 'americano', 'latte'))

cafe

str(cafe)
summary(cafe)

# 1줄의 cafe 리스트의 5번째 인덱스인 메뉴를 cafe$menu로 불러올 수 있음
# cafe[[5]] <- factor(cafe[[5]])
cafe$menu <- factor(cafe$menu)
# 내 생각이 맞다면 팩터는 행렬 이름에 가까운듯 리스트는 값으로 넣는듯

names(cafe$price) <- cafe$menu # 카페 가격의 이름은 카페 메뉴로 지정하겟다


# 카페 가격을 달라 이름은 아메리카노(위의 카페 메뉴의 인덱스 중 하나였음)
cafe$price['americano']	
cafe$americano #카페 리스트의 아메리카노라는 벡터가 가진 값


sale.americano <- cafe$price['americano'] * cafe$americano
# 아메리카노 수익 = 카페 가격[이름:아메리카노] * 아메리카노 판매량[벡터]값은 위에 확인
sum(sale.americano / 6)

str(cafe$price)

cafe$price[1]

sale.espresso <- cafe$price['espresso'] * cafe$espresso






