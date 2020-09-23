library(dplyr)
library(MASS)

data<- read.csv(choose.files(), fileEncoding="euc-kr")
str(data)

#####data안에서 뺄 변수들을 select 안에 넣어주세요!!
# start1<- data %>% select(-c("X_2", "X", "X_1", "사고번호", "시군구", "도로명","도로형태","X.1","X.2"))
start1<- data %>% select(-c("동","읍면동명_two","도로명","법규위반","도로형태","구","읍면동명","동면적"))


#####사고일시에서 월, 시간 빼는 작업이에요!!
# split<-strsplit(start1$사고일시, split=" ")

# for(i in 1:length(split)){
# start1$월[i]<-split[[i]][2]
# start1$시간[i]<-split[[i]][4]
# }


############데이터 형태 변환##############################
start1$시간<-gsub("시", "", start1$시간)
start1$월<-gsub("월", "", start1$월)

start1$요일<- as.factor(start1$요일)
start1$사고유형<- as.factor(start1$사고유형)

start1$사고내용<- as.factor(start1$사고내용)
start1$법규위반<- as.factor(start1$법규위반)
start1$노면상태<- as.factor(start1$노면상태)
start1$기상상태<- as.factor(start1$기상상태)
# start1$도로형태<- as.factor(start1$도로형태)


start1$가해운전자차종<-as.factor(start1$가해운전자차종)
start1$가해운전자성별<- as.factor(start1$가해운전자성별)
start1$가해운전자연령<- gsub("세", "", start1$가해운전자연령)
start1$가해운전자연령<- as.integer(start1$가해운전자연령)
start1$가해운전자상해정도<- as.factor(start1$가해운전자상해정도)

start1$피해운전자차종<-as.factor(start1$피해운전자차종)
start1$피해운전자성별<- as.factor(start1$피해운전자성별)
start1$피해운전자연령<- gsub("세", "", start1$피해운전자연령)
start1$피해운전자연령<- as.integer(start1$피해운전자연령)
start1$피해운전자상해정도<- as.factor(start1$피해운전자상해정도)

start1$월<- as.factor(start1$월)
start1$시간<- as.factor(start1$시간)


############회귀식에 써먹을 변수 선택##############################

####회귀식에 써먹을 변수 빼고 삭제하는 작업
# start2 <- start1  %>% filter(피해운전자연령 <= 13)  %>% dplyr::select(-c("V1","통화량", "동", "읍면동명_two", "사고일시", "시간","시", "구","월","전체인구","X65세인구", "읍면동명", "피해운전자차종","요일","사고내용","사망자수","중상자수","경상자수","부상신고자수","노면상태","기상상태","가해운전자연령","가해운전자성별","가해운전자차종","가해운전자상해정도","피해운전자성별","피해운전자연령","피해운전자상해정도","신호위반","안전운전의무불이행","교차로통행방법위반","과속","교통법규위반_총계"))
# start2<- start1%>% filter(피해운전자연령 >=)  %>% dplyr::select(-c("V1","통화량", "동", "읍면동명_two", "사고일시", "시간","시", "구","월","전체인구","X65세인구", "읍면동명", "피해운전자차종","요일","사고내용","사망자수","중상자수","경상자수","부상신고자수","법규위반","노면상태","기상상태","가해운전자연령","가해운전자성별","가해운전자차종","가해운전자상해정도","피해운전자성별","피해운전자연령","피해운전자상해정도","법규위반"))
# start2<- start1  %>% dplyr::select(-c("V1", "동", "읍면동명_two", "사고일시", "시간","시", "구","월","전체인구","X65세인구", "읍면동명", "피해운전자차종","요일","사고내용","사망자수","중상자수","경상자수","부상신고자수","법규위반","노면상태","기상상태","가해운전자연령","가해운전자성별","가해운전자차종","가해운전자상해정도","피해운전자성별","피해운전자연령","피해운전자상해정도"))
# start2<- start1 %>% filter(피해운전자연령 <= 15) %>%  dplyr::select(c( "사고유형","상점가_수","학교개수","학원수","유치원수","재래시장수","통화량","횡단보도수","보행환경_만족도","유흥업소수","교차로통행방법위반","교통법규위반_총계","신호위반","안전운전의무불이행","가로등수","도로폭평균","버스수"))
# start1$피해운전자연령<- as.integer(start1$피해운전자연령)
start2<- start1 %>% filter(피해운전자_연령<=15) %>% select(-c("피해운전자_연령","통화량","횡단보도수_구_"))

####NA값이 있는 행들을 삭제하는 작업
start3<- na.omit(start2)
start3$사고유형 %>% is.na() %>% table()

###사고 유형이 0: 차대-차, 1: 차대-사람 ==> 1: 차대-차, 2: 차대-사람
start3$사고유형<- ifelse(start3$사고유형==0, 1, 2)
#View(start3)

###전체 사고에 대한 회귀모델
model<-glm(사고유형~. , data=start3)

summary(model)

step_model<- stepAIC(model, direction = "backward")
summary(step_model)
