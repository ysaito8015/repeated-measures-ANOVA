rm(list = ls())
yieldData <- read.table("./yieldData.dat", header = TRUE)

print(head(yieldData))

#   Yield PlantID Plot Treatment
# 1 11.41    C1_1   C1         C
# 2 23.62    C1_2   C1         C
# 3 22.99    C1_3   C1         C
# 4 21.89    C1_4   C1         C
# 5  8.84    C1_5   C1         C
# 6 13.58    C1_6   C1         C

par(las = 1,
    family = "sans",
    lwd = 2,
    cex = 1)
boxplot(Yield ~ Treatment, # 農薬の有無, Treatment で作物の収量, Yield を比較する
        yieldData,
        xlab = "Treatment",
        ylab = "Yield(g)")
