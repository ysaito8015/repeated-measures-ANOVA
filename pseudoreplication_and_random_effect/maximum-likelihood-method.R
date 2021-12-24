rm(list = ls())
yieldData <- read.table("./yieldData.dat", header = TRUE)

library(lme4)
library(car)

lmer.m <- lmer(Yield ~ Treatment + (1|Plot), yieldData)
print(Anova(lmer.m, test="F"))

# 最尤法を用いたランダム効果入りモデル
# ランダム効果入りの線形モデル（正規分布仮定）を作る lmer 関数が用意されている
# lmer 関数で Plot をランダム効果に含めるためには, モデル式の中に "(1|Plot)" を加える
# car パッケージの Anova 関数で test="F" を指定すると, F 検定を実行する

# Analysis of Deviance Table (Type II Wald F tests with Kenward-Roger df)
# 
# Response: Yield
#                F Df Df.res Pr(>F)
# Treatment 5.7765  1      2 0.1381
# aov 関数の出力と比較すると同一
# Df.res は Treatment の Residuals の Df を示している
