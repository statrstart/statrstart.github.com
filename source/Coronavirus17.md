---
title: 都道府県別月別検査陽性者数と死亡者数及び重症者数の推移(新型コロナウイルス：Coronavirus)
date: 2020-11-26
tags: ["R","jsonlite","xts","Coronavirus","新型コロナウイルス"]
excerpt: 東洋経済オンラインのデータ
---

# 検査陽性者数(チャーター便を除く国内事例)と政府の対応(新型コロナウイルス：Coronavirus)

![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus17)  

(使用するデータ)  
[東洋経済オンライン:https://raw.githubusercontent.com/kaz-ogiwara/covid19/master/data/data.json](https://raw.githubusercontent.com/kaz-ogiwara/covid19/master/data/data.json)  

#### 北海道・東北

![carriersR1](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/carriersR1.png)

![deathsR1](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/deathsR1.png)

![seriousR1](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/seriousR1.png)

#### 関東

![carriersR2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/carriersR2.png)

![deathsR2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/deathsR2.png)

![seriousR2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/seriousR2.png)

#### 中部

![carriersR3](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/carriersR3.png)

![deathsR3](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/deathsR3.png)

![seriousR3](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/seriousR3.png)

#### 近畿

![carriersR4](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/carriersR4.png)

![deathsR4](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/deathsR4.png)

![seriousR4](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/seriousR4.png)

#### 中国

![carriersR5](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/carriersR5.png)

![deathsR5](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/deathsR5.png)

![seriousR5](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/seriousR5.png)

#### 四国

![carriersR6](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/carriersR6.png)

![deathsR6](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/deathsR6.png)

![seriousR6](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/seriousR6.png)

#### 九州・沖縄

![carriersR7](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/carriersR7.png)

![deathsR7](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/deathsR7.png)

![seriousR7](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/seriousR7.png)

### Rコード

#### データ読み込み

```R
library(jsonlite)
library(xts)
library(sf)
library(NipponMap)
#
#「東洋経済オンライン」新型コロナウイルス 国内感染の状況
# https://toyokeizai.net/sp/visual/tko/covid19/
#著作権「東洋経済オンライン」
covid19 = fromJSON("https://raw.githubusercontent.com/kaz-ogiwara/covid19/master/data/data.json")
#
names(covid19[[4]])
#[1] "carriers"     "pcrtested"    "discharged"   "serious"      "deaths"      
#[6] "reproduction"
#covid19[[4]][code1,1]
#
#都道府県別人口はNipponMapパッケージのデータを使う
shp <- system.file("shapes/jpn.shp", package = "NipponMap")[1]
m <- sf::read_sf(shp)
#データの順序が一致しているか確認
covid19[[5]]$en==m$name
all(covid19[[5]]$en==m$name)
#[1] TRUE <- データの順序は一致している
#
unique(m$region)
#[1] "Hokkaido"         "Tohoku"           "Kanto"            "Chubu"           
#[5] "Kinki"            "Chugoku"          "Shikoku"          "Kyushu / Okinawa"
```

#### 検査陽性者数

##### pngファイルで保存

```R
name<- "carriersR"
region<- c("Hokkaido|Tohoku","Kanto","Chubu","Kinki","Chugoku","Shikoku","Kyushu / Okinawa")
#
for (r in 1:7){
code<- as.numeric(m[grep(region[r],m$region),]$SP_ID)
data<- covid19[[4]]$carriers[code[1],]
from<- as.Date(paste0(data$from[[1]][1],"-",data$from[[1]][2],"-",data$from[[1]][3]))
data.xts<- xts(x=data$values[[1]],seq(as.Date(from),length=nrow(data$values[[1]]),by="days"))
#
for (i in code[-1]){
	data<- covid19[[4]]$carriers[i,]
	from<- as.Date(paste0(data$from[[1]][1],"-",data$from[[1]][2],"-",data$from[[1]][3]))
	tmp.xts<- xts(x=data$values[[1]],seq(as.Date(from),length=nrow(data$values[[1]]),by="days"))
	data.xts<- merge(data.xts,tmp.xts)
}
# NA<- 0
coredata(data.xts)[is.na(data.xts)]<- 0
colnames(data.xts)<- covid19[[5]]$ja[code]
#
monthsum<- NULL
for (i in 1:ncol(data.xts)){
#各月ごとの検査陽性者数の合計
m.xts<- apply.monthly(data.xts[,i],sum)
monthsum<- cbind(monthsum,m.xts)
}
#
monthsum<- data.frame(monthsum)
rownames(monthsum)<- paste0(sub("^0","",substring(rownames(monthsum),6,7)),"月")
#
#if (rownames(monthsum)[nrow(monthsum)]!="11"){
#	monthsum= rbind(monthsum,0)
#}
# 最初の月の検査陽性者数がすべての県で0なら削除
if ( all(monthsum[1,]==0) ) {monthsum<- monthsum[-1,]}
#plot
png(paste0(name,r,".png"),width=800,height=600)
par(mar=c(3,5,3,2),family="serif",mfrow=c(2,1))
b<- barplot(t(monthsum),beside=T,names=rownames(monthsum),las=1,col=rainbow(ncol(monthsum)),ylim=c(0,max(monthsum)*1.2),
	legend=T,args.legend=list(x="topleft",inset=0.02))
box(bty="l",lwd=2.5)
#for (i in 1:ncol(monthsum)){
#	text(x=b[i,],y=monthsum[,i],labels=monthsum[,i],pos=3)
#}
title("新型コロナウイルス月別検査陽性者数")
title("\n\n\nデータ：[東洋経済オンライン](https://raw.githubusercontent.com/kaz-ogiwara/covid19/master/data/data.json)",cex.main=0.8)
#
CperPop<- monthsum
for (i in 1:ncol(CperPop)){
	CperPop[,i]<- round(CperPop[,i]/m$population[code[i]]*10^6,0)
}
#
#plot
par(mar=c(3,5,3,2),family="serif")
b<- barplot(t(CperPop),beside=T,names=rownames(CperPop),las=1,col=rainbow(ncol(CperPop)),ylim=c(0,max(CperPop)*1.2),
	legend=T,args.legend=list(x="topleft",inset=0.02))
box(bty="l",lwd=2.5)
#for (i in 1:ncol(CperPop)){
#	text(x=b[i,],y=CperPop[,i],labels=CperPop[,i],pos=3)
#}
title("人口１００万人あたり新型コロナウイルス月別検査陽性者数")
title("\n\n\nデータ：[東洋経済オンライン](https://raw.githubusercontent.com/kaz-ogiwara/covid19/master/data/data.json) & 都道府県別人口:NipponMapパッケージ",cex.main=0.8)
#
dev.off()
}
par(mfrow=c(1,1))
```

#### 死亡者数

##### pngファイルで保存

```R
name<- "deathsR"
region<- c("Hokkaido|Tohoku","Kanto","Chubu","Kinki","Chugoku","Shikoku","Kyushu / Okinawa")
#
for (r in 1:7){
code<- as.numeric(m[grep(region[r],m$region),]$SP_ID)
data<- covid19[[4]]$deaths[code[1],]
from<- as.Date(paste0(data$from[[1]][1],"-",data$from[[1]][2],"-",data$from[[1]][3]))
data.xts<- xts(x=data$values[[1]],seq(as.Date(from),length=nrow(data$values[[1]]),by="days"))
#
for (i in code[-1]){
	data<- covid19[[4]]$deaths[i,]
	from<- as.Date(paste0(data$from[[1]][1],"-",data$from[[1]][2],"-",data$from[[1]][3]))
	tmp.xts<- xts(x=data$values[[1]],seq(as.Date(from),length=nrow(data$values[[1]]),by="days"))
	data.xts<- merge(data.xts,tmp.xts)
}
# NA<- 0
coredata(data.xts)[is.na(data.xts)]<- 0
colnames(data.xts)<- covid19[[5]]$ja[code]
#
monthsum<- NULL
for (i in 1:ncol(data.xts)){
#各月ごとの死亡者の合計
m.xts<- apply.monthly(data.xts[,i],sum)
monthsum<- cbind(monthsum,m.xts)
}
#
monthsum<- data.frame(monthsum)
rownames(monthsum)<- paste0(sub("^0","",substring(rownames(monthsum),6,7)),"月")
#
#if (rownames(monthsum)[nrow(monthsum)]!="11"){
#	monthsum= rbind(monthsum,0)
#}
# 最初の月の死亡者がすべての県で0なら削除
if ( all(monthsum[1,]==0) ) {monthsum<- monthsum[-1,]}
#plot
png(paste0(name,r,".png"),width=800,height=600)
par(mar=c(3,5,3,2),family="serif",mfrow=c(2,1))
b<- barplot(t(monthsum),beside=T,names=rownames(monthsum),las=1,col=rainbow(ncol(monthsum)),ylim=c(0,max(monthsum)*1.2),
	legend=T,args.legend=list(x="topleft",inset=0.02))
box(bty="l",lwd=2.5)
#for (i in 1:ncol(monthsum)){
#	text(x=b[i,],y=monthsum[,i],labels=monthsum[,i],pos=3)
#}
title("新型コロナウイルス月別死亡者")
title("\n\n\nデータ：[東洋経済オンライン](https://raw.githubusercontent.com/kaz-ogiwara/covid19/master/data/data.json)",cex.main=0.8)
#
CperPop<- monthsum
for (i in 1:ncol(CperPop)){
	CperPop[,i]<- round(CperPop[,i]/m$population[code[i]]*10^6,0)
}
#
#plot
par(mar=c(3,5,3,2),family="serif")
b<- barplot(t(CperPop),beside=T,names=rownames(CperPop),las=1,col=rainbow(ncol(CperPop)),ylim=c(0,max(CperPop)*1.2),
	legend=T,args.legend=list(x="topleft",inset=0.02))
box(bty="l",lwd=2.5)
#for (i in 1:ncol(CperPop)){
#	text(x=b[i,],y=CperPop[,i],labels=CperPop[,i],pos=3)
#}
title("人口１００万人あたり新型コロナウイルス月別死亡者")
title("\n\n\nデータ：[東洋経済オンライン](https://raw.githubusercontent.com/kaz-ogiwara/covid19/master/data/data.json) & 都道府県別人口:NipponMapパッケージ",cex.main=0.8)
#
dev.off()
}
par(mfrow=c(1,1))
```

#### 重症者数の推移

##### pngファイルで保存

```R
name<- "seriousR"
region<- c("Hokkaido|Tohoku","Kanto","Chubu","Kinki","Chugoku","Shikoku","Kyushu / Okinawa")
#
for (r in 1:7){
code<- as.numeric(m[grep(region[r],m$region),]$SP_ID)
data<- covid19[[4]]$serious[code[1],]
from<- as.Date(paste0(data$from[[1]][1],"-",data$from[[1]][2],"-",data$from[[1]][3]))
data.xts<- xts(x=cumsum(data$values[[1]]),seq(as.Date(from),length=nrow(data$values[[1]]),by="days"))
#
for (i in code[-1]){
	data<- covid19[[4]]$serious[i,]
	from<- as.Date(paste0(data$from[[1]][1],"-",data$from[[1]][2],"-",data$from[[1]][3]))
	tmp.xts<- xts(x=cumsum(data$values[[1]]),seq(as.Date(from),length=nrow(data$values[[1]]),by="days"))
	data.xts<- merge(data.xts,tmp.xts)
}
# NA<- 0
coredata(data.xts)[is.na(data.xts)]<- 0
colnames(data.xts)<- covid19[[5]]$ja[code]
#
#plot
png(paste0(name,r,".png"),width=800,height=600)
par(mar=c(3,5,3,2),family="serif",mfrow=c(1,1))
matplot(coredata(data.xts),type="l",lwd=2,lty=1,las=1,col=rainbow(ncol(data.xts),alpha=0.8),
	xlab="",ylab="",ylim=c(0,max(data.xts)*1.2),xaxt="n",bty="n")
box(bty="l",lwd=2.5)
labels<- sub("-","/",sub("-0","-",sub("^0","",sub("2020-","",index(data.xts)))))
labelpos<- paste0(rep(1:12,each=3),"/",1)
for (i in labelpos){
	at<- match(i,labels)
	if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.02)}
	}
labelpos<- paste0(rep(1:12,each=3),"/",c(10,20))
for (i in labelpos){
	at<- match(i,labels)
	if (!is.na(at)){ axis(1,at=at,labels =NA,tck= -0.01)}
	}
#都道府県名が３文字の場合全角スペースを加える
for (i in 1:ncol(data.xts)){
if (nchar(colnames(data.xts))[i]==3){
	colnames(data.xts)[i]<- paste0(colnames(data.xts)[i],"　")
	}
}
legend(x="topleft",inset=0.02,legend=paste0(colnames(data.xts),sprintf("%5d",tail(data.xts,1))),lwd=2,lty=1,
	col=rainbow(ncol(data.xts),alpha=0.8),title=paste(index(tail(data.xts,1)),"現在"),cex=1.5,bg=rgb(0,0,0,0))
title("新型コロナウイルス重症者数の推移")
title("\n\n\nデータ：[東洋経済オンライン](https://raw.githubusercontent.com/kaz-ogiwara/covid19/master/data/data.json)",cex.main=0.8)
#
dev.off()
}
```

