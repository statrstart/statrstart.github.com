---
title: インフルエンザ報告数と新型コロナウイルス陽性者数
date: 2021-06-22
tags: ["R","xts"]
excerpt: IDWR速報データ & NHK:新型コロナデータ
---

# インフルエンザ報告数と新型コロナウイルス陽性者数

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus22&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

(使用するデータ)  
IDWR速報データ  
- 2018 : https://www.niid.go.jp/niid/images/idwr/sokuho/idwr-2018/201852/2018-52-teiten-tougai.csv
- 2019 : https://www.niid.go.jp/niid/images/idwr/sokuho/idwr-2019/201952/2019-52-teiten-tougai.csv
- 2020 : https://www.niid.go.jp/niid/images/idwr/sokuho/idwr-2020/202053/2020-53-teiten-tougai.csv
- 2021(23週まで) : https://www.niid.go.jp/niid/images/idwr/sokuho/idwr-2021/202123/2021-23-teiten-tougai.csv

[作成したデータセット:influ2018_202123.csv](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/influ2018_202123.csv)  

NHK:新型コロナデータ  
- https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv

### 総数：インフルエンザ報告数と新型コロナウイルス陽性者数

![covid22_01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid22_01.png)

- インフルエンザ報告数のグラフと重ねてみると、新型コロナウイルスの感染力の強さがわかる。
- そのうえ、デルタ株も入ってきているし、どうなっちゃうんでしょう。

#### ほぼ年ごとのインフルエンザ報告数（週データを集計したものなので「ほぼ年ごと」）

|     |       x|
|:----|-------:|
|2018 | 1898134|
|2019 | 1875890|
|2020 |  563487|
|2021 |     711|

（注意）2021年は23週(2021-06-07〜2021-06-13)までの集計  

### 都道府県別(大阪府,東京都,北海道,沖縄県)

#### 大阪府：インフルエンザ報告数と新型コロナウイルス陽性者数

![covid22_02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid22_02.png)

#### 東京都：インフルエンザ報告数と新型コロナウイルス陽性者数

![covid22_03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid22_03.png)

#### 北海道：インフルエンザ報告数と新型コロナウイルス陽性者数

![covid22_04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid22_04.png)

#### 沖縄県：インフルエンザ報告数と新型コロナウイルス陽性者数

![covid22_05](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid22_05.png)

### Rコード

#### データ読み込み

```R
library(xts)
csvdata<- "https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/influ2018_202123.csv"
influ2018_2021<- read.csv(csvdata,fileEncoding = "CP932")
nhkC<- read.csv("https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv")
```

#### 総数のグラフ

```R
# 総数を求める
cov<- tapply(nhkC[,4], as.Date(nhkC[,1]), sum)
cov.xts<- xts(cov,as.Date(names(cov)))
# 2020-01-16
influ2018_2021[107,1:4]
#      年   週     始まり     終わり
#219 2020 03週 2020-01-13 2020-01-19
#2020-01-13から2020-01-15（感染者数は0）を付け足す
cov.xts<- rbind(xts(rep(0,3),seq(as.Date("2020-01-13"), as.Date("2020-01-15"), by = "day")),cov.xts)
# インフルエンザ報告者のある部分を取り出し週の合計を出す
dfC<- apply.weekly(cov.xts["2020-01-13::2021-06-13"],sum)
# Plot
options(scipen=2)
#png("covid22_01.png",width=800,height=600)
par(mar=c(5,5,4,5),family="serif")
ylim<- c(0.9,400000)
plot(x= 1:nrow(influ2018_2021),y=rep(NA,nrow(influ2018_2021)),las=1,log="y",ylim=ylim,xlab="",ylab="",xaxt="n",yaxt="n",bty="n")
box(bty="l",lwd=2)
abline(h=10^(0:6),col="darkgray",lwd=1.2,lty=3)
for (i in 1:9){
	abline(h=i*10^(0:6),col="darkgray",lwd=0.8,lty=3)
}
lines(x= 1:nrow(influ2018_2021),y=influ2018_2021$総数,col="royalblue3",lwd=2)
axis(1,at=which(influ2018_2021$週=="01週"),labels= 2018:2021)
axis(2,at= 10^(0:6),labels= 10^(0:6),las=1)
# 新型コロナのデータがあるのは107週目から
lines(x=107:(106+nrow(dfC)),y= as.vector(coredata(dfC)),col="brown3",lwd=2)
text(x=158,y=c(90,40000),labels=c("インフルエンザ","新型コロナウイルス"),xpd=T,pos=3)
title("インフルエンザ報告数と新型コロナウイルス陽性者数",
	"データ：IDWR速報データ & NHK:新型コロナデータ",cex.main=1.5)
#dev.off()
```

