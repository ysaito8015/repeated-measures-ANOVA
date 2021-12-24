rm(list = ls())
yieldData <- read.table("./yieldData.dat", header = TRUE)

par(las = 1,
    family = "sans",
    lwd = 2,
    cex = 1)

# Plot ごとに収量を比較する
boxplot(Yield ~ Plot,
        yieldData,
        xlab = "Plot",
        ylab = "Yield(g)")
