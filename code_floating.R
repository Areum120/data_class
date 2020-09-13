
getwd()
df <- read.csv(file="Floating_Population_2008.csv",
               header = T,
               fileEncoding = 'utf-8',
               # encoding="utf-8"
               )
df

# 구별, 연령대별로 groupby sum 60대와 70대 유동인구 합계를 구한 셀을 만듬
# 노인인구 60~70 top 10
