---
title: R 時系列データのグラフ
date: 2022-04-06
tags: ["R","zoo","xts","ggplot2","matplot","reshape2"]
excerpt: matplot,zoo,xts,ggplot2
---

# R 時系列データのグラフ

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2Ftimeseries01&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

（注意）Rコードのみ（グラフはなし）

### 月次データ

#### 使うデータ：USAccDeaths

```R
USAccDeaths
#       Jan   Feb   Mar   Apr   May   Jun   Jul   Aug   Sep   Oct   Nov   Dec
#1973  9007  8106  8928  9137 10017 10826 11317 10744  9713  9938  9161  8927
#1974  7750  6981  8038  8422  8714  9512 10120  9823  8743  9129  8710  8680
#1975  8162  7306  8124  7870  9387  9556 10093  9620  8285  8466  8160  8034
#1976  7717  7461  7767  7925  8623  8945 10078  9179  8037  8488  7874  8647
#1977  7792  6957  7726  8106  8890  9299 10625  9302  8314  8850  8265  8796
#1978  7836  6892  7791  8192  9115  9434 10484  9827  9110  9070  8633  9240
str(USAccDeaths)
# Time-Series [1:72] from 1973 to 1979: 9007 8106 8928 9137 10017 ...
```

### ts

tickを内側にしてみた

```R
library(Hmisc)
par(mar=c(4,4,2,1),mgp=c(2,0.5,0))
plot(USAccDeaths,xlab="Date",ylab="",yaxt="n",col="brown3",bty="n",lwd=1.5,tck=0.016 )
box(bty="l",lwd=2.5)
axis(2,at=axTicks(2),labels=scales::comma(axTicks(2)),las=1,tck=0.016)
minor.tick(nx=2,ny=2,x.args= list(tck=0.01),y.args = list(tck=0.01))
text(x=par("usr")[1],y=par("usr")[4],labels="（人）",xpd=T,pos=2)
title("USAccDeaths")
```

### zoo

```R
library(zoo)
library(Hmisc)
par(mar=c(4,4,2,1),mgp=c(2,0.5,0))
d<- as.zoo(USAccDeaths)
plot.zoo(d,plot.type="single",xaxt="n",yaxt="n",xlab="Date",ylab="",bty="n",lwd=2,col="brown3") 
box(bty="l",lwd=2.5)
axis(1,at=axTicks(1),tck=0.016)
axis(2,at=axTicks(2),labels=scales::comma(axTicks(2)),las=1,tck=0.016)
minor.tick(nx=2,ny=2,x.args= list(tck=0.01),y.args = list(tck=0.01))
text(x=par("usr")[1],y=par("usr")[4],labels="（人）",xpd=T,pos=2)
title("USAccDeaths",cex.main=1.2)
```

### xts

もっとも簡単だが、関数におまかせ。

```R
library(xts)
d<- as.xts(USAccDeaths)
par(mar=c(4,5,2,1))
plot(d,main="USAccDeaths",yaxis.left =T,yaxis.right =F,col="brown3") 
```

x軸：表示英語にしてみる(ロケールつつくのでご注意！)


```R
# LC_TIMEの設定保存
lctime<- gsub("=","",strsplit(strsplit(Sys.getlocale() ,"LC_TIME")[[1]][2],";")[[1]][1])
# LC_TIMEの設定変更
Sys.setlocale("LC_TIME","C")
d<- as.xts(USAccDeaths)
par(mar=c(4,5,2,1))
plot(d,main="USAccDeaths",yaxis.left =T,yaxis.right =F,col="brown3") 
#ロケールを元に戻す
Sys.setlocale("LC_TIME", lctime)
# Sys.setlocale("LC_TIME", "ja_JP.UTF-8")
# as.xts(USAccDeaths)
```

### ggplot x軸：表示英語にしてみる(ロケールつつくのでご注意！)

```R
library(ggplot2)
library(zoo)
# LC_TIMEの設定保存
lctime<- gsub("=","",strsplit(strsplit(Sys.getlocale() ,"LC_TIME")[[1]][2],";")[[1]][1])
# LC_TIMEの設定変更
Sys.setlocale("LC_TIME","C")
d<- as.zoo(USAccDeaths)
dat <- data.frame(x=factor(as.vector(index(d)),levels=index(d)) , y=coredata(d))
# １月(Jan)の位置
pos <- seq(1,length(dat$x),12) 
#
#ggplot(dat,aes(x=1:length(x),y=y)) + 
ggplot(dat,aes(x=as.numeric(x),y=y)) + 
	geom_line(colour="brown3") +
	theme_bw(14) +
	scale_y_continuous(labels=scales::comma) +
	scale_x_continuous(breaks=pos ,labels=dat$x[pos]) +
	labs(title="USAccDeaths",x="Date",y="")
#
# LC_TIMEのロケールを元に戻す
Sys.setlocale("LC_TIME", lctime)
# Sys.setlocale("LC_TIME", "ja_JP.UTF-8")
# as.xts(USAccDeaths)
```

### 日次データ(線の色はggplotにあわせてみた)

#### 使うデータ：airquality(1973 年5月から9月までのニューヨークの大気状態の観測値)

```R
head(airquality)
#  Ozone Solar.R Wind Temp Month Day
#1    41     190  7.4   67     5   1
#2    36     118  8.0   72     5   2
#3    12     149 12.6   74     5   3
#4    18     313 11.5   62     5   4
#5    NA      NA 14.3   56     5   5
#6    28      NA 14.9   66     5   6
```

