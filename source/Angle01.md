---
title: （小ネタ）Ｒで角の弧
date: 2022-12-07
tags: ["R","angle","arc"]
excerpt: Rで作図
---

#（小ネタ）Ｒで角の弧

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FAngle01&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

## Rで作図するときに角に弧を付けたいときがあって関数を作ってみました。

plotrix パッケージにdraw.arcという関数があるんですが応用するには使いにくいんです。(おまけとして一番下にサンプルコード載せときます。)

### 例１: angler関数とanglerL関数

![angle01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/angle01.png)

### 例２: angler90関数

![angle02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/angle02.png)

### 例３: angler関数とangler90関数(直角三角形)

![angle03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/angle03.png)

### 例４：応用

![angle04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/angle04.png)

### Rコード

#### 関数を定義します。

##### angler

```R
angler<- function(POS0=c(0,0),POS1=c(-1,-1),POS2=c(-1,1),n=0.05,lwd=1,col="black"){
#弧の半径を決める
n=n
Rlength<- n*(par("usr")[2]-par("usr")[1])
#弧の角度を求める
z1<- complex(re=POS1[1]-POS0[1],im=POS1[2]-POS0[2])
z2<- complex(re=POS2[1]-POS0[1],im=POS2[2]-POS0[2])
angle1= Arg(z1)
angle2= Arg(z2)
theta<- seq(angle1,angle2,length=100)
#弧を描く(中心はPOS0)
z<- complex(mod=Rlength,arg= theta)
lines(x=Re(z)+POS0[1],y=Im(z)+POS0[2],lwd=lwd,col=col)
}
```

##### anglerL

```R
anglerL<- function(POS0=c(0,0),POS1=c(-1,-1),POS2=c(-1,1),n=0.05,lwd=1,col="black"){
#弧の半径を決める
n=n
Rlength<- n*(par("usr")[2]-par("usr")[1])
#弧の角度を求める
z1<- complex(re=POS1[1]-POS0[1],im=POS1[2]-POS0[2])
z2<- complex(re=POS2[1]-POS0[1],im=POS2[2]-POS0[2])
angle1= Arg(z1)
angle2= Arg(z2)
#theta<- seq(angle1,angle2,length=100)
theta<- seq(-pi,min(angle1,angle2),length=100)
#弧を描く(中心はPOS0)
z<- complex(mod=Rlength,arg= theta)
lines(x=Re(z)+POS0[1],y=Im(z)+POS0[2],lwd=lwd,col=col)
theta<- seq(max(angle1,angle2),pi,length=100)
#弧を描く(中心はPOS0)
z<- complex(mod=Rlength,arg= theta)
lines(x=Re(z)+POS0[1],y=Im(z)+POS0[2],lwd=lwd,col=col)
}
```

##### angler90

```R
angler90<- function(POS0=c(0,0),POS1=c(-1,-1),POS2=c(-1,1),n=0.05,lwd=1,col="black"){
#弧の半径を決める
n=n
Rlength<- n*(par("usr")[2]-par("usr")[1])
#弧の角度を求める
z1<- complex(re=POS1[1]-POS0[1],im=POS1[2]-POS0[2])
z2<- complex(re=POS2[1]-POS0[1],im=POS2[2]-POS0[2])
angle1= Arg(z1)
angle2= Arg(z2)
theta<- seq(angle1,angle2,length=100)
#四角を描く(中心はPOS0)
z<- complex(mod=Rlength,arg=theta)
lines(x=c( Re(z)[1]/sqrt(2) + POS0[1] , Re(z)[length(Re(z))/2] + POS0[1] ,Re(z)[length(Re(z))]/sqrt(2) + POS0[1] ),
      y=c( Im(z)[1]/sqrt(2) + POS0[2] , Im(z)[length(Im(z))/2] + POS0[2] ,Im(z)[length(Im(z))]/sqrt(2) + POS0[2] ) ,lwd=lwd,col=col)
}
```

#### 作図

##### 例１

