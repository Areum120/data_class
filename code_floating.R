
getwd()
df <- read.csv(file="Floating_Population_2008_2.csv",
               header = T,
               fileEncoding = 'utf-8',
               # encoding="utf-8"
               )
df
attach(df)

str(df)
# 구별, 연령대별로 groupby sum 60대와 70대 유동인구 합계를 구한 셀을 만듬

install.packages("dplyr")
library(dplyr)


df %>%
  group_by(군구) %>%
  summarise(count = n(), 
            age_sum = sum(연령대.10세단위.),
            time_sum = sum(시간.1시간단위.)) %>%
  view()

# 노인인구 60~70 top 10
