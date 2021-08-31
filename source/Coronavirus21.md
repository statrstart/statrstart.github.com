---
title: 大阪府 年代別重症者数と死亡者数(新型コロナウイルス：Coronavirus)
date: 2021-08-31
tags: ["R","rvest","rio","大阪府","新型コロナウイルス"]
excerpt: 大阪府 新型コロナウイルス感染症患者の発生状況のexcelデータ
---

# 大阪府 年代別重症者数と死亡者数(新型コロナウイルス：Coronavirus)

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus21&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

(使用するデータ)  
[新型コロナウイルス感染症患者の発生状況（令和2年11月2日以降）](http://www.pref.osaka.lg.jp/iryo/osakakansensho/happyo_kako.html) 

(参考資料)  
[大阪府:国の重症基準変更に伴う取扱いについて(pdf)](https://www.pref.osaka.lg.jp/attach/38215/00370237/3-3_kunikizyun.pdf)   

- 大事な点は、国の重症者の定義は「患者の症状」ではなく、「入院・療養状況」だということです。
- 要するに、病状が「重症」でも、「重症」に見合った「治療」が受けることができなかったら「重症者」の数には入らないということ。

#### 大阪府：年代別（但し、未就学児,10歳代は除く）重症者数累計 - 死亡者数累計(時系列) [参考]感染者数推移
(2021-06-30現在)

![covid21_11](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_11.png)

- ７０歳代、８０歳代の動きに注目。

#### 大阪府：年代別重症者数と死亡者数(2020-12-01 :: 2021-08-31)

![covid21_01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_01.png)

#### 大阪府：性別＆年代別重症者数と死亡者数(2020-12-01 :: 2021-08-31)

![covid21_07](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_07.png)

#### 大阪府：年代別重症者数と死亡者数との差(2020-12-01 :: 2021-08-31)

![covid21_02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_02.png)

- 感染者数>>>>>>>>重症者数>死亡者数になると思うのですが、80歳代以上は重症者数 < 死亡者数になっています。
- 重症者の定義が「患者の症状」ではなく、「入院・療養の状況」だからです。

### 2020/12/1から2021/2/28まで,2021/3/1から2021/6/20まで,2021/6/21から現在まで年代別 重症者数と死亡者数

#### 大阪府：期間重症者数と死亡者数

![covid21_03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_03.png)

#### 大阪府：期間別年代別重症者数

![covid21_04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_04.png)

#### 大阪府：期間別年代別死亡者数

![covid21_05](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_05.png)

#### 大阪府：期間別 性別＆年代別死亡者数

![covid21_08](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_08.png)

#### 大阪府：期間別年代別重症者数累計と死亡者数累計との差

![covid21_06](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_06.png)

- どの期間も80歳代以上は重症者数 < 死亡者数となっている。
- 70歳代のグラフに注目。

#### 大阪府：年代別（但し、未就学児,10歳代は除く）重症者数累計 - 死亡者数累計(時系列) [参考]感染者数推移

![covid21_09](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_09.png)
![covid21_10](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_10.png)

- 2021/4/ 5 : 大阪「まん延防止等重点措置」
- 2021/5/ 1 : 感染者数1,262人
- 2021/5/11 : 感染者55人死亡 最多更新

#### (おまけ)大阪府のコロナ死の数はどれだけの都道府県のコロナ死の合計に相当するのか？(人口最大化)

コードは[大阪府のコロナ死の数はどれだけの都道府県のコロナ死の合計に相当するのか？(人口最大化)](https://gitpress.io/@statrstart/Coronavirus23)  

![covid23_01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid23_01.png)

#### (おまけ２)大阪「市」のコロナ死の数はどれだけの都道府県のコロナ死の合計に相当するのか？(人口最大化)

- 大阪「市」だけでも１１００人以上の方が亡くなっている。

![covid23_02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid23_02.png)

#### 大阪府：年代別(10歳代から60歳代)重症者数累計および死亡者数累計(2020-12-01から)

![covid21_12](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_12.png)

#### 大阪府：年代別(10歳代から60歳代)(死亡者数累計/重症者数累計)×100(%)(2020-12-01から)

![covid21_15](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_15.png)

#### 大阪府：他府県管理※ 府外保健所への所管替事例の数(他府県における入院・宿泊・自宅療養中及び入院・療養等調整中の数）

- 他府県管理の数は令和3年2月12日からエクセルファイルに載っています。（2021-08-31現在）

![covid21_13](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_13.png)

#### 大阪府：入院、宿泊療養、自宅療養、入院.療養等調整中、他府県管理（2021年2月12日以降）

![covid21_14](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_14.png)

### Rコード

(追記)2021-04-30から死亡に自宅・宿泊死亡という項目が加わったため「重症者」の属性を読みとるためには、
読み取りの開始行と読み取る列を調整する必要があります。

(例) 2021-05-12のデータ

```R
new<- "/attach/23711/00376069/0512.xlsx"
#
# 2021-04-30から自宅・宿泊死亡という項目が加わったため変更あり
tDdat<- NULL
tSdat<- NULL
for (i in new){
tryCatch(
{
	url<-paste0("http://www.pref.osaka.lg.jp",i)
	df<- rio::import(file = url,which = 2)
#	ss<- grep("重症の状況",df[,1])+3
	ss<- grep("重症の状況",df[,1])+4
	ee<- grep("市町村別陽性者発生状況",df[,1])-1
	ee<- tail(ee,1)
	dat1<- df[ss:ee,c(1,2,4)]
	colnames(dat1)<- c("Date","年代","性別")
	dat1[,1]<- as.numeric(dat1[,1])
	dat1<- dat1[ !is.na(dat1[,2]),]
#
#	dat2<- df[ss:ee,c(15,16,18)]
	dat2<- df[ss:ee,c(18,19,21)]
	colnames(dat2)<- c("Date","年代","性別")
	dat2[,1]<- as.numeric(dat2[,1])
	dat2<- dat2[ !is.na(dat2[,2]),]
	Cdate<- substring(sub("\\.xlsx","",sub("^.*/","",i)),1,4)
	if (length(dat1$Date)!=0){dat1$Date<- paste0("2021",Cdate)}
	if (length(dat2$Date)!=0){dat2$Date<- paste0("2021",Cdate)}
	tDdat<- rbind(tDdat,dat1)
	tSdat<- rbind(tSdat,dat2)
}
 , error = function(e) {}
)
}
# 確認
tDdat ; tSdat
nrow(tDdat) ; nrow(tSdat)
```

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
b<- barplot(d,ylim=c(0,max(d)*1.2),las=1,col="orange2")
text(x=b,y=d,labels=d,pos=3)
title("大阪府：年代別重症者数(2020-12-01 :: 2021-04-21)")
#
d<- table(factor(Ddat$年代,levels=c("未就学児",seq(10,100,10))))
b<- barplot(d,ylim=c(0,max(d)*1.2),las=1,col="brown2")
text(x=b,y=d,labels=d,pos=3)
title("大阪府：年代別死亡者数(2020-12-01 :: 2021-04-21)")
par(mfrow=c(1,1))
#dev.off()
#
#png("covid21_07.png",width=800,height=800)
par(mfrow=c(2,1),mar=c(3,3,3,2))
d<- table(factor(Sdat$性別,levels=c("男","女")),factor(Sdat$年代,levels=c("未就学児",seq(10,100,10))) )
barplot(d ,beside=T,col=c("royalblue","brown"),las=T,legend=T,args.legend =list(x ="topleft",inset=0.03))
title("大阪府：性別＆年代別 重症者数 \n(2020-12-01 :: 2021-08-31)")
d<- table(factor(Ddat$性別,levels=c("男","女")),factor(Ddat$年代,levels=c("未就学児",seq(10,100,10))) )
barplot(d ,beside=T,col=c("royalblue","brown"),las=T,legend=T,args.legend =list(x ="topleft",inset=0.03))
title("大阪府：性別＆年代別  死亡者数\n(2020-12-01 :: 2021-08-31)")
#dev.off()
#
#png("covid21_02.png",width=800,height=600)
d<- table(factor(Sdat$年代,levels=c("未就学児",seq(10,100,10))))-table(factor(Ddat$年代,levels=c("未就学児",seq(10,100,10))))
b<- barplot(d,ylim=c(min(d)*1.2,max(d)*1.2),las=1,col="orchid3")
text(x=b,y=d,labels=d,pos=c(rep(3,8),rep(1,3)))
title("大阪府：年代別 重症者数累計 - 死亡者数累計\n(2020-12-01 :: 2021-04-21)")
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
b<-barplot(d,ylim=c(0,max(d)*1.2),las=1,col="orange2")
text(x=b,y=d,labels=d,pos=3)
title("大阪府：期間重症者数([2020-12-01::2021-02-28] VS [2021-03-01::2021-04-21])")
#
d<- c(nrow(d3p),nrow(d4p))
names(d)<- c("2020-12-01::2021-02-28","2021-03-01::2021-04-21")
b<-barplot(d,ylim=c(0,max(d)*1.2),las=1,col="brown2")
text(x=b,y=d,labels=d,pos=3)
title("大阪府：期間死亡者数([2020-12-01::2021-02-28] VS [2021-03-01::2021-04-21])")
par(mfrow=c(1,1))
#dev.off()
#
#png("covid21_04.png",width=800,height=800)
par(mfrow=c(2,1),mar=c(3,3,3,2))
d<- table(factor(s3p$年代,levels=c("未就学児",seq(10,100,10))))
b<- barplot(d,ylim=c(0,max(d)*1.2),las=1,col="orange2")
text(x=b,y=d,labels=d,pos=3)
title("大阪府：年代別重症者数(2020-12-01 :: 2021-02-28)")
d<- table(factor(s4p$年代,levels=c("未就学児",seq(10,100,10))))
b<- barplot(d,ylim=c(0,max(d)*1.2),las=1,col="orange2")
text(x=b,y=d,labels=d,pos=3)
title("大阪府：年代別重症者数(2021-03-01 :: 2021-04-21)")
par(mfrow=c(1,1))
#dev.off()
#
#png("covid21_05.png",width=800,height=800)
par(mfrow=c(2,1),mar=c(3,3,3,2))
d<- table(factor(d3p$年代,levels=c("未就学児",seq(10,100,10))))
b<- barplot(d,ylim=c(0,max(d)*1.2),las=1,col="brown2")
text(x=b,y=d,labels=d,pos=3)
title("大阪府：年代別死亡者数(2020-12-01 :: 2021-02-28)")
d<- table(factor(d4p$年代,levels=c("未就学児",seq(10,100,10))))
b<- barplot(d,ylim=c(0,max(d)*1.2),las=1,col="brown2")
text(x=b,y=d,labels=d,pos=3)
title("大阪府：年代別死亡者数(2021-03-01 :: 2021-04-21)")
par(mfrow=c(1,1))
#dev.off()
```

#### 時系列

```R
require(xts)
d<- table(as.Date(Ddat$Date,format = "%Y%m%d"),factor(Ddat$年代,levels=c("未就学児",seq(10,100,10))) )
seq(as.Date("2020-12-01"),Sys.Date(),by="day")[!is.element(seq(as.Date("2020-12-01"),Sys.Date(),by="day"),as.Date(Ddat$Date,format = "%Y%m%d"))]
d1<- merge(xts(NULL,seq(as.Date("2020-12-01"),Sys.Date(),by="day")),xts(d,as.Date(rownames(d))))
colnames(d1)<- c("未就学児","10","20","30","40","50","60","70","80","90","100")
coredata(d1)[is.na(d1)]<- 0
#apply(d1,2,cumsum)
#matplot(apply(d1,2,cumsum),type="l")
#
d<- table(as.Date(Sdat$Date,format = "%Y%m%d"),factor(Sdat$年代,levels=c("未就学児",seq(10,100,10))) )
seq(as.Date("2020-12-01"),Sys.Date(),by="day")[!is.element(seq(as.Date("2020-12-01"),Sys.Date(),by="day"),as.Date(Sdat$Date,format = "%Y%m%d"))]
d2<- merge(xts(NULL,seq(as.Date("2020-12-01"),Sys.Date(),by="day")),xts(d,as.Date(rownames(d))))
colnames(d2)<- c("未就学児","10","20","30","40","50","60","70","80","90","100")
coredata(d2)[is.na(d2)]<- 0
#apply(d2,2,cumsum)
#matplot(apply(d2,2,cumsum),type="l")
#png("covid21_09.png",width=800,height=800)
par(mar=c(5,4,4,5),family="serif")
col<- rainbow(9)
# "未就学児","10"は外す
d3<- apply(d2[,-c(1,2)],2,cumsum)-apply(d1[,-c(1,2)],2,cumsum)
matplot(d3,type="l",lty=1,lwd=2,col=col,las=1,ylab="",xaxt="n",bty="n")
box(bty="l",lwd=2)
axis(1,at=grep("-01$",index(d1)),labels= paste0(c(12,1:6),"月"))
#mtext("2020年",1,at=1,line=2.5)
mtext("2021年",1,at=32,line=2.5)
text(x=par("usr")[2],y=coredata(tail(d3,1)),labels=paste0(colnames(d3),"歳代"),xpd=T)
abline(v=138,col="gray20",lty=2)
text(x=138,y=par("usr")[4],labels="2021-04-17",xpd=T)
abline(v=171,col="gray20",lty=2)
text(x=171,y=par("usr")[4],labels="2021-05-20",xpd=T)
title("大阪府：年代別（但し、未就学児,10歳代は除く）重症者数累計 - 死亡者数累計(時系列)")
#dev.off()
```

#### 3期間

```R
s3p<- Sdat[Sdat$Date <= 20210228,]
d3p<- Ddat[Ddat$Date <= 20210228,]
s4p<- Sdat[Sdat$Date >= 20210301 & Sdat$Date <= 20210620,]
d4p<- Ddat[Ddat$Date >= 20210301 & Ddat$Date <= 20210620,]
s5p<- Sdat[Sdat$Date >= 20210621,]
d5p<- Ddat[Ddat$Date >= 20210621,]
#png("covid21_03.png",width=800,height=800)
par(mfrow=c(2,1),mar=c(3,3,3,2))
d<- c(nrow(s3p),nrow(s4p),nrow(s5p))
names(d)<- c("2020-12-01から\n2021-02-28まで","2021-03-01から\n2021-06-20まで","2021-06-21から\n2021-08-31まで")
b<- barplot(d,ylim=c(0,max(d)*1.2),las=1,col="orange2")
text(x=b,y=d,labels=d,pos=3)
title("大阪府：期間別重症者数")
#
d<- c(nrow(d3p),nrow(d4p),nrow(d5p))
names(d)<- c("2020-12-01から\n2021-02-28まで","2021-03-01から\n2021-06-20まで","2021-06-21から\n2021-08-31まで")
b<- barplot(d,ylim=c(0,max(d)*1.2),las=1,col="brown2")
text(x=b,y=d,labels=d,pos=3)
title("大阪府：期間別死亡者数")
par(mfrow=c(1,1))
#dev.off()
#png("covid21_04.png",width=800,height=600)
par(mfrow=c(1,1),mar=c(3,3,3,2))
d<- table(factor(s3p$年代,levels=c("未就学児",seq(10,100,10))))
d<- rbind(d,table(factor(s4p$年代,levels=c("未就学児",seq(10,100,10)))))
d<- rbind(d,table(factor(s5p$年代,levels=c("未就学児",seq(10,100,10)))))
b<-barplot(d,beside=T,legend=T,las=1,col=c("royalblue","orange","brown"),ylim=c(0,max(d)*1.2),
	args.legend=list(x="topleft",inset=0.03,legend=c("2020-12-01から2021-02-28まで","2021-03-01から2021-06-20まで","2021-06-21から2021-08-31まで")))
text(x=b,y=d,labels=d,pos=3)
title("大阪府：期間別年代別重症者数")
#dev.off()
#png("covid21_05.png",width=800,height=600)
par(mfrow=c(1,1),mar=c(3,3,3,2))
d<- table(factor(d3p$年代,levels=c("未就学児",seq(10,100,10))))
d<- rbind(d,table(factor(d4p$年代,levels=c("未就学児",seq(10,100,10)))))
d<- rbind(d,table(factor(d5p$年代,levels=c("未就学児",seq(10,100,10)))))
b<-barplot(d,beside=T,legend=T,las=1,col=c("royalblue","orange","brown"),ylim=c(0,max(d)*1.2),
	args.legend=list(x="topleft",inset=0.03,legend=c("2020-12-01から2021-02-28まで","2021-03-01から2021-06-20まで","2021-06-21から2021-08-31まで")))
text(x=b,y=d,labels=d,pos=3)
title("大阪府：期間別年代別死亡者数")
#dev.off()
#png("covid21_06.png",width=800,height=600)
par(mfrow=c(1,1),mar=c(3,3,3,2))
d<- table(factor(s3p$年代,levels=c("未就学児",seq(10,100,10))))-table(factor(d3p$年代,levels=c("未就学児",seq(10,100,10))))
d<- rbind(d,table(factor(s4p$年代,levels=c("未就学児",seq(10,100,10))))-table(factor(d4p$年代,levels=c("未就学児",seq(10,100,10)))) )
d<- rbind(d,table(factor(s5p$年代,levels=c("未就学児",seq(10,100,10))))-table(factor(d5p$年代,levels=c("未就学児",seq(10,100,10)))) )

b<- barplot(d,beside=T,legend=T,las=1,col=c("royalblue","orange","brown"),ylim=c(min(d)*1.2,max(d)*1.2),
	args.legend=list(x="topleft",inset=0.03,legend=c("2020-12-01から2021-02-28まで","2021-03-01から2021-06-20まで","2021-06-21から2021-08-31まで")))
text(x=b,y=d,labels=d,pos=c(rep(3,23),rep(1,10)))
title("大阪府：期間別年代別 重症者数累計 - 死亡者数累計")
#dev.off()
#png("covid21_08.png",width=800,height=800)
par(mfrow=c(3,1),mar=c(3,3,3,2))
d<- table(factor(d3p$性別,levels=c("男","女")),factor(d3p$年代,levels=c("未就学児",seq(10,100,10))) )
barplot(d ,beside=T,col=c("royalblue","brown"),las=T,legend=T,args.legend =list(x ="topleft",inset=0.03))
title("大阪府：性別＆年代別  死亡者数(2020-12-01から2021-02-28まで)")
d<- table(factor(d4p$性別,levels=c("男","女")),factor(d4p$年代,levels=c("未就学児",seq(10,100,10))) )
barplot(d ,beside=T,col=c("royalblue","brown"),las=T,legend=T,args.legend =list(x ="topleft",inset=0.03))
title("大阪府：性別＆年代別  死亡者数(2021-03-01から2021-06-20まで)")
d<- table(factor(d5p$性別,levels=c("男","女")),factor(d5p$年代,levels=c("未就学児",seq(10,100,10))) )
barplot(d ,beside=T,col=c("royalblue","brown"),las=T,legend=T,args.legend =list(x ="topleft",inset=0.03))
title("大阪府：性別＆年代別  死亡者数(2021-06-21から2021-08-31まで)")
par(mfrow=c(1,1))
#dev.off()
```

#### 大阪府：年代別(10歳代から60歳代)重症者数累計および死亡者数累計(2020-12-01から)

```R
col<- rainbow(6)
#png("covid21_12.png",width=800,height=600)
par(mar=c(5,3,4,3),family="serif",mfrow=c(1,2))
ddd<- apply(d2[,2:7],2,cumsum)
matplot(ddd,type="l",lty=1,lwd=2,col=col,las=1,ylab="",xaxt="n",bty="n")
box(bty="l",lwd=2)
axis(1,at=grep("-01$",index(d2)),labels= paste0(c(12,1:8),"月"))
#mtext("2020年",1,at=1,line=2.5)
mtext("2021年",1,at=32,line=2.5)
text(x=par("usr")[2],y=coredata(tail(ddd,1)),labels=paste0(colnames(ddd),"歳代"),xpd=T,pos=4)
title("大阪府：年代別(10歳代から60歳代)\n重症者数累計(2020-12-01から)")
#
ddd<- apply(d1[,2:7],2,cumsum)
matplot(ddd,type="l",lty=1,lwd=2,col=col,las=1,ylab="",xaxt="n",bty="n")
box(bty="l",lwd=2)
axis(1,at=grep("-01$",index(d1)),labels= paste0(c(12,1:8),"月"))
#mtext("2020年",1,at=1,line=2.5)
mtext("2021年",1,at=32,line=2.5)
text(x=par("usr")[2],y=coredata(tail(ddd,1)),labels=paste0(colnames(ddd),"歳代"),xpd=T,pos=4)
title("大阪府：年代別(10歳代から60歳代)\n死亡者数累計(2020-12-01から)")
par(mfrow=c(1,1))
#dev.off()
# 死亡者数累計/重症者数累計
col<- rainbow(6)
ddd<- apply(d1[,2:7],2,cumsum)/apply(d2[,2:7],2,cumsum)*100
#png("covid21_15.png",width=800,height=600)
par(mar=c(5,3,4,3),family="serif",mfrow=c(1,1))
matplot(ddd,type="l",lty=1,lwd=2,col=col,las=1,ylab="",xaxt="n",bty="n")
box(bty="l",lwd=2)
axis(1,at=grep("-01$",index(d1)),labels= paste0(c(12,1:8),"月"))
#mtext("2020年",1,at=1,line=2.5)
mtext("2021年",1,at=32,line=2.5)
abline(h=seq(5,100,5),col="gray",lty=2)
text(x=par("usr")[2],y=coredata(tail(ddd,1)),labels=paste0(colnames(ddd),"歳代"),xpd=T)
title("大阪府：年代別(10歳代から60歳代)\n(死亡者数累計/重症者数累計)×100(%)(2020-12-01から)")
#dev.off()
```

#### 患者の状況

##### 昨日までのデータ

```R
library(rvest)
library(rio)
# 他府県管理 令和3年2月12日（金曜日） [Excelファイル／90KB]
xl<- NULL
for (i in paste0("0",2:7)){
source_url <- paste0("http://www.pref.osaka.lg.jp/iryo/osakakansensho/happyo_kako-r03",i,".html")
#
html <- read_html(source_url)
links <- html %>% html_nodes("a") %>% html_attr("href")
xl<- c(xl,rev(links[grep("xlsx",links)]))
}
#重複urlを削除
xl<- unique(xl)
#
xl<- xl[-c(1:11)]
# 今月
source_url <- "http://www.pref.osaka.lg.jp/iryo/osakakansensho/happyo_kako.html"
#
html <- read_html(source_url)
links <- html %>% html_nodes("a") %>% html_attr("href")
xl<- c(xl,rev(links[grep("xlsx",links)]))
#重複urlを削除
xl<- unique(xl)
#
Today<- NULL
Long<- NULL
for (i in xl){
tryCatch(
{
	url<-paste0("http://www.pref.osaka.lg.jp",i)
	df<- rio::import(file = url,which = 2)
	ss<- grep("患者の状況",df[,1])
	dat1<- df[(ss+3),c(4,6,8,10,12,14,16,18)]
	colnames(dat1)<- c("退院.解除","死亡","入院","重症","宿泊療養","自宅療養","入院.療養等調整中","他府県管理")
	dat2<- df[(ss+5),c(4,6,8,10,12,14,16,18)]
	colnames(dat2)<- c("退院.解除","死亡","入院","重症","宿泊療養","自宅療養","入院.療養等調整中","他府県管理")
	Cdate<- substring(sub("\\.xlsx","",sub("^.*/","",i)),1,4)
	rownames(dat1)<- paste0("2021",Cdate)
	rownames(dat2)<- paste0("2021",Cdate)
	Today<- rbind(Today,dat1)
	Long<- rbind(Long,dat2)
}
 , error = function(e) {}
)
}
d<- data.frame(lapply(Today,as.numeric))
rownames(d)<- seq(as.Date("2021-02-12"),length.out=nrow(d),by="day")
Today<- d
#
d<- data.frame(lapply(Long,as.numeric))
rownames(d)<- seq(as.Date("2021-02-12"),length.out=nrow(d),by="day")
Long<- d
#
save("Today",file="Today.rda")
save("Long",file="Long.rda")
```

##### 今日のデータを加える

```R
library(rvest)
library(rio)
load("Today.rda")
load("Long.rda")
# 確認
tail(Today) ; tail(Long)
# 今日が８月１３日の場合
xl<- "/attach/23711/00376026/0813.xlsx"
for (i in xl){
tryCatch(
{
	url<-paste0("http://www.pref.osaka.lg.jp",i)
	df<- rio::import(file = url,which = 2)
	ss<- grep("患者の状況",df[,1])
	dat1<- df[(ss+3),c(4,6,8,10,12,14,16,18)]
	colnames(dat1)<- c("退院.解除","死亡","入院","重症","宿泊療養","自宅療養","入院.療養等調整中","他府県管理")
	dat2<- df[(ss+5),c(4,6,8,10,12,14,16,18)]
	colnames(dat2)<- c("退院.解除","死亡","入院","重症","宿泊療養","自宅療養","入院.療養等調整中","他府県管理")
	Cdate<- substring(sub("\\.xlsx","",sub("^.*/","",i)),1,4)
	rownames(dat1)<- paste0("2021",Cdate)
	rownames(dat2)<- paste0("2021",Cdate)
}
 , error = function(e) {}
)
}
# 確認
dat1 ; dat2
#
Today<- rbind(Today,dat1)
Long<- rbind(Long,dat2)
#
d<- data.frame(lapply(Today,as.numeric))
rownames(d)<- seq(as.Date("2021-02-12"),length.out=nrow(d),by="day")
Today<- d
#
d<- data.frame(lapply(Long,as.numeric))
rownames(d)<- seq(as.Date("2021-02-12"),length.out=nrow(d),by="day")
Long<- d
# 保存
save("Today",file="Today.rda")
save("Long",file="Long.rda")
```

##### 作図

```R
#png("covid21_13.png",width=800,height=600)
par(mar=c(4,4,4,2),family="serif")
plot(Long$"他府県管理",type="l",lwd=2,las=1,xaxt="n",bty="n",xlab="",ylab="",ylim=c(0,max(Long$"他府県管理")),yaxs="i")
box(bty="l",lwd=2.5)
axis(1,at=grep("01",substring(rownames(Long),9,10)),labels=paste0(3:8,"月"))
#par(new=T) 
#plot(Today$"他府県管理",col="red",type="h",lend=1,lwd=3,ylim=c(0,max(Long$"他府県管理")),xaxt="n",yaxt="n",bty="n",xlab="",ylab="",yaxs="i")
title("大阪府：他府県管理\n※ 府外保健所への所管替事例の数(他府県における入院・宿泊・自宅療養中及び入院・療養等調整中の数）")
#dev.off()
#
#png("covid21_14.png",width=800,height=600)
par(mar=c(4,4,4,8),family="serif")
plotdata<- Long[,c(3,5,6,7,8)]
matplot(plotdata,type="l",lty=1,lwd=2,las=1,xaxt="n",bty="n",xlab="",ylab="",xaxs="i")
box(bty="l",lwd=2.5)
axis(1,at=grep("01",substring(rownames(Long),9,10)),labels=paste0(3:8,"月"))
text(x=par("usr")[2],y=tail(plotdata,1),labels=colnames(plotdata),pos=4,xpd=T)
title("大阪府：入院、宿泊療養、自宅療養、入院.療養等調整中、他府県管理\n（2021年2月12日以降）")
#dev.off()
```

