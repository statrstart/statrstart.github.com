---
title: Rでsin関数のグラフを作成
date: 2023-10-31
tags: ["R", "latex2exp","showtext","pracma"]
excerpt: x軸目盛りをラジアンに
---

# Rでsin関数のグラフを作成

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2Fsin01&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

### pilabelという超ニッチな関数を作った。

pracmaパッケージは最大公約数を求めるgcd関数を使うため。
最大公約数を求める関数はネット上でも見つかるし、他のパッケージにもある。

```R
require(latex2exp)
require(pracma)
pilabel<- function(s,e,by,bottom,u="pi"){ # s:分子(min) , e:分子(max) , by:分子間隔 , bottom:分母 , u:"pi"
	at<- eval(parse(text = paste0("seq(",s,",",e,",",by, ")*",u,"/",bottom ))) 
	top<- eval(parse(text = paste0("seq(",s,",",e,",",by, ")" ))) 
	labels<- NULL
	for (i in as.character(top)){
		x<- strsplit(i,"-")[[1]]
		# 約分
		if (length(x)>1){
		# pracma::gcd <- 最大公約数
			gcd<-gcd(as.numeric(x[2]),bottom)
			top2<- as.numeric(x[2])/gcd
			bottom2<-bottom/gcd
			if (bottom2==1){
				if (top2 != 1){
					labels<- c(labels,paste0("$-",top2,u,"$") )
				} else {
					labels<- c(labels,paste0("$-",u,"$") )
				}
			} else {
				labels<- c(labels,paste0("$-\\frac{",top2,"}{",bottom2,"}",u,"$"))
			}
		} else{
			if (as.numeric(x[1])==0){
				labels<- c(labels,"0")
			} else{
				# pracma::gcd <- 最大公約数
				gcd<-gcd(as.numeric(x[1]),bottom)
				top2<- as.numeric(x[1])/gcd
				bottom2<-bottom/gcd
				if (bottom2==1){
					if (top2 != 1){
						labels<- c(labels,paste0("$",top2,u,"$") )
					} else {
						labels<- c(labels,paste0("$",u,"$") )
					}
				} else {
					labels<- c(labels,paste0("$\\frac{",top2,"}{",bottom2,"}",u,"$"))
				}
			}
		}
	}
	return(data.frame(at,labels))
}
```


フォントはここでは、Computer Modernを使う。

linux なら、

```
sudo apt install fonts-cmu
```

