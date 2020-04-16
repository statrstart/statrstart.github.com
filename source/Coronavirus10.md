---
title: Rで塗り分け地図（コロプレス図）(新型コロナウイルス：Coronavirus)
date: 2020-04-15
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
|北海道     |      279|     3297|                               6.0|   8.46|
|青森県     |       22|      410|                               3.0|   5.37|
|岩手県     |        0|      170|                               1.3|   0.00|
|宮城県     |       64|      852|                               3.6|   7.51|
|秋田県     |       16|      603|                               5.6|   2.65|
|山形県     |       39|     1055|                               9.0|   3.70|
|福島県     |       39|      706|                               3.5|   5.52|
|茨城県     |      116|     2719|                               9.2|   4.27|
|栃木県     |       38|     1121|                               5.6|   3.39|
|群馬県     |       97|     1787|                               8.9|   5.43|
|埼玉県     |      433|     3056|                               4.2|  14.17|
|千葉県     |      490|     4163|                               6.7|  11.77|
|東京都     |     2332|     6563|                               5.0|  35.53|
|神奈川県   |      594|     6141|                               6.8|   9.67|
|新潟県     |       45|     1787|                               7.5|   2.52|
|富山県     |       54|      956|                               8.7|   5.65|
|石川県     |      131|      778|                               6.7|  16.84|
|福井県     |       92|      765|                               9.5|  12.03|
|山梨県     |       36|     1205|                              14.0|   2.99|
|長野県     |       35|     1106|                               5.1|   3.16|
|岐阜県     |      127|     1519|                               7.3|   8.36|
|静岡県     |       46|     1647|                               4.4|   2.79|
|愛知県     |      338|     4250|                               5.7|   7.95|
|三重県     |       19|     1002|                               5.4|   1.90|
|滋賀県     |       51|      599|                               4.2|   8.51|
|京都府     |      210|     2275|                               8.6|   9.23|
|大阪府     |      895|     5490|                               6.2|  16.30|
|兵庫県     |      403|     4403|                               7.9|   9.15|
|奈良県     |       47|      641|                               4.6|   7.33|
|和歌山県   |       35|     2119|                              21.1|   1.65|
|鳥取県     |        1|      432|                               7.3|   0.23|
|島根県     |       10|      442|                               6.2|   2.26|
|岡山県     |       16|      688|                               3.5|   2.33|
|広島県     |       66|     2276|                               8.0|   2.90|
|山口県     |       25|      738|                               5.1|   3.39|
|徳島県     |        3|      248|                               3.2|   1.21|
|香川県     |       20|      637|                               6.4|   3.14|
|愛媛県     |       39|      653|                               4.6|   5.97|
|高知県     |       60|      935|                              12.2|   6.42|
|福岡県     |      403|     5195|                              10.2|   7.76|
|佐賀県     |       15|      422|                               5.0|   3.55|
|長崎県     |       14|     1142|                               8.0|   1.23|
|熊本県     |       29|     1944|                              10.7|   1.49|
|大分県     |       43|     2172|                              18.2|   1.98|
|宮崎県     |       17|      733|                               6.5|   2.32|
|鹿児島県   |        4|      628|                               3.7|   0.64|
|沖縄県     |       76|      856|                               6.1|   8.88|

### 陽性率(都道府県別)の棒グラフ

![covidP02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covidP02.png)

### 散布図

![covidP01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covidP01.png)

#### 感染者50人以下、人口１万人あたりのPCR検査実施人数 25人以下の都道府県のみプロット

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
res <- pdf_text("https://www.mhlw.go.jp/content/10906000/000622037.pdf")
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
txt<- sub("PCR検査実施人数.*$"," ",txt)
txt<- sub("^.*％"," ",txt)
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

