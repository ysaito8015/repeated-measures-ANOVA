rm(list = ls())
yieldData <- read.table("./yieldData.dat", header = TRUE)

library(lme4)
lmer.m <- lmer(Yield ~ Treatment + (1|Plot), yieldData)

library(emmeans)
print(lsm.lmer.m <- lsmeans(lmer.m, specs="Treatment"))

# Loading required package: emmeans
# The 'lsmeans' package is now basically a front end for 'emmeans'.
# Users are encouraged to switch the rest of the way.
# See help('transition') for more information, including how to
# convert old 'lsmeans' objects and scripts to work with 'emmeans'.

# lsmeans 関数では, モデルにランダム効果が含まれていることを考慮の上, 平均値だけでなく正しい SE も算出が可能
#  Treatment lsmean   SE df lower.CL upper.CL
#  C           24.8 11.2  2    -23.4     72.9
#  P           62.8 11.2  2     14.7    111.0
# 
# Degrees-of-freedom method: kenward-roger 
# Confidence level used: 0.95 
