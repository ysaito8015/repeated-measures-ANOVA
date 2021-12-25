rm(list = ls())
yieldData <- read.table("./yieldData.dat", header = TRUE)

library(lme4)
lmer.m <- lmer(Yield ~ Treatment + (1|Plot), yieldData)

library(emmeans)
lsm.lmer.m <- lsmeans(lmer.m, specs="Treatment")

summ.lsm.lmer.m <- summary(lsm.lmer.m)
lsm <- summ.lsm.lmer.m$lsmean
ui <- summ.lsm.lmer.m$lsmean + summ.lsm.lmer.m$SE
li <- summ.lsm.lmer.m$lsmean - summ.lsm.lmer.m$SE

par(las = 1,
    cex = 1.5,
    family = "sans",
    lwd = 2)
x <- barplot(lsm,
             ylim = c(0, 80),
             names.arg = c("Control", "Pesticide"),
             xlab = "Treatment",
             ylab = "Yield/plant (mg)")
arrows(x, ui, x, li, angle = 90, code = 3)
