rm(list = ls())
growthData <- read.table("./growthData.dat", header = TRUE)
growthData$Day <- as.factor(growthData$Day)
attach(growthData)

library(lme4)
library(emmeans)

growth.lmer.m <- lmer(log(Mass) ~ Food * Day + (1|ID), growthData)

# 同じ日の中で, 処理間で体重が異なるか
print(lsmeans(growth.lmer.m, specs = c("Food", "Day")))

# Loading required package: Matrix
#  Food Day lsmean     SE   df lower.CL upper.CL
#  A    1     3.89 0.0367 12.2     3.81     3.97
#  B    1     3.93 0.0367 12.2     3.85     4.01
#  A    3     4.06 0.0420 13.9     3.97     4.15
#  B    3     4.34 0.0367 12.2     4.26     4.42
#  A    5     4.24 0.0420 13.9     4.15     4.33
#  B    5     4.74 0.0420 13.9     4.65     4.83
# 
# Degrees-of-freedom method: kenward-roger 
# Results are given on the log (not the response) scale. 
# Confidence level used: 0.95 

cat("\n")
# すべての組み合わせで事後検定を行う
print(pairs(lsmeans(growth.lmer.m, specs = c("Food", "Day"))))

#  contrast  estimate     SE    df t.ratio p.value
#  A 1 - B 1   -0.036 0.0520 12.16  -0.693  0.9794
#  A 1 - A 3   -0.168 0.0456  9.61  -3.680  0.0384
#  A 1 - B 3   -0.450 0.0520 12.16  -8.658  <.0001
#  A 1 - A 5   -0.348 0.0456  9.61  -7.628  0.0002
#  A 1 - B 5   -0.852 0.0558 13.19 -15.282  <.0001
#  B 1 - A 3   -0.132 0.0558 13.17  -2.360  0.2380
#  B 1 - B 3   -0.414 0.0408  9.05 -10.153  <.0001
#  B 1 - A 5   -0.312 0.0558 13.17  -5.585  0.0009
#  B 1 - B 5   -0.816 0.0455  9.57 -17.930  <.0001
#  A 3 - B 3   -0.282 0.0558 13.17  -5.054  0.0023
#  A 3 - A 5   -0.180 0.0511 10.47  -3.522  0.0442
#  A 3 - B 5   -0.685 0.0594 13.88 -11.527  <.0001
#  B 3 - A 5    0.102 0.0558 13.17   1.829  0.4814
#  B 3 - B 5   -0.402 0.0455  9.57  -8.840  0.0001
#  A 5 - B 5   -0.505 0.0594 13.88  -8.496  <.0001
# 
# Degrees-of-freedom method: kenward-roger 
# Results are given on the log (not the response) scale. 
# P value adjustment: tukey method for comparing a family of 6 estimates 

cat("\n")
# Day で場合分けし, Food に注目する
print(lsmeans(growth.lmer.m, specs = "Food", by = "Day"))

# Day = 1:
#  Food lsmean     SE   df lower.CL upper.CL
#  A      3.89 0.0367 12.2     3.81     3.97
#  B      3.93 0.0367 12.2     3.85     4.01
# 
# Day = 3:
#  Food lsmean     SE   df lower.CL upper.CL
#  A      4.06 0.0420 13.9     3.97     4.15
#  B      4.34 0.0367 12.2     4.26     4.42
# 
# Day = 5:
#  Food lsmean     SE   df lower.CL upper.CL
#  A      4.24 0.0420 13.9     4.15     4.33
#  B      4.74 0.0420 13.9     4.65     4.83
# 
# Degrees-of-freedom method: kenward-roger 
# Results are given on the log (not the response) scale. 
# Confidence level used: 0.95 

cat("\n")
# pairs 関数で囲むと, Day で場合分けした水準ごとに(水準内), 繰り返し事後検定を実行する
print(pairs(lsmeans(growth.lmer.m, specs = "Food", by = "Day"), adjust = "tukey"))

# Day = 1:
#  contrast estimate     SE   df t.ratio p.value
#  A - B      -0.036 0.0520 12.2  -0.693  0.5014
# 
# Day = 3:
#  contrast estimate     SE   df t.ratio p.value
#  A - B      -0.282 0.0558 13.2  -5.054  0.0002
# 
# Day = 5:
#  contrast estimate     SE   df t.ratio p.value
#  A - B      -0.505 0.0594 13.9  -8.496  <.0001
# 
# Degrees-of-freedom method: kenward-roger 
# Results are given on the log (not the response) scale. 

cat("\n")
# 3 つの比較全体, 水準間の p 値の調整を実行する
print(rbind(pairs(lsmeans(growth.lmer.m, specs = "Food", by = "Day")), adjust = "tukey"))

# Note: adjust = "tukey" was changed to "sidak"
# because "tukey" is only appropriate for one set of pairwise comparisons
#  Day contrast estimate     SE   df t.ratio p.value
#  1   A - B      -0.036 0.0520 12.2  -0.693  0.8760
#  3   A - B      -0.282 0.0558 13.2  -5.054  0.0006
#  5   A - B      -0.505 0.0594 13.9  -8.496  <.0001
# 
# Degrees-of-freedom method: kenward-roger 
# Results are given on the log (not the response) scale. 
# P value adjustment: sidak method for 3 tests 
