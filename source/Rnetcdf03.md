---
title: RでNetCDFファイルを読み込み、鉛直断面図作成（1）
date: 2021-02-22
tags: ["R","cdo","GrADS","ncdf4","fields","akima","oce"]
excerpt: Rで鉛直断面図
---

# RでNetCDFファイルを読み込み、鉛直断面図作成（1）

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FRnetcdf03&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

> 今回は、cdo(Climate Data Operatos)であらかじめデータの経度変換を行い、それをＲに取り込みます。

(準備)政治境界線のないFreeの世界地図を入手、oce オブジェクトに変換しておく。  
(Natural Earth : Free vector and raster map data at 1:10m, 1:50m, and 1:110m scales)[https://www.naturalearthdata.com/] の
「ne_50m_coastline.shp」から作成したものを置いておきます。  
[coastlineWorldNew.rda](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/coastlineWorldNew.rda)  

(my.image.plot関数の作成:fields::image.plotの一箇所変更)  
fields::image.plot 凡例のbreakポイントの箇所
```
    if (!is.null(lab.breaks)) {
        axis.args <- c(list(side = ifelse(horizontal, 1, 4), 
            mgp = c(3, 1, 0), las = ifelse(horizontal, 0, 2), 
            at = breaks, labels = lab.breaks), axis.args)
    }
```
labels = lab.breaksに対して、at = breaks　になっていたので、
```
    if (!is.null(lab.breaks)) {
        axis.args <- c(list(side = ifelse(horizontal, 1, 4), 
            mgp = c(3, 1, 0), las = ifelse(horizontal, 0, 2), 
            at = lab.breaks, labels = lab.breaks), axis.args)
    }
```
とした。my.image.plotとして保存。

(使用するデータ)

```
wget -P ./GrADS ftp://ftp.cdc.noaa.gov/Datasets/ncep.reanalysis.derived/pressure/air.mon.1981-2010.ltm.nc
```

### ２月のデータで作成します。

#### 鉛直断面図を作成する場所

![vcsmap01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/vcsmap01.png)

#### A:経度固定

GrADS

![airVCS01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/airVCS01.png)

R:グラデーション(凡例なし: image+contour)

![Rvcs01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Rvcs01.png)

#### B:緯度固定

GrADS

![airVCS02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/airVCS02.png)

R:塗りつぶし(凡例なし: image+contour)

![Rvcs02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Rvcs02.png)

#### C : 斜め(パターン１、２どちらを使っても良い)

GrADS

![airVCS03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/airVCS03.png)

R:塗りつぶし(凡例あり:fields::image.plot+contour)

![Rvcs03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Rvcs03.png)

#### D : 斜め(パターン１、２どちらを使っても良い)

GrADS

![airVCS04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/airVCS04.png)

R:グラデーション(凡例あり:fields::image.plot(一箇所変更した関数)+contour)

![Rvcs04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Rvcs04.png)

### cdoで経度0_360を-180_180に変更

```cdo
cdo sellonlatbox,-180,180,-90,90 air.mon.1981-2010.ltm.nc tempJ2.nc
```

### Rコード

#### cdo出力netcdf読み込み

```R
library(ncdf4)
library(akima)
library(fields)
library(oce)
aircolor <-function (n) {
    if (missing(n) || n <= 0) 
        colorRampPalette(c("blue","cyan", "white", "yellow","orange", "red"))
    else {
        colorRampPalette(c("blue","cyan", "white", "yellow","orange", "red"))(n)
    }
}
temp.nc <- nc_open("tempJ2.nc")
temp0 <- ncvar_get(temp.nc, "air")
dim(temp0)
#[1] 144  73  17  12
all(!is.na(temp0))
# [1] TRUE.
lev <- ncvar_get(temp.nc, "level")
temp0<- temp0[,,order(lev), ]      # levデータ部、昇順にする
lev<- lev[order(lev)]		   # lev、昇順にする
lon <- ncvar_get(temp.nc, "lon") 
#lat : 降順->昇順
lat <- ncvar_get(temp.nc, "lat") 
temp0<- temp0[,order(lat), ,]      # latデータ部、昇順にする
lat<- lat[order(lat)]		   # 緯度、昇順にする
month<- 2
temp<- temp0[ , , ,month]
```

#### 鉛直断面図を作成する場所

```R
load(url("https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/coastlineWorldNew.rda"))
lonlim = c(120,150)
latlim = c(20,50)
#ランベルト等角円錐図法 [LCC：Lambert Conformal Conic] 
# png("vcsmap01.png",width=800,height=600)
mapPlot(coastlineWorldNew,col="lightgray",projection="+proj=lcc +lat_1=21 +lat_2=48 +lon_0=135",
	longitudelim=lonlim,latitudelim=latlim)
# 経度固定(縦線)
lonA <- c(140,140) 
latA <- c(30,50)
mapPoints(lonA,latA, col='red')
mapLines(lonA,latA, col='red')
mapText(lonA[1],latA[1],labels="A",pos=1,col='red')
# 緯度固定(横線)
lonB <- c(125,145) 
latB <- c(35,35)
mapPoints(lonB,latB, col='blue')
mapLines(lonB,latB, col='blue')
mapText(lonB[1],latB[1],labels="B",pos=2,col='blue')
# 斜め1
lonC <- c(127,145) 
latC <- c(30,40)
mapPoints(lonC,latC, col='green')
mapLines(lonC,latC, col='green')
mapText(lonC[1],latC[1],labels="C",pos=2,col='green')
# 斜め2
lonD <- c(130,148)
latD <- c(50,40)
mapPoints(lonD,latD, col='orange')
mapLines(lonD,latD, col='orange')
mapText(lonD[1],latD[1],labels="D",pos=2,col='orange')
# dev.off()
```

#### 鉛直断面図作成

```R
# 経度固定(縦線)
# A:経度固定(縦線)
# lonA <- c(140,140) 
# latA <- c(30,50)
# 1.緯度を動かす。経度は固定もしくは動かす。
lon1 = 140
lon2 = 140
latmin = 30
latmax = 50
#
plat = latmin
pdata<- data.frame()
# 緯度経度内挿
(latmax-latmin)/199
i=1
while (plat <= latmax){
  plon = lon1 + (lon2-lon1)*(plat-latmin) / (latmax-latmin)
  pdata[i,1]<- plon ; pdata[i,2]<- plat
  plat = plat + 0.1
  i=i+1
}
vcs<- data.frame(lon=pdata[,1],lat=pdata[,2])
for (i in 1:length(lev)){
	vcs<- cbind(vcs,bilinear(lon,lat,temp[,,i],pdata[,1],pdata[,2])$z)
}
colnames(vcs)[3:ncol(vcs)]<- lev
# levを線形内挿
img<- data.frame()
num<- 199
nlev<- seq(min(lev),max(lev),length.out=num)
for (i in 1:length(vcs$lat)){
	img<- rbind(img,approx(lev,vcs[i,3:ncol(vcs)],n=num)$y)
}
# 単純なコンター図
zrange<- range(img)
levs<- seq(floor(zrange[1]),ceiling(zrange[2]),6)
contour(vcs$lat,nlev,as.matrix(img),yaxt="n",bty="l",labcex=1,,ylim=c(1000,0),
	method="flattest",vfont =c("sans serif","bold"),levels=levs,xlab="latitude")
box(bty="l",lwd=2.5)
at<- seq(100,1000,100)
axis(2,at=-at,labels=at,las=1)
title(paste0("Vertical Cross Section (",lon1,",",latmin,") - (",lon2,",",latmax,")"))
##### カラーコンター #####
#グラデーション(凡例なし: image+contour)
zrange<- range(img)
levs<- seq(floor(zrange[1]),ceiling(zrange[2]),6)
# png("Rvcs01.png",width=640,height=640)
par(mar=c(5,4,4,2),family="serif")
image(vcs$lat,nlev,as.matrix(img),yaxt ="n",ylim=c(1000,0),col=aircolor(120),
	xlab="latitude",ylab="",bty="l",breaks=seq(floor(zrange[1]),ceiling(zrange[2]),length.out=121))
box(bty="l",lwd=2.5)
abline(h= seq(100,900,100),lty=2,col="gray",lwd=0.6)
abline(v= pretty(vcs$lat),lty=2,col="gray",lwd=0.6)
at<- c(10,seq(50,1000,50))
axis(2,at=at,labels=at,las=1)
contour(vcs$lat,nlev,as.matrix(img),labcex=1.2,add=T,vfont = c("sans serif", "bold"),levels=levs)
title(paste0("Vertical Cross Section (",lon1,",",latmin,") - (",lon2,",",latmax,") month=",month))
# dev.off()
#塗りつぶし(凡例なし: image+contour)
zrange<- range(img)
levs<- seq(floor(zrange[1]),ceiling(zrange[2]),6)
par(mar=c(5,4,4,2),family="serif")
image(vcs$lat,nlev,as.matrix(img),yaxt ="n",ylim=c(1000,0),col=aircolor(length(levs)-1),
	breaks=levs,xlab="latitude",ylab="",bty="l")
box(bty="l",lwd=2.5)
abline(h= seq(100,900,100),lty=2,col="gray",lwd=0.6)
abline(v= pretty(vcs$lat),lty=2,col="gray",lwd=0.6)
at<- seq(100,1000,100)
axis(2,at=at,labels=at,las=1)
contour(vcs$lat,nlev,as.matrix(img),labcex=1.2,add=T,vfont = c("sans serif", "bold"),levels=levs,lwd=1.2)
title(paste0("Vertical Cross Section (",lon1,",",latmin,") - (",lon2,",",latmax,") month=",month))
#
#
# B : 緯度固定(横線)
#lonB <- c(125,145) 
#latB <- c(35,35)
# 2.経度を動かす。緯度は固定もしくは動かす。
lonmin = 125
lonmax = 145
lat1 = 35
lat2 = 35
#
plon = lonmin
pdata<- data.frame()
i=1 
while (plon <= lonmax){
  plat = lat1 + (lat2-lat1)*(plon-lonmin) / (lonmax-lonmin)
  pdata[i,1]<- plon ; pdata[i,2]<- plat
  plon = plon + 0.1
  i=i+1
}
vcs<- data.frame(lon=pdata[,1],lat=pdata[,2])
for (i in 1:length(lev)){
	vcs<- cbind(vcs,bilinear(lon,lat,temp[,,i],pdata[,1],pdata[,2])$z)
}
colnames(vcs)[3:ncol(vcs)]<- lev
# levを線形内挿
img<- data.frame()
num<- 199*2
nlev<- seq(min(lev),max(lev),length.out=num)
for (i in 1:length(vcs$lon)){
	img<- rbind(img,approx(lev,vcs[i,3:ncol(vcs)],n=num)$y)
}
##### カラーコンター #####
#塗りつぶし(凡例なし: image+contour)
zrange<- range(img)
levs<- seq(floor(zrange[1]),ceiling(zrange[2]),6)
# png("Rvcs02.png",width=640,height=640)
par(mar=c(5,4,4,2),family="serif")
image(vcs$lon,nlev,as.matrix(img),yaxt ="n",ylim=c(1000,0),col=aircolor(length(levs)-1),
	breaks=levs,xlab="longitude",ylab="",bty="l")
box(bty="l",lwd=2.5)
abline(h= seq(100,900,100),lty=2,col="gray",lwd=0.6)
abline(v= pretty(vcs$lon),lty=2,col="gray",lwd=0.6)
at<- seq(100,1000,100)
axis(2,at=at,labels=at,las=1)
contour(vcs$lon,nlev,as.matrix(img),labcex=1.2,add=T,vfont = c("sans serif", "bold"),levels=levs,lwd=1.2)
title(paste0("Vertical Cross Section (",lonmin,",",lat1,") - (",lonmax,",",lat2,") month=",month))
# dev.off()
#グラデーション(凡例なし: image+contour)
zrange<- range(img)
levs<- seq(floor(zrange[1]),ceiling(zrange[2]),6)
par(mar=c(5,4,4,2),family="serif")
image(vcs$lon,nlev,as.matrix(img),yaxt ="n",ylim=c(1000,0),col=aircolor(120),
	xlab="longitude",ylab="",bty="l",breaks=seq(floor(zrange[1]),ceiling(zrange[2]),length.out=121))
box(bty="l",lwd=2.5)
abline(h= seq(100,900,100),lty=2,col="gray",lwd=0.6)
abline(v= pretty(vcs$lon),lty=2,col="gray",lwd=0.6)
at<- c(10,seq(50,1000,50))
axis(2,at=at,labels=at,las=1)
contour(vcs$lon,nlev,as.matrix(img),labcex=1.2,add=T,vfont = c("sans serif", "bold"),levels=levs)
title(paste0("Vertical Cross Section (",lonmin,",",lat1,") - (",lonmax,",",lat2,") month=",month))
#
#
#C : 斜め(パターン１、２どちらを使っても良い)
#lonC <- c(127,145) 
#latC <- c(30,40)
# 2.経度を動かす。緯度は固定もしくは動かす。
lonmin = 127
lonmax = 145
lat1 = 30
lat2 = 40
#
plon = lonmin
pdata<- data.frame()
i=1 
while (plon <= lonmax){
  plat = lat1 + (lat2-lat1)*(plon-lonmin) / (lonmax-lonmin)
  pdata[i,1]<- plon ; pdata[i,2]<- plat
  plon = plon + 0.1
  i=i+1
}
vcs<- data.frame(lon=pdata[,1],lat=pdata[,2])
for (i in 1:length(lev)){
	vcs<- cbind(vcs,bilinear(lon,lat,temp[,,i],pdata[,1],pdata[,2])$z)
}
colnames(vcs)[3:ncol(vcs)]<- lev
# levを線形内挿
img<- data.frame()
num<- 199*2
nlev<- seq(min(lev),max(lev),length.out=num)
for (i in 1:length(vcs$lon)){
	img<- rbind(img,approx(lev,vcs[i,3:ncol(vcs)],n=num)$y)
}
##### カラーコンター #####
# 塗りつぶし(凡例あり:fields::image.plot+contour)
zrange<- range(img)
#levs<- seq(floor(zrange[1]),ceiling(zrange[2]),6)
levs<- seq(floor(zrange[1]),14,6) # 塗り残しがないように変更
# png("Rvcs03.png",width=720,height=640)
par(mar=c(5,4,4,1),family="serif")
image.plot(vcs$lon,nlev,as.matrix(img),yaxt ="n",ylim=c(1000,0),col=aircolor(length(levs)-1),
	xlab="longitude",ylab="",bty="l",breaks =levs,lab.breaks=levs)
contour(vcs$lon,nlev,as.matrix(img),yaxt="n",bty="l",labcex=1,
	method="flattest",vfont =c("sans serif","bold"),levels =levs,add=T)
box(bty="l",lwd=2.5)
abline(h= seq(100,900,100),lty=2,col="gray",lwd=0.6)
abline(v= pretty(vcs$lon),lty=2,col="gray",lwd=0.6)
at<- seq(100,1000,100)
axis(2,at=at,labels=at,las=1)
title(paste0("Vertical Cross Section (",lonmin,",",lat1,") - (",lonmax,",",lat2,") month=",month))
# dev.off()
#グラデーション(凡例あり:oce::drawPalette+image+contour)
zrange<- range(img)
levs<- seq(floor(zrange[1]),ceiling(zrange[2]),6)
layout(matrix(c(2,1), ncol = 2), widths = c(10,0.5))
par(mar=c(5,0,4,0))
plot.new()
drawPalette(zrange, col=aircolor(120),pos =4,las=1,at=levs,labels=levs,mai=c(0,0,0,0))
par(mar=c(4,3.5,3,3.5))
plot.new()
image(vcs$lon,nlev,as.matrix(img),yaxt ="n",ylim=c(1000,0),col=aircolor(120),
	xlab="longitude",ylab="",bty="l",breaks=seq(floor(zrange[1]),ceiling(zrange[2]),length.out=121))
box(bty="l",lwd=2.5)
abline(h= seq(100,900,100),lty=2,col="gray",lwd=0.6)
abline(v= pretty(vcs$lon),lty=2,col="gray",lwd=0.6)
at<- seq(100,1000,100)
axis(2,at=at,labels=at,las=1)
contour(vcs$lon,nlev,as.matrix(img),labcex=1.2,add=T,vfont = c("sans serif", "bold"),levels =levs)
title(paste0("Vertical Cross Section (",lonmin,",",lat1,") - (",lonmax,",",lat2,") month=",month))
#
#
#D1: 斜め(パターン１、２どちらを使っても良い)
#lonD <- c(130,148)
#latD <- c(50,40)
# 2.経度を動かす。緯度は固定もしくは動かす。
lonmin = 130
lonmax = 148
lat1 = 50
lat2 = 40
#
plon = lonmin
pdata<- data.frame()
i=1 
while (plon <= lonmax){
  plat = lat1 + (lat2-lat1)*(plon-lonmin) / (lonmax-lonmin)
  pdata[i,1]<- plon ; pdata[i,2]<- plat
  plon = plon + 0.1
  i=i+1
}
vcs<- data.frame(lon=pdata[,1],lat=pdata[,2])
for (i in 1:length(lev)){
	vcs<- cbind(vcs,bilinear(lon,lat,temp[,,i],pdata[,1],pdata[,2])$z)
}
colnames(vcs)[3:ncol(vcs)]<- lev
# levを線形内挿
img<- data.frame()
num<- 199*2
nlev<- seq(min(lev),max(lev),length.out=num)
for (i in 1:length(vcs$lon)){
	img<- rbind(img,approx(lev,vcs[i,3:ncol(vcs)],n=num)$y)
}
##### カラーコンター #####
#source("my.image.plot.R")
source("https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/my.image.plot.R")
# グラデーション(凡例あり:fields::image.plot(１箇所書き換え:my.image.plot)+contour)
zrange<- range(img)
levs<- seq(floor(zrange[1]),ceiling(zrange[2]),6)
# png("Rvcs04.png",width=720,height=640)
par(mar=c(5,4,4,1),family="serif")
my.image.plot(vcs$lon,nlev,as.matrix(img),yaxt ="n",ylim=c(1000,0),col=aircolor(120),
	xlab="longitude",ylab="",bty="l",breaks=seq(floor(zrange[1]),ceiling(zrange[2]),length.out=121),lab.breaks=levs)
contour(vcs$lon,nlev,as.matrix(img),yaxt="n",bty="l",labcex=1,
	method="flattest",vfont =c("sans serif","bold"),levels =levs,add=T)
box(bty="l",lwd=2.5)
abline(h= seq(100,900,100),lty=2,col="gray",lwd=0.6)
abline(v= pretty(vcs$lon),lty=2,col="gray",lwd=0.6)
at<- seq(100,1000,100)
axis(2,at=at,labels=at,las=1)
title(paste0("Vertical Cross Section (",lonmin,",",lat1,") - (",lonmax,",",lat2,") month=",month))
# dev.off()
#
#
#D2: 斜め(パターン１、２どちらを使っても良い)
#lonD <- c(130,148)
#latD <- c(50,40)
# 1.緯度を動かす。経度は固定もしくは動かす。
lon1 = 148
lon2 = 130
latmin = 40
latmax = 50
#
plat = latmin
pdata<- data.frame()
# 内挿の格子の大きさ
i=1
while (plat <= latmax){
  plon = lon1 + (lon2-lon1)*(plat-latmin) / (latmax-latmin)
  pdata[i,1]<- plon ; pdata[i,2]<- plat
  plat = plat + 0.1
  i=i+1
}
vcs<- data.frame(lon=pdata[,1],lat=pdata[,2])
for (i in 1:length(lev)){
	vcs<- cbind(vcs,bilinear(lon,lat,temp[,,i],pdata[,1],pdata[,2])$z)
}
colnames(vcs)[3:ncol(vcs)]<- lev
# levを線形内挿
img<- data.frame()
num<- 199*2
nlev<- seq(min(lev),max(lev),length.out=num)
for (i in 1:length(vcs$lat)){
	img<- rbind(img,approx(lev,vcs[i,3:ncol(vcs)],n=num)$y)
}
##### カラーコンター #####
# 塗りつぶし(凡例あり:fields::image.plot+contour)
zrange<- range(img)
levs<- seq(floor(zrange[1]),ceiling(zrange[2]),6)
par(mar=c(5,4,4,1),family="serif")
image.plot(vcs$lat,nlev,as.matrix(img),yaxt ="n",ylim=c(1000,0),col=aircolor(length(levs)-1),
	xlab="latitude",ylab="",bty="l",breaks =levs,lab.breaks=levs)
contour(vcs$lat,nlev,as.matrix(img),yaxt="n",bty="l",labcex=1,
	method="flattest",vfont =c("sans serif","bold"),levels =levs,add=T)
box(bty="l",lwd=2.5)
abline(h= seq(100,900,100),lty=2,col="gray",lwd=0.6)
abline(v= pretty(vcs$lat),lty=2,col="gray",lwd=0.6)
at<- seq(100,1000,100)
axis(2,at=at,labels=at,las=1)
title(paste0("Vertical Cross Section (",lon1,",",latmin,") - (",lon2,",",latmax,") month=",month))
#
#source("my.image.plot.R")
source("https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/my.image.plot.R")
# グラデーション(凡例あり:fields::image.plot(１箇所書き換え:my.image.plot)+contour)
zrange<- range(img)
levs<- seq(floor(zrange[1]),ceiling(zrange[2]),6)
par(mar=c(5,4,4,1),family="serif")
my.image.plot(vcs$lat,nlev,as.matrix(img),yaxt ="n",ylim=c(1000,0),col=aircolor(120),
	xlab="latitude",ylab="",bty="l",lab.breaks=levs,breaks=seq(floor(zrange[1]),ceiling(zrange[2]),length.out=121))
contour(vcs$lat,nlev,as.matrix(img),yaxt="n",bty="l",labcex=1,
	method="flattest",vfont =c("sans serif","bold italic"),levels =levs,add=T)
box(bty="l",lwd=2.5)
abline(h= seq(100,900,100),lty=2,col="gray",lwd=0.6)
#abline(v= seq(40,50,2),lty=2,col="gray",lwd=0.6)
abline(v= pretty(vcs$lat),lty=2,col="gray",lwd=0.6)
at<- seq(100,1000,100)
axis(2,at=at,labels=at,las=1)
title(paste0("Vertical Cross Section (",lon1,",",latmin,") - (",lon2,",",latmax,") month=",month))
```

