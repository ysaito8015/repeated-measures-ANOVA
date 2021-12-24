# Howell Table 14.4
# Repeated Measures ANOVA with 2 variables
# Read in data, convert to 'long' format, and factor()
library(car)
rm(list = ls())

dat <- read.table("Tab14-4.dat", header = TRUE)
head(dat)

dat$subject <- factor(1:24)
datLong <- reshape(data = dat,
                   varying = 2:7,
                   v.names = "outcome",
                   timevar = "time",
                   idvar = "subject",
                   ids = 1:24,
                   direction = "long")

datLong$Interval <- factor(rep(x = 1:6, each = 24),
                           levels = 1:6,
                           labels = 1:6)
datLong$Group <- factor(datLong$Group,
                        levels = 1:3,
                        labels = c("Control", "Same", "Different"))

cat("Group Means", "\n")
cat(tapply(datLong$outcome, datLong$Group, mean), "\n")
cat("\nInterval Means", "\n")

# Actual formula and calculation
King.aov <- aov(outcome ~ (Group * Interval) + Error(subject / (Interval)), data = datLong)

# Present the summary table (ANOVA source table)
print(summary(King.aov))

#Group Means 
#130.875 231.5208 144.6667 
#
#Interval Means 
#
#Error: subject
#          Df Sum Sq Mean Sq F value  Pr(>F)   
#Group      2 285815  142908   7.801 0.00293 **
#Residuals 21 384722   18320                   
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#
#Error: subject:Interval
#                Df Sum Sq Mean Sq F value  Pr(>F)    
#Interval         5 399737   79947  29.852 < 2e-16 ***
#Group:Interval  10  80820    8082   3.018 0.00216 ** 
#Residuals      105 281199    2678                    
#---
#Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

interaction.plot(datLong$Interval,
                 factor(datLong$Group),
                 datLong$outcome,
                 fun = mean,
                 type = "b",
                 pch = c(2,4,6),
                 legend = "F",
                 col = c(3,4,6),
                 ylab = "Mean of Outcome")
legend(4, 300, c("Same", "Different", "Control"),
      col = c(4,6,3),
      text.col = "green4",
      lty = c(2,1,3),
      pch = c(4,6,2),
      merge = TRUE,
      bg = 'gray90')

