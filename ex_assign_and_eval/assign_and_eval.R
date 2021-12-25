# assign function
a <- 10
assign("a", 10) # equal
# paste function
x <- paste("Hello", "World", sep = "") # "HelloWorld"
x <- paste("Hello", "World", sep = " ") # "Hello World"



for(i in 1:6) { #-- Create objects  'r.1', 'r.2', ... 'r.6' --
      nam <- paste("r", i, sep = ".")
        assign(nam, 1:i) # r.1 -> 1, r.2 -> 1,2, ... r.6 -> 1,2,3,4,5,6
}
print(ls(pattern = "^r..$"))
# [1] "r.1" "r.2" "r.3" "r.4" "r.5" "r.6"

# create vecters
# create objects by for loop

for( i in seq(5)){
  assign(paste("Test", i, sep = ""),
         # sample func: if replace = T and sampling from over 200, Walket's alias method (Ripley, 1987) is used
         sample(10:100, size = 10, replace = TRUE),
         env = .GlobalEnv) # set as global variable
}

# create dataframes by for loop
for( i in seq(5)) {
  assign(paste("TestDF", i, sep = ""),
         data.frame(TEST1 = sample(10:100, size = 10, replace = TRUE),
                    TEST2 = sample(200:300, size = 10, replace = TRUE)),
         env = .GlobalEnv)
}

print(ls())

#  [1] "i"       "Test1"   "Test2"   "Test3"   "Test4"   "Test5"   "TestDF1"
#  [8] "TestDF2" "TestDF3" "TestDF4" "TestDF5"

# eval(parse(text = "commands"))
# print Test1 to Test5 with labels
for( i in seq(5)) {
  cat(eval(parse(text = paste("Test", i, sep = ""))),
      labels = paste("Test", i, ":", sep = ""), fill = TRUE)
}

# Test1: 86 10 47 73 17 59 42 12 77 99
# Test2: 56 27 90 52 38 86 53 31 99 85
# Test3: 68 37 88 50 11 56 41 30 58 60
# Test4: 61 73 73 16 31 97 32 21 31 62
# Test5: 31 92 56 16 94 62 92 13 16 50

# Plot TestDF1 to TestDF5 in a canvas
layout(matrix(seq(5), rep(1, 5)), 1, 5)
ColSet <- c("#d9bb9c", "#4b61ba", "#deb7a0", "#a87963", "#28231e")

for( i in seq(5)) {
  plot(eval(parse(text = paste("TestDF", i, "[, 1]", sep = ""))),
       eval(parse(text = paste("TestDF", i, "[, 2]", sep = ""))),
       xlab = "", ylab = "", main = paste("TestDF", i, sep = ""),
       col = ColSet[i], pch = 15, cex = 4)
}

# > paste("TestDF", 1, "[, 1]", sep = "")
# [1] "TestDF1[, 1]"
# > parse(text = paste("TestDF", 1, "[, 1]", sep = ""))
# expression(TestDF1[, 1])
# > eval(parse(text = paste("TestDF", 1, "[, 1]", sep = "")))
#  [1] 78 62 95 68 95 36 87 55 18 29

# eval(substitute(do.call()))

# yarrr
library(yarrr)

par(mfrow = c(2,2))
loop.vector <- 1:4

for (i in loop.vector) {
  x <- examscores[, i]
  hist(x,
       main = paste("Question", i),
       xlab = "Scores",
       xlim = c(0, 100))
}
