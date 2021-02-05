---
title: 大阪府陽性者の属性と市町村別陽性者マップ(新型コロナウイルス：Coronavirus)
date: 2021-02-05
tags: ["R","jsonlite","Coronavirus","大阪府","新型コロナウイルス"]
excerpt: 大阪府 新型コロナウイルス感染症対策サイトのデータ
---

# 大阪府陽性者の属性と市町村別陽性者マップ(新型コロナウイルス：Coronavirus)

![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus12)  
[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus12&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

> ## 2020-11-16以降、陽性者の属性のデータ公開はなくなりましたので、陽性者の居住地、年齢、性別を用いたグラフ及び地図は更新されません。

## 新しい記事は[大阪府の検査陽性者(新型コロナウイルス：Coronavirus)](https://gitpress.io/@statrstart/Coronavirus12_2)です。  

(参考)[大阪府の最新感染動向](https://covid19-osaka.info/)  

[大阪府 新型コロナウイルス感染症対策サイト](https://github.com/codeforosaka/covid19)にあるデータを使います。  
地図の元データ：[国土数値情報 行政区域データ](https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-N03-v2_4.html#!)  
市町村別人口：[市町村別の年齢別人口と割合](http://www.pref.osaka.lg.jp/kaigoshien/toukei/ritu.html)  
月別死亡者数 : [東洋経済オンライン](https://raw.githubusercontent.com/kaz-ogiwara/covid19/master/data/data.json)

#### 大阪府 vs 東京都 vs 北海道 : 新型コロナウイルス 死亡者数の推移(データ：NHK 新型コロナ データ)

![covOvsT02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOvsT02.png)
- 2021/1/14 大阪府、東京都を逆転。
- 2021/2/4 東京都、大阪府を逆転。
- 人口：大阪約８８７万人、東京約１３１６万人、北海道約５５０万人

#### 大阪府 vs 東京都 vs 北海道 : 新型コロナウイルス 人口100万人あたりの死亡者数(データ：NHK 新型コロナ データ)

![covOvsT01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOvsT01.png)
- 2021/1/20 : 北海道人口１万人あたり１人の死亡者数突破。
- 2021/1/28 : 大阪府人口１万人あたり１人の死亡者数突破。
- 人口：大阪約８８７万人、東京約１３１６万人、北海道約５５０万人

#### 大阪府 : 月別の陽性者数と月別死亡者数

![covOsaka09_02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka09_02.png)

#### 大阪府：新型コロナウイルス死亡者の推移
(注意)NHKのデータ使用（更新時間の違いのため大阪府のデータより１日分少ないことがあります。）

![covOsaka13](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka13.png)

#### 他の都道府県（人口規模の大きい）との比較
##### 月別死者数と月別人口１００万人あたりの死者数（データ：NHK）
北海道(約550万人)、埼玉(約719万人)、東京(約1316万人)、神奈川(約905万人)、愛知(約741万人)、大阪(約886万人)
- １１月以降、寒さの厳しい北海道の死者数が激増。
- 大阪の気温は他と比べて低いわけではないのに８月以降の死者数は比較的多い。
(注)「人口１００万人あたり新型コロナウイルス月別死亡者」のグラフを直しました。(2020-12-12)

![covOsaka12](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka12.png)

#### 時系列

![covOsaka01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka01.png)

#### 検査結果

![covOsaka05](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka05.png)

#### 検査陽性率（％）７日移動平均（大阪府）

![covOsaka07](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka07.png)

#### 週単位の陽性者増加比

![covOsaka08](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka08.png)

#### 大阪市：市長の公務ありなしのカレンダーと公務日程なしの月別日数(2020年)
- 公務時間は考慮していません。

![Okoumu01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Okoumu01.png)
![KoumuOsakashi](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/KoumuOsakashi.png)

#### 塗り分け地図
データ：[【2月3日】新型コロナウイルス感染症患者の発生及び死亡について]  
[大阪府：新型コロナウイルス感染症患者の発生状況について](http://www.pref.osaka.lg.jp/iryo/osakakansensho/happyo.html)  

##### PCR検査 陽性者数(大阪府市町村別)

![osakaCmap03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/osakaCmap03.png)

##### 人口１万人あたりの検査陽性者数(大阪府市町村別)

![osakaCmap04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/osakaCmap04.png)

-----

#### 人口１万人あたりの検査陽性者数(大阪府市町村別)の推移 「2020-11-15までのデータ」

![covOsaka10](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka10.png)

#### 月別検査陽性者数（大阪府:大阪市と大阪市以外で色分け）「2020-11-15までのデータ」

![covOsaka09](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka09.png)
- 大阪市は人口の割合は約３割なのに６月以降の検査陽性者数の割合は約５割をしめる。

#### 月別の陽性者の属性:年代(大阪府)「2020-11-15までのデータ」

![covOsaka06](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka06.png)

#### 月別年代別の陽性者数と月別死亡者数「2020-11-15までのデータ」

![covOsaka06_2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka06_2.png)

- 8月に入ってから70歳以上の検査陽性者が増加。
- 死亡者数も8月に入ってから増加しているが、4、5月を見ると陽性者の増加と死亡者の増加する時期には一月ほどのずれがある。
- 本格的に死亡者が増加するのは来月だと思われる。  

#### 居住地「2020-11-15までのデータ」

![covOsaka02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka02.png)

#### 塗り分け地図：PCR検査 陽性者数(大阪府市町村別)「2020-11-15までのデータ」

![osakaCmap01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/osakaCmap01.png)

#### 塗り分け地図：人口１万人あたりの検査陽性者数(大阪府市町村別)「2020-11-15までのデータ」

![osakaCmap02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/osakaCmap02.png)

#### 年代「2020-11-15までのデータ」

![covOsaka03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka03.png)

#### 性別「2020-11-15までのデータ」

![covOsaka04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka04.png)

#### 吹田市の月別検査陽性者数「2020-11-15までのデータ」

![covOsuita](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsuita.png)

### Rコード

#### (json形式)データを読み込み、「陽性者の属性」の部分を取り出す。

```R
#install.packages("jsonlite")
#install.packages("curl")
library(jsonlite)
library(knitr)
library(TTR)
url<- "https://raw.githubusercontent.com/codeforosaka/covid19/master/data/data.json"
js<- fromJSON(url)
names(js)
#[1] "patients"                   "patients_summary"          
#[3] "inspections_summary"        
#    "contacts1_summary"  府民向け相談窓口への相談件数   
#[5] "contacts2_summary" 新型コロナ受診相談センターへの相談件数          
#    "transmission_route_summary" 感染経路不明者（リンク不明者） 
#[7] "treated_summary" 陰性確認済（退院者累計）           "lastUpdate"                
#[9] "main_summary" 
# "patients"「陽性者の属性」の部分を取り出す。
dat<- js[[1]][[2]][,c(8,4:7)]
# 居住地の「大阪府」は消し、「大阪府外」だけはもとに戻す。
dat$居住地<- gsub("大阪府","",dat$居住地)
dat$居住地<- gsub("^外$","大阪府外",dat$居住地)
```

#### 大阪府:月別の陽性者数(大阪市と大阪市以外で色分け）

```R
m1<- table(factor(substring(dat[,1],6,7),level=c("01","02","03","04","05","06","07","08","09","10","11")))
m2<- table(factor(substring(dat[dat$居住地=="大阪市",1],6,7),level=c("01","02","03","04","05","06","07","08","09","10","11")))
#
#png("covOsaka09.png",width=800,height=600)
par(mar=c(4,6,4,8),family="serif")
b<- barplot(m1,col="slateblue",axes=F,names="",ylim=c(0,max(m1)*1.2))
barplot(m2,add=T,col="firebrick2",las=1,ylim=c(0,max(m1)*1.2),names=paste0(1:11,"月"))
legend(x="topleft",inset=c(0.01,0.05),legend=c("大阪市以外","大阪市"),pch=15,col=c("slateblue","firebrick2"),bty="n")
#
lines(x=b,y=par("usr")[4]*(m2/m1),col="darkgreen",lwd=3)
text(x=b[1],y=par("usr")[4],labels="大阪市の感染者の割合",pos=2,xpd=T,col="darkgreen")
axis(4,at=par("usr")[4]*seq(0,1,0.2),labels=seq(0,100,20),las=1,col="darkgreen")
text(x=par("usr")[2],y=par("usr")[4],labels="(%)",pos=3,xpd=T)
#
abline(h=par("usr")[4]*0.3045,col="darkgreen",lty=2)
text(x=par("usr")[2],y=par("usr")[4]*0.3045,labels="大阪市の人口の\n割合:30.45%",pos=4,xpd=T,col="darkgreen")
abline(h=par("usr")[4]*0.5,col="red",lty=2)
text(x=par("usr")[2],y=par("usr")[4]*0.5,labels="50%ライン",pos=4,xpd=T,col="red")
title("大阪府:月別の陽性者数(大阪市と大阪市以外で色分け）",cex.main=1.5)
#dev.off()
```

#### 吹田市の月別検査陽性者数

```R
#kable(dat[dat$居住地=="吹田市",],row.names=F)
data<- dat[dat$居住地=="吹田市",]
#各月ごとの検査陽性者数
monthsum<- table(factor(substring(data$date,6,7),levels=c("01","02","03","04","05","06","07","08","09","10","11")))
#
#png("covOsuita.png",width=800,height=600)
par(mar=c(3,7,3,2),family="serif")
b<- barplot(monthsum,las=1,col="red",names=paste0(1:11,"月"),ylim=c(0,max(monthsum)*1.2),yaxt="n")
# Add comma separator to axis labels
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
text(x= b[1:nrow(monthsum)], y=as.numeric(monthsum),labels=formatC(as.numeric(monthsum), format="d", big.mark=','),cex=1.2,pos=3)
legend("topleft",inset=c(0,0),xpd=T,bty="n",
	legend="データ：https://raw.githubusercontent.com/codeforosaka/covid19/master/data/data.json")
title("吹田市 : 月別の陽性者数",cex.main=1.5)
#dev.off()
```

#### 大阪市の月別検査陽性者数

```R
data<- dat[dat$居住地=="大阪市",]
#各月ごとの検査陽性者数
monthsum<- table(factor(substring(data$date,6,7),levels=c("01","02","03","04","05","06","07","08","09","10","11")))
#
#png("covOosakashi.png",width=800,height=600)
par(mar=c(3,7,3,2),family="serif")
b<- barplot(monthsum,las=1,col="red",names=paste0(1:11,"月"),ylim=c(0,max(monthsum)*1.2),yaxt="n")
# Add comma separator to axis labels
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
text(x= b[1:nrow(monthsum)], y=as.numeric(monthsum),labels=formatC(as.numeric(monthsum), format="d", big.mark=','),cex=1.2,pos=3)
legend("topleft",inset=c(0,0),xpd=T,bty="n",
	legend="データ：https://raw.githubusercontent.com/codeforosaka/covid19/master/data/data.json")
title("大阪市 : 月別の陽性者数",cex.main=1.5)
#dev.off()
```

#### 時系列

```R
#date
tbl<- table(dat$date)
names(tbl)<- gsub("2020-","",names(tbl))
#元から日付順になっているのでこの部分は不要
#tbl<- tbl[order(names(tbl))]
sma7<- round(SMA(tbl,7),2)
#png("covOsaka01.png",width=800,height=600)
par(mar=c(3,7,4,2),family="serif")
b<- barplot(tbl,las=1,ylim=c(0,max(tbl)*1.2),col="red")
lines(x=b,y=sma7,lwd=2.5,col="blue")
legend("topleft",inset=0.03,lwd=2.5,col="blue",legend="7日移動平均",cex=1.2)
title("陽性者の人数：時系列(大阪府)",cex.main=1.5)
#dev.off()
```

#### 居住地

```R
tbl<- table(dat$居住地)
tbl<- tbl[order(tbl)]
# png("covOsaka02.png",width=800,height=800)
par(mar=c(3,7,4,2),family="serif")
b<- barplot(tbl,las=1,horiz=T,xlim=c(0,max(tbl)*1.2),col="pink")
text(x=tbl,y=b,labels=tbl,pos=4)
title("陽性者の属性:居住地(大阪府)",cex.main=1.5)
#dev.off()
```

#### 年代

```R
tbl<- table(dat$年代)
tbl<- tbl[order(tbl)]
# png("covOsaka03.png",width=800,height=600)
par(mar=c(3,7,4,2),family="serif")
b<- barplot(tbl,las=1,horiz=T,xlim=c(0,max(tbl)*1.2),col="pink")
text(x=tbl,y=b,labels=tbl,pos=4)
title("陽性者の属性:年代(大阪府)",cex.main=1.5)
#dev.off()
```

#### 性別

```R
dat$性別[dat$性別=="男"]<- "男性"
dat$性別[dat$性別=="女"]<- "女性"
tbl<- table(dat$性別)
tbl<- tbl[order(tbl)]
# png("covOsaka04.png",width=800,height=600)
par(mar=c(3,7,4,2),family="serif")
b<- barplot(tbl,las=1,horiz=T,xlim=c(0,max(tbl)*1.2),col="pink")
text(x=tbl,y=b,labels=tbl,pos=4)
title("陽性者の属性:性別(大阪府)",cex.main=1.5)
#dev.off()
```

#### "patients_summary" "inspections_summary" "lastUpdate" "main_summary"

```R
# 検査陽性率(%): 陽性患者数/検査実施人数*100
Pos<- round(js[[10]][[3]]$value/js[[10]][[2]]*100,2)
# 致死率(%): 亡くなった人の数/陽性患者数*100
Dth<- round(js[[10]][[3]][[3]][[1]][grep("死亡",js[[10]][[3]][[3]][[1]]$attr),2]/js[[10]][[3]]$value*100,2)
#
dat<- js[[2]][[2]]
dat<- merge(dat,js[[3]][[2]],by=1)
rownames(dat)<- sub("-","/",sub("-0","-",sub("^0","",substring(dat[,1],6,10))))
dat<- dat[,-1]
dat[,3]<- dat[,2]-dat[,1]
colnames(dat)<- c("陽性者数","検査実施人数","陰性者数")
ritsu1<- paste("・検査陽性率(%) :",Pos,"%")
ritsu2<- paste("・致  死  率   (%) :",Dth,"%")
#png("covOsaka05.png",width=800,height=600)
par(mar=c(3,7,4,2),family="serif")
barplot(t(dat[,c(1,3)]),names=rownames(dat),las=1,col=c("red","lightblue"))
legend("topleft",inset=0.03,bty="n",pch=15,col=c("red","lightblue"),cex=1.5,
	legend=c("陽性者数","検査実施人数-陽性者数"))
legend("topleft",inset=c(0,0.15),bty="n",cex=1.5,legend=c(paste0(js[[8]],"現在"),ritsu1,ritsu2))
title("検査結果(大阪府)",cex.main=1.5)
#dev.off()
```

#### 月別の陽性者の属性:年代(大阪府)

```R
month<- substring(js[[1]]$data$date,6,7)
tab<- table(month,js[[1]]$data$年代)
#"80代","90代","100代" -> "80歳以上"
tab<- cbind(tab,rowSums(tab[,c("80代","90代","100代")]))
colnames(tab)[ncol(tab)]<- "80歳以上"
#"未就学児","就学児"-> "10歳未満"
tab<- cbind(tab,rowSums(tab[,c("未就学児","就学児")]))
colnames(tab)[ncol(tab)]<- "10歳未満"
tab2<- tab[,c("10歳未満","10代","20代","30代","40代","50代","60代","70代","80歳以上")]
#
#png("covOsaka06.png",width=800,height=600)
par(mar=c(3,7,4,2),family="serif")
barplot(t(tab2),col=rainbow(9,0.7),beside=T,las=1,legend=T,names=paste0(sub("^0","",rownames(tab2)),"月"),
	args.legend = list(x = "topleft",inset= 0.03))
title("月別の陽性者の属性:年代(大阪府)",cex.main=1.5)
#dev.off()
```

#### 検査陽性率（％）７日移動平均（大阪府）

```R
library(TTR)
# 検査陽性率(%)
dat<- js[[2]][[2]]
dat<- merge(dat,js[[3]][[2]],by=1)
rownames(dat)<- sub("-","/",sub("-0","-",sub("^0","",substring(dat[,1],6,10))))
dat<- dat[,-1]
colnames(dat)<- c("陽性者数","検査実施件数")
# 検査陽性率(%)7日移動平均
sma<- round(runSum(dat$陽性者数,7)/runSum(dat$検査実施件数,7)*100,2)
#png("covOsaka07.png",width=800,height=600)
par(mar=c(3,7,4,3),family="serif")
plot(sma,type="l",lwd=2.5,las=1,xlab="",ylab="",xaxt="n",bty="n")
box(bty="l",lwd=2.5)
axis(1,at=1:length(sma),labels=rownames(dat))
text(x=par("usr")[2],y=sma[length(sma)],labels=paste0(rownames(dat)[nrow(dat)],"現在\n",sma[length(sma)]),xpd=T,cex=1.2)
title("検査陽性率（％）７日移動平均（大阪府）",cex.main=1.5)
#dev.off()
```

#### 週単位の陽性者増加比

```R
library(TTR)
dat<- js[[2]][[2]]
rownames(dat)<- sub("-","/",sub("-0","-",sub("^0","",substring(dat[,1],6,10))))
dat<- dat[,-1,drop=F]
#
e7<- runSum(dat,n=7)
b7<- runSum(dat,n=14) - e7
df<- round(e7/b7,2)
# InfにNAを入れる
df[df==Inf]<- NA
df<- data.frame(date=rownames(dat),zougen= df)
df<- df[40:nrow(df),]
#
#png("covOsaka08.png",width=800,height=600)
par(mar=c(4,6,4,7),family="serif")
plot(df[,2],type="l",lwd=2,las=1,ylim=c(0,11),xlab="",ylab="",xaxt="n",bty="n")
box(bty="l",lwd=2.5)
#axis(1,at=1:nrow(df),labels=df[,1])
labels<- df[,1]
labels<-gsub("^.*/","",labels)
pos<-gsub("/.*$","",sub("/20","",df[,1]))
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
text(x=par("usr")[2],y=df[,2][nrow(df)],labels= paste0(df[,1][nrow(df)],"現在\n",df[,2][nrow(df)]),xpd=T,cex=1.2,col="red")
arrows(par("usr")[2]*1.08, 1.1,par("usr")[2]*1.08,1.68,length = 0.2,lwd=2.5,xpd=T)
text(x=par("usr")[2]*1.08,y=2,labels="増加\n傾向",xpd=T)
arrows(par("usr")[2]*1.08, 0.9,par("usr")[2]*1.08,0.32,length = 0.2,lwd=2.5,xpd=T)
text(x=par("usr")[2]*1.08,y=0,labels="減少\n傾向",xpd=T)
title("週単位の陽性者増加比(大阪府)",cex.main=1.5)
#dev.off()
```

#### 塗り分け地図

```R
library(sf)
library(BAMMtools)
osaka<- st_read("https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/osaka.geojson", 
	stringsAsFactors=FALSE)
map<- aggregate(osaka[,c("code2","sityo")], list(osaka$code2), unique)
dat<- js[[1]][[2]][,c(8,4:7)]
#is.element(dat$居住地,as.vector(map$sityo))
unique(dat$居住地[!is.element(dat$居住地,as.vector(map$sityo))])
#検査陽性者のいない市町村
map$sityo[!is.element(map$sityo,dat$居住地)]
#ないものの数を0としてカウント:factorを使ってtable
#"大阪府外" "調査中"は除く
tbl<- table(factor(dat$居住地, levels=map$sityo))
#knitr::kable(tbl)
```

##### PCR検査 陽性者数(大阪府市町村別)

```R
# 並び順が一致しているか確認
all(names(tbl)== map$sityo)
#
df<- as.vector(tbl)
# legendのタイトル
ltitle<- "検査陽性者数"
# グラフのタイトル
title<- "PCR検査 陽性者数(大阪府市町村別)"
#
##### ここ以降のRコードは共通 #####
#
# Jenksの自然分類法で分ける最大
i <- length(df)
brk <- getJenksBreaks(df,k=i+1)
while (length(unique(brk)) != length(brk)) { 
	brk <- getJenksBreaks(df,k=i+1)
	i=i-1
}
# legendのlabelを作成
labels<- as.vector(cut(brk[1:length(brk)-1],breaks=brk,include.lowest=T,right =F, dig.lab=5))
# 塗りつぶしに使うカラーパレット：rev関数で　白->赤
color<- rev(heat.colors(length(brk)-1))
cols<-as.vector(cut(df, breaks=brk,labels =color,include.lowest=T,right =F))
# png("osakaCmap01.png",width=800,height=800)
par(mar=c(0,0,4,0),family="serif")
plot(st_geometry(map),col=cols)
c=st_centroid(st_geometry(map))
text(st_coordinates(c),paste0(map$sityo,"\n",df,"人"))
legend(x=135.8,y=35,legend=labels, fill=color,title =ltitle,ncol=1,bty="n",xpd=T,cex=1.2)
title(title,cex.main=1.5)
# dev.off()
```

##### 人口１万人あたりの検査陽性者数(大阪府市町村別)

```R
#市町村別の年齢別人口と割合
#http://www.pref.osaka.lg.jp/kaigoshien/toukei/ritu.html
prof<- c("大阪市","堺市","岸和田市","豊中市","池田市","吹田市","泉大津市","高槻市","貝塚市","守口市","枚方市","茨木市","八尾市","泉佐野市","富田林市","寝屋川市","河内長野市","松原市","大東市","和泉市","箕面市","柏原市","羽曳野市","門真市","摂津市","高石市","藤井寺市","東大阪市","泉南市","四條畷市","交野市","大阪狭山市","阪南市","島本町","豊能町","能勢町","忠岡町","熊取町","田尻町","岬町","太子町","河南町","千早赤阪村")
pop<- c(2691185,839310,194911,395479,103069,374468,75897,351829,88694,143042,404152,280033,268800,100966,113984,237518,106987,120750,123217,186109,133411,71112,112683,123576,85007,56529,65438,502784,62438,56075,76435,57792,54276,29983,19934,10256,17298,44435,8417,15938,13748,16126,5378)
# 並び順が一致しているか確認
all(prof== map$sityo)
#
df<- round(as.vector(tbl)/pop*10000,2)
# legendのタイトル
ltitle<- "人口１万人あたりの\n検査陽性者数"
# グラフのタイトル
title<- "人口１万人あたりの検査陽性者数(大阪府市町村別)"
#
##### ここ以降のRコードは共通 #####
#
# Jenksの自然分類法で分ける最大
i <- length(df)
brk <- getJenksBreaks(df,k=i+1)
while (length(unique(brk)) != length(brk)) { 
	brk <- getJenksBreaks(df,k=i+1)
	i=i-1
}
# legendのlabelを作成
labels<- as.vector(cut(brk[1:length(brk)-1],breaks=brk,include.lowest=T,right =F, dig.lab=5))
# 塗りつぶしに使うカラーパレット：rev関数で　白->赤
color<- rev(heat.colors(length(brk)-1))
cols<-as.vector(cut(df, breaks=brk,labels =color,include.lowest=T,right =F))
# png("osakaCmap02.png",width=800,height=800)
par(mar=c(0,0,4,4),family="serif")
plot(st_geometry(map),col=cols)
c=st_centroid(st_geometry(map))
text(st_coordinates(c),paste0(map$sityo,"\n",df,"人"))
legend(x=135.8,y=35.1,legend=labels, fill=color,title =ltitle,ncol=1,bty="n",xpd=T,cex=1.2)
title(title,cex.main=1.5)
# dev.off()
```

#### 月別年代別の陽性者数と月別死亡者数

```R
library(jsonlite)
library(xts)
#「東洋経済オンライン」新型コロナウイルス 国内感染の状況
# https://toyokeizai.net/sp/visual/tko/covid19/
#著作権「東洋経済オンライン」
covid19 = fromJSON("https://raw.githubusercontent.com/kaz-ogiwara/covid19/master/data/data.json")
covid19[[5]][covid19[[5]]$en=="Osaka",]
#   code     ja    en value
#27   27 大阪府 Osaka  6845
# 大阪府(code:27)
code<- 27
data<- covid19[[4]]$deaths[code,]
from<- as.Date(paste0(data$from[[1]][1],"-",data$from[[1]][2],"-",data$from[[1]][3]))
data.xts<- xts(x=data$values[[1]],seq(as.Date(from),length=nrow(data$values[[1]]),by="days"))
#各月ごとの死亡者の合計
monthsum.xts<- apply.monthly(data.xts[,1],sum)
monthsum<- data.frame(coredata(monthsum.xts))
rownames(monthsum)<- substring(index(monthsum.xts),6,7)
if (rownames(monthsum)[nrow(monthsum)]!="11"){
	monthsum= rbind(monthsum,0)
}
#
#png("covOsaka06_2.png",width=800,height=600)
par(mar=c(3,7,3,2),family="serif")
mat <- matrix(c(1,1,1,1,2,2),3,2, byrow = TRUE)
layout(mat) 
#3月以降
barplot(t(tab2[-c(1,2),]),col=rainbow(9,0.7),beside=T,las=1,legend=T,names=paste0(sub("^0","",rownames(tab2[-c(1,2),])),"月"),
	args.legend = list(x = "topleft",inset= 0.03))
title("大阪府 : 月別年代別の陽性者数と月別死亡者数",cex.main=1.5)
b<- barplot(t(monthsum),las=1,col="red",names=paste0(3:11,"月"),ylim=c(0,max(monthsum)*1.2))
text(x= b[1:nrow(monthsum)], y=as.vector(monthsum)[,1],labels=as.vector(monthsum)[,1],cex=1.2,pos=3)
legend("topleft",inset=c(0,-0.1),xpd=T,bty="n",legend="データ：[東洋経済オンライン]\n(https://raw.githubusercontent.com/kaz-ogiwara/covid19/master/data/data.json)")
#dev.off()
```

##### 大阪府 vs 東京都 : 新型コロナウイルス 人口100万人あたりの死亡者数

```R
library(sf)
library(NipponMap)
shp <- system.file("shapes/jpn.shp", package = "NipponMap")[1]
m <- sf::read_sf(shp)
#[NHK:新型コロナ データ一覧](https://www3.nhk.or.jp/news/special/coronavirus/data-widget/)
nhkC<- read.csv("https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv")
# 東京都
code<-13
data<- nhkC[nhkC$都道府県コード==code,c(1,7)]
data.xts<- as.xts(read.zoo(data, format="%Y/%m/%d"))
data.xts<- round(data.xts[,1]*1000000/m$population[code],2)
# 大阪府
code<-27
data<- nhkC[nhkC$都道府県コード==code,c(1,7)]
tmp.xts<- as.xts(read.zoo(data, format="%Y/%m/%d"))
tmp.xts<- round(tmp.xts[,1]*1000000/m$population[code],2)
data.xts<- merge(data.xts,tmp.xts)
colnames(data.xts)<- c("Tokyo","Osaka")
#
#png("covOvsT01.png",width=800,height=600)
par(mar=c(5,4,5,6),family="serif")
matplot(coredata(data.xts),type="l",lwd=2.5,lty=1,las=1,xaxt="n",yaxt="n",ylim=c(0,max(data.xts,na.rm=T)*1.1),col=c("blue","red"),xlab="",ylab="",bty="n")
box(bty="l",lwd=2)
# Add comma separator to axis labels
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
#表示するx軸ラベルを指定
# 2020- を削除。01-01 -> 1/1 
labels<- sub("-","/",sub("-0","-",sub("^0","",sub("2020-","",index(data.xts)))))
# 毎月1日
labelpos<- paste0(1:12,"/",1)
for (i in labelpos){
	at<- match(i,labels)
	if (!is.na(at)){ axis(1,at=at,labels = paste0(sub("/1","",i),"月"),tck= -0.02)}
	}
#labelpos<- paste0(rep(1:12,each=2),"/",c(10,20))
#for (i in labelpos){
#	at<- match(i,labels)
#	if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.01)}
#	}
legend("topleft",inset=0.03,legend=colnames(data.xts),col=c("blue","red"),lwd=2.5,lty=1)
text(x=par("usr")[2],y=tail(data.xts,1),xpd=T,
	labels=paste0(colnames(data.xts),"\n",tail(data.xts,1),"人"))
title("大阪府 vs 東京都 : 新型コロナウイルス 人口100万人あたりの死亡者数",
	"データ：[NHK](https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv)",line=3)
#dev.off()
```

##### 人口１万人あたりの検査陽性者数(大阪府市町村別)の推移

```R
tbl<- table(js[[1]]$data$date,factor(js[[1]]$data$居住地, levels=map$sityo))
#rownames(tbl)[1]
#tail(rownames(tbl),1)
alldate<- seq(as.Date(rownames(tbl)[1]),as.Date(tail(rownames(tbl),1)),"days")
rname<- alldate[!is.element(alldate,as.Date(rownames(tbl)))]
# 0行列
mat0<- matrix(0, nrow=length(rname), ncol=ncol(tbl))
colnames(mat0)<- colnames(tbl)
rownames(mat0)<- as.character(rname)
mat<- rbind(tbl,mat0)
#日付順
tbl<- mat[rownames(mat)[order(rownames(mat))],]
tbl<- apply(tbl,2,cumsum)
#順序を確認
all(prof==colnames(tbl))
tbl<- t(apply(tbl,1,function(x){round(10000*x/pop,2)}))
#
# png("covOsaka10.png",width=800,height=600)
par(mar=c(4,3,4,4),family="serif")
matplot(tbl,type="l",lty=1,xlab="",ylab="",xaxt="n",bty="n",las=1,col=rainbow(ncol(tbl)))
box(bty="l",lwd=2.5)
#表示するx軸ラベルを指定
# 2020- を削除。01-01 -> 1/1 
labels<- sub("-","/",sub("-0","-",sub("^0","",sub("2020-","",rownames(tbl)))))
# 毎月1日
labelpos<- paste0(rep(1:12),"/",1)
for (i in labelpos){
	at<- match(i,labels)
	if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.02)}
	}
labelpos<- paste0(rep(1:12,each=2),"/",c(10,20))
for (i in labelpos){
	at<- match(i,labels)
	if (!is.na(at)){ axis(1,at=at,labels = sub("^.*/","",i),tck= -0.01,cex.axis=0.8)} 
	}
text(x=par("usr")[2],y=tbl[nrow(tbl),],labels=colnames(tbl),xpd=T)
text(x=par("usr")[1],y=par("usr")[4],labels="(人)",pos=2,xpd=T)
# グラフのタイトル
title("人口１万人あたりの検査陽性者数(大阪府市町村別)の推移")
legend=round(sort(tbl[nrow(tbl),],decreasing=T),2)
legend("topleft",legend=paste(names(legend),legend),inset=0.01,ncol=3,bty="n",cex=1.2)
#dev.off()
```

##### 地図:国土数値情報 行政区域データから作成

```R
#国土数値情報 行政区域データ 
#https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-N03-v2_4.html#!
# install.packages("sf")
library(sf)
options(stringsAsFactors=FALSE)
osaka = st_read("./Osaka", options="ENCODING=CP932")
table(osaka$N03_007)
osaka2 = aggregate(osaka, list(osaka$N03_007), unique)
library(rmapshaper)
# データ量を約 1/333 に
osaka3 = ms_simplify(osaka2, keep=0.003, keep_shapes=TRUE)
plot(st_geometry(osaka3), graticule=TRUE, axes=TRUE)
#
#plot(st_geometry(osaka3))
#Group.1 N03_001  N03_003  N03_004
osaka = osaka3[ ,c("Group.1", "N03_003", "N03_004")]
names(osaka) = c("code","sigun","kusityo","geometry")
#作図しやすくするため
osaka$code2<- c(rep(27100,24),rep(27140,7),osaka$code[32:72])
osaka$sityo<- c(osaka$sigun[1:31],osaka$kusityo[32:72])
osaka<- osaka[,c(1,5,2,3,6,4)]
#osaka$sigunのNAに市名をいれる
osaka$sigun<- c(osaka$sigun[1:31],osaka$kusityo[32:62],osaka$sigun[63:72])
#できたデータをシェープファイル形式で保存するには
#st_write(osaka, "osaka.shp", layer_options="ENCODING=UTF-8")
#GeoJSON形式で保存する。
st_write(osaka, "./Osaka/osaka.geojson")
```
