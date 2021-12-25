rm(list = ls())
growthData <- read.table("./growthData.dat", header = TRUE)
growthData$Day <- as.factor(growthData$Day)
attach(growthData)

library(lme4)
library(car)

growth.lmer.m <- lmer(log(Mass) ~ Food * Day + (1|ID), growthData)
print(Anova(growth.lmer.m, test = "F"))

# The following objects are masked from growthData (pos = 3):
# 
#     Day, Food, ID, Mass
# 
# Analysis of Deviance Table (Type II Wald F tests with Kenward-Roger df)
# 
# Response: log(Mass)
#                F Df Df.res    Pr(>F)    
# Food      35.249  1 5.7562 0.0011830 **   # 個体差を無視した, two-way ANOVA の分析値より p 値が下がっている
# Day      165.941  2 9.5603 3.777e-08 ***
# Food:Day  27.124  2 9.6315 0.0001104 ***
# Df.res, 分母自由度が整数ではなくなっている
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
