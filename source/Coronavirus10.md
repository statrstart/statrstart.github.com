---
title: Rで塗り分け地図（コロプレス図）(新型コロナウイルス：Coronavirus)
date: 2020-04-13
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
|北海道     |      267|     2836|                               5.2|   9.41|
|青森県     |       22|      313|                               2.3|   7.03|
|岩手県     |        0|      136|                               1.0|   0.00|
|宮城県     |       52|      660|                               2.8|   7.88|
|秋田県     |       15|      491|                               4.5|   3.05|
|山形県     |       34|      782|                               6.7|   4.35|
|福島県     |       38|      541|                               2.7|   7.02|
|茨城県     |      109|     2221|                               7.5|   4.91|
|栃木県     |       35|     1003|                               5.0|   3.49|
|群馬県     |       90|     1495|                               7.4|   6.02|
|埼玉県     |      386|     2216|                               3.1|  17.42|
|千葉県     |      455|     3459|                               5.6|  13.15|
|東京都     |     2080|     5660|                               4.3|  36.75|
|神奈川県   |      478|     5439|                               6.0|   8.79|
|新潟県     |       42|     1587|                               6.7|   2.65|
|富山県     |       30|      646|                               5.9|   4.64|
|石川県     |      113|      562|                               4.8|  20.11|
|福井県     |       88|      515|                               6.4|  17.09|
|山梨県     |       35|     1013|                              11.7|   3.46|
|長野県     |       29|      899|                               4.2|   3.23|
|岐阜県     |      105|     1185|                               5.7|   8.86|
|静岡県     |       41|     1426|                               3.8|   2.88|
|愛知県     |      319|     3990|                               5.4|   7.99|
|三重県     |       17|      906|                               4.9|   1.88|
|滋賀県     |       38|      487|                               3.5|   7.80|
|京都府     |      193|     1968|                               7.5|   9.81|
|大阪府     |      812|     4712|                               5.3|  17.23|
|兵庫県     |      375|     3830|                               6.9|   9.79|
|奈良県     |       41|      539|                               3.8|   7.61|
|和歌山県   |       34|     1989|                              19.8|   1.71|
|鳥取県     |        1|      299|                               5.1|   0.33|
|島根県     |        7|      205|                               2.9|   3.41|
|岡山県     |       16|      595|                               3.1|   2.69|
|広島県     |       56|     1754|                               6.1|   3.19|
|山口県     |       23|      557|                               3.8|   4.13|
|徳島県     |        3|      228|                               2.9|   1.32|
|香川県     |        8|      480|                               4.8|   1.67|
|愛媛県     |       30|      545|                               3.8|   5.50|
|高知県     |       60|      814|                              10.6|   7.37|
|福岡県     |      362|     4137|                               8.2|   8.75|
|佐賀県     |       13|      367|                               4.3|   3.54|
|長崎県     |       14|      933|                               6.5|   1.50|
|熊本県     |       28|     1728|                               9.5|   1.62|
|大分県     |       42|     2070|                              17.3|   2.03|
|宮崎県     |       17|      612|                               5.4|   2.78|
|鹿児島県   |        4|      523|                               3.1|   0.76|
|沖縄県     |       66|      680|                               4.9|   9.71|

### 陽性率(都道府県別)の棒グラフ

![covidP02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covidP02.png)

### 散布図

![covidP01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covidP01.png)

#### 感染者30人以下、人口１万人あたりのPCR検査実施人数 10人以下の都道府県のみプロット

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
res <- pdf_text("https://www.mhlw.go.jp/content/10906000/000620474.pdf")
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
txt<- gsub("HP"," ",txt)
txt<- gsub("[0-9]+:[0-9]+"," ",txt)
# stringsAsFactors = Fをつけて、Factor化を防ぐ。
Jtest<- read.table(text=txt,stringsAsFactors = F,nrow=24)
#kable(Jtest,row.names =F)
#
# 1から3列、4から6列に分けつなぐ。合計は取り除く。
#d1<-Jtest[,1:3] ; d2<-Jtest[,4:6]
#colnames(d1)<- colnames(d2)<- c("都道府県名", "陽性者数", "検査人数")
#Jtest<- rbind(d1,d2)[1:47,]
#"％"が追加された
d1<-Jtest[,1:4] ; d2<-Jtest[,5:8]
colnames(d1)<- colnames(d2)<- c("都道府県名", "陽性者数", "検査人数","％")
Jtest<- rbind(d1,d2)[1:47,]
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
legend(x=144,y=40, legend=labels, fill=color,title =ltitle,ncol=2)
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
legend(x=144,y=41, legend="陽性者数 0",pch =16, col ="blue",bty="n")
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
legend(x=144,y=40, legend=labels, fill=color,title =ltitle)
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
legend(x=144,y=40, legend=labels, fill=color,title =ltitle)
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
legend(x=144,y=41, legend="陽性率 0%",pch =16, col ="blue",bty="n")
#dev.off()
```

### 表

```R
Jtest$人口１万人あたりのPCR検査実施人数<- round((10000*Jtest$検査人数)/m$population,3)
kable(Jtest[,-4])
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

#### 感染者30人以下、人口１万人あたりのPCR検査実施人数 10人以下の都道府県のみプロット

```R
# png("covidP01_1.png",width=800,height=800)
plot(人口１万人あたりのPCR検査実施人数~陽性者数,type="n",bty="l",las=1,xlim=c(0,24),ylim=c(0,5),data=Jtest)
box(bty="l",lwd=2)
text(x=Jtest$陽性者数,y=Jtest$人口１万人あたりのPCR検査実施人数,labels=Jtest$都道府県名)
# dev.off()
```

