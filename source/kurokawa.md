---
title: gtrendsRで黒○○務(様)と南海トラフ
date: 2020-05-12
tags: ["R","gtrendsR"]
excerpt: 三権分立
---

# gtrendsRで黒○○務(様)と南海トラフ
![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2Fkurokawa)

(関連ニュース)  
[定年延長”黒川弘務検事長に直撃取材　検察庁法改正で「安倍政権ベッタリ」の検事総長が誕生する広がり続ける「#検察庁法改正案に抗議します」](https://bunshun.jp/articles/-/37732)  
[関東周辺で相次ぐ地震の発生。ネット上で「南海トラフ」が上位に2020/05/11 17:15](https://news.goo.ne.jp/article/mag2/nation/mag2-451231.html)  

### 黒○○務(様)
#### 直近７日

![kurokawa](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/kurokawa.png)

### 南海トラフ
#### 直近７日

![nankaigtrend](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/nankaigtrend.png)

## Rコード

### 黒○○務(様)

```R
#devtools::install_github("PMassicotte/gtrendsR")
library(gtrendsR)
library(xts)
kurokawa2 <- gtrends("黒川弘務",time="now 7-d",geo="JP")
#plot(kurokawa2)
dat<-kurokawa2[[1]][,c("date", "hits")]
dat$hits<-as.numeric(gsub("<","",dat$hits))
#
dat.xts <- xts(dat[,-1], strptime(dat$date, "%Y-%m-%d %H:%M:%S"))
# 日本時間に直すために9時間（9*60*60 秒）加える
index(dat.xts)<-index(dat.xts)+9*60*60
colnames(dat.xts)<-"hits"
#
#png("kurokawa.png",width=800,height=600)
plot.xts(dat.xts,type="h",lend=1,lwd=5,col="red",ylim=c(-5,max(dat.xts$hits)*1.05),
	main="ピーク時を100としたときの検索割合の推移（キーワード：黒川弘務）")
#dev.off()
```

### 南海トラフ


```R
nankai <- gtrends("南海トラフ",time="now 7-d",geo="JP")
#plot(nankai)
dat<-nankai[[1]][,c("date", "hits")]
dat$hits<-as.numeric(gsub("<","",dat$hits))
#
dat.xts <- xts(dat[,-1], strptime(dat$date, "%Y-%m-%d %H:%M:%S"))
# 日本時間に直すために9時間（9*60*60 秒）加える
index(dat.xts)<-index(dat.xts)+9*60*60
colnames(dat.xts)<-"hits"
#
#png("nankaigtrend.png",width=800,height=600)
plot.xts(dat.xts,type="h",lend=1,lwd=5,col="red",ylim=c(-5,max(dat.xts$hits)*1.05),
	main="ピーク時を100としたときの検索割合の推移（キーワード：南海トラフ）")
#dev.off()
```

