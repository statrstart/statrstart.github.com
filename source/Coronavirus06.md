---
title: RでGitHub03 (Coronavirus)[2020-03-05更新]
date: 2020-03-05
tags: ["R", "lubridate" ,"xts","Coronavirus","Japan","新型コロナウイルス"]
excerpt: RでGitHub03 (Coronavirus)[2020-03-05更新]
---

# RでGitHub03 (Coronavirus)[2020-03-05更新]  
![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus06)

公開データの場所がグーグルスプレッドシートからGitHubに移動したのでＲコードを書き直しました。

## 新型コロナウイルスの感染状況

米ジョンズ・ホプキンス大学の新型コロナウイルスの感染状況をまとめたWebサイト  
[Coronavirus 2019-nCoV Global Cases by Johns Hopkins CSSE](https://gisanddata.maps.arcgis.com/apps/opsdashboard/index.html#/bda7594740fd40299423467b48e9ecf6)

データはGitHubから入手できます。  
[2019 Novel Coronavirus COVID-19 (2019-nCoV) Data Repository by Johns Hopkins CSSE](https://github.com/CSSEGISandData/COVID-19)  

使用するデータ（日次データになったので更新回数が減ってしまった。）  
[CSSE COVID-19 Dataset](https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data)

過去のデータ(archived_data)は  
[COVID-19 : archived_data](https://github.com/CSSEGISandData/COVID-19/tree/master/archived_data)

新型コロナウイルス関連の主なサイト  
[DXY.cn. Pneumonia. 2020](https://ncov.dxy.cn/ncovh5/view/pneumonia)  
[BNO News](https://bnonews.com/)   

### 新型コロナウイルスに感染された方、回復された方、亡くなった方の数の推移（日別）

![Coronavirus01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Coronavirus01.png)

### 新型コロナウイルスの国、場所別感染者の推移

#### 感染者数 10000人以上(Mainland China)

![CoronavirusG1](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/CoronavirusG1.png)

#### 感染者数 1000人以上10000人未満

![CoronavirusG2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/CoronavirusG2.png)

#### 感染者数 100人以上1000人未満(OthersはDiamond Princessのこと)

![CoronavirusG2_2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/CoronavirusG2_2.png)

#### Diamond Princessや韓国、イタリアの伸び率をみると、日本はそもそも検査している数が少ないのではないかと思われる。

日本のPCR検査実施人数 [報道発表資料　2020年2月](https://www.mhlw.go.jp/stf/houdou/houdou_list_202002.html)より 

韓国の検査数は[KCDC「News Room」「Press Release」](https://www.cdc.go.kr/board/board.es?mid=a30402000000&bid=0030)  
このうち、タイトルに「The Updates of COVID-19」のつくもの。9:00のデータ。

![pcr04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr04.png)

イタリアの２月２９日時点の検査数は[Coronavirus, 1.128 contagi in Italia: ecco i numeri regione per regione](https://www.corriere.it/salute/malattie_infettive/20_febbraio_29/coronavirus-888-contagi-italia-ecco-numeri-regione-regione-1b326950-5afd-11ea-8b1a-b76251361796.shtml)
によると、18661人です。

#### 感染者数 50人以上100人未満

![CoronavirusG3](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/CoronavirusG3.png)

#### 感染者数 20人以上50人未満

![CoronavirusG4](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/CoronavirusG4.png)

#### 感染者数 10人以上20人未満

![CoronavirusG5](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/CoronavirusG5.png)

#### 感染者数 10人未満

![CoronavirusG6](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/CoronavirusG6.png)

## Rコード

### パッケージの読み込み。データをGitHubから入手。(read.csvの際には、check.names=Fをつける)

```R
# read.csvの際には、check.names=Fをつける
url<- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv"
Confirmed<- read.csv(url,check.names=F)
url<- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Recovered.csv"
Recovered<- read.csv(url,check.names=F)
url<- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Deaths.csv"
Deaths<- read.csv(url,check.names=F)
```

### time_seriesデータは一日に数回更新だったのが、日次データになっていました。

#### ちゃんと日順になったデータですのでコードをシンプルにしました。

```R
nCoV<-colSums(Confirmed[,5:ncol(Confirmed)])
nCoV<-rbind(nCoV,colSums(Recovered[,5:ncol(Recovered)]))
nCoV<-rbind(nCoV,colSums(Deaths[,5:ncol(Deaths)]))
rownames(nCoV)<- c("Confirmed","Recovered","Deaths")
```

### 感染者、回復された方、亡くなった方の数の推移（日別）

```R
# png("Coronavirus01.png",width=800,height=600)
par(mar=c(3,5,3,2))
matplot(t(nCoV),type="o",col=1:3,lwd=1.5,lty=1:3,pch=16:18,las=1,xaxt="n",ylab="")
axis(1,at=1:ncol(nCoV), labels =gsub("/20","",colnames(nCoV)))
legend("topleft", legend = rownames(nCoV),col=1:3,lwd=1.5,lty=1:3,pch=16:18,inset =c(0.02,0.03))
title("Coronavirus [ Total Confirmed,Total Recovered,Total Deaths ]")
# dev.off()
```

### 新型コロナウイルスの国、場所別感染者の推移

```R
# Country/Regionごとに集計
timeline<- aggregate(Confirmed[,5:ncol(Confirmed)], sum, by=list(Confirmed$"Country/Region"))
rownames(timeline)<-timeline[,1]
timeline<- timeline[,-1]
#
# 最終データの値でグループ分け
# 感染者数 10000人以上(Mainland China)
G1<- timeline[timeline[,ncol(timeline)]>=10000,]  
# 感染者数 1000人以上10000人未満
G2<- timeline[timeline[,ncol(timeline)]>= 1000 & timeline[,ncol(timeline)]<10000,] 
# 感染者数 100人以上1000人未満
G2_2<- timeline[timeline[,ncol(timeline)]>= 100 & timeline[,ncol(timeline)]<1000,] 
# 感染者数 50人以上100人未満
G3<- timeline[timeline[,ncol(timeline)]>= 50 & timeline[,ncol(timeline)]<100,] 
# 感染者数 20人以上50人未満
G4<- timeline[timeline[,ncol(timeline)]>= 20 & timeline[,ncol(timeline)]<50,] 
# 感染者数 10人以上20人未満
G5<- timeline[timeline[,ncol(timeline)]>= 10 & timeline[,ncol(timeline)]<20,] 
# 感染者数 10人未満
G6<- timeline[timeline[,ncol(timeline)]<10,] 
#
# plot
# G1
#png("CoronavirusG1.png",width=800,height=600)
par(mar=c(5,5,4,10))
plot(t(G1),type="o",pch=16,lwd=2,las=1,xlab="",ylab="",xaxt="n")
axis(1,at=1:ncol(G1),labels=gsub("/20","",colnames(G1)))
text(x=par("usr")[2],y=G1[,ncol(G1)],labels=rownames(G1),pos=4,xpd=T)
title("reported confirmed COVID-19cases (mainland China)")
#dev.off()
# G2
# 降順に並べ替え
G2<-G2[order(G2[,ncol(G2)],decreasing=T),]
#png("CoronavirusG2.png",width=800,height=600)
par(mar=c(5,5,4,10))
matplot(t(G2),type="o",pch=16,lwd=2,las=1,xlab="",ylab="",xaxt="n",col=1:nrow(G2))
axis(1,at=1:ncol(G2),labels=gsub("/20","",colnames(G2)))
# text:位置調整
text(x=par("usr")[2],y=G2[,ncol(G2)],labels=rownames(G2),pos=4,xpd=T,col=1:nrow(G2))
title("reported confirmed COVID-19cases")
#dev.off()
# G2_2
# 降順に並べ替え
G2_2<-G2_2[order(G2_2[,ncol(G2_2)],decreasing=T),]
#png("CoronavirusG2_2.png",width=800,height=600)
par(mar=c(5,5,4,10))
matplot(t(G2_2),type="o",pch=16,lwd=2,las=1,xlab="",ylab="",xaxt="n",col=1:nrow(G2_2))
axis(1,at=1:ncol(G2_2),labels=gsub("/20","",colnames(G2_2)))
# text:位置調整
#text(x=par("usr")[2],y=G2_2[,ncol(G2_2)]+c(0,0,0,30,0,-10),labels=rownames(G2_2),pos=4,xpd=T,col=1:nrow(G2_2))
legend(x=par("usr")[2],y=par("usr")[4],legend=rownames(G2_2),pch=16,lwd=2,col=1:nrow(G2_2),xpd=T,bty="n",y.intersp = 1.5)
title("reported confirmed COVID-19cases")
#dev.off()
# G3
# 降順に並べ替え
G3<-G3[order(G3[,ncol(G3)],decreasing=T),]
#png("CoronavirusG3.png",width=800,height=600)
par(mar=c(5,5,4,10))
matplot(t(G3),type="o",pch=16,lwd=2,las=1,xlab="",ylab="",xaxt="n",col=1:nrow(G3))
axis(1,at=1:ncol(G3),labels=gsub("/20","",colnames(G3)))
#text(x=par("usr")[2],y=G3[,ncol(G3)],labels=rownames(G3),pos=4,xpd=T,col=1:nrow(G3))
legend(x=par("usr")[2],y=par("usr")[4],legend=rownames(G3),pch=16,lwd=2,col=1:nrow(G3),xpd=T,bty="n",y.intersp = 1.5)
title("reported confirmed COVID-19cases")
#dev.off()
# G4
# 降順に並べ替え
G4<-G4[order(G4[,ncol(G4)],decreasing=T),]
col<- rainbow(nrow(G4))
#png("CoronavirusG4.png",width=800,height=600)
par(mar=c(5,5,4,10))
matplot(t(G4),type="o",pch=16,lwd=2,las=1,xlab="",ylab="",xaxt="n",col=col)
axis(1,at=1:ncol(G4),labels=gsub("/20","",colnames(G4)))
# text:位置調整
#text(x=par("usr")[2],y=G4[,ncol(G4)],labels=rownames(G4),pos=4,xpd=T,col=col)
legend(x=par("usr")[2],y=par("usr")[4],legend=rownames(G4),pch=16,lwd=2,col=col,xpd=T,bty="n",y.intersp = 1.5)
title("reported confirmed COVID-19cases")
#dev.off()
# G5
# 降順に並べ替え
G5<-G5[order(G5[,ncol(G5)],decreasing=T),]
col<- rainbow(nrow(G5))
#png("CoronavirusG5.png",width=800,height=600)
par(mar=c(5,5,4,10))
matplot(t(G5),type="o",pch=16,lwd=2,las=1,xlab="",ylab="",xaxt="n",col=col)
axis(1,at=1:ncol(G5),labels=gsub("/20","",colnames(G5)))
# text:位置調整
#text(x=par("usr")[2],y=G5[,ncol(G5)]+c(0.25,-0.25,0.25,-0.25,0,0),labels=rownames(G5),pos=4,xpd=T,col=col)
legend(x=par("usr")[2],y=par("usr")[4],legend=rownames(G5),pch=16,lwd=2,col=col,xpd=T,bty="n",y.intersp = 1.5)
title("reported confirmed COVID-19cases")
#dev.off()
# G6
# 降順に並べ替え
G6<-G6[order(G6[,ncol(G6)],decreasing=T),]
col<- rainbow(nrow(G6))
#png("CoronavirusG6.png",width=800,height=600)
par(mar=c(5,5,4,15))
matplot(t(G6),type="o",pch=16,lwd=2,las=1,xlab="",ylab="",xaxt="n",col=col)
axis(1,at=1:ncol(G6),labels=gsub("/20","",colnames(G6)))
legend(x=par("usr")[2],y=par("usr")[4],legend=rownames(G6),pch=16,lwd=2,col=col,xpd=T,bty="n",y.intersp = 1.5,cex=0.8,ncol=2)
title("reported confirmed COVID-19cases")
#dev.off()
```

## 現在は使っていないRコードです。lubridateパッケージの覚書として残しています。

```R
library(xts)
library(lubridate)
#
# read.csvの際には、check.names=Fをつける
url<- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv"
Confirmed<- read.csv(url,check.names=F)
url<- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Recovered.csv"
Recovered<- read.csv(url,check.names=F)
url<- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Deaths.csv"
Deaths<- read.csv(url,check.names=F)
```

### time_seriesデータは一日に数回更新だったのが、日次データになっていました。

```R
#lubridateパッケージを使うのが便利
t<-mdy(colnames(Confirmed)[5:ncol(Confirmed)])
nCoV<-data.frame(date=t,Confirmed=as.vector(colSums(Confirmed[,5:ncol(Confirmed)],na.rm=T)))
#
t<-mdy(colnames(Recovered)[5:ncol(Recovered)])
d<-data.frame(date=t,Recovered=as.vector(colSums(Recovered[,5:ncol(Recovered)],na.rm=T)))
# merge
nCoV<-merge(nCoV,d,by="date")
#
t<-mdy(colnames(Deaths)[5:ncol(Deaths)])
d<-data.frame(date=t,Deaths=as.vector(colSums(Deaths[,5:ncol(Deaths)],na.rm=T)))
nCoV<-merge(nCoV,d,by="date")
```

### 感染者、回復された方、亡くなった方の数の推移（日別）

```R
# png("Coronavirus01.png",width=800,height=600)
par(mar=c(3,5,3,2))
matplot(nCoV[,2:4],type="o",col=1:3,lwd=1.5,lty=1:3,pch=16:18,las=1,xaxt="n",ylab="")
axis(1,at=1:nrow(nCoV), labels =gsub("2020-","",nCoV[,1] ))
legend("topleft", legend = colnames(nCoV[,2:4]),col=1:3,lwd=1.5,lty=1:3,pch=16:18,inset =c(0.02,0.03))
title("Coronavirus [ Total Confirmed,Total Recovered,Total Deaths ]")
# dev.off()
```

