rm(list = ls())
growthData <- read.table("./growthData.dat", header = TRUE)

library(dplyr)
library(tidyr)

par(las = 1,
    family = "sans",
    lwd = 2,
    cex = 1)

plotData = growthData %>%
  select(-Food) %>%
  mutate(Mass = log(Mass)) %>%
  spread(key = ID, value = Mass) %>%
  select(-Day) %>%
  as.matrix(.)

print(plotData)

matplot(plotData,
        type = "b",
        col = rep(c(1,2), each = 4),
        lty = 1,
        xlab = "Day",
        ylab = "ln(Mass)")
