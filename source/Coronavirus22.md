---
title: インフルエンザ報告数と新型コロナウイルス陽性者数のグラフと表
date: 2021-12-08
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
- 2021(47週まで) : https://www.niid.go.jp/niid/images/idwr/sokuho/idwr-2021/202147/2021-47-teiten-tougai.csv

[作成したデータセット:influ2018_2021.csv](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/influ2018_2021.csv)  
(注意)文字コードUTF-8に変更しました。

[NHK:新型コロナデータ](https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv)

（注意）グラフは「y軸片対数グラフ」です。
- グラフが途切れている個所は数が「0」です。
- 新型コロナウイルス陽性者数は最新ではありません。インフルエンザ報告数のデータのある最終日に合わせています。

> （注意）2021年はインフルエンザ、新型コロナウイルスとも47週 2021-11-22 2021-11-28までの集計  

### 総数：インフルエンザ報告数と新型コロナウイルス陽性者数

![covid22_01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid22_01.png)

- インフルエンザ報告数のグラフと重ねてみると、新型コロナウイルスの感染力の強さがわかる。

#### ほぼ年ごとのインフルエンザ報告数と新型コロナウイルス陽性者数（週データを集計したものなので年初の数日が前年に入っている場合あり）

|     | インフルエンザ| 新型コロナウイルス|
|:----|--------------:|------------------:|
|2018 |      1,898,134|                  0|
|2019 |      1,875,890|                  0|
|2020 |        563,487|            243,297|
|2021 |            903|          1,478,667|

### 都道府県別(大阪府,東京都,北海道,沖縄県,鳥取県)

都市代表（大阪府,東京都）、観光地代表（北海道,沖縄県）、コロナ感染者が少ない（鳥取県,島根県,秋田県）

地域のグラフは 0のところに0.5を入れ、線がとぎれないように工夫してみた。  
(注意)グラフを作成したあとで0.5のところに0を入れ直すこと。(表の数値が合わなくなります。)

#### 大阪府：インフルエンザ報告数と新型コロナウイルス陽性者数（グラフと表）

![covid22_02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid22_02.png)

#### 東京都：インフルエンザ報告数と新型コロナウイルス陽性者数（グラフと表）

![covid22_03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid22_03.png)

#### 北海道：インフルエンザ報告数と新型コロナウイルス陽性者数（グラフと表）

![covid22_04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid22_04.png)

#### 沖縄県：インフルエンザ報告数と新型コロナウイルス陽性者数（グラフと表）

![covid22_05](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid22_05.png)

#### 鳥取県：インフルエンザ報告数と新型コロナウイルス陽性者数（グラフと表）

![covid22_06](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid22_06.png)

#### 島根県：インフルエンザ報告数と新型コロナウイルス陽性者数（グラフと表）

![covid22_07](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid22_07.png)

#### 秋田県：インフルエンザ報告数と新型コロナウイルス陽性者数（グラフと表）

![covid22_08](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid22_08.png)

### Rコード

#### データ読み込み（linuxの場合）

```R
library(xts)
csvdata<- "https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/influ2018_2021.csv"
#influ2018_2021<- read.csv(csvdata,fileEncoding = "CP932")
influ2018_2021<- read.csv(csvdata,fileEncoding = "UTF-8")
nhkC<- read.csv("https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv")
```

#### ネット上のcsvファイルがうまく読み込めない場合

「windows版のR」でNHKのコロナデータがfileEncoding="UTF-8"をつけても読み込めないとき、fread関数でもだめなとき

```R
rL<- readLines("https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv")
rL<- iconv(rL,"UTF-8","CP932")
nhkC<- read.csv(text=rL,h=F,skip=1,stringsAsFactors=F)
colnames(nhkC)<- c("日付","コード","都道府県名","1日ごとの感染者数","感染者数累計","1日ごとの死者数","死者数累計")
```