ここ[Computer Modern:https://www.fontsquirrel.com/fonts/computer-modern](https://www.fontsquirrel.com/fonts/computer-modern)でも入手できる。

### pilabelを使わずに書いた

![sincos1.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/sincos1.png)

```R
require("latex2exp")
require(showtext)
xmin<- 0
xmax<- 2*pi
ymin= -1.2
ymax= 1.2
font_add(family = "cmunti", regular = "cmunti.ttf")
showtext_auto()
par(mar=c(3,3,3,1))
plot(NA, xlim=c(xmin,xmax),ylim=c(ymin,ymax),axes=FALSE,xlab="",ylab="",bty="n",las=1,xaxs="i")
axis(2,labels=FALSE,tck= -0.015)
axis(2,tick= FALSE,las=1,line= -0.4,cex.axis=0.8)
curve(sin(x), xmin, xmax,las=1,xaxt="n",col="brown3",lwd=2,bty="n",add=TRUE) 
curve(cos(x), xmin, xmax,las=1,xaxt="n",col="royalblue3",lty=2,lwd=2,bty="n",add=TRUE) 
box(bty="l",lwd=2.5)
legend("topright",legend=c(TeX("$y=sin(theta)$"),TeX("$y=cos(theta)$")),
	inset=c(0.1,-0.05),lty=c(1,2),lwd=2,col=c("brown3","royalblue3"),cex=0.8,xpd=TRUE)
xaxt<- data.frame(at=c(1/2*pi,3/2*pi),labels=c("$\\frac{1}{2}pi$","$\\frac{3}{2}pi$"))
axis(1,at=xaxt$at,labels=FALSE,tck=-0.015)
for(i in 1:nrow(xaxt)){
	axis(1,at=xaxt$at[i],labels=TeX(xaxt$labels[i]),tick=FALSE,cex.axis=0.8,line=0.6)
}
xaxt<- data.frame(at=c(0,pi,2*pi),labels=c("0","$pi$","$2pi$"))
axis(1,at=xaxt$at,labels=FALSE,tck=-0.015)
for(i in 1:nrow(xaxt)){
	axis(1,at=xaxt$at[i],labels=TeX(xaxt$labels[i]),tick=FALSE,cex.axis=0.8,line=0) 
}
showtext_auto(FALSE)
```

### pilabelを使って書く

#### 1

![sincos2.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/sincos2.png)

```R
require("latex2exp")
require(showtext)
# 分母を揃えておいた
xmin<- 0/6	# s=0 , bottom=6
xmax<- 12/6*pi	# e=12 ,byはここでは、1にする。
ymin= -1.2
ymax= 1.2
xaxt<- pilabel(s=0,e=12,by=1,bottom=6)
font_add(family = "cmunti", regular = "cmunti.ttf")
showtext_auto()
par(mar=c(3,3,3,1))
plot(NA, xlim=c(xmin,xmax),ylim=c(ymin,ymax),axes=FALSE,xlab="",ylab="",bty="n",las=1,xaxs="i")
axis(2,labels=FALSE,tck= -0.015)
axis(2,tick= FALSE,las=1,line= -0.4,cex.axis=0.8)
curve(sin(x), xmin, xmax,las=1,xaxt="n",col="brown3",lwd=2,bty="n",add=TRUE) 
curve(cos(x), xmin, xmax,las=1,xaxt="n",col="royalblue3",lty=2,lwd=2,bty="n",add=TRUE) 
box(bty="l",lwd=2.5)
legend("topright",legend=c(TeX("$y=sin(theta)$"),TeX("$y=cos(theta)$")),
	inset=c(0.1,-0.05),lty=c(1,2),lwd=2,col=c("brown3","royalblue3"),cex=0.8,xpd=TRUE)
axis(1,at=xaxt$at,labels=FALSE,tck=-0.015)
for (i in 1:nrow(xaxt)){
	ifelse(grepl("frac",xaxt$labels[i]) ,
		axis(1,at=xaxt$at[i],labels=TeX(xaxt$labels[i]),tick=FALSE,cex.axis=0.8,line=0.6) ,
		axis(1,at=xaxt$at[i],labels=TeX(xaxt$labels[i]),tick=FALSE,cex.axis=0.8,line=0)  )
}
showtext_auto(FALSE)
```

#### 2

![sincos3.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/sincos3.png)

```R
xmin<- -3/4*pi-0.2	# 目盛りは、-2/4*piから始めたいので s=-2
xmax<- 8/4*pi+0.2	# e=8 , byは1/2*pi 刻みにしたいので 2 にする
ymin= -1.5
ymax= 1.5
xaxt<- pilabel(s=-2,e=8,by=2,bottom=4)
require(showtext)
font_add(family = "cmunti", regular = "cmunti.ttf")
showtext_auto()
#cairo_pdf("out_cairo.pdf", width=4.5, height=3,family="cmunti")
par(mar=c(0,1,2,1.5))
plot(NA, xlim=c(xmin,xmax),ylim=c(ymin,ymax),axes=FALSE,xlab="",ylab="",bty="n",asp=1)
arrows(x0=xmin-0.3, y0=0, x1=xmax+0.3, y1=0,lwd=1,angle=20,length=0.08,xpd=TRUE)
arrows(x0=0,y0=ymin,x1=0,y1=ymax,lwd=1,angle=20,length=0.08,xpd=TRUE)
curve(sin(x), xmin, xmax,las=1,xaxt="n",col="brown3",lwd=1.5,bty="n",add=TRUE) 
curve(cos(x), xmin, xmax,las=1,xaxt="n",col="royalblue3",lty=2,lwd=1.5,bty="n",add=TRUE) 
legend("topright",legend=c(TeX("$y=sin(theta)$"),TeX("$y=cos(theta)$")),lty=c(1,2),
	cex=0.8,lwd=1.5,col=c("brown3","royalblue3"),xpd=TRUE)
text(x=0,y=0,labels="0",adj=c(-0.5,1.2),cex=1)
text(x=c(0,0),y=c(-1,1),labels=c(-1,1) ,pos=2,cex=1,offset=0.1 )
text(x=0,y=ymax,labels="y",pos=2,cex=1,xpd=TRUE)
text(x=xmax+0.3,y=0,labels=TeX("$\\theta$"),pos=1,cex=1,xpd=TRUE)
#
text(x=xaxt[1 ,1],y=0,labels=TeX(xaxt[1 ,2]),pos=3,cex=0.8)
text(x=xaxt[3 ,1],y=0,labels=TeX(xaxt[3 ,2]),pos=1,cex=0.8)
text(x=xaxt[4 ,1],y=0,labels=TeX(xaxt[4 ,2]),pos=3,cex=0.8)
text(x=xaxt[5 ,1],y=0,labels=TeX(xaxt[5 ,2]),pos=3,cex=0.8)
text(x=xaxt[6 ,1],y=0,labels=TeX(xaxt[6 ,2]),pos=1,cex=0.8)
segments(x0=xaxt[1 ,1],y=0,x1=xaxt[1 ,1] ,y1=-1,lty=2,col="brown3")
segments(x0=xaxt[3 ,1],y=0,x1=xaxt[3 ,1] ,y1=1,lty=2,col="brown3")
segments(x0=xaxt[5 ,1],y=0,x1=xaxt[5 ,1] ,y1=-1,lty=2,col="brown3")
segments(x0=xaxt[4 ,1],y=0,x1=xaxt[4 ,1] ,y1=-1,lty=2,col="royalblue3")
segments(x0=xaxt[6 ,1],y=0,x1=xaxt[6 ,1] ,y1=1,lty=2,col="royalblue3")
showtext_auto(FALSE)
# dev.off()
```


