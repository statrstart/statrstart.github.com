---
title: 大阪府 年代別重症者数と死亡者数(新型コロナウイルス：Coronavirus)
date: 2021-04-25
tags: ["R","rvest","rio","大阪府","新型コロナウイルス"]
excerpt: 大阪府 新型コロナウイルス感染症患者の発生状況のexcelデータ
---

# 大阪府 年代別重症者数と死亡者数(新型コロナウイルス：Coronavirus)

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus21&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

(使用するデータ)  
[新型コロナウイルス感染症患者の発生状況（令和2年11月2日以降）](http://www.pref.osaka.lg.jp/iryo/osakakansensho/happyo_kako.html)  

#### 大阪府：年代別重症者数と死亡者数(2020-12-01 :: 2021-04-25)

![covid21_01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_01.png)

#### 大阪府：年代別重症者数と死亡者数との差(2020-12-01 :: 2021-04-25)

![covid21_02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_02.png)

### 「緊急事態宣言解除」前倒し 前と後の年代別 重症者数と死亡者数

#### 大阪府：期間重症者数と死亡者数([2020-12-01::2021-02-28] VS [2021-03-01::2021-04-25])

![covid21_03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_03.png)

#### 大阪府：年代別重症者数([2020-12-01::2021-02-28] VS [2021-03-01::2021-04-25])

![covid21_04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_04.png)

#### 大阪府：年代別死亡者数([2020-12-01::2021-02-28] VS [2021-03-01::2021-04-25])

![covid21_05](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_05.png)

#### 大阪府：年代別重症者数と死亡者数との差([2020-12-01::2021-02-28] VS [2021-03-01::2021-04-25])

![covid21_06](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_06.png)

### Rコード

#### rvestパッケージを使って、エクセルファイル名を入手。rioパッケージでエクセルファイル読み込み。
#### 重症者、死亡者の年代、性別の書いてある部分を抽出する。

```R
library(rvest)
library(rio)
xl<- NULL
Ddat<- NULL
Sdat<- NULL
#
#2020 12
for (i in 12){
source_url <- paste0("http://www.pref.osaka.lg.jp/iryo/osakakansensho/happyo_kako-r02",i,".html")
#
html <- read_html(source_url)
links <- html %>% html_nodes("a") %>% html_attr("href")
xl<- c(xl,rev(links[grep("xlsx",links)]))
}
#重複urlを削除
xl<- unique(xl)
#
for (i in xl){
tryCatch(
{
	url<-paste0("http://www.pref.osaka.lg.jp",i)
	df<- rio::import(file = url,which = 2)
	ss<- grep("重症の状況",df[,1])+3
	ee<- grep("市町村別陽性者発生状況",df[,1])-1
	ee<- tail(ee,1)
	dat1<- df[ss:ee,c(1,2,4)]
	colnames(dat1)<- c("Date","年代","性別")
	dat1[,1]<- as.numeric(dat1[,1])
	dat1<- dat1[ !is.na(dat1[,2]),]
#
	dat2<- df[ss:ee,c(15,16,18)]
	colnames(dat2)<- c("Date","年代","性別")
	dat2[,1]<- as.numeric(dat2[,1])
	dat2<- dat2[ !is.na(dat2[,2]),]
	Cdate<- substring(sub("\\.xlsx","",sub("^.*/","",i)),1,4)
	if (length(dat1$Date)!=0){dat1$Date<- paste0("2020",Cdate)}
	if (length(dat2$Date)!=0){dat2$Date<- paste0("2020",Cdate)}
	Ddat<- rbind(Ddat,dat1)
	Sdat<- rbind(Sdat,dat2)
}
 , error = function(e) {}
)
}
#
# #2021
xl<- NULL
# 先月（３月）まで
for (i in paste0("0",1:3)){
source_url <- paste0("http://www.pref.osaka.lg.jp/iryo/osakakansensho/happyo_kako-r03",i,".html")
#
html <- read_html(source_url)
links <- html %>% html_nodes("a") %>% html_attr("href")
xl<- c(xl,rev(links[grep("xlsx",links)]))
}
#重複urlを削除
xl<- unique(xl)
#
# 今月
source_url <- "http://www.pref.osaka.lg.jp/iryo/osakakansensho/happyo_kako.html"
#
html <- read_html(source_url)
links <- html %>% html_nodes("a") %>% html_attr("href")
xl<- c(xl,rev(links[grep("xlsx",links)]))
#重複urlを削除
xl<- unique(xl)
#
for (i in xl){
tryCatch(
{
	url<-paste0("http://www.pref.osaka.lg.jp",i)
	df<- rio::import(file = url,which = 2)
	ss<- grep("重症の状況",df[,1])+3
	ee<- grep("市町村別陽性者発生状況",df[,1])-1
	ee<- tail(ee,1)
	dat1<- df[ss:ee,c(1,2,4)]
	colnames(dat1)<- c("Date","年代","性別")
	dat1[,1]<- as.numeric(dat1[,1])
	dat1<- dat1[ !is.na(dat1[,2]),]
#
	dat2<- df[ss:ee,c(15,16,18)]
	colnames(dat2)<- c("Date","年代","性別")
	dat2[,1]<- as.numeric(dat2[,1])
	dat2<- dat2[ !is.na(dat2[,2]),]
	Cdate<- substring(sub("\\.xlsx","",sub("^.*/","",i)),1,4)
	if (length(dat1$Date)!=0){dat1$Date<- paste0("2021",Cdate)}
	if (length(dat2$Date)!=0){dat2$Date<- paste0("2021",Cdate)}
	Ddat<- rbind(Ddat,dat1)
	Sdat<- rbind(Sdat,dat2)
}
 , error = function(e) {}
)
}
#
# 行名付け直し
rownames(Ddat)<- 1:nrow(Ddat)
rownames(Sdat)<- 1:nrow(Sdat)
# 2021/03/07のエクセルのファイル名は特に変
Ddat$Date[which(Ddat$Date=="2021syus")] <- "20210307"
Sdat$Date[which(Sdat$Date=="2021syus")] <- "20210307"
#
#save(Ddat,file="Ddat.rda") ; save(Sdat,file="Sdat.rda")
# load("Ddat.rda") ; load("Sdat.rda")
#barplot(table(Ddat$Date),ylim=c(0,max(table(Ddat$Date))*1.2),las=1,col="brown")
# 月ごとの死亡者数が一致しているか確認
table(substring(Ddat$Date,1,6))
# 202012 202101 202102 202103 202104   
#   259    347    191     67    117 <- 4月は4/21までのデータ
#
#barplot(table(Sdat$Date),ylim=c(0,max(table(Sdat$Date))*1.2),las=1,col="brown")
#table(substring(Sdat$Date,1,6))
# 死亡者数を日毎に確認する場合（NHKのデータと照らし合わせる）
AA<- xts(read.zoo(data.frame(table(Ddat$Date)),format="%Y%m%d"))
load("nhkC.Rdata")
code<-27
BB<- xts(read.zoo(nhkC[nhkC$都道府県コード==code,c(1,6)]))
AABB<- merge(AA,BB)
AABB[is.na(AABB)]<- 0
AABB2<- AABB["2020-12-01::2021-04-21"]
AABB[AABB2[,1]!=AABB2[,2],]
```

#### グラフ作成

```R
#png("covid21_01.png",width=800,height=800)
par(mfrow=c(2,1),mar=c(3,3,3,2))
d<- table(factor(Sdat$年代,levels=c("未就学児",seq(10,100,10))))
b<- barplot(d,ylim=c(0,max(d)*1.2),las=1,col="brown2")
text(x=b,y=d,labels=d,pos=3)
title("大阪府：年代別重症者数(2020-12-01 :: 2021-04-21)")
#
d<- table(factor(Ddat$年代,levels=c("未就学児",seq(10,100,10))))
b<- barplot(d,ylim=c(0,max(d)*1.2),las=1,col="brown3")
text(x=b,y=d,labels=d,pos=3)
title("大阪府：年代別死亡者数(2020-12-01 :: 2021-04-21)")
par(mfrow=c(1,1))
#dev.off()
#
#png("covid21_02.png",width=800,height=600)
d<- table(factor(Sdat$年代,levels=c("未就学児",seq(10,100,10))))-table(factor(Ddat$年代,levels=c("未就学児",seq(10,100,10))))
b<- barplot(d,ylim=c(min(d)*1.2,max(d)*1.2),las=1,col="brown2")
text(x=b,y=d,labels=d,pos=c(rep(3,8),rep(1,3)))
title("大阪府：年代別 重症者数 - 死亡者数\n(2020-12-01 :: 2021-04-21)")
#dev.off()
#
# 「緊急事態宣言解除」前倒し 前と後の年代別 重症者数と死亡者数
s3p<- Sdat[Sdat$Date <= 20210228,]
d3p<- Ddat[Ddat$Date <= 20210228,]
s4p<- Sdat[Sdat$Date >= 20210301,]
d4p<- Ddat[Ddat$Date >= 20210301,]
#
#png("covid21_03.png",width=800,height=800)
par(mfrow=c(2,1),mar=c(3,3,3,2))
d<- c(nrow(s3p),nrow(s4p))
names(d)<- c("2020-12-01::2021-02-28","2021-03-01::2021-04-21")
b<-barplot(d,ylim=c(0,max(d)*1.2),las=1,col="brown2")
text(x=b,y=d,labels=d,pos=3)
title("大阪府：期間重症者数([2020-12-01::2021-02-28] VS [2021-03-01::2021-04-21])")
#
d<- c(nrow(d3p),nrow(d4p))
names(d)<- c("2020-12-01::2021-02-28","2021-03-01::2021-04-21")
b<-barplot(d,ylim=c(0,max(d)*1.2),las=1,col="brown3")
text(x=b,y=d,labels=d,pos=3)
title("大阪府：期間死亡者数([2020-12-01::2021-02-28] VS [2021-03-01::2021-04-21])")
par(mfrow=c(1,1))
#dev.off()
#
#png("covid21_04.png",width=800,height=800)
par(mfrow=c(2,1),mar=c(3,3,3,2))
d<- table(factor(s3p$年代,levels=c("未就学児",seq(10,100,10))))
b<- barplot(d,ylim=c(0,max(d)*1.2),las=1,col="brown2")
text(x=b,y=d,labels=d,pos=3)
title("大阪府：年代別重症者数(2020-12-01 :: 2021-02-28)")
d<- table(factor(s4p$年代,levels=c("未就学児",seq(10,100,10))))
b<- barplot(d,ylim=c(0,max(d)*1.2),las=1,col="brown2")
text(x=b,y=d,labels=d,pos=3)
title("大阪府：年代別重症者数(2021-03-01 :: 2021-04-21)")
par(mfrow=c(1,1))
#dev.off()
#
#png("covid21_05.png",width=800,height=800)
par(mfrow=c(2,1),mar=c(3,3,3,2))
d<- table(factor(d3p$年代,levels=c("未就学児",seq(10,100,10))))
b<- barplot(d,ylim=c(0,max(d)*1.2),las=1,col="brown3")
text(x=b,y=d,labels=d,pos=3)
title("大阪府：年代別死亡者数(2020-12-01 :: 2021-02-28)")
d<- table(factor(d4p$年代,levels=c("未就学児",seq(10,100,10))))
b<- barplot(d,ylim=c(0,max(d)*1.2),las=1,col="brown3")
text(x=b,y=d,labels=d,pos=3)
title("大阪府：年代別死亡者数(2021-03-01 :: 2021-04-21)")
par(mfrow=c(1,1))
#dev.off()
```

