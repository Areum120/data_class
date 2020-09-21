import pandas as pd

df = pd.read_csv("all_file.csv", sep=",", encoding='utf-8')
print(df)
# 데이터가 뜨지 않는다. 왜? df, df.head()로 했을 때 안되고 print(df)로 했을 때 됐음.

# 자료형 확인
# df.dtypes 안됨
# df.head() 안됨

# df.index 안됨

# df.describe() 안됨

# df.loc['전체사고/거주인구'] #key error??
