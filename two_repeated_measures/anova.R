# Test for Two Within-Subject Repeated Measures
# One tricky part of this code came from Ben Bauer at the Univ. of Trent, Canada.
# He writes code that is more R-like than I do. In fact, he knows more about R than
# I do
# Two within subject variables , 1:8
# Data from Bouton & Schwartzentruber (1985) -- Group 2
# Methods8, p. 486

library(car)
rm(list = ls())
data <- read.table("Tab14-11long.dat", header = TRUE)
print(head(data))
#Loading required package: carData
#  Subj Phase Cycle dv
#1    1     1     1  1
#2    1     1     2  6
#3    1     2     1 16
#4    1     2     2  8
#5    1     3     1  9
#6    1     3     2 14

n <- 8
cells <- 8
nobs <- length(data$dv)
attach(data)
cat("Cell Means \n")
print(tapply(dv, list(Cycle,Phase), mean))
cat("\n")
#Cell Means 
#       1      2      3     4
#1 17.750 22.375 23.125 20.25
#2 20.875 28.125 20.750 24.25

# factorize
Subj <- factor(Subj)
Phase <- factor(Phase)
Cycle <- factor(Cycle)

# ANOVA
options(contrasts = c("contr.sum", "sontr.poly"))
model1 <- aov(dv ~ (Cycle * Phase) + Error(Subj / (Cycle * Phase)), contrasts = contr.sum)
print(summary(model1))
#Error: Subj
#          Df Sum Sq Mean Sq F value Pr(>F)
#Residuals  7   8411    1202               
#
#Error: Subj:Cycle
#          Df Sum Sq Mean Sq F value Pr(>F)
#Cycle      1  110.2  110.25   2.877  0.134
#Residuals  7  268.2   38.32               
#
#Error: Subj:Phase
#          Df Sum Sq Mean Sq F value Pr(>F)
#Phase      3  283.4   94.46   1.029    0.4
#Residuals 21 1928.1   91.82               
#
#Error: Subj:Cycle:Phase
#            Df Sum Sq Mean Sq F value Pr(>F)
#Cycle:Phase  3  147.6   49.21   0.728  0.547
#Residuals   21 1418.9   67.57               
#Warning message:
#In model.matrix.default(Terms, mf, contrasts) :
#  non-list contrasts argument ignored
