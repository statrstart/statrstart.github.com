---
title: 都道府県別検査陽性者数と死亡者数(新型コロナウイルス：Coronavirus)
date: 2022-08-14
tags: ["R","NipponMap","Coronavirus","新型コロナウイルス"]
excerpt: NHKのデータ
---

# 都道府県別検査陽性者数と死亡者数(新型コロナウイルス：Coronavirus)

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus18&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

> 2022/06/28 発表  
> 大阪市保健所管内において、1～３月の死亡が新たに９２件(1月：1件,2月：56件,3月：35件)判明した。  
> 6月(6/28)分がその分増えている。

(参考)  
[Rでグラフを描くときにY軸のタイトルを縦書きにする](https://id.fnshr.info/2017/03/13/r-plot-tategaki/)  
- tategaki 関数(簡潔でスッキリとした関数)を参考にさせてもらいました。

(昔（2015年）書いた記事)  
[統計ソフトRの備忘録２:縦書き帯グラフ棒グラフ](https://statrstart.github.io/2015/05/02/%E7%B8%A6%E6%9B%B8%E3%81%8D%E5%B8%AF%E3%82%B0%E3%83%A9%E3%83%95%E6%A3%92%E3%82%B0%E3%83%A9%E3%83%95/)

(使用するデータ)  2000/3/6より人口データ変更   
[NHK:新型コロナ データ](https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv)  
人口データ：[住民基本台帳に基づく人口、人口動態及び世帯数令和3年1月1日現在](https://www.soumu.go.jp/main_sosiki/jichi_gyousei/daityo/jinkou_jinkoudoutai-setaisuu.html)        

### いくつかのグラフはggplotで作成してみた。(2000/3/6より)

#### 都道府県別の感染者数 [ データ：ＮＨＫ ]

![nhkC01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/nhkC01.png)

#### 都道府県別の人口１００人あたり感染者数 [ データ：ＮＨＫ ]（降順）

![nhkC02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/nhkC02.png)

#### 都道府県別の死亡者数 [ データ：ＮＨＫ ]（降順）

![nhkC03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/nhkC031.png)

#### 都道府県別の人口１万人あたり死亡者数 [ データ：ＮＨＫ ]（降順）

![nhkC04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/nhkC04.png)

#### 都道府県別の致死率(%) [ データ：ＮＨＫ ]（降順）

![nhkC05](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/nhkC05.png)

#### 死亡者数の多い地域 : 新型コロナウイルス 死亡者数の推移(データ：NHK 新型コロナ データ)

- ggplotで作成してみた。(2000/3/6より)

![covOvsT02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOvsT02.png)

#### 人口あたりの死亡者数の多い地域 : 新型コロナウイルス 人口1万人あたりの死亡者数(データ：NHK 新型コロナ データ)

- ggplotで作成してみた。(2000/3/6より)

![covOvsT01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOvsT01.png)

##### 月別死者数と月別人口１００万人あたりの死者数（データ：NHK）
北海道(約550万人)、埼玉(約719万人)、東京(約1316万人)、神奈川(約905万人)、愛知(約741万人)、大阪(約886万人)、兵庫(約559万人)

![covOsaka12](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka12.png)

#### 東北の累計感染者数の推移 [ データ：ＮＨＫ ]

![covTohoku.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covTohoku.png)

#### 中国地方の累計感染者数の推移 [ データ：ＮＨＫ ]

![covChu.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covChu.png)

#### 近畿地方の累計感染者数の推移 [ データ：ＮＨＫ ]

![covkinki.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covkinki.png)

### Rコード

#### パッケージ読み込み、データ読み込み

```R
library(xts)
library(sf)
library(NipponMap)
#
nhkC<- read.csv("https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv")
#
# 都道府県別人口
#shp <- system.file("shapes/jpn.shp", package = "NipponMap")[1]
#m <- sf::read_sf(shp)
zinkou<- c(5228732,1260067,1221205,2282106,971604,1070017,1862777,2907678,1955402,1958185,7393849,6322897,13843525,9220245,2213353,1047713,
	1132656,774596,821094,2072219,2016868,3686335,7558872,1800756,1418886,2530609,8839532,5523627,1344952,944750,556959,672979,
	1893874,2812477,1356144,735070,973922,1356343,701531,5124259,818251,1336023,1758815,1141784,1087372,1617850,1485484)
```

#### 棒グラフ

```R
library(ggplot2)
library(scales)
library(latex2exp)
# latex2exp_supported()
library(ggrepel)
options(scipen=100) 
# ggplotで作図しやすくするため　１）項目にDate型追加　２）都道府県名のlevelsを県コード順にする
nhkC$date<- as.Date(nhkC$"日付")
nhkC$都道府県名<- factor(nhkC$都道府県名,levels=as.character(unique(nhkC$都道府県名)))
#
# 最新のデータのみ（棒グラフ用）
bpdata<- nhkC[nhkC$date==max(nhkC$date),]
bpdata$致死率<- round(bpdata$各地の死者数_累計/bpdata$各地の感染者数_累計*100,2)
for(i in unique(bpdata$都道府県コード)){
	match<- which(is.element(bpdata$都道府県コード,i))
	bpdata$人口当たり感染者数[match]<-round(bpdata[match,"各地の感染者数_累計"]*100/zinkou[i],2)
	bpdata$人口当たり死者数[match]<-round(bpdata[match,"各地の死者数_累計"]*10000/zinkou[i],2)
}
# 都道府県名縦書き
for (i in 1:47){
	bpdata$tate[i]<- sapply(strsplit(split="",as.character(bpdata$都道府県名)[i]), paste, collapse="\n")
}
#
# tateのlevelsを県コード順にする
bpdata$tate<- factor(bpdata$tate,levels=bpdata$tate[order(bpdata$都道府県コード)])
#
# 棒グラフの色を決める
bpdata$color<- rep("royalblue3",47)
#大阪府の色変更
bpdata$color[27]<- "brown3" 
#東京都と愛知県の色変更
bpdata$color[c(13,23)]<- "orange" 
#
# 棒グラフ作成
# 感染者数累計
g <- ggplot(bpdata, aes(x = tate, y = 各地の感染者数_累計)) 
g <- g + geom_bar(stat = "identity",fill=bpdata$color,colour=bpdata$color)
g <- g + labs(title="都道府県別の感染者数 [ データ：ＮＨＫ ]",x="",y="")
g <- g + scale_y_continuous(expand = c(0,0), limits = c(0,max(bpdata$"各地の感染者数_累計")*1.1),labels=comma,
			breaks=seq(200000,2000000,200000),minor_breaks=seq(100000,2100000,200000))
g <- g + theme(axis.text=element_text(colour = "black"),panel.grid.major.x = element_blank())
g
# ggsave("nhkC01.png",g,width=8,height=6,dpi=150)
#
# １００人当たり感染者数
g <- ggplot(bpdata, aes(x = reorder(tate, -人口当たり感染者数), y = 人口当たり感染者数)) 
g <- g + geom_bar(stat = "identity",fill=bpdata$color,colour=bpdata$color)
g <- g + theme_bw()
#g <- g + scale_x_discrete(limits = bpdata$tate)
g <- g + labs(title="都道府県別の人口１００人当たり感染者数 [ データ：ＮＨＫ ]",x="",y="")
g <- g + scale_y_continuous(expand = c(0,0), limits = c(0,max(bpdata$"人口当たり感染者数")*1.1),breaks=1:20)
g <- g + theme(axis.text=element_text(colour = "black"),panel.grid.major.x = element_blank())
g
# ggsave("nhkC02.png",g,width=8,height=6,dpi=150)
#
# 各地の死者数_累計
g <- ggplot(bpdata, aes(x = tate, y = 各地の死者数_累計)) 
g <- g + geom_bar(stat = "identity",fill=bpdata$color,colour=bpdata$color)
g <- g + theme_linedraw()
g <- g + labs(title="都道府県別の死亡者数(累計) [ データ：ＮＨＫ ] ",x="",y="")
g <- g + scale_y_continuous(expand = c(0,0), limits = c(0,max(bpdata$"各地の死者数_累計")*1.1),labels=comma)
g <- g + theme(panel.border = element_blank(), axis.line = element_line(),
		axis.text=element_text(colour = "black"),panel.grid.major.x = element_blank())
g
# ggsave("nhkC03.png",g,width=8,height=6,dpi=150)
#
# 人口１万人当たり死者数
g <- ggplot(bpdata, aes(x = reorder(tate, -人口当たり死者数), y = 人口当たり死者数)) 
g <- g + geom_bar(stat = "identity",fill=bpdata$color,colour=bpdata$color)
g <- g + theme_bw()
g <- g + labs(title="都道府県別の人口１万人当たり死亡者数 [ データ：ＮＨＫ ]",x="",y="")
g <- g + scale_y_continuous(expand = c(0,0), limits = c(0,max(bpdata$"人口当たり死者数")*1.1),labels=comma)
g <- g + theme(panel.border = element_blank(), axis.line = element_line(),
		axis.text=element_text(colour = "black"),panel.grid.major.x = element_blank())
g
# ggsave("nhkC04.png",g,width=8,height=6,dpi=150)
#
# 致死率
g <- ggplot(bpdata, aes(x = tate,y = 致死率)) 
g <- g + geom_bar(stat = "identity",fill=bpdata$color,colour=bpdata$color)
g <- g + labs(title="都道府県別の致死率（％） [ データ：ＮＨＫ ]",x="",y="")
g <- g + scale_y_continuous(expand = c(0,0), limits = c(0,max(bpdata$"致死率")*1.1),breaks=seq(0,2,0.2))
g <- g + theme(panel.border = element_blank(), axis.line = element_line(),
		axis.text=element_text(colour = "black"),panel.grid.major.x = element_blank())
g
# ggsave("nhkC05.png",g,width=8,height=6,dpi=150)
#
# 致死率 barplot関数でグリッド付き棒グラフを作成する場合
# グリッド付き棒グラフ定義(beside=Tのみ)
barplot2 <- function(height,xaxt="s",yaxt="s",col=NULL,border=NULL,xlab=NULL,ylab=NULL,grid=NULL,subgrid=NULL){
			b=barplot(height,xaxt="n",yaxt="n",xlab=xlab,ylab=ylab,names.arg=NA,col=0,border=0,xaxs="i",yaxs="i",ylim=c(0,max(height,na.rm=1)*1.1),beside=T)
			# グリッド線を引く
			abline(h=grid,lty=1,col="gray90",lwd=1.5)
			abline(h=subgrid,lty=1,col="gray90",lwd=0.8)
			# add=Tで重ね書き
			barplot(height,col=col,border=border,las=1,xaxs="i",yaxs="i",ylim=c(0,max(height,na.rm=1)*1.1),xaxt=xaxt,yaxt=yaxt,xlab="",ylab="",beside=T,add=T)
			box(bty="l",lwd=2)
			return(b)
}
# png("nhkC05.png",width=800,height=600)
par(mar=c(5,4,4,2),family="serif")
b<- barplot2(bpdata$致死率,col=bpdata$color,xaxt="n",yaxt="n",grid=seq(0.1,2,0.1))
box(bty="l",lwd=2)
axis(2,at=seq(0,2,0.2),labels=as.character(c(0,seq(0.2,2,0.2))),las=1)
text(x=b,y=0,labels=bpdata$tate,pos=1,offset=1,xpd=T)
#text(x=b,y=bpdata$致死率,labels=round(bpdata$致死率,1),pos=3)
title("都道府県別の致死率（％） [ データ：ＮＨＫ ]",cex.main=1.5)
# dev.off()
```

#### 各地の死者数(累計)

```R
n<- bpdata$都道府県コード[bpdata$各地の死者数_累計>=1000]
data<- nhkC[which(is.element(nhkC$都道府県コード,n)),c("date","都道府県名","各地の死者数_累計")]
unique(data$都道府県名)
#
#data<- nhkC[grep("(東京都|大阪府|北海道|神奈川県|兵庫県|愛知県|埼玉県|千葉県)",nhkC$都道府県名),
#	c("date","都道府県名","各地の死者数_累計")]
#
#凡例の表示順を降順にするため都道府県名のlevelsを変更する
sortlist<- data[data$date==max(data$date),]
data$都道府県名<- factor(data$都道府県名,levels= rev(as.character(sortlist[order(sortlist[,"各地の死者数_累計"]),"都道府県名"])))
#
g <- ggplot(data, aes(x = date, y = 各地の死者数_累計,color = 都道府県名)) 
g <- g + geom_line()
g <- g + theme_linedraw()
g <- g + labs(title=TeX("各地の死者数(累計)：累計死者数 \\geq 1,000人"),x="",y="")
# Dateクラスのベクトルを使って目盛位置を指定。
datebreaks <- seq(as.Date("2020-01-01"), Sys.Date(), by="2 month")
g <- g + scale_x_date(breaks =datebreaks,date_labels="%Y/%m")	# breaks
#g <- g + scale_x_date(date_breaks ="2 months",date_labels="%Y/%m")	# date_breaks
g <- g + scale_y_continuous(labels=comma)
g <- g + theme(
		panel.border = element_blank(), axis.line = element_line(),axis.text=element_text(colour = "black"),
		legend.position=c(0.03,0.97),legend.justification=c(0,1),
		legend.background = element_rect(fill = "white", colour = "black")
	)
# nudge_xでプロット位置をずらす
g <- g +  geom_text(data = subset(data,date == max(date)),aes(label =都道府県名),nudge_x =50)
g
# ggsave("covOvsT02.png",g,width=8,height=6,dpi=150)
```

#### 人口１万人あたりの死者数(累計)

```R
n<- bpdata$都道府県コード[bpdata$人口当たり死者数>=1]
data<- nhkC[which(is.element(nhkC$都道府県コード,n)),c("date","都道府県コード","都道府県名","各地の死者数_累計")]
unique(data$都道府県名)
# 人口１万人あたりの死者数の推移を計算(処理（１行毎）が遅いので書き換えた)
#for(i in 1:nrow(data)){
#	data$perP[i]<-round(data[i,"各地の死者数_累計"]*10000/zinkou[data[i,"都道府県コード"]],2)
#}
# 人口１万人あたりの死者数の推移を計算
code<- unique(data$都道府県コード)
for(i in code){
	match<- which(is.element(data$都道府県コード,i))
	data$perP[match]<-round(data[match,"各地の死者数_累計"]*10000/zinkou[i],2)
}
#凡例の表示順を降順にするため都道府県名のlevelsを変更する
sortlist<- data[data$date==max(data$date),]
data$都道府県名<- factor(data$都道府県名,levels= rev(as.character(sortlist[order(sortlist[,"perP"]),"都道府県名"])))
#
g <- ggplot(data, aes(x = date, y = perP,color = 都道府県名)) 
g <- g + geom_line()
g <- g + theme_linedraw()
g <- g + labs(title="人口１万人あたりの死者数(累計)",x="",y="")
#g <- g + scale_y_continuous()
g <- g + theme(
		panel.border = element_blank(), axis.line = element_line(),axis.text=element_text(colour = "black"),
		legend.position=c(0.03,0.97),legend.justification=c(0,1),
		legend.background = element_rect(fill = "white", colour = "black")
	)
# nudge_xでプロット位置をずらす
g <- g +  geom_text(data = subset(data,date == max(date)),aes(label =都道府県名),nudge_x =20)
# Dateクラスのベクトルを使って目盛位置を指定。
datebreaks <- seq(as.Date("2020-01-01"), Sys.Date(), by="2 month")
g <- g + scale_x_date(breaks =datebreaks,date_labels="%Y/%m")	# breaks
g
#
# ggrepel::geom_text_repel を使う
g <- ggplot(data, aes(x = date, y = perP,color = 都道府県名)) 
g <- g + geom_line()
g <- g + theme_linedraw()
g <- g + labs(title=TeX("人口１万人あたりの死者数(累計)：人口１万人あたりの死者数 \\geq 1人"),x="",y="")
g <- g + theme(
		panel.border = element_blank(), axis.line = element_line(),axis.text=element_text(colour = "black"),
		legend.position=c(0.03,0.97),legend.justification=c(0,1),
		legend.background = element_rect(fill = "white", colour = "black")
	) +
     guides(color=guide_legend(ncol=3))
g <- g + geom_text_repel(data = subset(data,date== max(date)),aes(label = 都道府県名),
		nudge_x=100,
#		segment.curvature = 1e-20,
		segment.linetype = 1,
		segment.colour =rgb(0,0,0,alpha=0.5),
		segment.size= 0.3,
		arrow = arrow(length = unit(0.015, "npc"))) + 
# "npc","cm","inches" ,type="closed"
	lims(x = c(min(data$date), max(data$date)+100)) 
# Dateクラスのベクトルを使って目盛位置を指定。(geom_text_repelとの相性が悪いので使わない)
# datebreaks <- seq(as.Date("2020-01-01"), Sys.Date(), by="4 month")
# g <- g + scale_x_date(breaks =datebreaks,date_labels="%Y/%m")	# breaks
g
# ggsave("covOvsT01.png",g,width=8,height=6,dpi=150)
```

#### 東北の累計感染者数

```R
code<- 2:7
#感染者数累計
# 
Cdata<- nhkC[nhkC$都道府県コード==code[1],c(1,5)]
Cdata.xts<- as.xts(read.zoo(Cdata, format="%Y/%m/%d"))
# 
for (i in code[-1]){
	Cdata<- nhkC[nhkC$都道府県コード== i,c(1,5)]
	tmp.xts<- as.xts(read.zoo(Cdata, format="%Y/%m/%d"))
	Cdata.xts<- merge(Cdata.xts,tmp.xts)
}
# NA<- 0
coredata(Cdata.xts)[is.na(Cdata.xts)]<- 0
colnames(Cdata.xts)<- unique(nhkC[nhkC$都道府県コード==code,"都道府県名"])
#
#plot(Cdata.xts)
labels<- sub("-","/",sub("-0","-",sub("^0","",sub("^....-","",index(Cdata.xts)))))
data<- coredata(Cdata.xts)
# 毎月1日
labelpos<- paste0(1:12,"/",1)
#png("covTohoku.png",width=800,height=600)
par(mar=c(5,4,5,9),family="serif")
matplot(data,type="l",lty=1,col=rainbow(length(code),alpha=0.8),lwd=1.5,las=1,bty="n",xlab="",ylab="",xaxt="n",xaxs="i")
box(bty="l",lwd=2.5)
for (i in labelpos){
	at<- which(labels== i)
	axis(1,at=at,labels = rep(paste0(sub("/1","",i),"月"),length(at)),tck= -0.02)	
	}
text(x=par("usr")[1],y=par("usr")[4],labels="(人)",pos=2,xpd=T)
text(x=par("usr")[2],y=tail(data,1),labels=paste0(colnames(data),":",tail(data,1),"人"),xpd=T,pos=4)
mtext(text="2020年",at=1,side=1,line=2.5,cex=1.2) 
mtext(text="2021年",at=352,side=1,line=2.5,cex=1.2) 
title("累計感染者数(東北)")
# dev.off()
```

#### 感染者2000人未満

```R
code<- 1:47
#感染者数累計
# 
Cdata<- nhkC[nhkC$都道府県コード==code[1],c(1,5)]
Cdata.xts<- as.xts(read.zoo(Cdata, format="%Y/%m/%d"))
# 
for (i in code[-1]){
	Cdata<- nhkC[nhkC$都道府県コード== i,c(1,5)]
	tmp.xts<- as.xts(read.zoo(Cdata, format="%Y/%m/%d"))
	Cdata.xts<- merge(Cdata.xts,tmp.xts)
}
# NA<- 0
coredata(Cdata.xts)[is.na(Cdata.xts)]<- 0
colnames(Cdata.xts)<- unique(nhkC[nhkC$都道府県コード==code,"都道府県コード"])
data<- coredata(tail(Cdata.xts,1))
#data[data<2000]
code<- colnames(data)[data<2000]
# 
Cdata<- nhkC[nhkC$都道府県コード==code[1],c(1,5)]
Cdata.xts<- as.xts(read.zoo(Cdata, format="%Y/%m/%d"))
# 
for (i in code[-1]){
	Cdata<- nhkC[nhkC$都道府県コード== i,c(1,5)]
	tmp.xts<- as.xts(read.zoo(Cdata, format="%Y/%m/%d"))
	Cdata.xts<- merge(Cdata.xts,tmp.xts)
}
# NA<- 0
coredata(Cdata.xts)[is.na(Cdata.xts)]<- 0
colnames(Cdata.xts)<- unique(nhkC[nhkC$都道府県コード==code,"都道府県名"])
#
#plot(Cdata.xts)
labels<- sub("-","/",sub("-0","-",sub("^0","",sub("^....-","",index(Cdata.xts)))))
data<- coredata(Cdata.xts)
data<- data[,order(-tail(data,1))]
# 毎月1日
labelpos<- paste0(1:12,"/",1)
# png("covU2000.png",width=800,height=600)
par(mar=c(5,4,5,9),family="serif")
matplot(data,type="l",lty=1,col=rainbow(length(code),alpha=0.8),lwd=2,las=1,bty="n",xlab="",ylab="",xaxt="n",xaxs="i")
box(bty="l",lwd=2.5)
for (i in labelpos){
	at<- which(labels== i)
	axis(1,at=at,labels = rep(paste0(sub("/1","",i),"月"),length(at)),tck= -0.02)	
	}
text(x=par("usr")[1],y=par("usr")[4],labels="(人)",pos=3,xpd=T)
text(x=par("usr")[2],y=tail(data,1),labels=colnames(data),xpd=T,pos=4)
mtext(text="2020年",at=1,side=1,line=2.5,cex=1.2) 
mtext(text="2021年",at=352,side=1,line=2.5,cex=1.2) 
legend("topleft",inset=0.03,legend=paste0(colnames(data)," : ",tail(data,1),"人"),lty=1,col=rainbow(length(code),alpha=0.8),lwd=2)
title("累計感染者数推移(累計感染者数2000人未満)")
# dev.off()
```

