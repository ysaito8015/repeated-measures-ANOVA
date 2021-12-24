rm(list = ls())
yieldData <- read.table("./yieldData.dat", header = TRUE)

# 作物の株, PlantID を繰り返しとして one-way ANOVA を実行する
lm.m <- lm(Yield ~ Treatment, yieldData)

# P 値が低く, 農薬散布の影響は有意
print(anova(lm.m))
# Analysis of Variance Table
# 
# Response: Yield
#           Df Sum Sq Mean Sq F value    Pr(>F)
# Treatment  1  14481 14481.1  72.073 2.627e-10 ***
# Residuals 38   7635   200.9 # Residuals の Df 値に注意
#
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