のようにreadLinesで読み込み -> iconvで文字コードを変換　-> read.csvでdata.frameとして読み込む  
このようにしても、colnames行はなぜかNAとなってしまったので、skip=1として後にcolnamesｗ付け直しました。

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
period<- paste0("2020-01-13::",tail(influ2018_2021[,4],1))
dfC<- apply.weekly(cov.xts[period],sum)
# Plot
options(scipen=2)
#png("covid22_01.png",width=800,height=600)
par(mar=c(5,5,4,5),family="serif")
ylim<- c(0.9,400000)
plot(x= 1:nrow(influ2018_2021),y=rep(NA,nrow(influ2018_2021)),las=1,log="y",ylim=ylim,xlab="",ylab="",xaxt="n",yaxt="n",bty="n")
box(bty="l",lwd=2)
abline(h=10^(0:7)%o%(2:9),lty=2,col="gray",lwd=0.8)
abline(h=10^(0:7),lty=2,col="gray20",lwd=1)
lines(x= 1:nrow(influ2018_2021),y=influ2018_2021$総数,col="royalblue3",lwd=2)
axis(1,at=which(influ2018_2021$週=="01週"),labels= 2018:2021)
axis(2,at= 10^(0:7),labels=formatC(10^(0:7), format="d", big.mark=','),las=1)
axis(2,at= 10^(0:7)*5,labels=formatC(10^(0:7)*5,format="d", big.mark=','),las=1,cex.axis=0.8,tck=-0.01)
# 新型コロナのデータがあるのは107週目から
lines(x=107:(106+nrow(dfC)),y= as.vector(coredata(dfC)),col="brown3",lwd=2)
text(x=158,y=c(90,40000),labels=c("インフルエンザ","新型コロナウイルス"),xpd=T,pos=3)
title("インフルエンザ報告数と新型コロナウイルス陽性者数(週合計)",
	"データ：感染症発生動向調査 週報（IDWR）、新型コロナデータ（NHK）",cex.main=1.5)
#dev.off()
```

#### ほぼ年ごとのインフルエンザ報告数と新型コロナウイルス陽性者数の表

```R
hyo<- influ2018_2021[,c("年","終わり","総数")]
names(hyo)[3]<- "インフルエンザ"
hyo$新型コロナウイルス<- NA
hyo$新型コロナウイルス[107:(106+nrow(dfC))]<- dfC
#
hyo2<- cbind(year=rep(hyo$年,2),stack(hyo,select=c(インフルエンザ,新型コロナウイルス)))
hyo2<- tapply(hyo2$values,list(hyo2$year,hyo2$ind),sum,na.rm=T)
knitr::kable(formatC(hyo2, format="d", big.mark=','),align= rep('r',2))
```

#### 都道府県別

```R
# グラフにする都道府県を指定
pref<- "鳥取県"
cov<- nhkC[nhkC$都道府県名==pref,c(1,4)]
cov.xts<- xts(cov[,2],as.Date(cov$日付))
#2020-01-13から2020-01-15（感染者数は0）を付け足す
cov.xts<- rbind(xts(rep(0,3),seq(as.Date("2020-01-13"), as.Date("2020-01-15"), by = "day")),cov.xts)
# インフルエンザ報告者のある部分を取り出し週の合計を出す
dfC<- apply.weekly(cov.xts["2020-01-13::2021-06-13"],sum)
influ<- influ2018_2021[,pref]
# Plot
options(scipen=2)
#png("covid22_06.png",width=800,height=600)
par(mar=c(5,5,4,5),family="serif")
ylim<- c(0.9,max(max(dfC),max(influ)))
plot(x= 1:nrow(influ2018_2021),y=rep(NA,nrow(influ2018_2021)),las=1,log="y",ylim=ylim,xlab="",ylab="",xaxt="n",yaxt="n",bty="n")
box(bty="l",lwd=2)
abline(h=10^(0:7)%o%(2:9),lty=2,col="gray",lwd=0.8)
abline(h=10^(0:7),lty=2,col="gray20",lwd=1)
lines(x= 1:nrow(influ2018_2021),y=influ,col="royalblue3",lwd=2)
axis(1,at=which(influ2018_2021$週=="01週"),labels= 2018:2021)
axis(2,at= 10^(0:7),labels=formatC(10^(0:7), format="d", big.mark=','),las=1)
axis(2,at= 10^(0:7)*5,labels=formatC(10^(0:7)*5,format="d", big.mark=','),las=1,cex.axis=0.8,tck=-0.01)
# 新型コロナのデータがあるのは107週目から
lines(x=107:(106+nrow(dfC)),y= as.vector(coredata(dfC)),col="brown3",lwd=2)
legend("topright",inset=c(-0.105,-0.08),legend=c("インフルエンザ","新型コロナウイルス"),lwd=2,col=c("royalblue3","brown3"),xpd=T)
title(paste("インフルエンザ報告数と新型コロナウイルス陽性者数(週合計)\n（",pref,"）"),
	"データ：感染症発生動向調査 週報（IDWR）、新型コロナデータ（NHK）",cex.main=1.5)