### matplot

```R
library(scales)
library(Hmisc)
cols<- hue_pal()(4)
xaxt<- paste0(airquality[,"Month"],"月")
matplot(airquality[,1:4],las=1,type="l",lty=1,lwd=1.5,col=cols,bty="n",xaxt="n",xlab="Date",ylab="")
box(bty="l",lwd=2.5)
at<- which(airquality[,"Day"]==1)
axis(1,at=at,labels=xaxt[at])
minor.tick(nx=F)
legend(x="topright",inset=-0.01,legend=colnames(airquality)[1:4],lwd=1.5,col=cols,title="Air",xpd=T)
title("airquality")
```

### zoo

```R
library(scales)
library(zoo)
library(Hmisc)
cols<- hue_pal()(4)
# zoo形式に変換
dat.zoo <- zoo(airquality[,1:4],seq(as.Date("1973-05-01"),by="day",length.out=nrow(airquality)))
plot(dat.zoo,plot.type="single",las=1,lwd=1.5,col=cols,xlab="Date",ylab="",bty="n")
box(bty="l",lwd=2.5)
minor.tick(nx=F)
legend(x="topright",inset=-0.01,legend=colnames(airquality)[1:4],lwd=1.5,col=cols,title="Air",xpd=T)
title("airquality")
```

### xts

凡例の位置決めがやっかい

```R
library(scales)
library(xts)
d<- as.xts(airquality[,1:4],seq(as.Date("1973-05-01"),by="day",length.out=nrow(airquality)))
plot(d,main="airquality",yaxis.left =T,yaxis.right =F,col=cols) 
legend(x="topright",inset=c(0,0.15),legend=colnames(airquality)[1:4],lwd=1.2,col=cols,title="Air",xpd=T,ncol=2,bg="white")
```

### グリッド線が欲しいならggplot

#### matplot

```R
library(scales)
library(Hmisc)
cols<- hue_pal()(4)
xaxt<- paste0(airquality[,"Month"],"月")
# type="n"で線を引かない
matplot(airquality[,1:4],las=1,type="n",bty="n",xaxt="n",xlab="Date",ylab="")
box(bty="l",lwd=2.5)
abline(h=seq(0,300,50),col="gray80",lwd=0.8)
abline(h=seq(25,350,50),col="gray80",lwd=0.4)
at<- which(airquality[,"Day"]==1)
abline(v=at ,col="gray80",lwd=0.8)
axis(1,at=at,labels=xaxt[at])
minor.tick(nx=F)
# ここで線を引く
matlines(airquality[,1:4], type = "l",col = cols, lwd =1.5,lty = 1)
legend(x="topright",inset=-0.01,bg="white",legend=colnames(airquality)[1:4],lwd=1.5,col=cols,title="Air",xpd=T)
title("airquality")
```

#### zoo

```R
library(scales)
library(zoo)
library(Hmisc)
cols<- hue_pal()(4)
# zoo形式に変換
dat.zoo <- zoo(airquality[,1:4],seq(as.Date("1973-05-01"),by="day",length.out=nrow(airquality)))
# type="n"で線を引かない
plot(dat.zoo,plot.type="single",type="n",las=1,xlab="Date",ylab="",bty="n")
abline(v=seq(as.Date("1973-05-01"),by="month",length=6),col="gray80",lwd=0.8)
abline(h=seq(0,300,50),col="gray80",lwd=0.8)
abline(h=seq(25,350,50),col="gray80",lwd=0.4)
minor.tick(nx=FALSE)
box(bty="l",lwd=2.5)
# ここで線を引く
for (i in 1:ncol(dat.zoo)){
	lines(dat.zoo[,i],col=cols[i],lwd=1.5)
}
legend(x="topright",inset=-0.01,bg="white",legend=colnames(airquality)[1:4],lwd=1.5,col=cols,title="Air",xpd=T)
title("airquality")
```

### ggplot2

#### この方法はあまりおすすめできない

```R
library(ggplot2)
mat<- as.matrix(airquality[,1:4])
rownames(mat)<- paste0(airquality[,"Month"],"/",airquality[,"Day"])
at<- grep("/1$",rownames(mat))
df <- reshape2::melt(mat)
ggplot(df,aes(x=as.numeric(Var1),y=value,colour=Var2)) + 
	geom_line() +
	theme_bw(14) +
	scale_x_continuous(breaks=at ,labels= rownames(mat)[at]) +
	labs(title="airquality",x="Date",y="",colour="Air")	
```

#### この方法がおすすめ

```R
library(ggplot2)
library(zoo)
# zoo形式に変換(indexが欲しい)
dat.zoo <- zoo(airquality[,1:4],seq(as.Date("1973-05-01"),by="day",length.out=nrow(airquality)))
mat<- as.matrix(airquality[,1:4])
# as.characterをつけて一旦文字に変換
rownames(mat)<- as.character(index(dat.zoo))
df <- reshape2::melt(mat)
#
# as.Dateで日付データに戻す
ggplot(df,aes(x=as.Date(Var1),y=value,colour=Var2)) + 
	geom_line() +
	theme_bw(14) +
# scale_x_dateを使う。目盛りは１ヶ月毎表示形式 月/日
	scale_x_date(date_breaks = "1 month",date_labels = "%m/%d") +
	labs(title="airquality",x="Date",y="",colour="Air")	
```
