---
title: Rで箱ひげ図１（boxplot関数とggplot）
date: 2022-03-18
tags: ["R","ggplot2","boxplot"]
excerpt: グラフを描く関数の違い その１
---

# Rで箱ひげ図１（boxplot関数とggplot）

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FRBoxplot01&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

なんとか映えするグラフが欲しい場合はggplot一択。  

ここでは、さほど装飾のないグラフを作ってみます。

> ggplot2のバージョンは`packageVersion("ggplot2")` '3.3.5'です。
> 特に欠損値があった場合どんな違いがあるのか見てみます。

## データの確認

データはirisから「Petal.Length」

```R
# ggplot2パッケージを読み込む
library(ggplot2)
# ggplot2のバージョンは
packageVersion("ggplot2")
#[1] '3.3.5'
# 標準データセットの中から「iris」データを読み込む
data(iris)
# データの要約
summary(iris)
#  Sepal.Length    Sepal.Width     Petal.Length    Petal.Width          Species  
# Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100   setosa    :50  
# 1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300   versicolor:50  
# Median :5.800   Median :3.000   Median :4.350   Median :1.300   virginica :50  
# Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199                  
# 3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800                  
# Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500  
#グループ別平均
# withを使うと、iris$...と書かずに済む(attach<->detachより気楽に使える)
# Species別の平均値
with(iris,tapply(Petal.Length,Species, mean,na.rm=T) ) 
# （不偏）標準偏差は
with(iris,tapply(Petal.Length,Species,sd,na.rm=T) ) 
```

## 欠損値のないデータの場合

### boxplot

```R
#png("Rboxplot01.png")
boxplot(Petal.Length ~ Species, data = iris,las=1)
#dev.off()
```
![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Rboxplot01.png)

```R
#png("Rboxplot02.png")
car::Boxplot(Petal.Length ~ Species, data=iris, id=list(method="y"),las=1)
# [1] "23" "99"
#dev.off()
```
![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Rboxplot02.png)
- carパッケージのBoxplot関数は外れ値の行番号も表示される。

### ggplot

シンプルなグラフ

```R
#png("Rboxplot03.png")
ggplot(iris,aes(x=Species,y=Petal.Length)) + 
geom_boxplot() + 
theme_classic()
#dev.off()
```
![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Rboxplot03.png)

## Speciesに欠損値のあるデータの場合（調査結果はあるが種がわからないデータがある）

まず、Speciesに欠損値のあるデータdatを作成

```R
dat<- iris
# ここでSpeciesにいくつか欠損値を入れる
# 値が連続した部分がないように
dat$Species[c(3,25,42,55,66,77,88,99,111,116,121,126,131)]<- NA
# datの要約
summary(dat)
#  Sepal.Length    Sepal.Width     Petal.Length    Petal.Width          Species  
# Min.   :4.300   Min.   :2.000   Min.   :1.000   Min.   :0.100   setosa    :47  
# 1st Qu.:5.100   1st Qu.:2.800   1st Qu.:1.600   1st Qu.:0.300   versicolor:45  
# Median :5.800   Median :3.000   Median :4.350   Median :1.300   virginica :45  
# Mean   :5.843   Mean   :3.057   Mean   :3.758   Mean   :1.199   NA's      :13  
# 3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.:5.100   3rd Qu.:1.800                  
# Max.   :7.900   Max.   :4.400   Max.   :6.900   Max.   :2.500                  
```

Speciesに欠損値が１３箇所できました（NA's :13）

### boxplot

```R
#png("Rboxplot04.png")
boxplot(Petal.Length ~ Species, data = dat,las=1)
#dev.off()
```
![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Rboxplot04.png)

### ggplot

```R
#png("Rboxplot05.png")
ggplot(dat,aes(x=Species,y=Petal.Length)) + 
geom_boxplot() + 
theme_classic()
#dev.off()
```
![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Rboxplot05.png)

欠損値の箱ひげ図が付け加わっている

これを消すには `scale_x_discrete(na.translate = FALSE)` を加える

```R
#png("Rboxplot06.png")
ggplot(dat,aes(x=Species,y=Petal.Length)) + 
geom_boxplot() + 
theme_classic() + 
scale_x_discrete(na.translate = FALSE)
#dev.off()
```

 警告:  Removed 13 rows containing missing values (stat_boxplot).

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Rboxplot06.png)

## Speciesだけでなく調査値にも欠損値のあるデータの場合

### サンプルデータの作成