#dev.off()
```

#### 0のところに0.5を入れ、線がとぎれないように工夫してみた

(注意)グラフ作成したら0.5のところに0を入れ直す。

```R
# 片対数グラフ
pref<- "鳥取県"
cov<- nhkC[nhkC$都道府県名==pref,c(1,4)]
cov.xts<- xts(cov[,2],as.Date(cov$日付))
#2020-01-13から2020-01-15（感染者数は0）を付け足す
cov.xts<- rbind(xts(rep(0,3),seq(as.Date("2020-01-13"), as.Date("2020-01-15"), by = "day")),cov.xts)
# インフルエンザ報告者のある部分を取り出し週の合計を出す
dfC<- apply.weekly(cov.xts["2020-01-13::2021-06-13"],sum)
influ<- influ2018_2021[,pref]
# dfC、influの0に便宜的に0.5をいれる。<- 途切れるのを防ぐため
dfC[dfC==0]<- 0.5
influ[influ==0]<- 0.5
#png("covid22_06.png",width=800,height=600)
par(mar=c(5,5,4,5),family="serif")
plot(influ,type="n",ylim=c(0.5,max(max(influ,na.rm=T),max(dfC,na.rm=T))*1.2),xaxt="n",yaxt="n",bty="n",xlab="",ylab="",log="y",yaxs="i")
box(bty="l",lwd=2)
abline(h=10^(0:7)%o%(2:9),lty=2,col="gray",lwd=0.8)
abline(h=10^(0:7),lty=2,col="gray20",lwd=1)
abline(h=0.5,lty=1,col="gray20",lwd=1)
lines(influ,lwd=2,col="royalblue3")
lines(x=107:(106+nrow(dfC)),y=dfC,col="brown3",lwd=2)
axis(1,at=which(influ2018_2021$週=="01週"),labels=2018:2021)
axis(2,at= 10^(0:7),labels=formatC(10^(0:7), format="d", big.mark=','),las=1)
axis(2,at= 10^(0:7)*5,labels=formatC(10^(0:7)*5,format="d", big.mark=','),las=1,cex.axis=0.8,tck=-0.01)
#
#axis(2,at= 0.5,labels="0*",las=1)
legend("topright",inset=c(-0.105,-0.08),legend=c("インフルエンザ","新型コロナウイルス"),
	lwd=2,col=c("royalblue3","brown3"),xpd=T)
title(paste("インフルエンザ報告数&新型コロナウイルス感染者数(週合計)\n（",pref,"）"),cex.main=1.5)
title("","データ：感染症発生動向調査 週報（IDWR）、新型コロナデータ（NHK）",line=2.5)
# dfC、influの0を入れ直す。
dfC[dfC==0.5]<- 0
influ[influ==0.5]<- 0
#dev.off()
```

#### 一つのpngファイルに収める

```R
library(grid)
library(gridBase)
library(gridExtra)
tt <- ttheme_default(core=list(fg_params=list(hjust=1, x=0.9)),
                      rowhead=list(fg_params=list(hjust=1, x=0.95)))
