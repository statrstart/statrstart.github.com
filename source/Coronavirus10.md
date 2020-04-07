---
title: Rで塗り分け地図（コロプレス図）(新型コロナウイルス：Coronavirus)
date: 2020-04-07
tags: ["R","pdftools","sf","NipponMap", "BAMMtools","Coronavirus","Japan","新型コロナウイルス"]
excerpt: 都道府県別:陽性者数&人口１万人あたりのPCR検査実施人数
---

# Rで塗り分け地図（コロプレス図）(新型コロナウイルス) 

![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus10)  

[韓国と日本のPCR検査実施人数比較](https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus08)をみると日本のPCR検査実施人数は
韓国より著しく少ないことがわかります。では、都道府県別にみるとどうなのか、コロプレス図をRで作ってみました。  

(参考:コロプレス図作成)[5. Plotting Simple Features](https://r-spatial.github.io/sf/articles/sf5.html)  

使用するデータ(厚生労働省：pdfファイル)  
[新型コロナウイルス陽性者数(チャーター便帰国者を除く)とPCR検査実施人数（都道府県別）1/15～3/20](https://www.mhlw.go.jp/content/10906000/000610714.pdf)  

(準備)上記のpdfファイルを保存。ここでは、作業フォルダ上のcovid19フォルダ内。

#### 陽性者数

![covmap01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covmap01.png)

#### 人口１万人あたりのPCR検査実施人数

![covmap02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covmap02.png)

#### 陽性率

![covmap03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covmap03.png)

#### 表  

|都道府県名 | 陽性者数| 検査人数| 人口１万人あたりのPCR検査実施人数| 陽性率|
|:----------|--------:|--------:|---------------------------------:|------:|
|北海道     |      194|     2296|                               4.2|   8.45|
|青森県     |       11|      199|                               1.4|   5.53|
|岩手県     |        0|       76|                               0.6|   0.00|
|宮城県     |       23|      348|                               1.5|   6.61|
|秋田県     |       11|      349|                               3.2|   3.15|
|山形県     |       10|      369|                               3.2|   2.71|
|福島県     |       16|      264|                               1.3|   6.06|
|茨城県     |       64|     1383|                               4.7|   4.63|
|栃木県     |       14|      657|                               3.3|   2.13|
|群馬県     |       26|      866|                               4.3|   3.00|
|埼玉県     |      174|     1550|                               2.2|  11.23|
|千葉県     |      238|     2592|                               4.2|   9.18|
|東京都     |     1040|     3806|                               2.9|  27.33|
|神奈川県   |      226|     3935|                               4.3|   5.74|
|新潟県     |       32|     1248|                               5.3|   2.56|
|富山県     |       10|      198|                               1.8|   5.05|
|石川県     |       43|      264|                               2.3|  16.29|
|福井県     |       51|      310|                               3.8|  16.45|
|山梨県     |       13|      625|                               7.2|   2.08|
|長野県     |       12|      670|                               3.1|   1.79|
|岐阜県     |       50|      842|                               4.0|   5.94|
|静岡県     |       10|     1006|                               2.7|   0.99|
|愛知県     |      227|     2917|                               3.9|   7.78|
|三重県     |       13|      598|                               3.2|   2.17|
|滋賀県     |       18|      293|                               2.1|   6.14|
|京都府     |      111|     1405|                               5.3|   7.90|
|大阪府     |      409|     3661|                               4.1|  11.17|
|兵庫県     |      195|     2805|                               5.0|   6.95|
|奈良県     |       25|      368|                               2.6|   6.79|
|和歌山県   |       25|     1580|                              15.8|   1.58|
|鳥取県     |        0|      227|                               3.9|   0.00|
|島根県     |        0|      163|                               2.3|   0.00|
|岡山県     |       11|      390|                               2.0|   2.82|
|広島県     |       16|     1053|                               3.7|   1.52|
|山口県     |        8|      409|                               2.8|   1.96|
|徳島県     |        3|      164|                               2.1|   1.83|
|香川県     |        2|      344|                               3.5|   0.58|
|愛媛県     |       12|      350|                               2.4|   3.43|
|高知県     |       31|      498|                               6.5|   6.22|
|福岡県     |      109|     1595|                               3.1|   6.83|
|佐賀県     |        8|      189|                               2.2|   4.23|
|長崎県     |        9|      505|                               3.5|   1.78|
|熊本県     |       20|     1144|                               6.3|   1.75|
|大分県     |       31|     1739|                              14.5|   1.78|
|宮崎県     |        6|      356|                               3.1|   1.69|
|鹿児島県   |        3|      346|                               2.0|   0.87|
|沖縄県     |        9|      430|                               3.1|   2.09|

### 陽性率(都道府県別)の棒グラフ

![covidP02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covidP02.png)

### 散布図

![covidP01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covidP01.png)

#### (上のグラフでは見づらい)感染者１０人以下、人口１万人あたりのPCR検査実施人数 3人以下の都道府県のみプロット

![covidP01_1](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covidP01_1.png)

## Rコード

### pdfファイルからデータの取り込み。加工。

- pdfファイルからデータの取り込み（pdftools::pdf_text）
- 余分な部分を削除(sub,gsub関数)
- data.frameへ（read.table(text=txt,stringsAsFactors = F)　）
- 1から3列、4から6列に分けつなぐ。合計は取り除く。
- 元のpdfファイルの備考をみて、手打ちで修正。


```R
# install.packages("pdftools")
library(pdftools)
library(knitr)
#
res <- pdf_text("https://www.mhlw.go.jp/content/10906000/000619392.pdf")
period<-sub("】.*$","",sub("^.*【","",res))
#都道府県名 陽性者数 検査人数 備考
txt<- sub("^.*備考","",sub("複数の検体を重複してカウントしているため.*$","",res))
txt<- gsub("※１","",txt)
txt<- gsub("※1","",txt)
txt<- gsub("未確定","",txt)
txt<- gsub("時点","",txt)
txt<- gsub("[0-9]*/[0-9]*","",txt)
txt<- gsub("※2","",txt)
txt<- gsub(",","",txt)
txt<- gsub(" +"," ",txt)
txt<- gsub("   "," ",txt)
# stringsAsFactors = Fをつけて、Factor化を防ぐ。
Jtest<- read.table(text=txt,stringsAsFactors = F,nrow=24)
#kable(Jtest,row.names =F)
#
# 1から3列、4から6列に分けつなぐ。合計は取り除く。
d1<-Jtest[,1:3] ; d2<-Jtest[,4:6]
colnames(d1)<- colnames(d2)<- c("都道府県名", "陽性者数", "検査人数")
Jtest<- rbind(d1,d2)[1:47,]
#kable(Jtest,row.names =F)
#
#神奈川県においてはクルーズ船を含む2835件の検査が行われた。
#千葉県において3/20までに1716件、
#大阪府において3/22までに2350件の検査が行われた。
#なお、千葉県は3/21より、神奈川県は3/23より、大阪府は3/22より検査人数を計上している。
# ※1を手入力。 
Jtest[Jtest$都道府県名=="神奈川県",3] <- Jtest[Jtest$都道府県名=="神奈川県",3] + 2835
Jtest[Jtest$都道府県名=="千葉県",3] <- Jtest[Jtest$都道府県名=="千葉県",3] + 1716
Jtest[Jtest$都道府県名=="大阪府",3] <- Jtest[Jtest$都道府県名=="大阪府",3] + 2350
#
#Jtest$陽性者数<- as.numeric(Jtest$陽性者数)
#Jtest$検査人数<- as.numeric(Jtest$検査人数)
summary(Jtest)
#save(Jtest,file="Jtest.Rdata")
```

### 塗り分け地図作成

#### パッケージの読み込み。都道府県の並びを確認。

```R
library(sf)
library(NipponMap)
library(BAMMtools)
shp <- system.file("shapes/jpn.shp", package = "NipponMap")[1]
m <- sf::read_sf(shp)
m$name
```

 [1] "Hokkaido"  "Aomori"    "Iwate"     "Miyagi"    "Akita"     "Yamagata"   
 [7] "Fukushima" "Ibaraki"   "Tochigi"   "Gunma"     "Saitama"   "Chiba"    
[13] "Tokyo"     "Kanagawa"  "Niigata"   "Toyama"    "Ishikawa"  "Fukui"    
[19] "Yamanashi" "Nagano"    "Gifu"      "Shizuoka"  "Aichi"     "Mie"      
[25] "Shiga"     "Kyoto"     "Osaka"     "Hyogo"     "Nara"      "Wakayama"  
[31] "Tottori"   "Shimane"   "Okayama"   "Hiroshima" "Yamaguchi" "Tokushima"  
[37] "Kagawa"    "Ehime"     "Kochi"     "Fukuoka"   "Saga"      "Nagasaki"   
[43] "Kumamoto"  "Oita"      "Miyazaki"  "Kagoshima" "Okinawa"    

## (注意)上のJtestデータの都道府県の並びがこの順序になっているか確認する。

### 地図作成

BAMMtoolsパッケージのgetJenksBreaks関数を使い値の区切りを決めます。  
グループの数も指定せずに済むようにしました。

#### 陽性者数

```R
dat<- Jtest$陽性者数
# legendのタイトル
ltitle<- "陽性者数"
# グラフのタイトル
title<- "PCR検査 陽性者数(都道府県別)"
#
##### ここ以降のRコードは共通 #####
#
# Jenksの自然分類法で分ける最大
i <- length(dat)
brk <- getJenksBreaks(dat,k=i+1)
while (length(unique(brk)) != length(brk)) { 
	brk <- getJenksBreaks(dat,k=i+1)
	i=i-1
}
# legendのlabelを作成
labels<- as.vector(cut(brk[1:length(brk)-1],breaks=brk,include.lowest=T,right =F, dig.lab=5))
# 塗りつぶしに使うカラーパレット：rev関数で　白->赤
color<- rev(heat.colors(length(brk)-1))
cols<-as.vector(cut(dat, breaks=brk,labels =color,include.lowest=T,right =F))
# png("covmap01.png",width=800,height=800)
par(mar=c(0,0,4,0))
JapanPrefMap(col=cols)
legend(x=146,y=40, legend=labels, fill=color,title =ltitle)
title(paste(title,period))
# 陽性者数0の県に青丸をつける場合
shp <- system.file("shapes/jpn.shp", package = "NipponMap")[1]
m <- sf::read_sf(shp)
st_crs(m) <- "+proj=longlat +datum=WGS84"
m[,"Cases"]<- dat
m0 <- m
m0$geometry[[47]] <- m0$geometry[[47]] + c(3.5,14)
zero<- m0[m0$Cases==0,]
plot(st_geometry(st_centroid(zero)), pch =16, col ="blue", add = TRUE)
legend(x=146,y=41, legend="陽性者数 0",pch =16, col ="blue",bty="n")
# dev.off()
```

#### 人口１万人あたりのPCR検査実施人数

#### 都道府県の人口は地図データに入っているものを使います。

```R
# 人口１万人あたりの検査数
dat<- round((10000*Jtest$検査人数)/m$population,3)
# legendのタイトル
ltitle<- ""
# グラフのタイトル
title<- "人口１万人あたりのPCR検査実施人数(都道府県別)"
#
##### ここ以降のRコードは共通 #####
#
# Jenksの自然分類法で分ける最大
i <- length(dat)
brk <- getJenksBreaks(dat,k=i+1)
while (length(unique(brk)) != length(brk)) { 
	brk <- getJenksBreaks(dat,k=i+1)
	i=i-1
}
# legendのlabelを作成
labels<- as.vector(cut(brk[1:length(brk)-1],breaks=brk,include.lowest=T,right =F, dig.lab=5))
# 塗りつぶしに使うカラーパレット：rev関数で　白->赤
color<- rev(heat.colors(length(brk)-1))
cols<-as.vector(cut(dat, breaks=brk,labels =color,include.lowest=T,right =F))
# png("covmap02.png",width=800,height=800)
par(mar=c(0,0,4,0))
JapanPrefMap(col=cols)
legend(x=146,y=40, legend=labels, fill=color,title =ltitle)
title(paste(title,period))
# dev.off()
```

### 陽性率

```R
dat<- round(Jtest$陽性者数/Jtest$検査人数*100,2)
# legendのタイトル
ltitle<- "陽性率(%)"
# グラフのタイトル
title<- "陽性率(%)(都道府県別)"
#
##### ここ以降のRコードは共通 #####
#
# Jenksの自然分類法で分ける最大
i <- length(dat)
brk <- getJenksBreaks(dat,k=i+1)
while (length(unique(brk)) != length(brk)) { 
	brk <- getJenksBreaks(dat,k=i+1)
	i=i-1
}
# legendのlabelを作成
labels<- as.vector(cut(brk[1:length(brk)-1],breaks=brk,include.lowest=T,right =F, dig.lab=5))
# 塗りつぶしに使うカラーパレット：rev関数で　白->赤
color<- rev(heat.colors(length(brk)-1))
cols<-as.vector(cut(dat, breaks=brk,labels =color,include.lowest=T,right =F))
#png("covmap03.png",width=800,height=800)
par(mar=c(0,0,4,0))
JapanPrefMap(col=cols)
legend(x=146,y=40, legend=labels, fill=color,title =ltitle)
title(paste(title,period))
# 陽性者数0の県に青丸をつける場合
shp <- system.file("shapes/jpn.shp", package = "NipponMap")[1]
m <- sf::read_sf(shp)
st_crs(m) <- "+proj=longlat +datum=WGS84"
m[,"Cases"]<- dat
m0 <- m
m0$geometry[[47]] <- m0$geometry[[47]] + c(3.5,14)
zero<- m0[m0$Cases==0,]
plot(st_geometry(st_centroid(zero)), pch =16, col ="blue", add = TRUE)
legend(x=146,y=41, legend="陽性率 0%",pch =16, col ="blue",bty="n")
#dev.off()
```

### 表

```R
Jtest$人口１万人あたりのPCR検査実施人数<- round((10000*Jtest$検査人数)/m$population,3)
kable(Jtest)
```

### 陽性率(都道府県別)の棒グラフ

```R
dat<- Jtest[,c("都道府県名","陽性率")]
dat<- dat[order(dat$陽性率),]
# グラフのタイトル
title<- "陽性率(%)(都道府県別)"
#
#png("covidP02.png",width=800,height=800)
par(mar=c(3,7,4,2))
b<- barplot(dat$陽性率,names=dat$都道府県名,horiz=T,col="pink",las=1,xlim=c(0,max(dat$陽性率)*1.2))
text(x=dat$陽性率,y=b,labels=paste(dat$陽性率,"%"),pos=4)
title(paste(title,period))
#dev.off()
```

### 散布図

```R
# png("covidP01.png",width=800,height=800)
plot(人口１万人あたりのPCR検査実施人数~陽性者数,type="n",bty="l",las=1,data=Jtest)
box(bty="l",lwd=2)
text(x=Jtest$陽性者数,y=Jtest$人口１万人あたりのPCR検査実施人数,labels=Jtest$都道府県名)
# dev.off()
```

#### 感染者24人以下、人口１万人あたりのPCR検査実施人数 4人以下の都道府県のみプロット

```R
# png("covidP01_1.png",width=800,height=800)
plot(人口１万人あたりのPCR検査実施人数~陽性者数,type="n",bty="l",las=1,xlim=c(0,24),ylim=c(0,4),data=Jtest)
box(bty="l",lwd=2)
text(x=Jtest$陽性者数,y=Jtest$人口１万人あたりのPCR検査実施人数,labels=Jtest$都道府県名)
# dev.off()
```

