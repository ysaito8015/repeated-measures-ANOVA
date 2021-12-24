# R for repeated measures
# One within subject measure and no between subject measures
# Be sure to run this from the beginning because
# otherwise vectors become longer and longer.
library(car)
rm(list = ls())

data <- read.table("./NolenHoeksema.dat", header = TRUE)
print(head(data))
#  Subject Time1 Time2 Time3 Time4 Time5
#1       1     7    10     8    14    16
#2       2     3     4     8     5     6
#3       3     3     4     8    15    16
#4       4     5     5     8    10     7
#5       5     5     7     9     7    12
#6       6     6     7     9     7     7

datLong <- reshape(data = data,
                   varying = 2:6,
                   v.names = "outcome",
                   timevar = "time",
                   idvar = "Subject",
                   ids = 1:9,
                   direction = "long")
print(head(datLong))
#    Subject time outcome
#1.1       1    1       7
#2.1       2    1       3
#3.1       3    1       3
#4.1       4    1       5
#5.1       5    1       5
#6.1       6    1       6

# Factorize
datLong$time <- factor(datLong$time)
datLong$Subject <- factor(datLong$Subject)

# sort by time
orderedTime <- datLong[order(datLong$time),]
options(contrasts=c("contr.sum", "contr.poly"))

# ANOVA
modelADV <- aov(outcome ~ factor(time) + Error(factor(Subject)), data = datLong)
print(summary(modelADV))
# Error: factor(Subject)
#           Df Sum Sq Mean Sq F value Pr(>F)
# Residuals 24  953.7   39.74               
# 
# Error: Within
#              Df Sum Sq Mean Sq F value Pr(>F)  
# factor(time)  4   94.3  23.572   2.726 0.0337 *
# Residuals    96  830.1   8.647                 
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

obtF <- summary(modelADV)$"Error: Within"[[1]][[4]][1]
# [1] 2.726032

# Box plot
par(mfrow = c(2,2))
plot(datLong$time, datLong$outcome, pch = c(2,4,6), col = c(3,4,6))
legend(1, 20,
       c("same", "different", "control"),
       col = c(4,6,3),
       text.col = "green4",
       pch = c(4,6,2),
       bg = 'gray90')
