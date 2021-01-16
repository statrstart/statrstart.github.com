---
title: Rでtwinspan
date: 2021-01-16
tags: ["R", "twinspanR","vegan"]
excerpt: Rを使ってtwinspan
---

# Rでtwinspanの比較（modified TWINSPAN(modif = T) vs Standard TWINSPAN(modif = F)  ）

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2Ftwinspan01&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)


## （注意）今回の記事のＲコードは「twinspanR:Example Code」そのままです。(手抜き!!)

(参考)  
[Analysis of community ecology data in R twinspan : David Zelený ](https://www.davidzeleny.net/anadat-r/doku.php/en:hier-divisive)  

Rでtwinspanできるパッケージ  
[library(twinspanR), David Zelený](https://github.com/zdealveindy/twinspanR)  
- modified TWINSPAN(modif = T) & Standard TWINSPAN(modif = F)
- it can be installed only on Windows platform (since the engine of the library is based on running *.exe file externally) 

[library (twinspan), Jari Oksanen](https://github.com/jarioksa/twinspan)  
- importing the original FORTRAN code into R

twinspanR package のおもしろいところは、RからtwinspanR package付属の「twinspan.exe」を呼び出し、使っているところ。  
「twinspan.exe」はwineを使うと、linuxからでも使える。

この記事では、twinspanR packageとvegan付属のdatasetsを使って、modified TWINSPANとStandard TWINSPANのちょっとした比較をしてみました。

## グラフ（あくまで、一例）

（注意）  
「Standard TWINSPAN」の場合は分ける基準はlevelであって、clusterの数ではない。  
「modified TWINSPAN」の場合はclusterの数。（これが「modified TWINSPAN」の大きな利点）  

### dune (Package: vegan)

![tw01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/tw01.png)

- Standard TWINSPAN　はlevel=2で４つに分かれた。modified TWINSPAN は４つに分けた。同じ。

### mite (Package: vegan)

![tw02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/tw02.png)

- modified TWINSPAN は３つに分けた、 Standard TWINSPAN　はlevel=2で４つに分かれた。違う。

### BCI (Package: vegan)

![tw03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/tw03.png)

- modified TWINSPAN は３つに分けた、 Standard TWINSPAN　はlevel=2で４つに分かれた。違う。

### sipoo (Package: vegan)

![tw04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/tw04.png)

- Standard TWINSPAN　はlevel=2で３つに分かれた。modified TWINSPAN は３つに分けた。同じ。

### pyrifos (Package: vegan)

![tw05](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/tw05.png)

- modified TWINSPAN は３つに分けた、 Standard TWINSPAN　はlevel=2で４つに分かれた。違う。

### varespec (Package: vegan)

![tw06](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/tw06.png)

- Standard TWINSPAN　はlevel=2で４つに分かれた。modified TWINSPAN は４つに分けた。同じ。

### danube (Package: twinspanR) <- twinspanR付属のデータセット

![tw07](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/tw07.png)

- Standard TWINSPAN　はlevel=2で３つに分かれた。modified TWINSPAN は３つに分けた。違う。

## Rコード

[twinspanR:Example Code](https://www.davidzeleny.net/anadat-r/doku.php/en:hier-divisive_examples)  

### データセットの読み込み

```R
data(dune)
data<- dune
```

```R
data(mite)
data<- mite
```

```R
data(BCI)
data<- BCI
```

```R
data(sipoo)
data<- sipoo
```

```R
data(pyrifos)
data<- pyrifos
```

```R
data(varespec)
data<- varespec
```

```R
data(danube)
data<- danube$spe
```

### 実行(違うのは、modified TWINSPAN : cluster= とStandard TWINSPAN : level= にいれる数だけですのでひとつにした。)


```R
res <- twinspan(data, modif = TRUE)
# one of c('species.names', 'order.plots', 'reading.data', 'input.parameters', 'levels', 'table', 'twi')
print (res, 'table')
( k <- cut(res,cluster=4) )
table(k)
#
res2 <- twinspan(data, modif = F)
# one of c('species.names', 'order.plots', 'reading.data', 'input.parameters', 'levels', 'table', 'twi')
print(res2, 'table')
( k2 <- cut(res2,level=2) )
table(k2)
#
dca <- decorana(data)
#
#png("tw01.png",width=800,height=600)
par (mfrow = c(1,2))
# Modified TWINSPAN
ordiplot (dca, type = 'n', display = 'si', main = 'Modified TWINSPAN')
points (dca, col = k)
# 
for (i in c(1,2,4)) ordihull (dca, groups = k, show.group = i, col = i,
 draw = 'polygon', label = TRUE)
#
# Standard TWINSPAN (Hill 1979)
ordiplot (dca, type = 'n', display = 'si', main = 'Standard TWINSPAN (Hill 1979)')
points (dca, col = k2)
# 
for (i in c(2:4)) ordihull (dca, groups = k2, show.group = i, col = i,
 draw = 'polygon', label = TRUE)
#
par (mfrow = c(1,1))
#dev.off()
```

