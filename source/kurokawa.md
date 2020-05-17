---
title: gtrendsRで黒○○務(様)と南海トラフ、黒○○務(様) VS アベノマスク、黒○○務(様) VS アベノミクス
date: 2020-05-17
tags: ["R","gtrendsR"]
excerpt: 三権分立
---

# gtrendsRで黒○○務(様)と南海トラフ、黒○○務(様) VS アベノマスク
![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2Fkurokawa)

### 時系列の棒グラフをいろんな方法で作成

(関連ニュース)  
[定年延長”黒川弘務検事長に直撃取材　検察庁法改正で「安倍政権ベッタリ」の検事総長が誕生する広がり続ける「#検察庁法改正案に抗議します」](https://bunshun.jp/articles/-/37732)  
[若狭勝氏、同期の黒川氏は「自ら辞めるのでは…」[2020年5月13日18時39分] ](https://www.nikkansports.com/general/nikkan/news/202005130000510.html)
[アクセスジャーナル](https://access-journal.jp/47424) <- これほんと？！  

[関東周辺で相次ぐ地震の発生。ネット上で「南海トラフ」が上位に2020/05/11 17:15](https://news.goo.ne.jp/article/mag2/nation/mag2-451231.html)  

### 黒○○務(様)
#### 直近７日

![kurokawa](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/kurokawa.png)

- この黒○○務とかいうお方、そんなに検事総長になりたいのでしょうか？

### 南海トラフ
#### 直近７日

![nankaigtrend](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/nankaigtrend.png)

### 黒○○務(様) VS アベノマスク
#### 直近７日

![kuromask](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/kuromask.png)

### 黒○○務(様) VS アベノミクス
#### 直近７日
#### ggplot2
![kuromics](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/kuromics.png)

#### barplot
![kuromics2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/kuromics2.png)

- 黒○○務(様)はアベノミクスには圧勝。アベノマスク>>黒○○務(様)>>>>>アベノミクス
- アベノミクスってもうほとんど死語
- いまや安○(様)といえば、アベノマスク！

## Rコード

### 黒○○務(様)

```R
#devtools::install_github("PMassicotte/gtrendsR")
library(gtrendsR)
kurokawa <- gtrends("黒川弘務",time="now 7-d",geo="JP")
# 日本時間に直すために9時間（9*60*60 秒）加える
kurokawa[[1]]$date<- kurokawa[[1]]$date+9*60*60
#
#plot(kurokawa)
#
# 棒グラフ
dat<-kurokawa[[1]][,c("date", "hits")]
dat$hits<-as.numeric(gsub("<","",dat$hits))
#
# ggplot2
#library(ggplot2)
#ggplot(dat, aes(x=date,y=hits)) + 
#	geom_bar(stat="identity",fill=rgb(1,0,0,0.6)) 
#
# Base graphics
#png("kurokawa.png",width=800,height=600)
par(mar=c(4,5,4,2),family="serif")
b<- barplot(dat[,2],col=rgb(1,0,0,0.6),ylim=c(0,max(dat[,2])*1.05),las=1,xaxt="n",
	main="ピーク時を100としたときの検索割合の推移（キーワード：黒川弘務）",border="lightgray")
at<-grep("00:00:00",dat[,1])
labels<- paste0(sub("-","/",sub("-0","-",sub("^0","",substring(dat[at,1],6,10)))),"\n00:00")
axis(1,at=b[at],labels=labels,padj=0.5)
box(bty="l",lwd=2)
#dev.off()
```

### 南海トラフ

```R
library(gtrendsR)
library(xts)
nankai <- gtrends("南海トラフ",time="now 7-d",geo="JP")
# 日本時間に直すために9時間（9*60*60 秒）加える
nankai[[1]]$date<-nankai[[1]]$date+9*60*60
#plot(nankai)
#
dat<-nankai[[1]][,c("date", "hits")]
dat$hits<-as.numeric(gsub("<","",dat$hits))
#
dat.xts <- xts(dat[,-1], strptime(dat$date, "%Y-%m-%d %H:%M:%S"))
colnames(dat.xts)<-"hits"
#
#png("nankaigtrend.png",width=800,height=600)
plot.xts(dat.xts,type="h",lend=1,lwd=5,col="red",ylim=c(-5,max(dat.xts$hits)*1.05),
	main="ピーク時を100としたときの検索割合の推移（キーワード：南海トラフ）")
#dev.off()
```

### 黒○○務(様) VS アベノマスク

```R
kuromask <- gtrends(c("黒川弘務","アベノマスク"),time="now 7-d",geo="JP")
# 日本時間に直すために9時間（9*60*60 秒）加える
kuromask[[1]]$date<- kuromask[[1]]$date+9*60*60
#
#plot(kuromask)
#
dat<-kuromask[[1]][,c("date", "hits","keyword")]
dat$hits<-as.numeric(gsub("<","",dat$hits))
#
library(reshape2)
dat_wide <- dcast(dat,date ~ keyword, value.var="hits")
#png("kuromask.png",width=800,height=600)
par(mar=c(4,5,4,2),family="serif")
matplot(dat_wide[,2:3],type="h",lend=1,lty=1,lwd=4,col=c(rgb(1,0,0,alpha=0.5),rgb(0,1,0,alpha=0.5)),
	ylim=c(0,100),yaxs="i",las=1,xaxt="n",bty="n",ylab="Search hits")
box(bty="l",lwd=2.5)
at<-grep("00:00:00",dat_wide$date)
labels<- paste0(sub("-","/",sub("-0","-",sub("^0","",substring(dat_wide[at,1],6,10)))),"\n00:00")
axis(1,at=at,labels=labels,padj=0.5)
legend("topleft",inset=0.02,legend=colnames(dat_wide)[2:3],pch=15,col=c(rgb(1,0,0,alpha=0.5),rgb(0,1,0,alpha=0.5)),cex=1.2,bty="n")
title("ピーク時を100としたときの検索割合の推移(キーワード：黒川弘務 VS アベノマスク)",cex.main=1.2)
#dev.off()
```

### 黒○○務(様) VS アベノミクス
#### ggplot2

```R
kuromics <- gtrends(c("黒川弘務","アベノミクス"),time="now 7-d",geo="JP")
# 日本時間に直すために9時間（9*60*60 秒）加える
kuromics[[1]]$date<- kuromics[[1]]$date+9*60*60
#
#plot(kuromics)
#
dat<-kuromics[[1]][,c("date", "hits","keyword")]
dat$hits<-as.numeric(gsub("<","",dat$hits))
# ggplot2
library(ggplot2)
#png("kuromics.png",width=800,height=600)
ggplot(dat, aes(x=date,y=hits,fill=keyword)) + 
	geom_bar(stat="identity",position = "dodge") +
	ggtitle("ピーク時を100としたときの検索割合の推移(キーワード：黒川弘務 VS アベノミクス)") +
	theme_minimal()
#dev.off()
```

#### barplot

```R
library(reshape2)
dat_wide <- dcast(dat,date ~ keyword, value.var="hits")
#png("kuromics2.png",width=800,height=600)
par(mar=c(4,5,4,2),family="serif")
b<- barplot(dat_wide[,2],col=rgb(1,0,0,0.8),ylim=c(0,max(dat_wide[,2:3])*1.05),xaxt="n",las=1,width=1,space=0,
	main="ピーク時を100としたときの検索割合の推移（キーワード：黒川弘務 VS アベノミクス）",border=rgb(1,0,0,0.8))
at<-grep("00:00:00",dat_wide[,1])
labels<- paste0(sub("-","/",sub("-0","-",sub("^0","",substring(dat_wide[at,1],6,10)))),"\n00:00")
axis(1,at=b[at],labels=labels,padj=0.5)
barplot(dat_wide[,3],col=rgb(0,1,0,0.5),ylim=c(0,max(dat_wide[,2:3])*1.05),xaxt="n",yaxt="n",border=rgb(0,1,0,0.5),width=1,space=0,add=T)
box(bty="l",lwd=2)
legend("topleft",inset=0.02,legend=colnames(dat_wide[,2:3]),pch=15,col=c(rgb(1,0,0,0.8),rgb(0,1,0,0.5)),cex=1.2,bty="n")
#dev.off()
```
