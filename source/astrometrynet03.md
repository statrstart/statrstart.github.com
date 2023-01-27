---
title: astrometry.netとR その3
date: 2023-01-27
tags: ["R","sf","celestial","showtext","astrometry.net"]
excerpt: 撮影範囲とその周辺
---

# astrometry.netとR その3 撮影範囲とその周辺

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2Fastrometrynet03&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

astrometry.netプログラムを実行して得た wcsファイルから撮影範囲とその周辺の星、星座線の図を書くプログラム。  
図法は、Orthographic (正射方位図法)です。

（使用するデータ）

1. ステラリウムのwesternをもとに作成した星座線データ。線の総数６７６本。  
[constellation_lineJ.csv](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/constellation_lineJ.csv)
- (参照) [astrometry.netとR（番外編：星座線](https://gitpress.io/@statrstart/Constellation01)  
2. [hip_majorJ.csv](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/hip_majorJ.csv)  
- 元データは[Astro Commonsさん](http://astro.starfree.jp/commons/index.html)
- いくつかの名称はネットで検索した。  

### 例1 

#### astrometry.netとR その2で作成したもの

![astro02Y.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/astro02Y.png)

#### 撮影範囲とその周辺の星、星座線の図

![photorange02.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/photorange02.png)

### 例2 

#### astrometry.netとR その2で作成したもの

![astro01YeJ.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/astro01YeJ.png)

#### 撮影範囲とその周辺の星、星座線の図

![photorange01.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/photorange01.png)

### Rコード

#### 準備

- 「使用するデータ」のところで説明した2つのデータをダウンロードしておく。
- 以下のプログラムでは、WCSファイルは作業フォルダ、「使用するデータ」2つは作業フォルダ内のastrometryフォルダにおいている。

##### WCS ファイル

[image001.wcs](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/image001.wcs)  
[image002.wcs](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/image002.wcs)

#### 自作プログラムの定義（３つ）

##### wcsファイルの必要なヘッダー部分だけ取り出す関数

```R
read.wcs=function(file){
	fcon = file(file, "rb")
# 80文字で一つのバラメータ(50あればよいが、10余分にとった)
	ll<-readChar(fcon, 80*60)
	close(fcon)
# 最初のHISTORY以降は削除
	ll<- gsub("HISTORY.*","",ll)
	key = NULL ; value = NULL
	for(i in 1:(nchar(ll)/80)){
		row = substr(ll,((80*(i-1))+1),(80*i))
		k = paste(strsplit(substr(row,1,8)," +")[[1]],collapse="",sep="")
		key = c(key, k) ; value=c(value,row)
	}
# value : /以降削除
	value = gsub("/.*","",value)
# value : =まで(key部分)削除
	value = gsub("^.*=","",value)
# hdr作成(データフレーム)
	hdr = data.frame(key=key,value=value)
	return(hdr)
}
```

##### エリア内にあるデータだけを抽出する関数(sf パッケージが必要)

```R
### R : sf -180 <= RA <= 180
## area内外の判断する。RAは -180<=RA<=180に変換したものを用意しなければならない。
inarea<- function(data,area,RA="RA",Dec="Dec"){
	require(sf)
	# RAは -180<=RA<=180に変換(元のデータは書き換えないこと)
	temp <- data
	temp[temp[,RA]>180,RA] <- temp[temp[,RA]>180,RA]-360
	df<-st_as_sfc(st_as_sf(data.frame(RA=temp[,RA],Dec=temp[,Dec]),coords=c("RA","Dec"),crs=4326))
	# polygon
	s <- st_as_sfc(st_as_binary(st_sfc(st_polygon(list(area))))[[1]] ,crs=4326)
	indata <- st_intersects(df,s,sparse = FALSE)
	# RAは変換前の値をかえす。
	return(data[indata,])
}
```

##### Orthographic (正射方位図法)に変換する関数

```R
# Orthographic (正射方位図法)
ortho<-function(RA,Dec,cenRA,cenDec){
  RA[RA>180]<- RA[RA>180]-360
  cenRA[cenRA>180] <- cenRA[cenRA>180]-360 
  deg2rad     <- pi / 180
  rRA    <- RA * deg2rad
  rDec     <- Dec * deg2rad
  cenrRA <- cenRA * deg2rad
  cenrDec  <- cenDec * deg2rad
  x <- cos(rDec) * sin(rRA - cenrRA)
  y <- cos(cenrDec) * sin(rDec) - sin(cenrDec) * cos(rDec) * cos(rRA - cenrRA)
  p <- sin(cenrDec) * sin(rDec) + cos(cenrDec) * cos(rDec) * cos(rRA-cenrRA) > 0
  return(data.frame(x=x,y=y,p=p))
}
```

#### プロットするwcsファイル名を入力

```R
# プロットするwcsファイル名
wcs<- "image001.wcs"
```

#### 必要なパッケージ（sf,celestial）、wcsファイルの読み込み、撮影範囲の取得

```R
require(sf)
require(celestial)
# wcsファイルを読み込む
hdr<- read.wcs(wcs)
width=as.numeric(hdr[hdr$key=="IMAGEW",2])
height=as.numeric(hdr[hdr$key=="IMAGEH",2])
area<- xy2radec(x=c(0,width,width,0), y=c(0,0,height,height), header=hdr)
area<- rbind(area,area[1,])
```

#### プロットする範囲(レンズの焦点距離によって変える)、星、星座線データの読み込み、座標変換

```R
plotarea<- cbind(c(min(area[1:4,1])-( max(area[1:4,1])-min(area[1:4,1]) )/2,max(area[1:4,1])+( max(area[1:4,1])-min(area[1:4,1]) )/2,
	max(area[1:4,1])+( max(area[1:4,1])-min(area[1:4,1]) )/2,min(area[1:4,1])-( max(area[1:4,1])-min(area[1:4,1]) )/2 ,
	min(area[1:4,1])-( max(area[1:4,1])-min(area[1:4,1]) )/2 ) ,
	c(min(area[1:4,2])-( max(area[1:4,2])-min(area[1:4,2]) )/2 ,min(area[1:4,2])-( max(area[1:4,2])-min(area[1:4,2]) )/2,
	max(area[1:4,2])+( max(area[1:4,2])-min(area[1:4,2]) )/2,max(area[1:4,2])+( max(area[1:4,2])-min(area[1:4,2]) )/2,
	min(area[1:4,2])-( max(area[1:4,2])-min(area[1:4,2]) )/2 ) )
# HIP major プラスアルファ
hip<- read.csv(file = "~/Rwork/astrometry/hip_majorJ.csv", header = T)
hip<- inarea(hip,plotarea)
# 星座線
line<- read.csv(file = "~/Rwork/astrometry/constellation_lineJ.csv", header = T)
line<- unique(rbind(inarea(line,plotarea,RA="RA1",Dec="Dec1"),inarea(line,plotarea,RA="RA2",Dec="Dec2")))
Constellation <- unique(hip$Constellation)
if ("All" %in% Constellation){
	pline<- line
	} else {
	pline<- line[is.element(line$Constellation,Constellation),]
}
# 中心の座標を決める
cenRA=mean(area[1:4,1])
cenDec=mean(area[1:4,2])
# 正射方位図法の座標を計算
xy0=ortho(area[,1],area[,2],cenRA,cenDec)
xy=ortho(hip$RA,hip$Dec,cenRA,cenDec)
xy2_1=ortho(pline$RA1,pline$Dec1,cenRA,cenDec)
xy2_2=ortho(pline$RA2,pline$Dec2,cenRA,cenDec)
xy2=data.frame(x1=xy2_1$x,y1=xy2_1$y,x2=xy2_2$x,y2=xy2_2$y)
```


#### プロット

```R
# png("photorange01.png",width=600,height=600,type ="cairo")
par(bg="gray5", fg="white", col.main="white", col.lab="white", col.axis="white")
par(mar=c(4,5,4,2))
lim=ortho(plotarea[,1],plotarea[,2],cenRA,cenDec)
# 見た目に合わせるために xlim=c(max(lim$x),min(lim$x)) とする。
plot(NA,xlim=c(max(lim$x),min(lim$x)),ylim=c(min(lim$y),max(lim$y)),asp=1,las=1,bty="n",xlab="",ylab="",xaxt="n",yaxt="n")
title("撮影範囲とその周辺")
# 外枠(正射方位図法の座標を計算->線を引く)
# 縦
ppoints <- ortho(rep(min(plotarea[,1]),100),seq(min(plotarea[,2]),max(plotarea[,2]),length=100),cenRA,cenDec )
lines(ppoints$x, ppoints$y,lty=1,lwd=2,col="white",xpd=TRUE)
ppoints <- ortho(rep(max(plotarea[,1]),100),seq(min(plotarea[,2]),max(plotarea[,2]),length=100),cenRA,cenDec )
lines(ppoints$x, ppoints$y,lty=1,lwd=2,col="white",xpd=TRUE)
# 横
ppoints <- ortho(seq(min(plotarea[,1]),max(plotarea[,1]),length=100),rep(min(plotarea[,2]),100),cenRA,cenDec )
lines(ppoints$x, ppoints$y,lty=1,lwd=2,col="white",xpd=TRUE)
ppoints <- ortho(seq(min(plotarea[,1]),max(plotarea[,1]),length=100),rep(max(plotarea[,2]),100),cenRA,cenDec )
lines(x=ppoints$x, y=ppoints$y,lty=1,lwd=2,col="white",xpd=TRUE)
mtext(round(min(plotarea[,1]),4), side = 1, line = 0, outer = FALSE, at =min(lim$x))
mtext(round(max(plotarea[,1]),4), side = 1, line = 0, outer = FALSE, at =max(lim$x))
mtext(round(min(plotarea[,2]),4), side = 2, line = 0, outer = FALSE, at =min(lim$y),las=1)
mtext(round(max(plotarea[,2]),4), side = 2, line = 0, outer = FALSE, at =max(lim$y),las=1)
# 撮影した範囲(赤線で囲む)
lines(x=xy0$x, y=xy0$y,col="red",lwd=2)
# 星
points(xy$x,xy$y,pch=16,cex=1,col="yellow")
hip=cbind(hip,xy)
# 星座線
for (i in 1:nrow(xy2)){
	segments(x0=xy2$x1, y0=xy2$y1, x1 =xy2$x2, y1=xy2$y2, col = "green",lwd=1)
}
# hip.csv PrnがNAではないもの
for(i in 1:nrow(hip)){
	if(!is.na(hip$Prn[i])){
		points(hip$x[i],hip$y[i],pch=21,col="white",bg="yellow",cex=2,xpd=TRUE)
	}
}
for(i in 1:nrow(hip)){
	if(!is.na(hip$Prn[i])){
		text(hip$x[i],hip$y[i],labels=hip$Name[i],pos=1,col="white",cex=1,xpd=TRUE)
	}
}
par(bg="white", fg="black", col.main="black", col.lab="black", col.axis="black")
# dev.off()
```

