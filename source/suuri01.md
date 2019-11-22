---
title: 「問題解決の数理('17)」線形最適化法
date: 2019-11-22
tags: ["R", "Rglpk","lpSolve","CVXR"]
excerpt: R + GLPK
---

# 「問題解決の数理('17)」線形最適化法

(参考)  
[問題解決の数理（’１７）](https://info.ouj.ac.jp/~maps17/01_02/)  

Rglpkを利用して、RからGLPKを使用してみます。  
＊ GLPKのインストールが必要です。

凸最適化パッケージCVXRからもGLPKが利用できるのでそれもついでに。
[Integer Programming](https://cvxr.rbind.io/cvxr_examples/cvxr_integer-programming/)    

### 生産計画問題(lpSolve,Rglpk)

RglpkのコードとlpSolveのコードはよく似ています。  
[dir]ectionの"<="と">="は同じですが。lpSolveは"="も"=="もOKですが、Rglpkでは"="はエラーになります。

#### lpSolve,Rglpk 共通

```R
library(lpSolve)
library(Rglpk)
obj <- c(2,3)
mat <- rbind(c(1,3),c(4,4),c(2,1))
dir <- c("<=", "<=", "<=")
rhs <- c(24,48,22)
```

#### lpSolve

```R
res <-  lp("max", obj, mat, dir, rhs) 
res$objval
# [1] 30
res$solution
# [1] 6 6
```

#### Rglpk

```R
max <- TRUE
res<-Rglpk_solve_LP(obj, mat, dir, rhs, max = max)
unlist(res)[1:(length(obj)+1)]
#  optimum solution1 solution2 
#     "30"       "6"       "6"
```

### 輸送問題(lpSolve,Rglpk)

#### lpSolve,Rglpk 共通

```R
library(lpSolve)
library(Rglpk)
obj <- c(10,6,16,8,8,10)
mat<- rbind(
	c(1,1,1,0,0,0),
	c(0,0,0,1,1,1),
	c(1,0,0,1,0,0),
	c(0,1,0,0,1,0),
	c(0,0,1,0,0,1) )
dir <- rep("==", 5) # "=="を使います。
rhs <- c(80, 160, 120, 40, 80)
```

#### lpSolve

```R
res <-  lp("min", obj, mat, dir, rhs) 
res$objval
# [1] 2080
res$solution
# [1] 40 40  0 80  0 80
```

#### Rglpk

```R
max <- F
res<-Rglpk_solve_LP(obj, mat, dir, rhs, max = max)
unlist(res)[1:(length(obj)+1)]
#  optimum solution1 solution2 solution3 solution4 solution5 solution6 
#   "2080"      "40"      "40"       "0"      "80"       "0"      "80" 
```

### 演習問題 1.2(lpSolve,Rglpk)

#### lpSolve,Rglpk 共通

```R
library(lpSolve)
library(Rglpk)
obj<-c(240,800)
mat<-rbind(
	c(1,5),
	c(1,2),
	c(3,0) )
dir <- rep(">=", 3)
rhs<-c(240,90,60)
```

#### lpSolve

```R
res <-  lp("min", obj, mat, dir, rhs) 
res$objval
# [1] 40000
res$solution
# [1] 20 44
```

#### Rglpk

```R
max <- F
res<-Rglpk_solve_LP(obj, mat, dir, rhs, max = max)
unlist(res)[1:(length(obj)+1)]
#  optimum solution1 solution2 
#  "40000"      "20"      "44"
```

### 生産計画問題(CVXR)

```R
library(CVXR)
library(knitr)
# 最適化を行う変数は Boolは真偽値、Intは整数、Variableは実数
y1 <- Variable(2)
x <- vstack(y1) ## Create x expression
C <- matrix(c(2,3), nrow = 1)
# 目的関数はMaximizeやMinimizeを設定する
objective <- Maximize(C %*% x)
#
constraints <- list(
        x[1] + 3 * x[2] <= 24,
    4 * x[1] + 4 * x[2] <= 48,
    2 * x[1] +     x[2] <= 22,
                      x >=  0)
#
problem <- Problem(objective, constraints)
result <- solve(problem)
# 変数の値
ecos_solution <- result$getValue(x)
# 目的関数の値
ecos_value <-result$value
ecos_solution <-rbind(ecos_solution,ecos_value)
#
result <- solve(problem, solver = "GLPK")
glpk_solution <- result$getValue(x)
glpk_value <-result$value
glpk_solution<-rbind(glpk_solution,glpk_value)
#
solutions <- data.frame(ECOS = ecos_solution,
                        GLPK = glpk_solution )
row.names(solutions) <- c("$x_1$", "$x_2$","Value")
kable(solutions)
```

|      | ECOS| GLPK|
|:-----|----:|----:|
|$x_1$ |    6|    6|
|$x_2$ |    6|    6|
|Value |   30|   30|

### 輸送問題(CVXR)

```R
library(CVXR)
library(knitr)
# 最適化を行う変数は Boolは真偽値、Intは整数、Variableは実数
y1 <- Variable(6)
x <- vstack(y1) ## Create x expression
C <- matrix(c(10, 6, 16, 8, 8, 10), nrow = 1)
# 目的関数はMaximizeやMinimizeを設定する
objective <- Minimize(C %*% x)
#
constraints <- list(
	x[1] + x[2] + x[3] == 80 ,
	x[4] + x[5] + x[6] == 160 ,
	x[1] + x[4]  == 120 ,
	x[2] + x[5]  == 40 ,
	x[3] + x[6]  == 80 ,
                   x >=  0)
#
problem <- Problem(objective, constraints)
result <- solve(problem)
# 変数の値
ecos_solution <- result$getValue(x)
# 目的関数の値
ecos_value <-result$value
ecos_solution <-rbind(ecos_solution,ecos_value)
#
result <- solve(problem, solver = "GLPK")
glpk_solution <- result$getValue(x)
glpk_value <-result$value
glpk_solution<-rbind(glpk_solution,glpk_value)
#
solutions <- data.frame(ECOS = ecos_solution,
                        GLPK = glpk_solution )
row.names(solutions) <- c("$x_1$", "$x_2$", "$x_3$", "$x_4$", "$x_5$", "$x_6$","Value")
kable(solutions)
```

|      |     ECOS| GLPK|
|:-----|--------:|----:|
|$x_1$ | 4.00e+01|   40|
|$x_2$ | 4.00e+01|   40|
|$x_3$ | 5.00e-07|    0|
|$x_4$ | 8.00e+01|   80|
|$x_5$ | 1.00e-07|    0|
|$x_6$ | 8.00e+01|   80|
|Value | 2.08e+03| 2080|

### 演習問題 1.2(CVXR)

```R
library(CVXR)
library(knitr)
# 最適化を行う変数は Boolは真偽値、Intは整数、Variableは実数
y1 <- Variable(2)
x <- vstack(y1) ## Create x expression
C <- matrix(c(240,800), nrow = 1)
# 目的関数はMaximizeやMinimizeを設定する
objective <- Minimize(C %*% x)
#
constraints <- list(
        x[1] + 5 * x[2] >= 240,
        x[1] + 2 * x[2] >= 90,
    3 * x[1]            >= 60,
                      x >= 0)
#
problem <- Problem(objective, constraints)
result <- solve(problem)
# 変数の値
ecos_solution <- result$getValue(x)
# 目的関数の値
ecos_value <-result$value
ecos_solution <-rbind(ecos_solution,ecos_value)
#
result <- solve(problem, solver = "GLPK")
glpk_solution <- result$getValue(x)
glpk_value <-result$value
glpk_solution<-rbind(glpk_solution,glpk_value)
#
solutions <- data.frame(ECOS = ecos_solution,
                        GLPK = glpk_solution )
row.names(solutions) <- c("$x_1$", "$x_2$","Value")
kable(solutions)
```

|      |  ECOS|  GLPK|
|:-----|-----:|-----:|
|$x_1$ |    20|    20|
|$x_2$ |    44|    44|
|Value | 40000| 40000|


