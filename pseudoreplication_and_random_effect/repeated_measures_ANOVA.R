rm(list = ls())
yieldData <- read.table("./yieldData.dat", header = TRUE)

# aov 関数では, モデル式中で Error() とう言う記法を用いる
# この中で指定した変数がランダム効果となる
# Plot をランダム効果に含める書き方
print(summary(aov(Yield ~ Treatment + Error(Plot), yieldData)))

# Treatment: F = 5.78, P = 0.138 となり, 農薬処理が収量に与える効果は有意ではない
# Error という階層を示す結果が表示されている
# Error: Plot
#           Df Sum Sq Mean Sq F value Pr(>F)
# Treatment  1  14481   14481   5.776  0.138 # Treatment はこの階層のみに表示される
# Residuals  2   5014    2507                # Residuals の DF が変化している
# Plot の存在を無視した ANOVA では 38 だったものが, 2 と大幅に減少
# 農薬処理を検証するための郡内変動として, Plot 間変動が選ばれたことを示している
# Plot の合計は 4 つなので, Df は, 4 - 1 - 1 = 2 となる
# 
# Error: Within
#           Df Sum Sq Mean Sq F value Pr(>F)
# Residuals 36   2621   72.81
