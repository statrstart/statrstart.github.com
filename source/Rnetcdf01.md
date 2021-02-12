---
title: RでNetCDFファイルを読み込み、カラーコンターマップ作成（１）
date: 2021-02-11
tags: ["R","ncdf4","oce","sf"]
excerpt: Rでカラーコンターマップ(oce package)
---

# RでNetCDFファイルを読み込み、カラーコンターマップ作成（１）

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FRnetcdf01&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

(準備)政治境界線のないFreeの世界地図を（感謝して）入手、oce オブジェクトに変換しておく。  
(Natural Earth : Free vector and raster map data at 1:10m, 1:50m, and 1:110m scales)[https://www.naturalearthdata.com/] の
「ne_50m_coastline.shp」から作成したものを置いておきます。  
[coastlineWorldNew.rda](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/coastlineWorldNew.rda)  

(使用するNetCDF形式のファイル)  

[air.mon.1981-2010.ltm.nc](ftp://ftp.cdc.noaa.gov/Datasets/ncep.reanalysis.derived/pressure/air.mon.1981-2010.ltm.nc)  

(linuxなら)  

```
wget ftp://ftp.cdc.noaa.gov/Datasets/ncep.reanalysis.derived/pressure/air.mon.1981-2010.ltm.nc  
```

#### （別にRを使わないでも）GrADSで作成したカラーコンターマップ(モルワイデ図法)

![GrADSair01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/GrADSair01.png)

#### Ｒで作成したカラーコンターマップ(モルワイデ図法) : グラデーション(内挿なし)

![airR01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/airR01.png)
- 描く範囲が広ければ、グラデーション表示のカラーコンターマップは内挿の必要なし

#### Ｒで作成したカラーコンターマップ(モルワイデ図法)(内挿あり)

![airR02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/airR02.png)
- グラデーション表示でない場合、内挿して格子の数を増やさないときれいに描けない。

#### Ｒで作成したカラーコンターマップ(北極を中心にしたポーラーステレオ) : グラデーション(内挿あり)

![airR03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/airR03.png)

#### Ｒで作成したカラーコンターマップ(北極を中心にしたポーラーステレオ) (内挿あり)

![airR04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/airR04.png)

#### Ｒで作成したカラーコンターマップ(日本周辺：メルカトル図法) : グラデーション(内挿あり)

![airR05](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/airR05.png)

#### Ｒで作成したカラーコンターマップ(日本周辺：ランベルト等角円錐図法) (内挿あり)

![airR06](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/airR06.png)

### Rコード

#### パッケージ、地図データ、NETCDFデータの読み込み。緯度、経度の変換等。

```R
library(ncdf4)
library(oce)
# 政治境界線のない世界地図(ネットからデータを取り込む場合)
load(url("https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/coastlineWorldNew.rda"))
temp.nc <- nc_open("air.mon.1981-2010.ltm.nc")
temp <- ncvar_get(temp.nc, "air")
dim(temp)
# [1] 144  73  17  12 <- 経度(lon), 緯度(lat), 鉛直層(圧力, level), 時間=月の順
lon <- ncvar_get(temp.nc, "lon")
# 東経はそのまま、西経(lon > 180)は 360を引く
lon[lon > 180] <- lon[lon > 180] - 360
# tempのlonを昇順、次にlonを昇順
temp <- temp[order(lon) , , , ] 
lon<- lon[order(lon)]
lat <- ncvar_get(temp.nc, "lat")
# latを逆順、tempのlat（つまり昇順にする）
lat <- rev(lat)
temp <- temp[, ncol(temp):1, , ] 
#
lev <- ncvar_get(temp.nc, "level")
# ２月 Pressure levels　1000
month<- 2
plev<- "1000"
temp11 <- temp[ , ,which(lev==plev),month]
```

#### Ｒで作成したカラーコンターマップ(モルワイデ図法) : グラデーション(内挿なし)

```R
Tlim <- range(temp11)
cutpoints<- seq(ceiling(Tlim[1])-2,floor(Tlim[2]),6)
#
# モルワイデ図法
#png("airR01.png",width=800,height=600)
par(mar=c(5,2,4,2),mai=c(0,0.40,0.80,0.40))
drawPalette(Tlim, col=oce.colorsJet,pos =1,at=cutpoints,labels=cutpoints)
mapPlot(coastlineWorldNew, projection="+proj=moll",type="n",drawBox=F)
mapImage(lon, lat,temp11, col=oce.colorsJet(120), zlim=Tlim)
mapPolygon(coastlineWorldNew,border="black",lwd=0.7)
mapContour(lon, lat, temp11,lwd=0.5,labcex =0.8,levels=cutpoints,underlay="interrupt")
## adding grid
mapGrid(30,30,lty=1,lwd=0.5,col="black")
lablon1 <- rep(-180,5)
lablon2 <- rep(180,5)
lablat <- c(0,30,60,-30,-60)
labels<- c("０°","３０°","６０°","−３０°","−６０°")
mapText(lablon1, lablat, labels, pos=2, offset=0.6,xpd=T)
mapText(lablon2, lablat, labels, pos=4, offset=0.6,xpd=T)
title(paste("Monthly Long Term Mean of Air temperature : level=",plev,"mb (month=",month,")"),cex.main=1.5)
#dev.off()
```

#### 内挿関数作成、カラーパレット作成、内挿
（自作内挿関数）格子の数を縦横２倍にするだけの単純なものです。
- 未定義域、欠損値があると使えない。
-（陸域、海域だけのデータの場合、擬似的に十分大きな値もしくは小さな値を入れて計算、あとでマスクする。）

```R
library(zoo)
library(TTR)
# 欠損値有無確認
all(!is.na(temp11))
# 欠損値の数（FALSEが欠損値）
table(!is.na(temp11)=="TRUE")
# 欠損値があった場合
temp11<- na.approx(temp11)
# 欠損値有無確認
all(!is.na(temp11))
#
head(lon) ; tail(lon)
# -177.5 -175.0 -172.5 -170.0 -167.5 -165.0
# 167.5 170.0 172.5 175.0 177.5 180.0
#
easyinterp<- function(x,y,z){
	if (x[1]== -180){
		x<- c(x[-1],180)
		z<- rbind(z[-1,],z[1,])
	}
	x<- c(-180,x)
	z<- rbind(tail(z,1),z)
	x1<- c(x,SMA(x,2)[-1])
	y1<- c(y,SMA(y,2)[-1])
	z1<- cbind(rbind(z,apply(z,2,SMA,2)[-1,]),t(apply(rbind(z,apply(z,2,SMA,2)[-1,]),1,SMA,2))[,-1])
	z2<- z1[order(x1),order(y1)][-1,]
	x2<- x1[order(x1)][-1]
	y2<- y1[order(y1)]
	return(list(x2,y2,z2))
}
# 1回め約縦横2倍で４倍
interp<- easyinterp(lon,lat,temp11)
# 2回め約縦横2倍で元データからすると、約縦横4倍で１６倍
interp<- easyinterp(interp[[1]],interp[[2]],interp[[3]])
lon1<- interp[[1]] ; lat1<- interp[[2]] ; temp1<- interp[[3]]
# カラーパレットも作成
aircolor <-function (n) {
    if (missing(n) || n <= 0) 
        colorRampPalette(c("blue","cyan", "gray95", "yellow","orange", "red"))
    else {
        colorRampPalette(c("blue","cyan", "gray95", "yellow","orange", "red"))(n)
    }
}
```

#### コンターマップ作成

```R
Tlim <- range(temp1)
cutpoints<- seq(ceiling(Tlim[1])-2,floor(Tlim[2]),6)
# モルワイデ図法
#png("airR02.png",width=800,height=600)
par(mar=c(5,2,4,2),mai=c(0,0.40,0.80,0.40))
drawPalette(Tlim, col=aircolor,pos =1,breaks=cutpoints,at=cutpoints,labels=cutpoints)
mapPlot(coastlineWorldNew, projection="+proj=moll",type="n",drawBox=F)
mapImage(lon1,lat1,temp1, col=aircolor, zlim=Tlim,breaks=cutpoints)
mapPolygon(coastlineWorldNew,border="black",lwd=0.7)
mapContour(lon1, lat1, temp1,lwd=0.5,labcex =1,underlay="interrupt",levels=cutpoints)
## adding grid
mapGrid(30,30,lty=1,lwd=0.5,col="black")
lablon1 <- rep(-180,5)
lablon2 <- rep(180,5)
lablat <- c(0,30,60,-30,-60)
labels<- c("０°","３０°","６０°","−３０°","−６０°")
mapText(lablon1, lablat, labels, pos=2, offset=0.6,xpd=T)
mapText(lablon2, lablat, labels, pos=4, offset=0.6,xpd=T)
title(paste("Monthly Long Term Mean of Air temperature : level=",plev,"mb (month=",month,")"),cex.main=1.5)
#dev.off()
#
#
Tlim <- range(temp1)
cutpoints<- seq(ceiling(Tlim[1])-2,floor(Tlim[2]),6)
#北極を中心にしたポーラーステレオ
#png("airR03.png",width=700,height=600)
par(mar=c(5,2,4,2),mai=c(0.5,0.40,0.80,0.40))
drawPalette(Tlim, col=aircolor,pos =1,at=cutpoints,labels=cutpoints)
mapPlot(coastlineWorldNew, longitudelim=c(-180,180), latitudelim=c(20,90),
        projection="+proj=stere +lat_0=90", type="n",showHemi=F,axes =F)
mapImage(lon1, lat1,temp1, col=aircolor(120), zlim=Tlim,filledContour =T)
mapPolygon(coastlineWorldNew,border="black",lwd=0.7)
mapContour(lon1, lat1, temp1,lwd=1,labcex =0.8,levels=cutpoints)
## adding grid
mapGrid(30,30,lty=1,lwd=0.5,col="black")
title(paste("Monthly Long Term Mean of Air temperature : level=",plev,"mb (month=",month,")"),cex.main=1.5)
lablon1 <- 0
lablat <- 20
labels<- "０°"
mapText(lablon1, lablat, labels, pos=1, offset=1,xpd=T)
#dev.off()
#
#
Tlim <- range(temp1)
cutpoints<- seq(ceiling(Tlim[1])-2,floor(Tlim[2]),6)
#北極を中心にしたポーラーステレオ
#png("airR04.png",width=700,height=600)
par(mar=c(5,2,4,2),mai=c(0.5,0.40,0.80,0.40))
drawPalette(Tlim, col=aircolor,pos =1,breaks=cutpoints,at=cutpoints,labels=cutpoints)
mapPlot(coastlineWorldNew, longitudelim=c(-180,180), latitudelim=c(20,90),
        projection="+proj=stere +lat_0=90", type="n",showHemi=F,axes =F)
mapImage(lon1,lat1,temp1,col=aircolor,zlim=Tlim,filledContour =T,breaks=cutpoints)
mapPolygon(coastlineWorldNew,border="black",lwd=0.7)
mapContour(lon1,lat1,temp1,lwd=1,labcex =0.8,levels=cutpoints)
## adding grid
mapGrid(30,30,lty=1,lwd=0.5,col="black")
title(paste("Monthly Long Term Mean of Air temperature : level=",plev,"mb (month=",month,")"),cex.main=1.5)
lablon1 <- 0
lablat <- 20
labels<- "０°"
mapText(lablon1, lablat, labels, pos=1, offset=1,xpd=T)
#dev.off()
#
#
Tlim <- range(temp1)
cutpoints<- seq(ceiling(Tlim[1])-2,floor(Tlim[2]),6)
## set the extent
lonlim = c(121,150)
latlim = c(21,49)
#png("airR05.png",width=700,height=600)
par(mar=c(2, 2, 1, 1))
## draw scalebar
drawPalette(Tlim,col=aircolor,pos =4,las=1,at=cutpoints,labels=cutpoints)
## make a base
mapPlot(coastlineWorldNew,projection="+proj=merc",type="n",longitudelim=lonlim,latitudelim=latlim)
mapImage(longitude=lon1,latitude=lat1,z=temp1,zlim=Tlim,filledContour=T,col= aircolor(120))
## add polygon
mapPolygon(coastlineWorldNew,border="black",lwd=0.7)
mapContour(lon1,lat1,temp1,lwd=0.8,lty=1,labcex=0.8,levels=cutpoints)
## adding grid
mapGrid(10,10,lty=2,lwd =0.5,col="black")
title(paste("Monthly Long Term Mean of Air temperature : level=",plev,"mb (month=",month,")"),cex.main=1.5)
#dev.off()
#
#
Tlim <- range(temp1)
cutpoints<- seq(ceiling(Tlim[1])-2,floor(Tlim[2]),6)
## set the extent
lonlim = c(121,150)
latlim = c(21,49)
#png("airR06.png",width=700,height=600)
par(mar=c(2, 2, 1, 1))
## draw scalebar
drawPalette(Tlim,col=aircolor,pos =4,las=1,breaks=cutpoints,at=cutpoints,labels=cutpoints)
## make a base
#ランベルト等角円錐図法 [LCC：Lambert Conformal Conic] 
mapPlot(coastlineWorldNew,type="n",projection="+proj=lcc +lat_1=21 +lat_2=48 +lon_0=135",longitudelim=lonlim,latitudelim=latlim)
mapImage(longitude=lon1,latitude=lat1,z=temp1,zlim=Tlim,filledContour=T,col= aircolor,breaks=cutpoints)
## add polygon
mapPolygon(coastlineWorldNew,border="black",lwd=0.7)
mapContour(lon1,lat1,temp1,lwd=0.8,lty=1,labcex=0.8,levels=cutpoints)
## adding grid
mapGrid(10,10,lty=2,lwd =0.5,col="black")
title(paste("Monthly Long Term Mean of Air temperature : level=",plev,"mb (month=",month,")"),cex.main=1.5)
#dev.off()
```
