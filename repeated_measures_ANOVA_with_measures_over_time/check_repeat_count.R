rm(list = ls())
growthData <- read.table("./growthData.dat", header = TRUE)

print(with(growthData, table(Food, Day)))

# 繰り返し階数が異なっている
#     Day
# Food 1 3 5
#    A 4 3 3
#    B 4 4 3
