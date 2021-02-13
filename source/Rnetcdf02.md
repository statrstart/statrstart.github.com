---
title: RでNetCDFファイルを読み込み、カラーコンターマップ作成（2）
date: 2021-02-13
tags: ["R","cdo","GrADS","ncdf4","oce","sf"]
excerpt: Rでカラーコンターマップ(oce package)
---

# RでNetCDFファイルを読み込み、カラーコンターマップ作成（2）

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FRnetcdf02&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

> 今回は、cdo(Climate Data Operatos)であらかじめデータの経度変換、内挿、levelの選択を行い、それをＲに取り込みます。

(準備)政治境界線のないFreeの世界地図を入手、oce オブジェクトに変換しておく。  
(Natural Earth : Free vector and raster map data at 1:10m, 1:50m, and 1:110m scales)[https://www.naturalearthdata.com/] の
「ne_50m_coastline.shp」から作成したものを置いておきます。  
[coastlineWorldNew.rda](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/coastlineWorldNew.rda)  

(使用するデータ)

```
wget -P ./GrADS ftp://ftp.cdc.noaa.gov/Datasets/ncep.reanalysis.derived/pressure/air.mon.1981-2010.ltm.nc
wget -P ./GrADS ftp://ftp.cdc.noaa.gov/Datasets/ncep.reanalysis.derived/pressure/uwnd.mon.1981-2010.ltm.nc
wget -P ./GrADS ftp://ftp.cdc.noaa.gov/Datasets/ncep.reanalysis.derived/pressure/vwnd.mon.1981-2010.ltm.nc
```

#### GrADSで作成したカラーコンターマップ

![GrADSair02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/GrADSair02.png)

#### GrADSで作成したカラーコンターマップ(日本周辺)

![GrADSair03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/GrADSair03.png)

### cdoを使い、風データ(uwnd , vwnd)のマージ、経度変換を行います。

```cdo
# u,v をひとつのファイルにまとめる
cdo merge uwnd.mon.1981-2010.ltm.nc vwnd.mon.1981-2010.ltm.nc temp.nc
# 経度 : 0_360を-180_180に変換
cdo -sellonlatbox,-180,180,-90,90 temp.nc wind.mon.1981-2010.ltm.nc
```

### 風データ：level=1000だけを抽出

```cdo
cdo -sellevel,1000 wind.mon.1981-2010.ltm.nc wind1000.nc
```

### airデータはlevel=1000だけを抽出->内挿->経度変換の順で行います。
- "You have to select the region after the interpolation."
- 経度変換->内挿の順だと地図に横線が何本も入りました。

```cdo
cdo sellonlatbox,-180,180,-90,90 -sellevel,1000 -remapbil,r576x290 air.mon.1981-2010.ltm.nc temp1000.nc
```

#### Ｒで作成したカラーコンターマップ

![airwindmon2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/airwindmon2.png)


#### Ｒで作成したカラーコンターマップ(日本周辺)

![Jairwindmon2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Jairwindmon2.png)

### Rコード

#### cdo出力netcdf読み込み、コンターマップ作成

```R
library(ncdf4)
library(oce)
# 政治境界線のない世界地図(ネットからデータを取り込む場合)
load(url("https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/coastlineWorldNew.rda"))
#カラーパレット作成
aircolor <-function (n) {
    if (missing(n) || n <= 0) 
        colorRampPalette(c("blue","cyan", "white", "yellow","orange", "red"))
    else {
        colorRampPalette(c("blue","cyan", "white", "yellow","orange", "red"))(n)
    }
}
temp.nc <- nc_open("/home/aki/GrADS/temp1000.nc")
temp0 <- ncvar_get(temp.nc, "air")
dim(temp0)
#[1] 144  73  12
min(temp0)
#[1] -45.90232
max(temp0)
#[1] 41.616
lon <- ncvar_get(temp.nc, "lon")
lat <- ncvar_get(temp.nc, "lat")
nc_close(temp.nc)
#
wind.nc <- nc_open("/home/aki/GrADS/wind1000.nc")
u <- ncvar_get(wind.nc, "uwnd")
v <- ncvar_get(wind.nc, "vwnd")
wlon <- ncvar_get(wind.nc, "lon")
wlat <- ncvar_get(wind.nc, "lat")
nc_close(wind.nc)
#
#month
#for (month in 1:12){
month<- 2
temp<- temp0[ , ,month]
#all(!is.na(temp))
#
#Tlim <- range(temp)
Tlim <- range(temp0)
cutpoints<- seq(ceiling(Tlim[1])-2,floor(Tlim[2]),6)
#
# 正距円筒図法
#png(paste0("airwindmon",month,".png"),width=800,height=600)
par(mar=c(5,2,4,2),mai=c(0,0.40,0.80,0.40))
drawPalette(Tlim, col=aircolor,pos =1,breaks=cutpoints,at=cutpoints,labels=cutpoints)
mapPlot(coastlineWorldNew,projection="+proj=eqc",type="n",drawBox=F)
mapImage(lon, lat,temp, col=aircolor, zlim=Tlim,breaks=cutpoints)
mapPolygon(coastlineWorldNew,border="black",lwd=0.7)
mapContour(lon, lat, temp,lwd=1,labcex =0.8,levels=cutpoints) # underlay="interrupt",
## adding grid
mapGrid(30,30,lty=1,lwd=0.5,col="black")
lablon1 <- rep(-180,7)
lablon2 <- rep(180,7)
lablat <- c(0,30,60,90,-30,-60,-90)
labels<- c("０°","３０°","６０°","９０°","−３０°","−６０°","−９０°")
mapText(lablon1, lablat, labels, pos=2, offset=0.6,xpd=T)
mapText(lablon2, lablat, labels, pos=4, offset=0.6,xpd=T)
lablat1 <- rep(-90,5)
lablat2 <- rep(90,5)
lablon <- c(0,60,120,-120,-60)
labels<- c("０°","６０°","１２０°","−１２０°","−６０°")
mapText(lablon, lablat1, labels, pos=1, offset=0.6,xpd=T)
mapText(lablon, lablat2, labels, pos=3, offset=0.6,xpd=T)
title(paste0("Monthly Long Term Mean of Air temperature : level=1000mb ( month=",month,"）"),cex.main=1.5)
# 風
Shrink<- 0.7
skip1<- 5
skip2<- 3
xxx<- seq(5,dim(u)[1],skip1)
yyy<- seq(5,dim(u)[2],skip2)
plon<- wlon[xxx]
plat<- wlat[yyy]
w<- data.frame(lon=rep(plon,length(plat)),lat=rep(plat,each=length(plon)) ,u=as.vector(u[xxx,yyy,month]),v=as.vector(v[xxx,yyy,month]))
mapArrows(longitude0=w$lon-w$u*Shrink, latitude0=w$lat-w$v*Shrink, 
			longitude1=w$lon,latitude1 =w$lat,length = 0.05, angle = 20, code = 2)
#dev.off()
#}
```

#### 日本周辺のコンターマップ作成

```R
Tlim <- range(temp0)
cutpoints<- seq(ceiling(Tlim[1])-2,floor(Tlim[2]),6)
## set the extent
lonlim = c(121,150)
latlim = c(21,49)
# 正距円筒図法
#png(paste0("Jairwindmon",month,".png"),width=700,height=600)
par(mar=c(2, 2, 4, 1))
## draw scalebar
drawPalette(Tlim,col=aircolor,pos =4,las=1,breaks=cutpoints,at=cutpoints,labels=cutpoints)
## make a base
mapPlot(coastlineWorldNew,projection="+proj=eqc",type="n",longitudelim=lonlim,latitudelim=latlim)
mapImage(longitude=lon,latitude=lat,z=temp,zlim=Tlim,filledContour=T,col= aircolor,breaks=cutpoints)
## add polygon
mapPolygon(coastlineWorldNew,border="black",lwd=0.7)
mapContour(lon,lat,temp,lwd=0.8,lty=1,labcex=0.8,levels=cutpoints)
## adding grid
mapGrid(10,10,lty=2,lwd =0.5,col="black")
title(paste("Monthly Long Term Mean of Air temperature : level=1000mb (month=",month,")"),cex.main=1.5)
#
Shrink<- 0.3
skip1<- 2
skip2<- 2
xxx<- seq(5,dim(u)[1],skip1)
yyy<- seq(5,dim(u)[2],skip2)
plon<- wlon[xxx]
plat<- wlat[yyy]
w<- data.frame(lon=rep(plon,length(plat)),lat=rep(plat,each=length(plon)) ,u=as.vector(u[xxx,yyy,month]),v=as.vector(v[xxx,yyy,month]))
mapArrows(longitude0=w$lon-w$u*Shrink, latitude0=w$lat-w$v*Shrink, 
			longitude1=w$lon,latitude1 =w$lat,length = 0.05, angle = 30, code = 2)
#dev.off()
```

### GrADSコード

#### GrADS起動

```
grads -l
```

```GrADS
*データの読み込み
sdfopen air.mon.1981-2010.ltm.nc
* 風のデータも読み込む
sdfopen uwnd.mon.1981-2010.ltm.nc
sdfopen vwnd.mon.1981-2010.ltm.nc
*グラフ背景を白に変更
set display color white
c
*カラーパターンを変更
run rgbset2.gs
c
*読み込んだファイルの情報
q file
q ctlinfo
q ctlinfo 2
q ctlinfo 3
* ２月、level=2
set t 2
set lev 1000
*モルワイデ図法
*set mproj mollweide
*ロビンソン図法
*set mproj robinson
*メルカトル図法
set mproj latlon
*中心位置
set lon -180 180
set gxout shaded 
*等値線間隔の設定
set cint 6
*グリッド
set xlint 30
set ylint 30
d air
set gxout contour   *デフォルト
*等値線間隔の設定
set cint 6
d air
*カラーバーを描く
cbarn.gs
draw title Monthly Long Term Mean of Air temperature Feb 1000mb
*線の色
set ccolor 1
* .2 : ２番めのファイルの意味 .3は３番目のファイル
* 風データ間引き、描画
d skip(uwnd.2,5,3);vwnd.3
*画面に表示されている図をpngファイルに保存する
printim GrADSair02.png x800 y600 
c
* 日本周辺、カラーコンターマップ（Lambert conformal conic projection）
set mproj lambert
set lon 121 150
set lat 21 50
set t 2
set lev 1000
set mpdset hires
* 政治境界を描かない
set poli off
set cint 3
set gxout shaded 
d air
set gxout contour
set cint 3 
d air
*カラーバーを描く
cbarn.gs
draw title Monthly Long Term Mean of Air temperature Feb 1000mb
*線の色
set ccolor 1
* .2 : ２番めのファイルの意味 .3は３番目のファイル
* 風データ描画
d uwnd.2;vwnd.3
*画面に表示されている図をpngファイルに保存する
printim GrADSair03.png x800 y600 
```

