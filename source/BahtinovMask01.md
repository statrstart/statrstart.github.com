---
title: Rでカメラレンズのバーティノフ・マスク
date: 2022-11-09
tags: ["R","BahtinovMask","svg"]
excerpt: 透明なシートに印刷
---

# Rでカメラレンズのバーティノフ・マスク

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FBahtinovMask01&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

### BahtinovMask.svg

[BahtinovMask.svg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/BahtinovMask.svg)

### Rコード

#### （注意）

- 直径58mm[半径29mm]のレンズにあわせたつもりです。（外枠は80mm[半径40mm]）
- 線の太さは何ミリかは不明。（ggplotを使うとできるかもしれませんが面倒くさいのでやりません。）

```R
# 外枠の半径
R<- 40
# 半径
r=29
# 間隔
b=0.8
# 角度
theta=pi/6 # 30°
a=tan(theta)
# 仕切り線（相対値）
line1<- 2
# マスクの線
line2<- 1.5（相対値）
# 円上の点の数を決める数（レンズの径が大きい場合は増やす）
rl<- 20
# 副鏡の円の半径(カメラレンズは0)
RR<- 0
#
# svg関数のwidth,heightはインチで指定します。ミリをインチに変換。
#svg(file="BahtinovMask.svg", width=2*R/25.4, height=2*R/25.4)
par(mar = rep(0,4))
plot(x=c(-R,R),y=c(-R,R),asp=1,type="n",xaxt="n",yaxt="n",xlab="",ylab="",bty="n",yaxs="i",xaxs="i")
h=unique(c(seq(0,r,b),seq(0,-r,-b)))
z<-complex(mod=r,arg=seq(-pi,pi,length=length(h)*rl))
lines(x=Re(z),y=Im(z),xpd=T,lwd=1)
# 仕切り線
segments(x0=0, y0=-r, x1 =0, y1=r,lwd=line1)
segments(x0=0, y0=0, x1 =-r, y1=0,lwd=line1)
# 横線
z1<- asin(h/r)
segments(x0=rep(0,length(z1)), y0=h, x1 =r*cos(z1), y1=h,lwd=line2)
# 斜めの線(連立方程式の解)
x1<- (-2*a*h-sqrt(4*a^2*h^2-4*(1+a^2)*(h^2-r^2)))/(2*(1+a^2))
y1<- a*(-2*a*h-sqrt(4*a^2*h^2-4*(1+a^2)*(h^2-r^2)))/(2*(1+a^2)) +h
x2<- (-2*a*h+sqrt(4*a^2*h^2-4*(1+a^2)*(h^2-r^2)))/(2*(1+a^2))
y2<- a*(-2*a*h+sqrt(4*a^2*h^2-4*(1+a^2)*(h^2-r^2)))/(2*(1+a^2)) +h
#
for (i in 1:length(h)){
if (h[i]<=0){
	segments(x0=0, y0=h[i], x1 =x1[i], y1=y1[i],lwd=line2)
	}
if (h[i]<=0 & y2[i]>=0){
	segments(x0= h[i]/a, y0=0, x1= -x2[i], y1=y2[i],lwd=line2)
	}

if (h[i]>0){
	segments(x0=0, y0=h[i], x1 = -x2[i], y1=y2[i],lwd=line2)
	}


if (h[i]>0 & y1[i]<=0){
	segments(x0= -h[i]/a, y0=0, x1= x1[i], y1=y1[i],lwd=line2)
	}
}
# 外枠と円との間を塗りつぶす
Z<-complex(mod=R,arg=seq(-pi,pi,length=length(h)*rl))
lines(x=Re(Z),y=Im(Z),xpd=T,lwd=1)
for (i in 1:(length(z)-1)){
	polygon(x=c(Re(Z[i]),Re(z[i]),Re(Z[i+1]),Re(z[i+1]),Re(Z[i])),y=c(Im(Z[i]),Im(z[i]),Im(Z[i+1]),Im(z[i+1]),Im(Z[i])),col=1,xpd=T)
}
polygon(x=c(Re(Z[length(z)]),Re(z[length(z)]),Re(Z[1])),y=c(Im(Z[length(z)]),Im(z[length(z)]),Im(Z[1])),col=1,xpd=T)
# 副鏡の円を塗りつぶす
ZZ<-complex(mod=RR,arg=seq(-pi,pi,length=length(h)*rl))
polygon(x=c(Re(ZZ),Re(ZZ[1])),y=c(Im(ZZ),Im(ZZ[1])),col=1)
# dev.off()
```