```R
# png("angle01.png")
plot(1,type="n",axes=F,xlim=c(-0.1,1),ylim=c(-0.1,1),xlab="",ylab="",asp=1)
#点の座標
x0 = c(0,0)
x1 = c(0.7,0.4)
x2 = c(0.4,0.7)
# X0
text(0,0,expression(x[0]),cex=1.5,pos=1)
# X1
arrows(0,0,x1[1],x1[2])
text(0.7,0.4,expression(x[1]),cex=1.5,pos=4)
# X2
arrows(0,0,x2[1],x2[2])
text(0.4,0.7,expression(x[2]),cex=1.5,pos=4)
#
angler(x0,x1,x2,n=0.04,col="Blue",lwd=1)
angler(x0,x1,x2,n=0.05,col="Blue",lwd=1)
#
anglerL(x0,x1,x2,n=0.06,col="red",lwd=1)
# dev.off()
```

##### 例２

直角（直交）かどうかは確認してください。

```R
# png("angle02.png")
plot(1,type="n",axes=F,xlim=c(-0.1,1),ylim=c(-0.5,1),xlab="",ylab="",asp=1)
#点の座標
x0 = c(0,0)
x1 = c(0.7,-0.4)
x2 = c(0.4,0.7)
# X0
text(0,0,expression(x[0]),cex=1.5,pos=1)
# X1
arrows(0,0,x1[1],x1[2])
text(0.7,-0.4,expression(x[1]),cex=1.5,pos=4)
# X2
arrows(0,0,x2[1],x2[2])
text(0.4,0.7,expression(x[2]),cex=1.5,pos=4)
#
# 直角かどうか確認
(x1-x0)%*%(x2-x0)
#     [,1]
#[1,]    0
angler90(x0,x1,x2,n=0.04,col="Blue",lwd=1)
# dev.off()
```

##### 例３

```R
# png("angle03.png")
xlim=c(-1,2) ; ylim=c(-1,2)
plot(x=0,y=0,type="n",xlim=xlim*1.01,ylim=ylim*1.01,xlab="",ylab="",xaxt="n",yaxt="n",bty="n",asp=1)
P=c(-1,0)
A=c(-1,2)
B=c(2,0)
polygon(x=c(P[1],A[1],B[1]),y=c(P[2],A[2],B[2]),border="black")
text(P[1],P[2],"P",pos=2,xpd=T)
text(A[1],A[2],"A",pos=3,xpd=T)
text(B[1],B[2],"B",pos=1,xpd=T)
# 直角かどうか確認
(A-P)%*%(B-P)
#     [,1]
# [1,]    0
angler90(P,A,B,n=0.05,col="red",lwd=2)
#(P-A)%*%(B-A)
angler(A,P,B)
#(P-B)%*%(A-B)
angler(B,P,A,n=0.07,col="blue",lwd=1)
angler(B,P,A,n=0.06,col="blue",lwd=1)
# dev.off()
```

##### 例４

