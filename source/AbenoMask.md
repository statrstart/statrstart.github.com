---
title: gtrendsRでアベノマスク (新型コロナウイルス：Coronavirus)
date: 2020-04-21
tags: ["R","gtrendsR", "Coronavirus","Japan","新型コロナウイルス"]
excerpt: アベノマスク !
---

# gtrendsRでアベノマスク (新型コロナウイルス：Coronavirus) 
![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FAbenoMask)

(関連ニュース)  
[アベノマスク出典: フリー百科事典『ウィキペディア（Wikipedia）』](https://ja.wikipedia.org/wiki/%E3%82%A2%E3%83%99%E3%83%8E%E3%83%9E%E3%82%B9%E3%82%AF)  
[政府、アベノマスク製造元の公表を頑なに拒否。衛生用品としての品質を疑う声も 2020年4月20日](https://www.mag2.com/p/money/912777)   
[政府の妊婦向け布マスクに「変色」「髪の毛混入」など不良品の報告相次ぐ 4/18(土) 22:25配信 ](https://headlines.yahoo.co.jp/hl?a=20200418-00050263-yom-soci)

##### 2020-04-04
[Bloomberg:From Abenomics to Abenomask: Japan Mask Plan Meets With Derision](https://www.bloomberg.com/news/articles/2020-04-02/from-abenomics-to-abenomask-japan-mask-plan-meets-with-derision)  
[The Japan Times:Abenomask? Prime minister's 'two masks per household' policy spawns memes on social media](https://www.japantimes.co.jp/news/2020/04/02/national/abe-two-masks-social-media/#.XoZ5FelUvZs)  
[Nikkei Asian Review:Abe faces calls for decisive action after 'Abenomask' blunder(Emergency declaration gives government limited power compared with other nations)](https://asia.nikkei.com/Spotlight/Coronavirus/Abe-faces-calls-for-decisive-action-after-Abenomask-blunder)  
[CNN:Anger as Japanese Prime Minister offers two cloth masks per family while refusing to declare coronavirus emergency](https://edition.cnn.com/2020/04/02/asia/japan-coronavirus-shinzo-abe-masks-hnk-intl/index.html)  
[FOCUS: Citizens mock Abe's plan to provide cloth face masks to fight virus](https://english.kyodonews.net/news/2020/04/e9ac1302215a-focus-citizens-mock-abes-plan-to-provide-cloth-face-masks-to-fight-virus.html)    

### 2020-04-01 2020-04-18 時系列トレンドをプロット 

![AbenoMask02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/AbenoMask02.png)

### 2020-04-04 : 時系列トレンドをプロット（xtsパッケージを使った。）

![AbenoMask01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/AbenoMask01.png)

## Rコード

### 2020-04-01 2020-04-18

```R
#devtools::install_github("PMassicotte/gtrendsR")
library(gtrendsR)
library(knitr)
AbenoMask <- gtrends(c("アベノマスク"), time="2020-04-01 2020-04-18",geo="JP")
dat<-AbenoMask[[1]][,c("date", "hits")]
dat$hits<-as.numeric(gsub("<","",dat$hits))
#png("AbenoMask02.png",width=800,height=600)
date<- sub("-","/",sub("-0","-",sub("^0","",sub("2020-","",dat$date))))
barplot(dat$hits,names=date,col="pink",ylim=c(0,max(dat$hits)*1.05),las=1,
	main="ピーク時を100としたときの検索割合の推移（キーワード：アベノマスク）")
#dev.off()
```

```R
kable(head(AbenoMask$related_topics,6),row.names=T)
```

|   |subject |related_topics |value         |geo |keyword      | category|
|:--|:-------|:--------------|:-------------|:---|:------------|--------:|
|1  |100     |top            |Naoki Urasawa |JP  |アベノマスク |        0|
|2  |59      |top            |Abeno Ward    |JP  |アベノマスク |        0|
|3  |39      |top            |Shinzō Abe   |JP  |アベノマスク |        0|
|4  |30      |top            |Sazae-san     |JP  |アベノマスク |        0|
|5  |23      |top            |Abenomics     |JP  |アベノマスク |        0|
|6  |13      |top            |Donation      |JP  |アベノマスク |        0|


```R
kable(head(AbenoMask$related_queries,17),row.names=T)
```

|   |subject |related_queries |value                         |geo |keyword      | category|
|:--|:-------|:---------------|:-----------------------------|:---|:------------|--------:|
|1  |100     |top             |アベノマスク 浦沢             |JP  |アベノマスク |        0|
|2  |88      |top             |アベノマスク 製造元           |JP  |アベノマスク |        0|
|3  |79      |top             |浦沢 直樹 アベノマスク        |JP  |アベノマスク |        0|
|4  |74      |top             |浦沢 直樹                     |JP  |アベノマスク |        0|
|5  |61      |top             |アベノマスク 小さい           |JP  |アベノマスク |        0|
|6  |57      |top             |アベノマスク twitter          |JP  |アベノマスク |        0|
|7  |39      |top             |アベノマスク 届い た          |JP  |アベノマスク |        0|
|8  |27      |top             |アベノマスク サザエ さん      |JP  |アベノマスク |        0|
|9  |22      |top             |アベノマスク 寄付             |JP  |アベノマスク |        0|
|10 |22      |top             |アベノマスク 費用             |JP  |アベノマスク |        0|
|11 |22      |top             |アベノマスク urasawa          |JP  |アベノマスク |        0|
|12 |17      |top             |アベノマスク 山口 県          |JP  |アベノマスク |        0|
|13 |13      |top             |アベノマスク いつ             |JP  |アベノマスク |        0|
|14 |13      |top             |アベノマスク いつから         |JP  |アベノマスク |        0|
|15 |9       |top             |阿部 の マスク                |JP  |アベノマスク |        0|
|16 |4       |top             |アベノマスク twitter イラスト |JP  |アベノマスク |        0|
|17 |4       |top             |浦沢 直樹 氏 アベノマスク     |JP  |アベノマスク |        0|

### 2020-04-04
### Googleトレンドデータを入手。直近７日

```R
#devtools::install_github("PMassicotte/gtrendsR")
library(gtrendsR)
library(xts)
library(knitr)
AbenoMask <- gtrends(c("AbenoMask"), time="now 7-d")
names(AbenoMask)
#
#[1] "interest_over_time"  "interest_by_country" "interest_by_region" 
#[4] "interest_by_dma"     "interest_by_city"    "related_topics"     
#[7] "related_queries" 
```

### 時系列トレンドをプロット（xtsパッケージを使った。）

```R
dat<-AbenoMask[[1]][,c("date", "hits")]
dat$hits<-as.numeric(gsub("<","",dat$hits))
#
dat.xts <- xts(dat[,-1], strptime(dat$date, "%Y-%m-%d %H:%M:%S"))
# 日本時間に直すために9時間（9*60*60 秒）加える
index(dat.xts)<-index(dat.xts)+9*60*60
colnames(dat.xts)<-"hits"
#
#png("AbenoMask01.png",width=800,height=600)
plot.xts(dat.xts,type="h",lend=1,lwd=5,col="red",ylim=c(-5,max(dat.xts$hits)*1.05),
	main="ピーク時を100としたときの検索割合の推移（キーワード：AbenoMask）")
#dev.off()
```

### interest_by_country

```R
kable(head(AbenoMask$interest_by_country,5),row.names=T)
```

|   |location       | hits|keyword   |geo   |gprop |
|:--|:--------------|----:|:---------|:-----|:-----|
|1  |Japan          |  100|AbenoMask |world |web   |
|2  |Singapore      |   29|AbenoMask |world |web   |
|3  |South Korea    |   17|AbenoMask |world |web   |
|4  |United States  |    2|AbenoMask |world |web   |
|5  |United Kingdom |    2|AbenoMask |world |web   |

```R
kable(head(AbenoMask$interest_by_city,11),row.names=T)
```

|   |location  | hits|keyword   |geo   |gprop |
|:--|:---------|----:|:---------|:-----|:-----|
|1  |Bunkyo    |  100|AbenoMask |world |web   |
|2  |Setagaya  |   67|AbenoMask |world |web   |
|3  |Minato    |   63|AbenoMask |world |web   |
|4  |Shinagawa |   61|AbenoMask |world |web   |
|5  |Chiyoda   |   61|AbenoMask |world |web   |
|6  |Koto      |   55|AbenoMask |world |web   |
|7  |Suginami  |   53|AbenoMask |world |web   |
|8  |Shibuya   |   47|AbenoMask |world |web   |
|9  |Shinjuku  |   39|AbenoMask |world |web   |
|10 |Yokohama  |   38|AbenoMask |world |web   |
|11 |Kawasaki  |   34|AbenoMask |world |web   |

```R
kable(head(AbenoMask$related_topics,15),row.names=T)
```

|   |subject |related_topics |value              |keyword   | category|
|:--|:-------|:--------------|:------------------|:---------|--------:|
|1  |100     |top            |Abenomics          |AbenoMask |        0|
|2  |77      |top            |Bloomberg          |AbenoMask |        0|
|3  |62      |top            |CNN International  |AbenoMask |        0|
|4  |61      |top            |Japan              |AbenoMask |        0|
|5  |53      |top            |Japanese people    |AbenoMask |        0|
|6  |50      |top            |Japanese Language  |AbenoMask |        0|
|7  |42      |top            |Respirator         |AbenoMask |        0|
|8  |33      |top            |Policy             |AbenoMask |        0|
|9  |29      |top            |Shinzō Abe        |AbenoMask |        0|
|10 |22      |top            |Yahoo! Japan       |AbenoMask |        0|
|11 |14      |top            |Household          |AbenoMask |        0|
|12 |14      |top            |CORONA CORPORATION |AbenoMask |        0|
|13 |12      |top            |Abeno Ward         |AbenoMask |        0|
|14 |11      |top            |Sazae-san          |AbenoMask |        0|
|15 |9       |top            |The Japan Times    |AbenoMask |        0|

```R
kable(head(AbenoMask$related_queries,24),row.names=T)
```

|   |subject |related_queries |value                       |keyword   | category|
|:--|:-------|:---------------|:---------------------------|:---------|--------:|
|1  |100     |top             |abenomics abenomask         |AbenoMask |        0|
|2  |100     |top             |abenomics                   |AbenoMask |        0|
|3  |91      |top             |アベノマスク                |AbenoMask |        0|
|4  |71      |top             |bloomberg abenomask         |AbenoMask |        0|
|5  |71      |top             |bloomberg                   |AbenoMask |        0|
|6  |68      |top             |abenomask cnn               |AbenoMask |        0|
|7  |59      |top             |マスク                      |AbenoMask |        0|
|8  |53      |top             |コロナ                      |AbenoMask |        0|
|9  |35      |top             |abenomask policy            |AbenoMask |        0|
|10 |31      |top             |abe mask                    |AbenoMask |        0|
|11 |29      |top             |derision                    |AbenoMask |        0|
|12 |27      |top             |meme                        |AbenoMask |        0|
|13 |21      |top             |from abenomics to abenomask |AbenoMask |        0|
|14 |18      |top             |japan mask                  |AbenoMask |        0|
|15 |17      |top             |ブルームバーグ              |AbenoMask |        0|
|16 |15      |top             |memes                       |AbenoMask |        0|
|17 |14      |top             |マスク 2 枚                 |AbenoMask |        0|
|18 |12      |top             |安倍 マスク                 |AbenoMask |        0|
|19 |11      |top             |abenomusk                   |AbenoMask |        0|
|20 |10      |top             |アベノミクス                |AbenoMask |        0|
|21 |10      |top             |coronavirus japan           |AbenoMask |        0|
|22 |10      |top             |翻訳                        |AbenoMask |        0|
|23 |9       |top             |abeno mask                  |AbenoMask |        0|
|24 |9       |top             |アベノマスク twitter        |AbenoMask |        0|