mat <- matrix(c(1,1,1,1,2,3),2)
#mat
# 片対数グラフ
nn<- paste0("0",2:8)
pref0<- c("大阪府","東京都","北海道","沖縄県","鳥取県","島根県","秋田県")
for (i in 1:length(pref0)){
pref<- pref0[i]
influ<- influ2018_2021[,pref]
xx<- nhkC[nhkC[,3]==pref,c(1,4)]
cov.xts<- xts(xx[,2],as.Date(xx[,1]))
#2020-01-13から2020-01-15（感染者数は0）を付け足す
cov.xts<- rbind(xts(rep(0,3),seq(as.Date("2020-01-13"), as.Date("2020-01-15"), by = "day")),cov.xts)
# インフルエンザの最終データの日まで
period<- paste0("2020-01-13::",tail(influ2018_2021[,4],1))
dfC<- apply.weekly(cov.xts[period],sum)
# dfC、influの0に便宜的に0.5をいれる。
dfC[dfC==0]<- 0.5
influ[influ==0]<- 0.5
# First base plot
png(paste0("covid22_",nn[i],".png"),width=800,height=600)
par(mar=c(5,4,4,2),family="serif")
layout(mat) 
plot(influ,type="n",ylim=c(0.5,max(max(influ,na.rm=T),max(dfC,na.rm=T))*1.25),xaxt="n",yaxt="n",bty="n",xlab="",ylab="",log="y",yaxs="i")
box(bty="l",lwd=2)
abline(h=10^(0:7)%o%(2:9),lty=2,col="gray",lwd=0.8)
abline(h=10^(0:7),lty=2,col="gray20",lwd=1)
abline(h=0.5,lty=1,col="gray20",lwd=1)
lines(influ,lwd=2,col="royalblue3")
lines(x=107:(106+nrow(dfC)),y=dfC,col="brown3",lwd=2)
axis(1,at=which(influ2018_2021$週=="01週"),labels=2018:2021)
axis(2,at= 10^(0:7),labels=formatC(10^(0:7), format="d", big.mark=','),las=1)
axis(2,at= 10^(0:7)*5,labels=formatC(10^(0:7)*5,format="d", big.mark=','),las=1,cex.axis=0.8,tck=-0.01)
#
#axis(2,at= 0.5,labels="0*",las=1)
legend("topright",inset=c(0,-0.03),legend=c("インフルエンザ","新型コロナウイルス"),
	lwd=2,col=c("royalblue3","brown3"),xpd=T)
title(paste("インフルエンザ報告数&新型コロナウイルス感染者数(週合計)\n（",pref,"）"),cex.main=1.5)
title("","データ：感染症発生動向調査 週報（IDWR）、新型コロナデータ（NHK）",line=2.5)
# dfC、influの0を0に戻す。
dfC[dfC==0.5]<- 0
influ[influ==0.5]<- 0
# second base plot 
frame()
# Grid regions of current base plot (ie from frame)
vps <- baseViewports()
pushViewport(vps$inner, vps$figure, vps$plot)
# Table grob
hyo<- influ2018_2021[,c("年","終わり",pref)]
names(hyo)[3]<- "インフルエンザ"
hyo$新型コロナウイルス<- NA
hyo$新型コロナウイルス[107:(106+nrow(dfC))]<- dfC
hyo2<- cbind(year=rep(hyo$年,2),stack(hyo,select=c(インフルエンザ,新型コロナウイルス)))
hyo2<- tapply(hyo2$values,list(hyo2$year,hyo2$ind),sum,na.rm=T)
grob <-  tableGrob(formatC(hyo2, format="d", big.mark=',') ,theme=tt)
grid.draw(grob)
popViewport(3)
# third base plot
barplot(t(hyo2),beside=T,col=c("royalblue3","brown3"),legend=T,ylim=c(0,max(hyo2,na.rm=T)*1.2),yaxt="n",
	args.legend=list(x="topright",inset=c(0,-0.05),xpd=T))
axis(2,at=axTicks(2),labels=formatC(axTicks(2), format="d", big.mark=','),las=1)
dev.off()
}
```


#### ほぼ年ごとのインフルエンザ報告数と新型コロナウイルス陽性者数の表(都道府県別)

```R
hyo<- influ2018_2021[,c("年","終わり",pref)]
names(hyo)[3]<- "インフルエンザ"
hyo$新型コロナウイルス<- NA
hyo$新型コロナウイルス[107:(106+nrow(dfC))]<- dfC
#
hyo2<- cbind(year=rep(hyo$年,2),stack(hyo,select=c(インフルエンザ,新型コロナウイルス)))
hyo2<- tapply(hyo2$values,list(hyo2$year,hyo2$ind),sum,na.rm=T)
knitr::kable(formatC(hyo2, format="d", big.mark=','),align= rep('r',2))
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
"https://www.niid.go.jp/niid/images/idwr/sokuho/idwr-2021/202134/2021-34-teiten-tougai.csv")
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