#### ほぼ年ごとのインフルエンザ報告数の表

```R
knitr::kable(tapply(influ2018_2021$総数,influ2018_2021$年,sum))
```

#### 都道府県別

```R
# グラフにする都道府県を指定
loc<- "沖縄県"
cov<- nhkC[nhkC$都道府県名==loc,c(1,4)]
cov.xts<- xts(cov[,2],as.Date(cov$日付))
#2020-01-13から2020-01-15（感染者数は0）を付け足す
cov.xts<- rbind(xts(rep(0,3),seq(as.Date("2020-01-13"), as.Date("2020-01-15"), by = "day")),cov.xts)
# インフルエンザ報告者のある部分を取り出し週の合計を出す
dfC<- apply.weekly(cov.xts["2020-01-13::2021-06-13"],sum)
influ<- influ2018_2021[,loc]
# Plot
options(scipen=2)
#png("covid22_05.png",width=800,height=600)
par(mar=c(5,5,4,5),family="serif")
ylim<- c(0.9,max(max(dfC),max(influ)))
plot(x= 1:nrow(influ2018_2021),y=rep(NA,nrow(influ2018_2021)),las=1,log="y",ylim=ylim,xlab="",ylab="",xaxt="n",yaxt="n",bty="n")
box(bty="l",lwd=2)
abline(h=10^(0:6),col="darkgray",lwd=1.2,lty=3)
for (i in 1:9){
	abline(h=i*10^(0:6),col="darkgray",lwd=0.8,lty=3)
}
lines(x= 1:nrow(influ2018_2021),y=influ,col="royalblue3",lwd=2)
axis(1,at=which(influ2018_2021$週=="01週"),labels= 2018:2021)
axis(2,at= 10^(0:6),labels= 10^(0:6),las=1)
# 新型コロナのデータがあるのは107週目から
lines(x=107:(106+nrow(dfC)),y= as.vector(coredata(dfC)),col="brown3",lwd=2)
legend("topright",inset=c(-0.08,-0.08),legend=c("インフルエンザ","新型コロナウイルス"),lwd=2,col=c("royalblue3","brown3"),xpd=T)
title(paste("インフルエンザ報告数と新型コロナウイルス陽性者数\n（",loc,"）"),
	"データ：IDWR速報データ & NHK:新型コロナデータ",cex.main=1.5)
#dev.off()
```

#### インフルエンザ報告数のデータを読み込みデータセット作成

（注意）linuxでRの3系を使うとエンコードがやっかい。表計算ソフトにコピペして整理したほうがよい。  

linuxでRの3系を使ったコード

```R
library(xts)
url<- c(
"https://www.niid.go.jp/niid/images/idwr/sokuho/idwr-2018/201852/2018-52-teiten-tougai.csv",
"https://www.niid.go.jp/niid/images/idwr/sokuho/idwr-2019/201952/2019-52-teiten-tougai.csv",
"https://www.niid.go.jp/niid/images/idwr/sokuho/idwr-2020/202053/2020-53-teiten-tougai.csv",
"https://www.niid.go.jp/niid/images/idwr/sokuho/idwr-2021/202123/2021-23-teiten-tougai.csv")
year<- 2018:2021
#
influ2018_2021<- NULL
#
for (ii in 1:length(url)){
rl <- readLines(url[ii])
# linuxの場合
rl<- iconv(rl, from="CP932", to="UTF-8")
SS<- grep("インフルエンザ",rl)
data <- read.csv(text=rl[(SS+1):(SS+50)] ,h=F,stringsAsFactors=F)
data<- data[,data[2,]!="定当"]
data<- data[-2,]
rownames(data)<- data[,1]
# 転置してデータフレームに変換
df<- data.frame(t(data[,-1]),stringsAsFactors=F)
df<- df[-1,]
# 2列め以降の変数の型をnumericに変換
for (i in 2:ncol(df) ){
	df[,i]<- as.numeric(df[,i])
}
#確認
#str(df)
colnames(df)[1]<- "週"
df$年<- rep(year[ii],nrow(df))
influ2018_2021<- rbind(influ2018_2021,df)
}
rownames(influ2018_2021)<- 1:nrow(influ2018_2021)
#
influ2018_2021$始まり<- seq(as.Date("2018-01-01"),length.out=nrow(influ2018_2021),by = "week")
influ2018_2021$終わり<- seq(as.Date("2018-01-07"),length.out=nrow(influ2018_2021),by = "week")
#列並び替え
influ2018_2021<- influ2018_2021[,c(50,1,51,52,2:49)]
#csv形式で保存
write.csv(influ2018_2021,file="influ2018_202123.csv",row.names=F)
```