```R
dat2<- dat
# Speciesが欠損値ではない行のPetal.Lengthを欠損値にする(+1する)
dat2$Petal.Length[c(3,25,42,55,66,77,88,99,111,116,121,126,131)+1] <- NA
# setosaのところに外れ値を２個追加（Speciesが欠損値の箇所とそうでない箇所）
dat2$Petal.Length[c(3,20)] <- 20
# 確認
summary(dat2)
#  Sepal.Length    Sepal.Width     Petal.Length     Petal.Width          Species  
# Min.   :4.300   Min.   :2.000   Min.   : 1.000   Min.   :0.100   setosa    :47  
# 1st Qu.:5.100   1st Qu.:2.800   1st Qu.: 1.600   1st Qu.:0.300   versicolor:45  
# Median :5.800   Median :3.000   Median : 4.400   Median :1.300   virginica :45  
# Mean   :5.843   Mean   :3.057   Mean   : 3.996   Mean   :1.199   NA's      :13  
# 3rd Qu.:6.400   3rd Qu.:3.300   3rd Qu.: 5.100   3rd Qu.:1.800                  
# Max.   :7.900   Max.   :4.400   Max.   :20.000   Max.   :2.500                  
#                                 NA's   :13                                     
```

### boxplot

```R
#png("Rboxplot07.png")
boxplot(Petal.Length ~ Species, data = dat2,las=1)
#dev.off()
```
![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Rboxplot07.png)

- 故意に入れた欠損値は１つだけ表示される。Speciesが欠損値部分に入れた欠損値は表示されない。

### ggplot

```R
#png("Rboxplot08.png")
ggplot(dat2,aes(x=Species,y=Petal.Length)) + 
geom_boxplot() + 
theme_classic()
#dev.off()
```

 警告:  Removed 13 rows containing non-finite values (stat_boxplot).  

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Rboxplot08.png)

故意に入れた欠損値は２つ。Speciesが欠損値部分に入れた欠損値も表示される。

```R
#png("Rboxplot09.png")
ggplot(dat2,aes(x=Species,y=Petal.Length)) + 
geom_boxplot() + 
theme_classic() + 
scale_x_discrete(na.translate = FALSE)
#dev.off()
```

 警告メッセージ: 
1: Removed 13 rows containing missing values (stat_boxplot).   
2: Removed 13 rows containing non-finite values (stat_boxplot). 

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Rboxplot09.png)

> 「箱ひげ図」の欠損処理には`scale_x_discrete(na.translate = FALSE)` を加えるとよい。ところが「ヒストグラム」では。

## Speciesに分けない場合（グラフは省略。書き方だけ）

### boxplot

ベクトルを与えるだけ

```R
boxplot(iris$Petal.Length,las=1)
# こう書いても良い
with(iris,boxplot(Petal.Length,las=1))
```

### ggplot

データフレームを与えなければならないのでやっかい。検索して調べた。
ラベル名とか"１"とか消さないとだめだけどめんどうなのでここまで。

```R
ggplot(iris,aes(x=factor(1),y=Petal.Length)) +
geom_boxplot()
```

## （おまけ）Factorが２つある場合

使用するデータは「warpbreaks」

```R
# warpbreaks:羊毛(wool)が２種類、張力(Tension)が３種類の、６通りの組合せについて、切れた(break)数のデータ
data(warpbreaks)
str(warpbreaks)
#'data.frame':	54 obs. of  3 variables:
# $ breaks : num  26 30 54 25 70 52 51 26 67 18 ...
# $ wool   : Factor w/ 2 levels "A","B": 1 1 1 1 1 1 1 1 1 1 ...
# $ tension: Factor w/ 3 levels "L","M","H": 1 1 1 1 1 1 1 1 1 2 ...
summary(warpbreaks)
#     breaks      wool   tension
# Min.   :10.00   A:27   L:18   
# 1st Qu.:18.25   B:27   M:18   
# Median :26.00          H:18   
# Mean   :28.15                 
# 3rd Qu.:34.00                 
# Max.   :70.00  
```

### まずはggplotから

```R
library(ggplot2)
#png("Rboxplot10.png")
# Factorの一方をx、もう一方をfillに指定するだけ
ggplot(data = warpbreaks, aes(x = wool, y = breaks, fill = tension)) + 
geom_boxplot() +
theme_classic()
#dev.off()
```
![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Rboxplot10.png)

### boxplot

```R
# tension+wool：Factorを+で結ぶ
#png("Rboxplot11.png")
boxplot(breaks~tension+wool,data=warpbreaks,las=1)
#dev.off()
```
![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Rboxplot11.png)

#### ggplotみたいにするには

```R
#png("Rboxplot12.png")
boxplot(breaks~tension+wool,data=warpbreaks,las=1,xaxt="n",xlab="wool",col=rep(c("royalblue3","brown3","orange"),3))
axis(1,at=c(2,5),labels=c("A","B"))
legend("topright",inset=0.03,pch=15,cex=1.2,col=c("royalblue3","brown3","orange"),legend=levels(warpbreaks$tension),title="tension")
#dev.off()
```
![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Rboxplot12.png)

