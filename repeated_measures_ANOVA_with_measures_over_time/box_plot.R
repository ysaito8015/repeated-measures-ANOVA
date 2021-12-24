rm(list = ls())
growthData <- read.table("./growthData.dat", header = TRUE)

par(mfrow = c(1,2),
    las = 1,
    family = "sans",
    lwd = 2,
    cex = 1)
boxplot(Mass ~ Day + Food, growthData, ylab = "Mass")
boxplot(log(Mass) ~ Day + Food, growthData, ylab = "log(Mass)")

