rm(list = ls())
growthData <- read.table("./growthData.dat", header = TRUE)

library(car)

growthData$Day <- as.factor(growthData$Day)
growth.lm.m <- lm(log(Mass) ~ Food * Day, growthData)

print(Anova(growth.lm.m))
# Loading required package: carData
# Anova Table (Type II tests)
# 
# Response: log(Mass)                        # すべての項が有意になっている
#            Sum Sq Df F value    Pr(>F)    
# Food      0.34905  1  65.775 7.273e-07 ***
# Day       1.13038  2 106.504 1.368e-09 ***
# Food:Day  0.20457  2  19.274 7.163e-05 ***
# Residuals 0.07960 15                       # 分母自由度が 15 になっている
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
