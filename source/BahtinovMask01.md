---
title: Rでカメラレンズのバーティノフ・マスク（更新）
date: 2022-11-12
tags: ["R","BahtinovMask","svg"]
excerpt: 透明なシートに印刷
---

# Rでカメラレンズのバーティノフ・マスク

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FBahtinovMask01&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

##（参考）  
「カメラレンズ バーティノフ・マスク 自作」で検索したサイト。

## （注意）「透明なシートに印刷」して使うバーティノフ・マスクを作るための簡単なプログラムです。

### BahtinovMaskのsvgファイル

#### 外円と内円間 塗り潰しなし

[BahtinovMask.svg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/BahtinovMask.svg)

#### 外円と内円間 塗り潰しあり(1)

[BahtinovMask1.svg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/BahtinovMask1.svg)

#### 間隔を広げた（b=4）塗り潰しなし

[BahtinovMask2.svg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/BahtinovMask2.svg)

#### 間隔を広げた（b=4）塗り潰しあり(2)

[BahtinovMask3.svg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/BahtinovMask3.svg)

#### 間隔を広げた （b=4）マスク線太く(line1=line2=1.8*b) 塗り潰しあり(3)

[BahtinovMask4.svg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/BahtinovMask4.svg)

なお、Gimpで以下のように処理すると  

1. 塗り潰しありのSVGファイルを幅、高さを拡大した大きさ（例えば1000px）で読み込む。
2. フィルター -> 輪郭抽出
3. 色 -> 階調の反転
4. ファイル -> 名前を付けてエクスポート(例えば、BahtinovMask4.png)
5. 画像 -> 画像の拡大、縮小 で元のサイズに直す
6. ファイル -> BahtinovMask4.pngに再エクスポート

![BahtinovMask4.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/BahtinovMask4.png)

となる。

#### Maskulatorでシミュレート

#### (1)BahtinovMask1

![BahtinovMask1.jpg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/BahtinovMask1.jpg)

D=38mm F=135mm Brightness=0.5

![Maskulator1.jpg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Maskulator1.jpg)

#### (2)BahtinovMask3

![BahtinovMask3.jpg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/BahtinovMask3.jpg)

D=38mm F=135mm Brightness=0.5

![Maskulator3.jpg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Maskulator3.jpg)

#### (3)BahtinovMask4

![BahtinovMask4.jpg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/BahtinovMask4.jpg)

D=38mm F=135mm Brightness=0.375(隙間が少ない分減らした)

![Maskulator4.jpg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Maskulator4.jpg)

### Rコード

#### （注意）
- 直径58mm[半径29mm]のレンズにあわせたつもりです。（外円直径は80mm[半径40mm]）
- 線の太さは何ミリかは不明。（ggplotを使うとできるかもしれませんが面倒くさいのでやりません。）
- いくつか作図してみて「Gimp」(ツール->定規)で確認したところ、line2は 1.25*b を目安に調整するのがいいみたいです。

```R
# 外円半径
R<- 40
# 内円半径
r=29
# 間隔
b=0.75
# 角度
theta=pi/6 # 30°
a=tan(theta)
# 仕切り線(横と斜め)
line0<- 3.75*b
# 仕切り線(2つ斜め)
line1<- 1.25*b
# マスクの線(1.25*b)
line2<- 1.25*b
# 円上の点の数を決める数
rl<- 100
# 副鏡の円の半径(カメラレンズは0)
RR<- 0
# 外円と円との間の塗りつぶし(塗りつぶさない場合は0、それ以外は塗りつぶす)
pa<- 0
#
################################################################################
# svgで保存する場合は svg(....) と dev.off() の前のコメントアウト# を消す。 #
################################################################################
# svgで保存
#svg(file="BahtinovMask%02d.svg", width=2*R/25.4, height=2*R/25.4)
par(mar = rep(0,4))
plot(x=c(-R,R),y=c(-R,R),asp=1,type="n",xaxt="n",yaxt="n",xlab="",ylab="",bty="n",yaxs="i",xaxs="i")
h=unique(c(seq(0,r,b),seq(0,-r,-b)))
z<-complex(mod=r,arg=seq(-pi,pi,length=length(h)*rl))
#lines(x=Re(z),y=Im(z),xpd=T,lwd=1)
# 仕切り線
segments(x0=0, y0=-r, x1 =0, y1=r,lwd=line0)
segments(x0=0, y0=0, x1 =-r, y1=0,lwd=line1)
# 横線
hh=unique(c(seq(b/2,r,b),seq(-b/2,-r,-b)))
z1<- asin(hh/r)
segments(x0=rep(0,length(z1)), y0=hh, x1 =r*cos(z1), y1=hh,lwd=line2)
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
lines(x=Re(Z),y=Im(Z),xpd=T,lwd=1,xpd=T)
if (pa != 0){
	for (i in 1:(length(z)-1)){
		polygon(x=c(Re(Z[i]),Re(z[i]),Re(Z[i+1]),Re(z[i+1]),Re(Z[i])),y=c(Im(Z[i]),Im(z[i]),Im(Z[i+1]),Im(z[i+1]),Im(Z[i])),col=1,xpd=T)
	}
	polygon(x=c(Re(Z[length(z)]),Re(z[length(z)]),Re(Z[1])),y=c(Im(Z[length(z)]),Im(z[length(z)]),Im(Z[1])),col=1,xpd=T)
}
# 副鏡の円を塗りつぶす
ZZ<-complex(mod=RR,arg=seq(-pi,pi,length=length(h)*rl))
polygon(x=c(Re(ZZ),Re(ZZ[1])),y=c(Im(ZZ),Im(ZZ[1])),col=1)
#
text(x=par("usr")[2]*0.82,y=par("usr")[3]*0.83,labels=paste0(R*2," ; ",r*2,"\n",b," ; ",theta*(180/pi),"\n",round(line0,2)," : ",round(line1,2),"\n",round(line2,2)),cex=0.5)
# dev.off()
```
