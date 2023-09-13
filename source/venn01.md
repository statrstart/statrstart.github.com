---
title: Rで「OPECプラス＋上海協力機構＋BRICSプラス」相関図
date: 2023-09-13
tags: ["R", "ggplot2","Vennerable","ggimage","statebins","berryFunctions"]
excerpt: OPECプラス＋上海協力機構＋BRICSプラス
---

# Rで「OPECプラス＋上海協力機構＋BRICSプラス」相関図

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2Fvenn01&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

作成：2023/9/13

(参考)  

[中国問題研究家 遠藤誉が斬る:習近平が狙う「米一極から多極化へ」の実現に一歩近づいたBRICS加盟国拡大](https://news.yahoo.co.jp/expert/articles/8f6d14113b90cbec85da83aa482307bc84402b4c)

#### OPECプラス(23か国)

OPEC:イラン、イラク、クウェート、サウジアラビア、ベネズエラ、リビア、アルジェリア、ナイジェリア、アラブ首長国連邦、ガボン、アンゴラ、赤道ギニア、コンゴ（加盟13か国）

OPECプラス:（OPEC加盟国に加えて）アゼルバイジャン、バーレーン、ブルネイ、カザフスタン、マレーシア、メキシコ、オマーン、ロシア、スーダン、南スーダン（参加13か国＋10か国）

#### 上海協力機構(9か国)

ロシア、中国、インド、パキスタン、カザフスタン、キルギス、タジキスタン、ウズベキスタン、イラン

(ベラルーシが２０２４年の加盟に向けた覚書に署名)

#### BRICSプラス(11か国)

ブラジル、ロシア、インド、中国、南アフリカ共和国

2024年1月から6カ国(アルゼンチン、イラン、エジプト、エチオピア、サウジアラビア、アラブ首長国連邦（UAE）)を加える。

### ベン図:「OPECプラス＋上海協力機構＋BRICSプラス」

![venndiagram01.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/venndiagram01.png)

### 「OPECプラス＋上海協力機構＋BRICSプラス」相関図１

![el01.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/el01.png)

### 「OPECプラス＋上海協力機構＋BRICSプラス」相関図２

![el02.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/el02.png)

### Rコード

#### ベン図

```R
# パッケージのインストール
# install.packages("BiocManager")
# BiocManager::install(c("RBGL","graph"))
# remotes::install_github("js229/Vennerable")
# パッケージの読み込み
library("Vennerable")
# データ
OPECplus <- c("イラン","イラク","クウェート","サウジアラビア","ベネズエラ","リビア","アルジェリア","ナイジェリア","アラブ首長国連邦","ガボン","アンゴラ","赤道ギニア","コンゴ共和国","アゼルバイジャン","バーレーン","ブルネイ","カザフスタン","マレーシア","メキシコ","オマーン","ロシア","スーダン","南スーダン")
SCO <- c("ロシア","中国","インド","パキスタン","カザフスタン","キルギス","タジキスタン","ウズベキスタン","イラン") #ベラルーシ(2024)
BRICSplus <- c("ブラジル","ロシア","インド","中国","南アフリカ共和国","アルゼンチン","イラン","エジプト","エチオピア","サウジアラビア","アラブ首長国連邦")
# リストにまとめる
data <- list(OPECプラス = OPECplus ,上海協力機構 = SCO, BRICSプラス = BRICSplus)
# 返り値をv1に入れておく
v1<- Venn(data)
# 3変数;"triangles","circles","squares"
# png("venndiagram01.png",width=600,height=600)
plot(v1, doWeights = FALSE, type = "circles")
# dev.off()
```

##### VennerableパッケージのVenn関数の返り値

```R
# str(v1)
v1@IndicatorWeight
#    OPECプラス 上海協力機構 BRICSプラス .Weight
#000          0            0           0       0
#100          1            0           0      18
#010          0            1           0       4
#110          1            1           0       1
#001          0            0           1       5
#101          1            0           1       2
#011          0            1           1       2
#111          1            1           1       2
#
# 各要素が７つの領域のどこに属しているかもわかる
v1@IntersectionSets
# v1@IntersectionSets[[2]]
```

$`000`  
NULL  

$`100`  
 [1] "イラク"           "クウェート"       "ベネズエラ"       "リビア"            
 [5] "アルジェリア"     "ナイジェリア"     "ガボン"           "アンゴラ"        
 [9] "赤道ギニア"       "コンゴ共和国"     "アゼルバイジャン" "バーレーン"      
[13] "ブルネイ"         "マレーシア"       "メキシコ"         "オマーン"        
[17] "スーダン"         "南スーダン"      

$`010`  
[1] "パキスタン"     "キルギス"       "タジキスタン"   "ウズベキスタン"

$`110`  
[1] "カザフスタン"

$`001`  
[1] "ブラジル"         "南アフリカ共和国" "アルゼンチン"     "エジプト"        
[5] "エチオピア"      

$`101`  
[1] "サウジアラビア"   "アラブ首長国連邦"

$`011`  
[1] "中国"   "インド"

$`111`  
[1] "イラン" "ロシア"

#### 「OPECプラス＋上海協力機構＋BRICSプラス」相関図１

```R
# 角の丸い長方形 (berryFunctions パッケージの roundedRect 関数)
library(berryFunctions)
# ベクトルを改行挟んでつなげる関数を定義
kaigyo<- function(vec){
	kai=NULL
	if ( length(vec)>1 ){
		for(i in 1:(length(vec)-1)){
			kai=paste0(kai,vec[i],"\n")
		}
	}
	if ( length(vec)>0 ){	
		kai=paste0(kai,vec[length(vec)])
	}
	return(kai)
}
#
# plot
rounding=0.15
# png("el01.png",width=800,height=600)
plot(x=0,y=0,xlim=c(0,15),ylim=c(-1,11),type="n",axes=F,xlab="",ylab="",asp=1) 
roundedRect(
  xleft=0,
  ybottom=0.2,
  xright=10,
  ytop=10, 
  rounding=rounding,
  border="brown3",lwd=2)
roundedRect(
  xleft=6.8,
  ybottom=4,
  xright=14.8,
  ytop=9.8, 
  rounding=rounding,
  border="royalblue3",lty=2,lwd=2)
roundedRect(
  xleft=7,
  ybottom=0,
  xright=15,
  ytop=6, 
  rounding=rounding,
  border="darkgreen",lwd=3)
text(x=5,y=10,labels="OPECプラス",pos=3,xpd=T,col="brown3")
text(x=10.8,y=9.8,labels="上海協力機構",pos=3,xpd=T,col="royalblue3")
text(x=11,y=0,labels="BRICSプラス",pos=1,xpd=T,col="darkgreen")
#
vec<- v1@IntersectionSets[[2]]
kaigyo(vec)
text(x=3,y=8,labels=kaigyo(vec),pos=1,xpd=T,col="black")
vec<- v1@IntersectionSets[[3]]
kaigyo(vec)
text(x=12,y=8.5,labels=kaigyo(vec),pos=1,xpd=T,col="black")
vec<- v1@IntersectionSets[[4]]
kaigyo(vec)
text(x=8.4,y=8.5,labels=kaigyo(vec),pos=1,xpd=T,col="black")
vec<- v1@IntersectionSets[[5]]
kaigyo(vec)
text(x=12,y=3.5,labels=kaigyo(vec),pos=1,xpd=T,col="black")
vec<- v1@IntersectionSets[[6]]
kaigyo(vec)
text(x=8.4,y=3.5,labels=kaigyo(vec),pos=1,xpd=T,col="black")
vec<- v1@IntersectionSets[[7]]
kaigyo(vec)
text(x=12,y=5.5,labels=kaigyo(vec),pos=1,xpd=T,col="black")
vec<- v1@IntersectionSets[[8]]
kaigyo(vec)
text(x=8.4,y=5.5,labels=kaigyo(vec),pos=1,xpd=T,col="black")
# dev.off()
```

#### 「OPECプラス＋上海協力機構＋BRICSプラス」相関図１

```R
require(ggplot2)
# 角丸長方形
require(statebins)
# 国旗
require(ggimage)
p <- ggplot() + ylim(0, 10) + xlim(0, 15)
#
p <- p + statebins:::geom_rrect(mapping=aes(xmin=0,
         xmax=10, ymin=0.2,  ymax=10),
         colour = "brown3", fill = rgb(1,0,0,0.1) )
#
p <- p + statebins:::geom_rrect(mapping=aes(xmin=6.8, 
         xmax=14.8, ymin=4, ymax=9.8),  
         colour = "royalblue3", fill = rgb(0,0,1,0.1) )
#
p <- p + statebins:::geom_rrect(mapping=aes(xmin=7, 
         xmax=15, ymin=0, ymax=6),  
         colour = "darkgreen", fill = rgb(0,1,0,0.1) )
p <- p + annotate("text", x=5, y=10, label="OPECプラス", vjust=-1,family="serif",color="brown3",size=5)
p <- p + annotate("text", x=11.5,y=9.8,label="上海協力機構", vjust=-1,family="serif",color="royalblue3",size=5)
p <- p + annotate("text", x=11,y=0,label="BRICSプラス", vjust=1.5,family="serif",color="darkgreen",size=5)
#2
p <- p + geom_flag(aes(x=c(rep(2,9),rep(4.5,9)),y=c(9,8,7,6,5,4,3,2,1,9,8,7,6,5,4,3,2,1), 
	image = c("IQ","KW","VE","LY","DZ","NG","GA","AO","GQ","CG","AZ","BH","BN","MY","MX","OM","SD","SS"))) 
#3
p <- p + geom_flag(aes(x=c(11.5,11.5,13.5,13.5),y=c(8.5,7.5,8.5,7.5), image = c("PK","KG","TJ","UZ"))) 
#4
p <- p + geom_flag(aes(x=8.4,y=8, image = "KZ")) 
#5
p <- p + geom_flag(aes(x=c(rep(11.5,3),13.5,13.5),y=c(3.5,2.5,1.5,3.5,2.5), image = c("BR","ZA","AR","EG","ET"))) 
#6
p <- p + geom_flag(aes(x=c(8.4,8.4),y=c(3,2), image = c("SA","AE"))) 
#7
p <- p + geom_flag(aes(x=c(12.5,12.5),y=c(5.5,4.5), image = c("CN","IN"))) 
#8
p <- p + geom_flag(aes(x=c(8.4,8.4),y=c(5.5,4.5), image = c("RU","IR"))) 
# Print
p <- p + theme(aspect.ratio=1) + theme_void()
p
```
