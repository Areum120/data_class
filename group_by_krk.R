library(dplyr)
getwd()
setwd("C:/git/python/data_class/")
df <- read.csv(file="Floating_Population_2008.csv",
               header = T,
               fileEncoding = 'utf-8',
               # encoding="utf-8"
               )
gr <- df %>% group_by(군구, 연령대.10세단위.) %>%
  select(군구, 연령대.10세단위., 유동인구수) %>%
  summarise(dd = sum(유동인구수))

dim(gr)
View(gr)


