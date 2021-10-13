---
title: 都道府県別検査陽性者数と死亡者数(新型コロナウイルス：Coronavirus)
date: 2021-10-13
tags: ["R","NipponMap","Coronavirus","新型コロナウイルス"]
excerpt: NHKのデータ
---

# 都道府県別検査陽性者数と死亡者数(新型コロナウイルス：Coronavirus)

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus18&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

(参考)  
[Rでグラフを描くときにY軸のタイトルを縦書きにする](https://id.fnshr.info/2017/03/13/r-plot-tategaki/)  
- tategaki 関数(簡潔でスッキリとした関数)を参考にさせてもらいました。

(昔（2015年）書いた記事)  
[統計ソフトRの備忘録２:縦書き帯グラフ棒グラフ](https://statrstart.github.io/2015/05/02/%E7%B8%A6%E6%9B%B8%E3%81%8D%E5%B8%AF%E3%82%B0%E3%83%A9%E3%83%95%E6%A3%92%E3%82%B0%E3%83%A9%E3%83%95/)

(使用するデータ)  
[NHK:新型コロナ データ](https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv)  

#### 東北の累計感染者数の推移 [ データ：ＮＨＫ ]

![covTohoku.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covTohoku.png)

#### 中国地方の累計感染者数の推移 [ データ：ＮＨＫ ]

![covChu.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covChu.png)

#### 累計感染者数2000人以下の県の累計感染者数の推移 [ データ：ＮＨＫ ]

![covU2000.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covU2000.png)

#### 都道府県別の感染者数 [ データ：ＮＨＫ ]

![nhkC01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/nhkC01.png)

#### 都道府県別の人口１万人あたり感染者数 [ データ：ＮＨＫ ]

![nhkC02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/nhkC02.png)

#### 都道府県別の死亡者数 [ データ：ＮＨＫ ]

![nhkC03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/nhkC03.png)

#### 都道府県別の人口100万人あたり死亡者数 [ データ：ＮＨＫ ]

![nhkC04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/nhkC04.png)

#### 都道府県別の致死率(%) [ データ：ＮＨＫ ]

![nhkC05](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/nhkC05.png)

### Rコード

#### パッケージ読み込み、データ読み込み

```R
library(xts)
library(sf)
library(NipponMap)
#
nhkC<- read.csv("https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv")
#
# 都道府県別人口
shp <- system.file("shapes/jpn.shp", package = "NipponMap")[1]
m <- sf::read_sf(shp)
```

#### 都道府県別の感染者数 [ データ：ＮＨＫ ]

```R
code<- 1:47
#感染者数累計
#
column<- c(1,5)
# 
Cdata<- nhkC[nhkC$都道府県コード==code[1],column]
Cdata.xts<- as.xts(read.zoo(Cdata, format="%Y/%m/%d"))
# 
for (i in code[-1]){
	Cdata<- nhkC[nhkC$都道府県コード== i,column]
	tmp.xts<- as.xts(read.zoo(Cdata, format="%Y/%m/%d"))
	Cdata.xts<- merge(Cdata.xts,tmp.xts)
}
# NA<- 0
coredata(Cdata.xts)[is.na(Cdata.xts)]<- 0
colnames(Cdata.xts)<- unique(nhkC[nhkC$都道府県コード==code,"都道府県名"])
#
#tail(Cdata.xts,1)
vec<- as.vector(tail(Cdata.xts,1))
# tategaki関数の定義なしですませる
#
#png("nhkC01.png",width=800,height=600)
par(mar=c(4,4,3,1),family="serif")
b<- barplot(vec,yaxt="n",las=1,col="royalblue3",ylim=c(0,max(vec,na.rm=T)*1.1))
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
for (i in 1:length(vec)){
	x = strsplit(split="",colnames(Cdata.xts)[i])
	x = sapply(x, paste, collapse="\n")
	text(x=b[i],y=0,labels=x,pos=1,offset=1,xpd=T)
}
title("都道府県別の感染者数 [ データ：ＮＨＫ ] ")
#dev.off()
```

#### 都道府県別の人口１万人あたり感染者数 [ データ：ＮＨＫ ]

```R
code<- 1:47
#人口１万人あたり感染者数
#
column<- c(1,5)
perP<- 10000
# 
Cdatap<- nhkC[nhkC$都道府県コード==code[1],column]
Cdatap.xts<- as.xts(read.zoo(Cdatap, format="%Y/%m/%d"))
Cdatap.xts<- round(Cdatap.xts[,1]*perP/m$population[1],2)
# 
for (i in code[-1]){
	Cdatap<- nhkC[nhkC$都道府県コード== i,column]
	tmp.xts<- as.xts(read.zoo(Cdatap, format="%Y/%m/%d"))
	tmp.xts<- round(tmp.xts[,1]*perP/m$population[i],2)
	Cdatap.xts<- merge(Cdatap.xts,tmp.xts)
}
# NA<- 0
coredata(Cdatap.xts)[is.na(Cdatap.xts)]<- 0
colnames(Cdatap.xts)<- unique(nhkC[nhkC$都道府県コード==code,"都道府県名"])
#
vec<- as.vector(tail(Cdatap.xts,1))
# 
#png("nhkC02.png",width=800,height=600)
par(mar=c(4,4,3,1),family="serif")
b<- barplot(vec,yaxt="n",las=1,col="royalblue4",ylim=c(0,max(vec,na.rm=T)*1.1))
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
for (i in 1:length(vec)){
	x = strsplit(split="",colnames(Cdatap.xts)[i])
	x = sapply(x, paste, collapse="\n")
	text(x=b[i],y=0,labels=x,pos=1, offset=1,xpd=T)
}
title("都道府県別の人口１万人あたり感染者数 [ データ：ＮＨＫ ] ")
#dev.off()
```

#### 都道府県別の死亡者数 [ データ：ＮＨＫ ]

```R
code<- 1:47
#死亡者数
#
column<- c(1,7)
# 
Ddata<- nhkC[nhkC$都道府県コード==code[1],column]
Ddata.xts<- as.xts(read.zoo(Ddata, format="%Y/%m/%d"))
# 
for (i in code[-1]){
	Ddata<- nhkC[nhkC$都道府県コード== i,column]
	tmp.xts<- as.xts(read.zoo(Ddata, format="%Y/%m/%d"))
	Ddata.xts<- merge(Ddata.xts,tmp.xts)
}
# NA<- 0
coredata(Ddata.xts)[is.na(Ddata.xts)]<- 0
colnames(Ddata.xts)<- unique(nhkC[nhkC$都道府県コード==code,"都道府県名"])
#
vec<- as.vector(tail(Ddata.xts,1))
#
#png("nhkC03.png",width=800,height=600)
par(mar=c(4,4,3,1),family="serif")
b<- barplot(vec,yaxt="n",las=1,col="brown3",ylim=c(0,max(vec,na.rm=T)*1.1))
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
for (i in 1:length(vec)){
	x = strsplit(split="",colnames(Ddata.xts)[i])
	x = sapply(x, paste, collapse="\n")
	text(x=b[i],y=0,labels=x,pos=1, offset=1,xpd=T)
}
title("都道府県別の死亡者数 [ データ：ＮＨＫ ] ")
#dev.off()
```

#### 都道府県別の人口100万人あたり死亡者数 [ データ：ＮＨＫ ]

```R
code<- 1:47
#人口100万人あたり死亡者数
#
column<- c(1,7)
perP<- 1000000
# 
Ddatap<- nhkC[nhkC$都道府県コード==code[1],column]
Ddatap.xts<- as.xts(read.zoo(Ddatap, format="%Y/%m/%d"))
Ddatap.xts<- round(Ddatap.xts[,1]*perP/m$population[1],2)
# 
for (i in code[-1]){
	Ddatap<- nhkC[nhkC$都道府県コード== i,column]
	tmp.xts<- as.xts(read.zoo(Ddatap, format="%Y/%m/%d"))
	tmp.xts<- round(tmp.xts[,1]*perP/m$population[i],2)
	Ddatap.xts<- merge(Ddatap.xts,tmp.xts)
}
# NA<- 0
coredata(Ddatap.xts)[is.na(Ddatap.xts)]<- 0
colnames(Ddatap.xts)<- unique(nhkC[nhkC$都道府県コード==code,"都道府県名"])
#
vec<- as.vector(tail(Ddatap.xts,1))
# 
#png("nhkC04.png",width=800,height=600)
par(mar=c(4,4,3,1),family="serif")
b<- barplot(vec,yaxt="n",las=1,col="brown4",ylim=c(0,max(vec,na.rm=T)*1.1))
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
for (i in 1:length(vec)){
	x = strsplit(split="",colnames(Ddatap.xts)[i])
	x = sapply(x, paste, collapse="\n")
	text(x=b[i],y=0,labels=x,pos=1, offset=1,xpd=T)
}
title("都道府県別の人口100万人あたり死亡者数 [ データ：ＮＨＫ ] ")
#dev.off()
```

#### 東北の累計感染者数

```R
code<- 2:7
#感染者数累計
# 
Cdata<- nhkC[nhkC$都道府県コード==code[1],c(1,5)]
Cdata.xts<- as.xts(read.zoo(Cdata, format="%Y/%m/%d"))
# 
for (i in code[-1]){
	Cdata<- nhkC[nhkC$都道府県コード== i,c(1,5)]
	tmp.xts<- as.xts(read.zoo(Cdata, format="%Y/%m/%d"))
	Cdata.xts<- merge(Cdata.xts,tmp.xts)
}
# NA<- 0
coredata(Cdata.xts)[is.na(Cdata.xts)]<- 0
colnames(Cdata.xts)<- unique(nhkC[nhkC$都道府県コード==code,"都道府県名"])
#
#plot(Cdata.xts)
labels<- sub("-","/",sub("-0","-",sub("^0","",sub("^....-","",index(Cdata.xts)))))
data<- coredata(Cdata.xts)
# 毎月1日
labelpos<- paste0(1:12,"/",1)
#png("covTohoku.png",width=800,height=600)
par(mar=c(5,4,5,9),family="serif")
matplot(data,type="l",lty=1,col=rainbow(length(code),alpha=0.8),lwd=1.5,las=1,bty="n",xlab="",ylab="",xaxt="n",xaxs="i")
box(bty="l",lwd=2.5)
for (i in labelpos){
	at<- which(labels== i)
	axis(1,at=at,labels = rep(paste0(sub("/1","",i),"月"),length(at)),tck= -0.02)	
	}
text(x=par("usr")[1],y=par("usr")[4],labels="(人)",pos=2,xpd=T)
text(x=par("usr")[2],y=tail(data,1),labels=paste0(colnames(data),":",tail(data,1),"人"),xpd=T,pos=4)
mtext(text="2020年",at=1,side=1,line=2.5,cex=1.2) 
mtext(text="2021年",at=352,side=1,line=2.5,cex=1.2) 
title("累計感染者数(東北)")
# dev.off()
```

#### 感染者2000人未満

```R
code<- 1:47
#感染者数累計
# 
Cdata<- nhkC[nhkC$都道府県コード==code[1],c(1,5)]
Cdata.xts<- as.xts(read.zoo(Cdata, format="%Y/%m/%d"))
# 
for (i in code[-1]){
	Cdata<- nhkC[nhkC$都道府県コード== i,c(1,5)]
	tmp.xts<- as.xts(read.zoo(Cdata, format="%Y/%m/%d"))
	Cdata.xts<- merge(Cdata.xts,tmp.xts)
}
# NA<- 0
coredata(Cdata.xts)[is.na(Cdata.xts)]<- 0
colnames(Cdata.xts)<- unique(nhkC[nhkC$都道府県コード==code,"都道府県コード"])
data<- coredata(tail(Cdata.xts,1))
#data[data<2000]
code<- colnames(data)[data<2000]
# 
Cdata<- nhkC[nhkC$都道府県コード==code[1],c(1,5)]
Cdata.xts<- as.xts(read.zoo(Cdata, format="%Y/%m/%d"))
# 
for (i in code[-1]){
	Cdata<- nhkC[nhkC$都道府県コード== i,c(1,5)]
	tmp.xts<- as.xts(read.zoo(Cdata, format="%Y/%m/%d"))
	Cdata.xts<- merge(Cdata.xts,tmp.xts)
}
# NA<- 0
coredata(Cdata.xts)[is.na(Cdata.xts)]<- 0
colnames(Cdata.xts)<- unique(nhkC[nhkC$都道府県コード==code,"都道府県名"])
#
#plot(Cdata.xts)
labels<- sub("-","/",sub("-0","-",sub("^0","",sub("^....-","",index(Cdata.xts)))))
data<- coredata(Cdata.xts)
data<- data[,order(-tail(data,1))]
# 毎月1日
labelpos<- paste0(1:12,"/",1)
# png("covU2000.png",width=800,height=600)
par(mar=c(5,4,5,9),family="serif")
matplot(data,type="l",lty=1,col=rainbow(length(code),alpha=0.8),lwd=2,las=1,bty="n",xlab="",ylab="",xaxt="n",xaxs="i")
box(bty="l",lwd=2.5)
for (i in labelpos){
	at<- which(labels== i)
	axis(1,at=at,labels = rep(paste0(sub("/1","",i),"月"),length(at)),tck= -0.02)	
	}
text(x=par("usr")[1],y=par("usr")[4],labels="(人)",pos=3,xpd=T)
text(x=par("usr")[2],y=tail(data,1),labels=colnames(data),xpd=T,pos=4)
mtext(text="2020年",at=1,side=1,line=2.5,cex=1.2) 
mtext(text="2021年",at=352,side=1,line=2.5,cex=1.2) 
legend("topleft",inset=0.03,legend=paste0(colnames(data)," : ",tail(data,1),"人"),lty=1,col=rainbow(length(code),alpha=0.8),lwd=2)
title("累計感染者数推移(累計感染者数2000人未満)")
# dev.off()
```
