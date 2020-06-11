---
title: PCR検査者数の比較（ourworldindata）
date: 2020-06-11
tags: ["R","PCR"]
excerpt: 日本がいかに検査をしていないか
---

# PCR検査者数の比較（ourworldindata）

![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2pcrtest01)  

ourworldindata.org のデータを使います。

#### 1位〜20位

![pcrtest01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcrtest01.png)

- 第１位のバーレーンは人口1000人あたり222人以上検査しています。

#### 21位〜40位

![pcrtest02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcrtest02.png)

- シンガポール（２８位）、香港（３５位）

#### 41位〜60位

![pcrtest03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcrtest03.png)

- 韓国（４４位）人口1000人あたり約20人

#### 61位〜84位

![pcrtest04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcrtest04.png)

- 台湾（７１位）初期対応が完璧だったので少ない。
- 日本（７４位）人口1000人あたり2.5人

### Rコード

```R
#データ読み込み
test<- read.csv("https://covid.ourworldindata.org/data/owid-covid-data.csv")
#
dat<- test[,c("date","location","total_tests_per_thousand")]
# total_tests_per_thousandがNAではないものを抽出
dat<- dat[!is.na(dat[,3]),]
# 国ごとの最新のトータル検査者数(maxデータ)
dat<- aggregate(dat$total_tests_per_thousand,max,na.rm=T, by=list(dat$location))
# ネーム変更
colnames(dat)<- c("location","total_tests_per_thousand")
# 並べ替え
dat<- dat[order(dat$total_tests_per_thousand),]
#barplot(dat$total_tests_per_thousand,names=dat$location,col="lightblue",las=1,horiz=T)
# ランクごとに分ける
dat01<- dat[(nrow(dat)-19):nrow(dat),]
dat02<- dat[(nrow(dat)-39):(nrow(dat)-20),]
dat03<- dat[(nrow(dat)-59):(nrow(dat)-40),]
dat04<- dat[1:(nrow(dat)-60),]
#
# 1〜20
#png("pcrtest01.png",width=800,height=600)
par(mar=c(3,8,4,2),family="serif")
b<- barplot(dat01$total_tests_per_thousand,names=dat01$location,col="lightblue",las=1,horiz=T,
	xlim=c(0,max(dat01$total_tests_per_thousand)*1.2))
text(x=dat01$total_tests_per_thousand,y=b,labels=dat01$total_tests_per_thousand,col="red",pos=4)
title("人口1000人あたりの検査者数（第1位から20位）")
#dev.off()
# 21〜40
#png("pcrtest02.png",width=800,height=600)
par(mar=c(3,8,4,2),family="serif")
b<- barplot(dat02$total_tests_per_thousand,names=dat02$location,col="lightblue",las=1,horiz=T,
	xlim=c(0,max(dat02$total_tests_per_thousand)*1.2))
text(x=dat02$total_tests_per_thousand,y=b,labels=dat02$total_tests_per_thousand,col="red",pos=4)
title("人口1000人あたりの検査者数（第21位から40位）")
#dev.off()
# 41〜60
#png("pcrtest03.png",width=800,height=600)
par(mar=c(3,8,4,2),family="serif")
b<- barplot(dat03$total_tests_per_thousand,names=dat03$location,col="lightblue",las=1,horiz=T,
	xlim=c(0,max(dat03$total_tests_per_thousand)*1.2))
text(x=dat03$total_tests_per_thousand,y=b,labels=dat03$total_tests_per_thousand,col="red",pos=4)
title("人口1000人あたりの検査者数（第41位から60位）")
#dev.off()
# 61〜84
jpos<- is.element(dat04$location,"Japan")
col<- gsub("TRUE","red",gsub("FALSE","lightblue",jpos))
#png("pcrtest04.png",width=800,height=600)
par(mar=c(3,8,4,2),family="serif")
b<- barplot(dat04$total_tests_per_thousand,names=dat04$location,col=col,las=1,horiz=T,
	xlim=c(0,max(dat04$total_tests_per_thousand)*1.2))
text(x=dat04$total_tests_per_thousand,y=b,labels=dat04$total_tests_per_thousand,col="red",pos=4)
title("人口1000人あたりの検査者数（第61位から84位）",cex.main=1.5)
#dev.off()
```

