require(rbenchmark)

evalParse <- function() {
  set.seed(20211225)
  # eval + parse + text パターン
  strDataName <- "x"
  strFuncName1 <- "mean"
  strFuncName2 <- "rnorm"
  strDataValue <- "2"

  command <- paste(
    strDataName, "<-",
    strFuncName1, "(", strDataValue, ")",
    sep = ""
  )
  eval(parse(text = command), envir = .GlobalEnv)

}

evalSubstitute <- function() {
  set.seed(20211225)

  # eval + substitute + do.call パターン
  args <- list(
    data = "x",
    fun1 = "mean",
    fun2 = "rnorm",
    arg1 = "2"
  )
  # substitute(R の命令文, 環境 or オブジェクトリスト)
  # do.call(関数名, 引数リスト)
  eval(
   substitute(
    data <- do.call(
      fun1,
      list(x = do.call(fun2, list(n = arg1)))
      ),
      args
    ),
   envir = .GlobalEnv
  )

}

res <- benchmark(
  evalSubstitute(),
  evalParse(),
  columns = c("test", "replications", "elapsed", "relative", "user.self", "sys.self"),
  order = "relative",
  replications = 10000
)

print(res)
#               test replications elapsed relative user.self sys.self
# 1 evalSubstitute()        10000   0.294    1.000     0.291    0.000
# 2      evalParse()        10000   0.617    2.099     0.608    0.008
