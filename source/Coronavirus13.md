---
title: 東京都検査陽性者(新型コロナウイルス：Coronavirus)
date: 2020-11-15
tags: ["R","jsonlite","TTR","Coronavirus","東京都","新型コロナウイルス"]
excerpt: 東京都 新型コロナウイルス感染症対策サイトのデータ
---

# 東京都陽性者(新型コロナウイルス：Coronavirus)

![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus13)  

[東京都 新型コロナウイルス感染症対策サイトにあるデータ](https://raw.githubusercontent.com/tokyo-metropolitan-gov/covid19/development/data/data.json)を使います。

6/12以降、検査実施件数のデータの公開はなされていますが、検査実施人数のデータ公開はなくなりました。  
2020-11-12以降、陽性者の属性のデータ公開はなくなりました。

#### 時系列

![covTokyo01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covTokyo01.png)

#### 時系列(y軸対数表示)
- 折れ線は現時点でも公開されている「検査実施件数」です。
- y軸は対数表示です。

![covTokyo01_1](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covTokyo01_1.png)

#### 検査件数陽性者率（%）推移（1週間(7日)の幅で移動平均した数で計算)
分母は「検査人数」ではなく、公表されている「検査件数」です。

![covTokyo02_3](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covTokyo02_3.png)

#### 週単位の陽性者増加比

![covTokyo05](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covTokyo05.png)

#### 検査陽性者率（%）推移（累計した数で計算)
6/11までのグラフです。

![covTokyo02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covTokyo02.png)

#### 直近の状況を見るには移動平均の方が累計より適しているので 検査陽性率(%)を1週間(7日)の幅で移動平均
6/11までのグラフです。

![covTokyo02_2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covTokyo02_2.png)

### 2020-11-11まで

#### 年代（月別）2020-11-11まで
- 「不明」「-」はのせていません。
- 「８０代」「９０代」「１００歳以上」は「８０歳以上」にまとめました。

![covTokyo03_2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covTokyo03_2.png)

#### 年代(累計)2020-11-11まで

![covTokyo03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covTokyo03.png)

#### 性別(累計)2020-11-11まで

![covTokyo04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covTokyo04.png)

### Rコード

#### (json形式)データ読み込み

```R
#install.packages("jsonlite")
#install.packages("curl")
library(jsonlite)
library(knitr)
library(TTR)
url<- "https://raw.githubusercontent.com/tokyo-metropolitan-gov/covid19/development/data/data.json"
js<- fromJSON(url)
names(js)
```

#### 時系列

```R
#### 時系列
# 致死率(%): 亡くなった人の数/陽性患者数*100
Dth<- round(js[[6]]$children$children[[1]][grep("死亡",js[[6]]$children$children[[1]]$attr),2]/js[[6]]$children$value*100,2)
#
# 検査陽性者数
patients<- js[[3]]$data
patients[,1]<- substring(patients[,1],6,10)
colnames(patients)<- c("date","patients")
dat<- patients
sma7<- round(SMA(dat[,"patients"],7),2)
# 日付を例えば、01-01を1/1 のように書き直す。
dat[,1]<- sub("-","/",sub("-0","-",sub("^0","",dat[,1])))
ritsu2<- paste("・致  死  率   (%) :",Dth,"%")
#png("covTokyo01.png",width=800,height=600)
par(mar=c(3,7,4,2),family="serif")
b<- barplot(dat[,"patients"],names=dat[,1],col="red",las=1,ylim=c(0,max(dat[,"patients"],na.rm=T)*1.1))
lines(x=b,y=sma7,lwd=2.5,col="blue")
legend("topleft",inset=0.03,lwd=2.5,col="blue",legend="7日移動平均",cex=1.2)
legend("topleft",inset=c(0.03,0.15),bty="n",cex=1.5,legend=c(paste0(js[[3]]$date,"現在"),ritsu2))
title("陽性者の人数：時系列(東京都)",cex.main=1.5)
#dev.off()
```

#### 時系列(対数表示)

```R
# 検査陽性者数
patients<- js[[3]]$data
patients[,1]<- substring(patients[,1],6,10)
colnames(patients)<- c("date","patients")
patients$date<- sub("-","/",sub("-0","-",sub("^0","",patients$date)))
#検査実施件数
df<- data.frame(js[[4]]$data)
inspection<- data.frame(date=js[[4]]$label,inspection=rowSums(df))
#patients$id  <- 1:nrow(patients)
#dat<- merge(patients,inspection,by="date",all.x=T,sort=F)
#dat<- dat[order(dat$id), ]
dat<- plyr::join(patients,inspection)
dat$patients[dat$patients==0]<- NA
dat$inspection[dat$inspection==0]<- NA
#
ylim<- c(0.9,max(dat[,"inspection"],na.rm=T))
#png("covTokyo01_1.png",width=800,height=600)
par(mar=c(4,5,4,3),family="serif")
b<- barplot(dat[,"patients"],names=dat[,1],las=1,log="y",ylim=ylim)
abline(h=10^(0:3),col="darkgray",lwd=1.2,lty=3)
for (i in 1:9){
	abline(h=i*10^(0:3),col="darkgray",lwd=0.8,lty=3)
}
barplot(dat[,"patients"],names=NA,col="red",log="y",las=1,axes=F,ylim=ylim,add=T)
lines(x=b,y=dat[,"inspection"],lwd=1.2,col="darkgreen")
points(x=b,y=dat[,"inspection"],pch=16,cex=0.8,col="darkgreen")
legend("topleft",inset=0.03,bty="n",legend="PCR検査実施件数",lwd=2,lty=1,pch=16,col="darkgreen")
title("東京都の検査陽性者数 対数表示（日別）",cex.main=1.5)
#dev.off()
```

#### 検査件数陽性率(%)を1週間(7日)の幅で移動平均

```R
# 検査陽性率(%)を1週間(7日)の幅で移動平均
library(TTR)
# 検査陽性者数
patients<- js[[3]]$data
patients[,1]<- sub("-","/",sub("-0","-",sub("^0","",substring(patients[,1],6,10))))
colnames(patients)<- c("date","patients")
#検査実施件数
df<- data.frame(js[[4]]$data)
rownames(df)<- js[[4]]$label
inspection<- data.frame(date=js[[4]]$label,inspection=rowSums(df))
#dat<- merge(patients,inspection,by="date",all=T,sort=F)
dat<- plyr::join(patients,inspection)
# 1週間の幅で移動平均
dat<- na.omit(dat)
dat2<- data.frame(date=dat[,1],patients=SMA(dat[,2],n=7),inspection=SMA(dat[,3],n=7))
#dat2<- na.omit(dat2)
dat2<- dat2[7:nrow(dat2),]
#検査陽性率(%)= 検査陽性者数/検査実施件数*100
dat2[,4]<- round(dat2[,2]/dat2[,3]*100,2)
#
#png("covTokyo02_3.png",width=800,height=600)
par(mar=c(3,6,4,7),family="serif")
# プロットする範囲は0%から20%とした
plot(dat2[,4],type="o",pch=16,lwd=2,las=1,xaxt="n",xlab="",ylab="",bty="n",ylim=c(0,20))
box(bty="l",lwd=2)
# 日付を例えば、01-01を1/1 のように書き直す。
#dat2[,1]<- sub("-","/",sub("-0","-",sub("^0","",dat2[,1])))
#表示するx軸ラベルを指定
axis(1,at=1:length(dat2[,1]),labels =NA,tck= -0.01)
labels<- dat2[,1]
labelpos<- paste0(rep(1:12,each=3),"/",c(1,10,20))
for (i in labelpos){
	at<- match(i,labels)
	if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.02)}
	}
text(x=par("usr")[2],y=dat2[,4][nrow(dat2)],labels= paste0(dat2[,1][nrow(dat2)],"現在\n",dat2[,4][nrow(dat2)],"%"),
	xpd=T,cex=1.2,col="red",pos=4)
title("東京都のPCR検査件数陽性率(%)の推移(1週間(7日)の幅で移動平均)",cex.main=1.5)
#dev.off()
```

### 週単位の陽性者増加比

```R
#週単位の陽性者増加比
library(TTR)
# 検査陽性者数
patients<- js[[3]]$data
patients[,1]<- sub("-","/",sub("-0","-",sub("^0","",substring(patients[,1],6,10))))
colnames(patients)<- c("date","patients")
#
x<- patients[,2]
e7<- runSum(x,n=7)
b7<- runSum(x,n=14) - e7
df<- round(e7/b7,2)
# InfにNAを入れる
df[df==Inf]<- NA
dat<- data.frame(date=patients$date,zougen= df)
dat<- dat[28:nrow(dat),]
#
#png("covTokyo05.png",width=800,height=600)
par(mar=c(4,6,4,7),family="serif")
plot(dat[,2],type="l",lwd=2,las=1,ylim=c(0,6),xlab="",ylab="",xaxt="n",bty="n")
box(bty="l",lwd=2.5)
#axis(1,at=1:nrow(dat),labels=dat[,1])
labels<- dat[,1]
labels<-gsub("^.*/","",labels)
pos<-gsub("/.*$","",sub("/20","",dat[,1]))
pos<- factor(pos,levels=min(as.numeric(pos)):max(as.numeric(pos)))
for (i in c("1","10","20")){
	at<- grep("TRUE",is.element(labels,i))
	axis(1,at=at,labels = rep(i,length(at)))
	}
Month<-c("Jan.","Feb.","Mar.","Apr.","May","Jun.","Jul.","Aug.","Sep.","Oct.","Nov.","Dec.")
mon<-cut(as.numeric(names(table(pos))),breaks = seq(0,12),right=T, labels =Month)
# 月の中央
#mtext(text=mon,at=cumsum(as.vector(table(pos)))-as.vector(table(pos)/2),side=1,line=2) 
# 月のはじめ
mtext(text=mon,at=1+cumsum(as.vector(table(pos)))-as.vector(table(pos)),side=1,line=2) 
abline(h=1,col="red",lty=2)
text(x=par("usr")[2],y=dat[,2][nrow(dat)],labels= paste0(dat[,1][nrow(dat)],"現在\n",dat[,2][nrow(dat)]),xpd=T,cex=1.2,col="red")
arrows(par("usr")[2]*1.08, 1.1,par("usr")[2]*1.08,1.68,length = 0.2,lwd=2.5,xpd=T)
text(x=par("usr")[2]*1.08,y=1.9,labels="増加\n傾向",xpd=T)
arrows(par("usr")[2]*1.08, 0.9,par("usr")[2]*1.08,0.32,length = 0.2,lwd=2.5,xpd=T)
text(x=par("usr")[2]*1.08,y=0.1,labels="減少\n傾向",xpd=T)
title("週単位の陽性者増加比(東京都)",cex.main=1.5)
#dev.off()
```