```R
a=1 ; b=1.1
x<-seq(a ,3*a,length=1000)
xlim=c(-1.5*a,2.5*a)
ylim=c(-sqrt(b^2*max(x)^2/a^2 - b^2),sqrt(b^2*max(x)^2/a^2 - b^2))
#png("angle04.png",width=800,height=800)
par(mar=c(0,0,0,0))
plot(x=0,y=0,type="n",xlim=xlim,ylim=ylim,asp=1,xlab="",ylab="",xaxs="i",yaxs="i")
lines(x=x,y= sqrt(b^2*x^2/a^2 - b^2),lwd=3,col="red")
lines(x=x,y= - sqrt(b^2*x^2/a^2 - b^2),lwd=3,col="red")
lines(x= -x,y= sqrt(b^2*x^2/a^2 - b^2),lwd=3,lty=2,col="red")
lines(x= -x,y=- sqrt(b^2*x^2/a^2 - b^2),lwd=3,lty=2,col="red")
# x=0 ; y=0
abline(h=0,col="blue",lty=2)
abline(v=0,col="blue",lty=2)
# 漸近線
abline(0,b/a,col="blue")
abline(0,-b/a,col="blue")
# 衝突係数 = 0
abline((b/a)*sqrt(a^2+b^2),b/a,col="blue",lty=2)
# F , F'
points(x= -sqrt(a^2+b^2) ,y= 0,pch=21,cex=2,bg="red")
text(x= -sqrt(a^2+b^2) ,y= 0,labels="F",pos=2,cex=2.5)
points(x= sqrt(a^2+b^2) ,y= 0,pch=16,cex=2)
text(x= sqrt(a^2+b^2) ,y= 0,labels="F'",pos=4,cex=2.5)
# A ,b
points(x= a ,y= 0,pch=21,cex=2,bg="red")
text(x= a ,y= 0,labels="A",pos=4,cex=2.5)
text(x= - 0.7*(sqrt(a^2/(a^2+b^2) + sqrt(a^2+b^2))) , 0.7*(-sqrt(b^2/(a^2+b^2))),labels="b",cex=1.5,pos=2,offset=0.5)
# O ,l ,l',theta
text(0,0,labels="O",pos=3,cex=2.5,offset=0.8)
text(2*a,(b/a)*2*a,labels="l",pos=3,cex=2.5)
text(2*a,-(b/a)*2*a,labels="l'",pos=1,cex=2.5)
text(0,0,labels=expression(theta),pos=1,offset=3.2,cex=2.5)
text(x= -0.65*sqrt(a^2+b^2) ,y= 0,labels=expression(theta/2),pos=1,offset=0.5,cex=1.5)
text(x=0.8*a ,y=0.7*b,labels=expression(theta/2),pos=1,offset=0.5,cex=1.5)
# 線分
segments(-sqrt(a^2+b^2),0,a,0,lwd=2)
segments(a,0,a,b,lwd=1)
text(a,b,labels="D",pos=3,cex=2.5)
# arrow B
# abline(-(a/b)*sqrt(a^2+b^2),-(a/b),col="blue",lty=2)
arrows(-sqrt(a^2+b^2),0, -sqrt(a^2/(a^2+b^2)),-sqrt(b^2/(a^2+b^2)),lwd=1,length = 0.2)
arrows(-sqrt(a^2/(a^2+b^2)),-sqrt(b^2/(a^2+b^2)),-sqrt(a^2+b^2),0,lwd=1,length = 0.2)
text(-sqrt(a^2/(a^2+b^2)),-sqrt(b^2/(a^2+b^2)),labels="B",pos=1,cex=2.5,offset=0.8)
# 角度
## O(0,0)
P=c(0,0)
P1=c(-sqrt(a^2/(a^2+b^2)),-sqrt(b^2/(a^2+b^2)))
P2=c(sqrt(a^2/(a^2+b^2)),-sqrt(b^2/(a^2+b^2)))
angler(P,P1,P2,n=0.05,col="black",lwd=2)
## D(a,b)
P=c(a,b)
P1=c(0,0)
P2=c(a,0)
angler(P,P1,P2,n=0.05,col="black",lwd=2)
## F(-sqrt(a^2+b^2),0)
P=c(-sqrt(a^2+b^2),0)
P1=c(0,0)
P2=c(-sqrt(a^2/(a^2+b^2)),-sqrt(b^2/(a^2+b^2)))
angler(P,P1,P2,n=0.05,col="black",lwd=2)
## A(a,0)
P=c(a,0)
P1=c(a,b)
P2=c(0,0)
angler90(P,P1,P2,n=0.03,col="black",lwd=2)
## B(-sqrt(a^2+b^2),0)
P=c(-sqrt(a^2/(a^2+b^2)),-sqrt(b^2/(a^2+b^2)))
P1=c(-sqrt(a^2+b^2),0)
P2=c(0,0)
angler90(P,P1,P2,n=0.03,col="black",lwd=2)
#dev.off()
```

#### おまけ：plotrix パッケージdraw.arc

```R
library(plotrix)
# 
plot(1,type="n",axes=F,xlim=c(-0.1,1.2),ylim=c(-0.1,1.2),xlab="",ylab="",asp=1)
#点の座標
x0 = c(0,0)
x1 = c(0.7,0.4)
x2 = c(0.4,0.7)
# X0
text(0,0,expression(x[0]),cex=1.5,pos=1)
# X1
arrows(0,0,x1[1],x1[2])
text(0.7,0.4,expression(x[1]),cex=1.5,pos=4)
# X2
arrows(0,0,x2[1],x2[2])
text(0.4,0.7,expression(x[2]),cex=1.5,pos=4)
#
angle1= Arg(complex(re=0.7,im=0.4))
angle2= Arg(complex(re=0.4,im=0.7))
draw.arc(x=0, y=0, radius = 0.1,angle1=angle1,angle2=angle2)
```
