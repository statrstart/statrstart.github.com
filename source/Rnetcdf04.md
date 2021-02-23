---
title: Rで計算済みNetCDFファイルを読み込み、折れ線グラフ作成（１）
date: 2021-02-23
tags: ["R","ncdf4","cdo","GrADS"]
excerpt: R & cdo
---

# Rで計算済みNetCDFファイルを読み込み、折れ線グラフ作成（１）

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FRnetcdf04&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

今回は、cdo(Climate Data Operatos)を使って領域平均をだし、その結果をRに渡して作図します。

(使用するNetCDF形式のファイル)  

[sst.mnmean.nc](ftp://ftp.cdc.noaa.gov/Datasets/noaa.oisst.v2/sst.mnmean.nc)  

(linuxなら)  

```
wget ftp://ftp.cdc.noaa.gov/Datasets/noaa.oisst.v2/sst.mnmean.nc 
```

エルニーニョ監視海域（5ﾟN～5ﾟS、150～90ﾟW）の月平均海面水温との差をグラフにします。

#### GrADSで作成した折れ線グラフ

![elnino1991_2020](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/elnino1991_2020.png)

#### Ｒで作成した折れ線グラフ(シンプル)

![ElNino02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/ElNino02.png)

#### Ｒで作成した折れ線グラフ(グリッド入れた)

![ElNino01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/ElNino01.png)

#### Ｒで作成した折れ線グラフ(エルニーニョ、ラニーニャの色つけ)
- グラフにした全期間、1991から2020までの月平均からの偏差をとっているので厳密には気象庁の定義には当てはまりません。

![ElNino03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/ElNino03.png)

### Rコード

#### cdo実行(領域平均を計算)

```cdo
cdo fldmean -sellonlatbox,210,270,-5,5 -selyear,1991/2020 sst.mnmean.nc monmean.nc
```

#### cdo出力netcdf読み込み、グラフ作成

```R
library(ncdf4)
elino<- nc_open("monmean.nc")
temp<- ncvar_get(elino,"sst")
time<- ncvar_get(elino, "time")
start<- strsplit(ncatt_get(elino, "time","units")$value," ")[[1]][3]
s_year<- as.numeric(substring(as.Date(start)+time[1],1,4))
e_year<- as.numeric(substring(as.Date(start)+tail(time,1),1,4))
# 30年間分で計算した月平均
mm<- apply(matrix(temp,nrow=12),1,mean)
# 長いオブジェクトの長さ(temp)が短いオブジェクトの長さ(mm)の倍数になっているので、
deviation<- temp-mm	# mmは繰り返してくれる。
# tsオブジェクトに変換して簡単に描く
# png("ElNino02.png",width=800,height=600)
elino.ts<- ts(deviation,start=1991,freq=12)
plot(elino.ts,col="darkgreen",lwd=2,las=1,xlab="",ylab="",bty="l")
box(bty="l",lwd=2.5)
title("El Nino 1991_2020",cex.main=1.5)
# dev.off()
# 
xgrid<- 2 # 年グリッド間隔
# png("ElNino01.png",width=800,height=600)
plot(deviation,type="l",las=1,lwd=2,xlab="",ylab="",bty="l",col="brown3",xaxt="n",panel.first = 
       c(abline(h = seq(-2,4,1), lty = 2, col = 'grey',lwd=c(0.8,0.8,1.2,rep(0.8,4))) ,
        abline(v = seq(1,length(deviation),xgrid*12), lty = 2, col = 'grey',lwd=0.8)))
axis(1,at=seq(1,length(deviation),xgrid*12),labels=seq(s_year,e_year,xgrid))
box(bty="l",lwd=2.5)
title(paste0("El Nino ",s_year,"_",e_year),cex.main=1.5)
# dev.off()
```

```R
xgrid<- 2 # 年グリッド間隔
# png("ElNino03.png",width=800,height=600)
par(mar=c(4,3,4,1))
plot(deviation,type="l",las=1,lwd=2,xlab="",ylab="",bty="l",col="brown3",xaxt="n",panel.first = 
       c(abline(h = seq(-2,4,1), lty = 2, col = 'grey',lwd=c(0.8,0.8,1.2,rep(0.8,4))) ,
        abline(v = seq(1,length(deviation),xgrid*12), lty = 2, col = 'grey',lwd=0.8)))
axis(1,at=seq(1,length(deviation),xgrid*12),labels=seq(s_year,e_year,xgrid))
abline(h = c(-0.5,0.5), lty = 2, col = c("blue","red"),lwd=1)
lines(stats::filter(deviation,rep(1,5))/5,col="royalblue3",lty=2,lwd=2)
box(bty="l",lwd=2.5)
title(paste0("El Nino ",s_year,"_",e_year),cex.main=1.5)
# エルニーニョ、ラニーニャの色つけ
s1<- stats::filter(deviation,rep(1,5))/5
x1<- which(s1 >= 0.5)
points(x1,rep(par("usr")[4]-0.1,length(x1)),pch=15,cex=0.5,col="red")
x2<- which(s1 <= -0.5)
points(x2,rep(par("usr")[3]+0.1,length(x2)),pch=15,cex=0.5,col="blue")
#
i=1
ElNlist<- list()
j=1
xx<- c(x1,0)
while(i<length(xx)){
	ElN<- xx[i]
	while(xx[i]+1 == xx[i+1]) {
		ElN<- c(ElN,xx[i+1])
		i=i+1
	}
	if (length(ElN)>=6){
		ElNlist[[j]]<- ElN
		j=j+1
	}
	i=i+1
}
#
i=1
LaNlist<- list()
j=1
xx<- c(x2,0)
while(i<length(xx)){
	LaN<- xx[i]
	while(xx[i]+1 == xx[i+1]) {
		LaN<- c(LaN,xx[i+1])
		i=i+1
	}
	if (length(LaN)>=6){
		LaNlist[[j]]<- LaN
		j=j+1
	}
	i=i+1
}
#
for (i in 1:length(ElNlist)){
	xx<- unlist(ElNlist[[i]])
	rect(xx[1],par("usr")[3],tail(xx,1),par("usr")[4],col=rgb(1,0,0,0.2), border =rgb(1,0,0,0.3))
}
#
for (i in 1:length(LaNlist)){
	xx<- unlist(LaNlist[[i]])
	rect(xx[1],par("usr")[3],tail(xx,1),par("usr")[4],col=rgb(0,0,1,0.2), border =rgb(0,0,1,0.3))
}
legend("topright",inset=c(0.03,-0.1),legend=c("El Nino","La Nina"),pch=22,col=c(rgb(1,0,0,0.3),rgb(0,0,1,0.3)),
	pt.bg=c(rgb(1,0,0,0.2),rgb(0,0,1,0.2)),pt.cex=1.5,ncol=2,xpd=T)
# dev.off()
```

### GrADSコード

#### GrADS起動

```
grads -l
```

```GrADS
*データの読み込み
sdfopen sst.mnmean.nc
*グラフ背景を白に変更
set display color white
c
*読み込んだファイルの情報
q file
q ctlinfo
*折れ線グラフを描く準備
set x 1
set y 1
*1991年から2020年 30年平均
set time JAN1991 DEC2020
*確認
q dim
*領域平均:エルニーニョ監視海域
a=aave(sst,lon=210,lon=270,lat=-5,lat=5)
*時間平均
*平均期間の起点から1年分の時間を設定．
set time JAN1991 DEC1991
clim=ave(a,t+0, time=DEC2020,1yr)
*modify により気候値climを12か月周期のデータにする
modify clim seasonal
*グラフにする期間の設定
set time JAN1991 DEC2020
*折れ線グラフ線の色等の設定
set gxout line
set cstyle 1
set ccolor 3
set cthick 6
set digsiz 0.1
set cmark 0
*描画
d a-clim
draw title El Nino 1991_2020
*pngで保存
printim elnino1991_2020.png x800 y600 
```

