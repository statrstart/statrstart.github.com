---
title: 最近の地震(気象庁 震源リスト)
date: 2021-12-03
tags: ["R", "rvest" ,"hillshade"]
excerpt: 陰影段彩図　+「気象庁 震源リスト」
---

# 最近の地震(気象庁 震源リスト)
[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FRecent_Eq&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

### １２月３日、午前９時半頃結構揺れました。（2021年12月3日 9時28分ごろ. 震源地, 紀伊水道. 最大震度, 5弱. マグニチュード, 5.4. 深さ, 20km）  

気象庁 震源リストに１２月１日までのデータがあったので9/1から12/1まで（約３ヶ月）のマグニチュード３以上の震源データを地図上にプロットした。

「Rで陰影段彩図05」で作成した陰影段彩図に「気象庁 震源リスト」から得た震源の位置をプロットします。  
今回は「RでWebスクレイピング01(気象庁 震源リスト)」で得たデータを陰影段彩図にプロットします。

### 最近の地震(気象庁 震源リスト)

![Recent_Eq2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Recent_Eq2.png)

- 青領域 : 南海地震の想定震源域
- 赤領域 : 東南海地震の想定震源域
- 緑領域 : 東海地震の想定震源域
- 黄領域 : 関東地震，東海地域のアスペリティ

## Rコード（トラフ等のデータがないと完全には実行できません）

```R
library(raster)
library(rgdal)
library(marmap)
library(geosphere)
library(zoo)
#Lon.range = c(130, 144)
#Lat.range = c(30, 38)
#dat<-getNOAA.bathy(Lon.range[1],Lon.range[2],Lat.range[1],Lat.range[2],res=1,keep=TRUE)
#ETOPO1:1分=~1.8kmの解像度のデータセット(resolution = 1)
dat<-read.bathy("marmap_coord_122;20;154;46_res_1.csv", header=TRUE)
#
map<-marmap::as.raster(dat)
#
Lon.range = c(130, 144)
Lat.range = c(30, 38)
#
axes1<-seq(130,144,1)
axes2<-seq(30,38,1)
#
Crop <- c(Lon.range[1],Lon.range[2],Lat.range[1],Lat.range[2])
r1 <- crop(map,Crop)
#配色はGMTのカラーパレット“relief”を参考にした
ocean<-colorRampPalette(c("#000000", "#000413", "#000728", "#002650", "#005E8C", 
                          "#0096C8", "#45BCBB", "#8AE2AE", "#BCF8B9" , "#DBFBDC"))
#
land1 <- colorRampPalette(c("#467832","#786432"))
land2 <- colorRampPalette(c("#786433","#927E3C"))
land3 <- colorRampPalette(c("#927E3D","#C6B250"))
land4 <- colorRampPalette(c("#C6B251","#FAE664"))
land5 <- colorRampPalette(c("#FAE665","#FAEA7E"))
breakpoints <- c(seq(-11000,0,100),1,seq(50,500,50),seq(550,1000,50),seq(1100,2000,100),seq(2100,3000,100),seq(3500,9000,500))
colors <- c(ocean(110),land1(11),land2(10),land3(10),land4(10),land5(12))
slope <- terrain(r1, opt='slope')
aspect <- terrain(r1, opt='aspect')
hill <- hillShade(slope, aspect,45,315) #,normalize=T
#
## 彩色
v<-getValues(r1)
#欠損値の個数
sum(is.na(v))
#欠損値があった場合
#直前の値を入れる
#v<-na.locf(v) #zoo package
#平均値を入れる
#v[is.na(v)] <- mean(v,na.rm=T)
#0を入れる
#v[is.na(v)] <- 0
v<-as.vector(cut(v, breaks=breakpoints, labels = colors, right = F))
v1<-rgb2hsv(col2rgb(v))
## 陰影
x<-getValues(hill)
#欠損値の個数
sum(is.na(x))
x[is.na(x)] <- mean(x,na.rm=T)
#
#最小値を m、最大値を Mにする正規化
m<-0 ; M<-max(v1[3,])
x<-(M-m)*((x-min(x))/(max(x)-min(x)))+m
#
h<-NULL
for ( i in 1:length(x)){
  h[i]<-gray(x[i])
}
#h
h1<-rgb2hsv(col2rgb(h))
#
d1<-NULL
d1<-(v1+h1)/2
d1[1,]<-v1[1,]
#
g<-c(col2rgb(hsv(d1[1,],d1[2,],d1[3,]))[1,],
     col2rgb(hsv(d1[1,],d1[2,],d1[3,]))[2,],
     col2rgb(hsv(d1[1,],d1[2,],d1[3,]))[3,] )
s<-NULL
r<-r1
s <- stack(r, r, r)
#nlayers(s)
values(s)<-g
#
#install.packages("rvest")
library("rvest")
#
#### 気象庁　震源リストにあるデータの期間を調べる #####
webdata<-read_html("http://www.data.jma.go.jp/svd/eqev/data/daily_map/")
# class属性がliタグのノードを抽出
node_extracted <-html_nodes(webdata, "li")
# ノードからテキストを抽出。
data <- data.frame(html_text(node_extracted),stringsAsFactors = F)
day<-subset(data,grepl("..年..月..日", data[,1]))
ymd<-gsub("日","",gsub("月","",gsub("年","", rev(day[,1]))))
head(ymd,1) ; tail(ymd,1)
#
#震源リストにあるデータを取得する
# 1.震源リストにある全期間のデータを取得する場合
#date<-ymd
#
# 2.期間を指定する場合
#date<-gsub("-","",seq(as.Date("2020-01-01"), len=17, by="1 day"))
date<-gsub("-","",seq(as.Date("2021-09-01"),as.Date("2021-12-01"), by="1 day"))
#
eqdata<-read.table(text="",col.names=c("time", "longitude", "latitude", "depth", "mag"))
for (i in date){
  url<-paste0("http://www.data.jma.go.jp/svd/eqev/data/daily_map/",i,".html")
  #
  doc<-readLines(url,encoding ="UTF-8")
  kensaku<-paste0(substr(i,1,4)," ",gsub("\\<0"," ",substr(i,5,6))," ",gsub("\\<0"," ",substr(i,7,8)))
  #
  x<-doc[grep(paste0("\\<",kensaku),doc)]
  #全角文字 ° が入っているので半角スペース２つに変換する
  x<-gsub("°", "  ",x)
  time<-paste0(substr(x,1,4),"-",substr(x,6,7),"-",substr(x,9,10)," ",substr(x,12,16),":",substr(x,18,21))
  #
  #南緯、西経の場合も考慮に入れると
  latitude = as.numeric(paste0(substr(x,23,23),as.character(as.numeric(substr(x,24,25))+as.numeric(substr(x,28,29))/60+as.numeric(substr(x,31,31))/600)))
  longitude = as.numeric(paste0(substr(x,34,34),as.character(as.numeric(substr(x,35,37))+as.numeric(substr(x,40,41))/60+as.numeric(substr(x,43,43))/600)))
  depth<-as.numeric(substr(x,48,50))
  mag<-as.numeric(substr(x,55,58))
  eq<-data.frame(time,longitude,latitude,depth,mag)
  eqdata<-rbind(eqdata,subset(eq,mag>=-4))
}
#
#重複した行を取り除く
eqdata<-unique(eqdata)
#
##震源の深さによって色を分ける
eqdep<-c(-Inf,10,20,40,80,150,Inf)
eqcol<-c("red","orange","yellow","green","blue","purple")
#"D<10km"->"red" ,"10km<=D<20km"->"orange" ,"20km<=D<40km"->"yellow" ,"40km<=D<80km"->"green" ,"80km<=D<150km"->"blue","150km<=D"->"purple"
# なに以上なになに未満となるようにright = Fとする
eqdata$col<-as.vector(cut(eqdata$depth, breaks=eqdep, labels = eqcol, right = F))
##並べ替え:マグニチュードの昇順
sortlist <- order(eqdata$mag)
eq<- eqdata[sortlist,]
#
#トラフ等データ読み込み
trench<-readLines("./mapdata/trench.dat")
fromto<-grep(">",trench)
trench1<-read.table(text=trench,nrows =fromto[1]-1,col.names=c("latitude","longitude"))
trench2<-read.table(text=trench,skip=fromto[1],nrows =fromto[2]-(fromto[1]+1),col.names=c("latitude","longitude"))
trench3<-read.table(text=trench,skip=fromto[2],col.names=c("latitude","longitude"))
#
nankai=read.table("./mapdata/nankai.region",h=F)
names(nankai)<-c("latitude","longitude")
#
tokai=read.table("./mapdata/tokai.region",h=F)
names(tokai)<-c("latitude","longitude")
#
tonankai=read.table("./mapdata/tonankai.region",h=F)
names(tonankai)<-c("latitude","longitude")
#
trough<-data.frame(names=c("駿河トラフ","相模トラフ","南海トラフ","フィリピン海プレート","東海","東南海","南海"),
                   longitude=c(138.9,140.2,136.5,136,138,136.8,134),latitude=c(33.8,34.4,32.5,30.7,34.5,34,32.9))
#
# Asperities
# Kanto (Wald and Somerville, 1995, BSSA)
kasp=read.table("./mapdata/kanto_eq.dat",h=F,skip=1)
names(kasp)<-c("longitude","latitude")
#
# Tokai (Matsumura, 1997, Tectono.)
tasp=read.table("./mapdata/tokai_asperity.data",h=F)
names(tasp)<-c("latitude","longitude")
#
arrow1<-destPointRhumb(c(140.8,33.5),90-131, 63750/3*2)
arrow2<-destPointRhumb(c(137,31.1),90-145, 105000/3*2)
#
#プロットする最小のマグニチュード
ptmag<-3
over<-subset(eq,mag>=ptmag & 
               longitude>=Lon.range[1] & longitude<=Lon.range[2] &
               latitude>=Lat.range[1] & latitude<=Lat.range[2])
#マグニチュードに応じてプロットサイズを変える
msize<-1
cexsize=c(3,4,5,6)*msize
maglegend = c("M=3","M=4","M=5","M=6")
#
#library(showtext)
#https://fonts.google.com/
#font_add_google("Noto Serif JP", regular.wt = 400, bold.wt = 600)
#png("Recent_Eq.png",width=1280,height=960)
#par(family="Noto Serif JP")
#showtext_begin()
par(family="serif")
par(mar=c(4,4,3,2), xaxt="n", yaxt="n")
plotRGB(s,stretch='lin',axes=TRUE)
par(xpd=T)
rect(extent(s)[1],extent(s)[3],extent(s)[2],extent(s)[4],
     lwd=3)
text(axes1,extent(s)[3],paste0(as.character(axes1),"°"),pos=1)
text(extent(s)[1],axes2,paste0(as.character(axes2),"°"),pos=2)
points(x=axes1,y=rep(extent(s)[3],length(axes1)),cex=1,pch=3)
points(x=rep(extent(s)[1],length(axes2)),y=axes2,cex=1,pch=3)
par(xpd=F)
#
lines(x=trench1$longitude, y = trench1$latitude,col="red",lty=2,lwd=2)
lines(x=trench2$longitude, y = trench2$latitude,col="red",lty=2,lwd=2)
lines(x=trench3$longitude, y = trench3$latitude,col="red",lty=2,lwd=2)
#
#arrows(140.8,33.5,arrow1[1],arrow1[2],angle = 25, length = 0.2, code = 2,lwd=3) 
#arrows(137,31.1,arrow2[1],arrow2[2],angle = 25, length = 0.2, code = 2,lwd=3)
#
polygon(x=nankai$longitude, y = nankai$latitude, col=rgb(0,0,1,0.3),border=rgb(0,0,1,0.8))
#
polygon(x=tokai$longitude, y = tokai$latitude, col=rgb(0,1,0,0.3),border=rgb(0,1,0,0.8))
#
polygon(x=tonankai$longitude, y = tonankai$latitude,col=rgb(1,0,0,0.3),border=rgb(1,0,0,0.8))
#
polygon(x=kasp$longitude, y = kasp$latitude,col=rgb(1,1,0,0.8),border=rgb(1,1,0,1),angle=90,density=100)
polygon(x=tasp$longitude, y = tasp$latitude,col=rgb(1,1,0,0.8),border=rgb(1,1,0,1),angle=90,density=100)
#
text(x = trough$longitude, y = trough$latitude,labels =trough$names)
#
points(x=over$longitude, y=over$latitude,cex=over$mag*msize,pch=21,bg=over$col,col="gray20")
#legend("topleft",title="Depth",
#       legend = c("D<10km","10km<=D<20km","20km<=D<40km","40km<=D<80km","80km<=D<150km","150km<=D"),  
#       cex=1,pch=19,col=eqcol,
#       pt.cex =1.2,bg ="gray90",bty = "n", y.intersp =1.5, inset = c(0.01, 0.03))
legend("topleft",title="Depth",
       legend = c(expression(paste(D<10,"km")),
                  expression(paste("10",km<=D,"< 20km")),
                  expression(paste("20",km<=D,"< 40km")),
                  expression(paste("40",km<=D,"< 80km")),
                  expression(paste("80",km<=D,"< 150km")),
                  expression(paste("150",km<=D))), 
       cex=1,pch=21,col=1,pt.bg=eqcol,
       pt.cex =2,bty = "n", y.intersp =1.5, inset = c(0.01, 0.03))
#
legend("topleft",title="Magnitude",
       legend =maglegend, col=1,pch=21,pt.cex=cexsize,pt.bg=2,
       cex =1, x.intersp = 2, y.intersp =2.2,bty = "n", inset = c(0.17, 0.03)) #inset = c(0.03, 0.24)
#
#bquote()内では、.(変数)とすることで、変数を受け取ることができる
date1<-date[1] ; date2<-date[length(date)]
title(bquote(.(date1) ~ "～" ~ .(date2) ~ 
               "地震 (" * M >= .(ptmag) * ")"))
title("","( データ：気象庁 震源リスト )",line=2)
#
#showtext_end()
#dev.off()
```
