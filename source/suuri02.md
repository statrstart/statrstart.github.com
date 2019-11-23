---
title: 「問題解決の数理('17)」ネットワーク最適化法
date: 2019-11-23
tags: ["R", "Rglpk","lpSolve","CVXR"]
excerpt: R + GLPK
---

# 「問題解決の数理('17)」ネットワーク最適化法

(参考)  
[問題解決の数理（’１７）](https://info.ouj.ac.jp/~maps17/01_02/)  

Rglpkを利用して、RからGLPKを使用してみます。  
＊ GLPKのインストールが必要です。

凸最適化パッケージCVXRからもGLPKが利用できるのでそれもついでに。
[Integer Programming](https://cvxr.rbind.io/cvxr_examples/cvxr_integer-programming/)    

### 最短路問題(lpSolve,Rglpk)

RglpkのコードとlpSolveのコードはよく似ています。  
[dir]ectionの"<="と">="は同じですが。lpSolveは"="も"=="もOKですが、Rglpkでは"="はエラーになります。

#### lpSolve,Rglpk 共通

```R
library(lpSolve)
library(Rglpk)
w12 <- 1
w13 <- 5
w21 <- 1
w23 <- 2
w24 <- 2
w31 <- 5
w32 <- 4
w35 <- 2
w43 <- 3
w46 <- 3
w53 <- 1
w56 <- 4
obj <- c(w12,w13,w21,w23,w24,w31,w32,w35,w43,w46,w53,w56)
mat <- rbind(
		c(1,1,-1,0,0,-1,0,0,0,0,0,0),  
		c(-1,0,1,1,1,0,-1,0,0,0,0,0),  
		c(0,-1,0,-1,0,1,1,1,-1,0,-1,0),  
		c(0,0,0,0,-1,0,0,0,1,1,0,0),  
		c(0,0,0,0,0,0,0,-1,0,0,1,1),  
		c(0,0,0,0,0,0,0,0,0,-1,0,-1)
		)
dir <- rep("==",6)
rhs <- c(1, 0, 0, 0, -1, 0)
```

#### lpSolve

```R
res <-  lp("min", obj, mat, dir,rhs, binary.vec=1:12)
# 0-1IPなので，変数1-16は2値 binary.vec = 1:12,
res$objval
# [1] 5
res$solution
# [1] 1 0 0 1 0 0 0 1 0 0 0 0
```

#### Rglpk

```R
max <- F
types <- rep("B",12)
res<-Rglpk_solve_LP(obj, mat, dir, rhs, max = max,types = types)
unlist(res)[1:(length(obj)+1)]
#   optimum  solution1  solution2  solution3  solution4  solution5  solution6 
#       "5"        "1"        "0"        "0"        "1"        "0"        "0" 
# solution7  solution8  solution9 solution10 solution11 solution12 
#       "0"        "1"        "0"        "0"        "0"        "0"
```

### 最大流問題(lpSolve,Rglpk)

#### lpSolve,Rglpk 共通

```R
library(lpSolve)
library(Rglpk)
obj <- c(1,1,0,0,0,0,0,0,0)
# x12 x13 x24 x25 x34 x36 x47 x57 x67
mat <- rbind(
		c(-1,0,1,1,0,0,0,0,0), 
		c(0,-1,0,0,1,1,0,0,0), 
		c(0,0,-1,0,-1,0,1,0,0), 
		c(0,0,0,-1,0,0,0,1,0), 
		c(0,0,0,0,0,-1,0,0,1),  
		c(1,0,0,0,0,0,0,0,0), 
		c(0,1,0,0,0,0,0,0,0), 
		c(0,0,1,0,0,0,0,0,0), 
		c(0,0,0,1,0,0,0,0,0), 
		c(0,0,0,0,1,0,0,0,0), 
		c(0,0,0,0,0,1,0,0,0), 
		c(0,0,0,0,0,0,1,0,0), 
		c(0,0,0,0,0,0,0,1,0), 
		c(0,0,0,0,0,0,0,0,1)
		)
dir <- c(rep("==",5),rep("<=",9))
rhs <- c(0,0,0,0,0, 3,5,2,2,3,3,2,3,4)
```

#### lpSolve

```R
res <-  lp("max", obj, mat, dir, rhs) 
res$objval
# [1] 7
res$solution
# [1] 3 4 1 2 1 3 2 2 3
```

#### Rglpk

```R
max <- T
res<-Rglpk_solve_LP(obj, mat, dir, rhs, max = max)
unlist(res)[1:(length(obj)+1)]
#  optimum solution1 solution2 solution3 solution4 solution5 solution6 solution7 
#      "7"       "3"       "4"       "1"       "2"       "1"       "3"       "2" 
#solution8 solution9 
#      "2"       "3" 
```

### 演習問題 3.5 (最小費用流問題)(lpSolve,Rglpk)

#### lpSolve,Rglpk 共通

```R
library(lpSolve)
library(Rglpk)
c12 <- 3
c13 <- 5
c24 <- 2
c25 <- 2
c34 <- 3
c36 <- 3
c47 <- 3
c57 <- 2
c68 <- 4
#
u12 <- 20
u13 <- 25
u24 <- 15
u25 <- 20
u34 <- 20
u36 <- 15
u47 <- 30
u57 <- 20
u68 <- 15
#
b1 <- 40
b2 <- 0
b3 <- 0
b4 <- 0
b5 <- 0
b6 <- 0
b7 <- -30
b8 <- -10
obj <- c(c12, c13, c24, c25, c34, c36, c47, c57, c68)
mat <- rbind(
		c(1,1,0,0,0,0,0,0,0),  
		c(-1,0,1,1,0,0,0,0,0),  
		c(0,-1,0,0,1,1,0,0,0),  
		c(0,0,-1,0,-1,0,1,0,0),  
		c(0,0,0,-1,0,0,0,1,0),  
		c(0,0,0,0,0,-1,0,0,1),  
		c(0,0,0,0,0,0,-1,-1,0),  
		c(0,0,0,0,0,0,0,0,-1),  
		c(1,0,0,0,0,0,0,0,0),  
		c(0,1,0,0,0,0,0,0,0),  
		c(0,0,1,0,0,0,0,0,0),  
		c(0,0,0,1,0,0,0,0,0),  
		c(0,0,0,0,1,0,0,0,0),  
		c(0,0,0,0,0,1,0,0,0),  
		c(0,0,0,0,0,0,1,0,0),  
		c(0,0,0,0,0,0,0,1,0),  
		c(0,0,0,0,0,0,0,0,1)
		)
dir <- c(rep("==", 8), rep("<=", 9))
rhs <- c(b1,b2,b3,b4,b5,b6,b7,b8,u12,u13,u24,u25,u34,u36,u47,u57,u68)
```

#### lpSolve

```R
res <-  lp("min", obj, mat, dir, rhs) 
res$objval
# [1] 370
res$solution
# [1] 20 20  0 20 10 10 10 20 10
```

#### Rglpk

```R
max <- F
res<-Rglpk_solve_LP(obj, mat, dir, rhs, max = max)
unlist(res)[1:(length(obj)+1)]
#  optimum solution1 solution2 solution3 solution4 solution5 solution6 solution7 
#    "370"      "20"      "20"       "0"      "20"      "10"      "10"      "10" 
#solution8 solution9 
#     "20"      "10" 
```

### 最短路問題(CVXR)

```R
library(CVXR)
library(knitr)
w12 <- 1
w13 <- 5
w21 <- 1
w23 <- 2
w24 <- 2
w31 <- 5
w32 <- 4
w35 <- 2
w43 <- 3
w46 <- 3
w53 <- 1
w56 <- 4
# 最適化を行う変数は Boolは真偽値、Intは整数、Variableは実数
y1 <- Bool(12)
x <- vstack(y1) ## Create x expression
C <- matrix(c(w12,w13,w21,w23,w24,w31,w32,w35,w43,w46,w53,w56), nrow = 1)
# 目的関数はMaximizeやMinimizeを設定する
objective <- Minimize(C %*% x)
#
constraints <- list(
        x[1] + x[2] - (x[3] + x[6]) ==  1,
        x[11] + x[12] - x[8]        == -1,
        x[3] + x[4] + x[5] - (x[1] + x[7]) == 0,
        x[6] + x[7] + x[8] - (x[2] + x[4] + x[9] + x[11]) == 0,
        x[9] + x[10] - x[5] == 0,
      -(x[10] + x[12]) == 0)
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
row.names(solutions) <- c(paste0("x",1:12),"Value")
kable(solutions)
```

|      | ECOS| GLPK|
|:-----|----:|----:|
|x1    |    1|    1|
|x2    |    0|    0|
|x3    |    0|    0|
|x4    |    1|    1|
|x5    |    0|    0|
|x6    |    0|    0|
|x7    |    0|    0|
|x8    |    1|    1|
|x9    |    0|    0|
|x10   |    0|    0|
|x11   |    0|    0|
|x12   |    0|    0|
|Value |    5|    5|


### 最大流問題(CVXR)

```R
library(CVXR)
library(knitr)
# 最適化を行う変数は Boolは真偽値、Intは整数、Variableは実数
y1 <- Int(9)
x <- vstack(y1) ## Create x expression
C <- matrix( c(1,1,0,0,0,0,0,0,0), nrow = 1)
# 目的関数はMaximizeやMinimizeを設定する
objective <- Maximize(C %*% x)
#
constraints <- list(
        -x[1] + x[3] + x[4]  == 0,
        -x[2] + x[5] + x[6]  == 0,
        -x[3] - x[5] + x[7]  == 0,
        -x[4] + x[8]         == 0,
        -x[6] + x[9]         == 0,
			x[1] <= 3, 
			x[2] <= 5,
			x[3] <= 2, 
			x[4] <= 2,
			x[5] <= 3, 
			x[6] <= 3,
			x[7] <= 2, 
			x[8] <= 3,
			x[9] <= 4  )
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
row.names(solutions) <- c(paste0("x",1:9),"Value")
kable(solutions)
```

|      | ECOS| GLPK|
|:-----|----:|----:|
|x1    |    3|    3|
|x2    |    4|    4|
|x3    |    1|    1|
|x4    |    2|    2|
|x5    |    1|    1|
|x6    |    3|    3|
|x7    |    2|    2|
|x8    |    2|    2|
|x9    |    3|    3|
|Value |    7|    7|


### 演習問題 3.5 (最小費用流問題)(CVXR)

```R
library(CVXR)
library(knitr)
c12 <- 3
c13 <- 5
c24 <- 2
c25 <- 2
c34 <- 3
c36 <- 3
c47 <- 3
c57 <- 2
c68 <- 4
# 最適化を行う変数は Boolは真偽値、Intは整数、Variableは実数
y1 <- Variable(9)
x <- vstack(y1) ## Create x expression
C <- matrix( c(c12, c13, c24, c25, c34, c36, c47, c57, c68), nrow = 1)
# 目的関数はMaximizeやMinimizeを設定する
objective <- Minimize(C %*% x)
#
constraints <- list(
	x[1] + x[2]         == 40 ,
	-x[1] + x[3] + x[4] == 0 ,
	-x[2] + x[5] + x[6] == 0 ,
	-x[3] - x[5] + x[7] == 0 ,
	-x[4] + x[8]        == 0 ,
	-x[6] + x[9]        == 0 ,
	-x[7] - x[8]        == -30 ,
	-x[9]               == -10 ,
	x[1]                <= 20 ,
	x[2]                <= 25 ,
	x[3]                <= 15 ,
	x[4]                <= 20 ,
	x[5]                <= 20 ,
	x[6]                <= 15 ,
	x[7]                <= 30 ,
	x[8]                <= 20 ,
	x[9]                <= 15 )
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
row.names(solutions) <- c(paste0("x",1:9),"Value")
kable(solutions)
```

|      | ECOS| GLPK|
|:-----|----:|----:|
|x1    |   20|   20|
|x2    |   20|   20|
|x3    |    0|    0|
|x4    |   20|   20|
|x5    |   10|   10|
|x6    |   10|   10|
|x7    |   10|   10|
|x8    |   20|   20|
|x9    |   10|   10|
|Value |  370|  370|

