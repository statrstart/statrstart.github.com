---
title: RでIMFの世界経済見通し(WEO)データを扱う(その２)
date: 2023-05-15
tags: ["R", "ggplot2","cowplot","scales"]
excerpt: 名目GPDのグラフ
---

# RでIMFの世界経済見通し(WEO)データを扱う(その２)

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FIMF_WEO02&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

(データ)  

[mitsuoxv/imf-weo](https://github.com/mitsuoxv/imf-weo)　data -> data_2304.rda

(参考)

[長期経済統計から見た21世紀の世界経済 : 1950～2100年の長期展望と経済・社会の課題](https://www.jstage.jst.go.jp/article/peq/51/1/51_KJ00009847643/_pdf/-char/ja)

### 世界の名目GDPの推移: (単位: 10億ドル) と (購買力平価換算)

![imfweo01_1.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/imfweo01_1.png)

### G7のGDP/世界全体GDP　BRICsのGDP 対世界GDP比: (単位: 10億ドル) と (購買力平価換算)

（注意）G7、BRICsの国で、lastactualdateを調べると、 FranceとRussiaは、2021。他の国は、2022。

![imfweo01_2.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/imfweo01_2.png)

### G7、BRICs 各国GDP: (単位: 10億ドル) と (購買力平価換算)

（注意）G7、BRICsの国で、lastactualdateを調べると、 FranceとRussiaは、2021。他の国は、2022。

![imfweo01_3.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/imfweo01_3.png)

### G7、BRICs 各国一人当たりGDP: (単位: 1ドル) と (購買力平価換算)

（注意）G7、BRICsの国で、lastactualdateを調べると、 

- 2022: Germany, Canada,  China

- 2021: United States, France, Italy, Japan, Russia 

- 2020: United Kingdom, Brazil

- 2013: India

![imfweo01_4.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/imfweo01_4.png)

### Rコード

#### パッケージとデータの読み込み

```R
require(ggplot2)
require(cowplot)
require(scales)
#
load("data_2304.rda")
#load("data_2304lite.rda")
#data_2304 <- data_2304lite
#
url="https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/"
source(paste0(url,"WEOcountry.R"))
# これでデータが読み込まれる。
head(WEOcountry)
#ダウンロードした場合
#source("WEOcountry.R")
# 他のことにも使えるようにWEO(IMF)コードのないデータもあるので、
# 今回は、WEO(IMF)コードが欠損しているデータを取り除く
WEOcountry <- WEOcountry[!is.na(WEOcountry$WEO) , ]  
```

#### データの抽出

```R
# GDP: data_2304$concept=="NGDPD"
ngdpd<-data_2304[data_2304$concept=="NGDPD",c("ref_area","year","value","scale","lastactualdate")]
# 単位: ngdpd$scale== 1e+09 <--- 10億ドル
# scaleは削除
ngdpd<- ngdpd[,c("ref_area","year","value","lastactualdate")]
# GDP: data_2304$concept=="PPPGDP"
PPPGDP<-data_2304[data_2304$concept=="PPPGDP",c("ref_area","year","value","scale","lastactualdate")]
# 単位: PPPGDP$scale== 1e+09 <--- 10億ドル
# scaleは削除
PPPGDP<- PPPGDP[,c("ref_area","year","value","lastactualdate")]
#
# NGDPDの国データを抽出、WEOcountryとマージ
ngdpdC<-merge(ngdpd,WEOcountry,by.x="ref_area",by.y="WEO")
#
# PPPGDPの国データを抽出、WEOcountryとマージ
PPPGDPC<-merge(PPPGDP,WEOcountry,by.x="ref_area",by.y="WEO")
#
# 一人当たりGDP(ドル): data_2304$concept=="NGDPDPC"
NGDPDPC<-data_2304[data_2304$concept=="NGDPDPC",c("ref_area","year","value","scale","lastactualdate")]
# 単位: all(NGDPDPC$scale== 1)   1ドル
# scaleは削除
NGDPDPC<- NGDPDPC[,c("ref_area","year","value","lastactualdate")]
# 一人当たりGDP (購買力平価換算): data_2304$concept=="PPPPC"
PPPPC<-data_2304[data_2304$concept=="PPPPC",c("ref_area","year","value","scale","lastactualdate")]
# scaleは削除
PPPPC<- PPPPC[,c("ref_area","year","value","lastactualdate")]
# NGDPDPCの国データを抽出、WEOcountryとマージ
NGDPDPC_C<-merge(NGDPDPC,WEOcountry,by.x="ref_area",by.y="WEO")
#
# PPPPCの国データを抽出、WEOcountryとマージ
PPPPC_C<-merge(PPPPC,WEOcountry,by.x="ref_area",by.y="WEO")
```

#### 世界の名目GDPの推移: (単位: 10億ドル) と (購買力平価換算)

```R
# 世界全体GDP
world<- ngdpd[ngdpd$ref_area=="001",]
g1<- ggplot(world,aes(x=year,y=value))+
	geom_line()+
	labs(x=NULL,y=NULL,title="世界の名目GDP(単位: 10億ドル)の推移") +
	scale_y_continuous(labels = comma)+
	theme_cowplot(14) 
# 世界全体GDP
world<- PPPGDP[PPPGDP$ref_area=="001",]
g2<- ggplot(world,aes(x=year,y=value))+
	geom_line()+
	ylab("名目GDP(購買力平価換算)") +
	labs(x=NULL,y=NULL,title="世界の名目GDP(購買力平価換算)の推移") +
	scale_y_continuous(labels = comma)+
	theme_cowplot(14) 
g <- plot_grid(g1, g2, labels="auto", align="h") 
ggsave("imfweo01_1.png", width = 16, height = 8)
```

#### G7のGDP/世界全体GDP　BRICsのGDP 対世界GDP比: (単位: 10億ドル) と (購買力平価換算)

```R
# G7GDP/世界全体GDP
world<- ngdpd[ngdpd$ref_area=="001",]
g7<- ngdpd[ngdpd$ref_area=="119",]
# yearの一致を確認
all(g7$year==world$year)
g7<- data.frame(Group="G7",year=g7$year,p=g7$value/world$value)  
# BRICsGDP/世界全体GDP
BRICs<-ngdpdC[grep("BRA|RUS|IND|CHN",ngdpdC$iso3c),]
# year別に足し合わせる
x<- aggregate(BRICs$value,list(BRICs$year),sum,na.rm=TRUE)
colnames(x)<- c("year","value")
all(world$year==x$year)
brics<-data.frame(Group="BRICs",year=x$year,p=x$value/world$value) 
#
per=rbind(g7,brics)
per$Group=factor(per$Group,levels=c("G7","BRICs"))
#
g1<- ggplot(per,aes(x=year,y=p,color=Group)) +
	geom_line(linewidth=1.5)+
	labs(x=NULL,y=NULL,title="名目GDP 対世界比(U.S ドル)") +
	scale_y_continuous(labels = percent)+
	theme_cowplot(14) +
	scale_color_manual(values = c( "#339900","#ff9900")) +
	theme(
	    legend.position = c(.98, .98),
	    legend.justification = c("right", "top"),
	    legend.box.just = "right",
	    legend.margin = margin(6,6,6,6)
	)

# G7GDP/世界全体GDP(購買力平価換算)
world<- PPPGDP[PPPGDP$ref_area=="001",]
g7<- PPPGDP[PPPGDP$ref_area=="119",]
# yearの一致を確認
all(g7$year==world$year)
g7<- data.frame(Group="G7",year=g7$year,p=g7$value/world$value)  
# BRICsGDP/世界全体GDP(購買力平価換算)
BRICs<-PPPGDPC[grep("BRA|RUS|IND|CHN",PPPGDPC$iso3c),]
# year別に足し合わせる
x<- aggregate(BRICs$value,list(BRICs$year),sum,na.rm=TRUE)
colnames(x)<- c("year","value")
all(world$year==x$year)
brics<-data.frame(Group="BRICs",year=x$year,p=x$value/world$value) 
#
per=rbind(g7,brics)
per$Group=factor(per$Group,levels=c("BRICs","G7"))
#
g2<- ggplot(per,aes(x=year,y=p,color=Group)) +
	geom_line(linewidth=1.5)+
	labs(x=NULL,y=NULL,title="名目GDP 対世界比(購買力平価換算)") +
	scale_y_continuous(labels = percent)+
	theme_cowplot(14) +
	scale_color_manual(values = c("#ff9900", "#339900")) +
	theme(
	    legend.position = c(.98, .98),
	    legend.justification = c("right", "top"),
	    legend.box.just = "right",
	    legend.margin = margin(6,6,6,6)
	)

g <- plot_grid(g1, g2, labels="auto", align="h") 
ggsave("imfweo01_2.png", width = 16, height = 8)
```

#### G7、BRICs 各国GDP: (単位: 10億ドル) と (購買力平価換算)

```R
G7BRICs<-ngdpdC[grep("CAN|JPN|USA|FRA|ITA|GBR|DEU|BRA|RUS|IND|CHN",ngdpdC$iso3c),]
id<- G7BRICs[G7BRICs$year=="2028",c("Name","value")]
G7BRICs$Name<- factor(G7BRICs$Name,levels=id[order(-id$value),]$Name)
g1<- ggplot(G7BRICs,aes(x=year,y=value,color=Name))+
	geom_line()+
	labs(x=NULL,y=NULL,title="G7, BRICs: 名目GDP(単位: 10億ドル)",color="Country") +
	scale_y_continuous(labels = comma)+
	theme_cowplot(14) +
	theme(
	    legend.position = c(.02, .98),
	    legend.justification = c("left", "top"),
	    legend.box.just = "left",
	    legend.margin = margin(6,6,6,6)
	    )
#table(G7BRICs$lastactualdate)
#2021 2022 
#  98  441
#unique(G7BRICs[G7BRICs$lastactualdate==2021,"Name"])
# [1] France Russia
#
G7BRICs<-PPPGDPC[grep("CAN|JPN|USA|FRA|ITA|GBR|DEU|BRA|RUS|IND|CHN",PPPGDPC$iso3c),]
id<- G7BRICs[G7BRICs$year=="2028",c("Name","value")]
G7BRICs$Name<- factor(G7BRICs$Name,levels=id[order(-id$value),]$Name)
g2<-ggplot(G7BRICs,aes(x=year,y=value,color=Name))+
	geom_line()+
	labs(x=NULL,y=NULL,title="G7, BRICs: 名目GDP(購買力平価換算)",color="Country") +
	scale_y_continuous(labels = comma)+
	theme_cowplot(14) +
	theme(
	    legend.position = c(.02, .98),
	    legend.justification = c("left", "top"),
	    legend.box.just = "left",
	    legend.margin = margin(6,6,6,6)
	    )
#unique(G7BRICs[G7BRICs$lastactualdate==2021,"Name"])
#[1] France Russia

g <- plot_grid(g1, g2, labels="auto", align="h") 
ggsave("imfweo01_3.png", width = 16, height = 8)
```

#### G7、BRICs 各国一人当たりGDP: (単位: 1ドル) と (購買力平価換算)

```R
G7BRICs<-NGDPDPC_C[grep("CAN|JPN|USA|FRA|ITA|GBR|DEU|BRA|RUS|IND|CHN",NGDPDPC_C$iso3c),]
id<- G7BRICs[G7BRICs$year=="2028",c("Name","value")]
G7BRICs$Name<- factor(G7BRICs$Name,levels=id[order(-id$value),]$Name)
g1<- ggplot(G7BRICs,aes(x=year,y=value,color=Name))+
	geom_line()+
	labs(x=NULL,y=NULL,title="G7, BRICs: 一人当たり名目GDP(単位: 1ドル)",color="Country") +
	scale_y_continuous(labels = comma)+
	theme_cowplot(14) +
	theme(
	    legend.position = c(.02, .98),
	    legend.justification = c("left", "top"),
	    legend.box.just = "left",
	    legend.margin = margin(6,6,6,6)
	    )
#table(G7BRICs$lastactualdate)
#2013 2020 2021 2022 
#  49   98  245  147 
#unique(G7BRICs[G7BRICs$lastactualdate==2022,"Name"])
#[1] Germany Canada  China
#unique(G7BRICs[G7BRICs$lastactualdate==2021,"Name"])
#[1] United States France        Italy         Japan         Russia 
#unique(G7BRICs[G7BRICs$lastactualdate==2020,"Name"])
#[1] United Kingdom Brazil 
#unique(G7BRICs[G7BRICs$lastactualdate==2013,"Name"])
#[1] India
#
G7BRICs<-PPPPC_C[grep("CAN|JPN|USA|FRA|ITA|GBR|DEU|BRA|RUS|IND|CHN",PPPPC_C$iso3c),]
id<- G7BRICs[G7BRICs$year=="2028",c("Name","value")]
G7BRICs$Name<- factor(G7BRICs$Name,levels=id[order(-id$value),]$Name)
g2<-ggplot(G7BRICs,aes(x=year,y=value,color=Name))+
	geom_line()+
	labs(x=NULL,y=NULL,title="G7, BRICs: 一人当たり名目GDP(購買力平価換算)",color="Country") +
	scale_y_continuous(labels = comma)+
	theme_cowplot(14) +
	theme(
	    legend.position = c(.02, .98),
	    legend.justification = c("left", "top"),
	    legend.box.just = "left",
	    legend.margin = margin(6,6,6,6)
	    )
#table(G7BRICs$lastactualdate)
#2013 2020 2021 2022 
#  49   98  245  147 
g <- plot_grid(g1, g2, labels="auto", align="h") 
ggsave("imfweo01_4.png", width = 16, height = 8)
```
