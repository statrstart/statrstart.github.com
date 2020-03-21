---
title: Rで塗り分け地図（コロプレス図） (Coronavirus)
date: 2020-03-21
tags: ["R","pdftools","sf","NipponMap", "Coronavirus","Japan","新型コロナウイルス"]
excerpt: Rで塗り分け地図（コロプレス図） (Coronavirus)
---

# Rで塗り分け地図（コロプレス図） (Coronavirus) 
![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus10)  

[韓国と日本のPCR検査実施人数比較](https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus08)をみると日本のPCR検査実施人数は
韓国より著しく少ないことがわかります。では、都道府県別にみるとどうなのか、コロプレス図をRで作ってみました。  

(参考:コロプレス図作成)[5. Plotting Simple Features](https://r-spatial.github.io/sf/articles/sf5.html)  

使用するデータ(厚生労働省：pdfファイル)  
[新型コロナウイルス陽性者数(チャーター便帰国者を除く)とPCR検査実施人数（都道府県別）【1/15～3/19】](https://www.mhlw.go.jp/content/10906000/000610653.pdf)  

(準備)上記のpdfファイルを保存。ここでは、作業フォルダ上のcovid19フォルダ内。

#### 陽性者数

![covmap01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covmap01.png)

#### 人口１万人あたりのPCR検査実施人数

![covmap02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covmap02.png)

#### 表  

|都道府県名 | 陽性者数| 検査人数| 人口１万人あたりのPCR検査実施人数|
|:----------|--------:|--------:|---------------------------------:|
|北海道     |      157|     1652|                            3.0001|
|青森県     |        0|       79|                            0.5752|
|岩手県     |        0|       29|                            0.2180|
|宮城県     |        1|      144|                            0.6132|
|秋田県     |        2|      114|                            1.0497|
|山形県     |        0|      133|                            1.1378|
|福島県     |        2|      132|                            0.6505|
|茨城県     |        3|      464|                            1.5624|
|栃木県     |        3|      263|                            1.3100|
|群馬県     |       10|      173|                            0.8615|
|埼玉県     |       38|      684|                            0.9507|
|千葉県     |       36|     1686|                            2.7122|
|東京都     |      124|     1848|                            1.4043|
|神奈川県   |       64|     2591|                            2.8635|
|新潟県     |       21|      647|                            2.7248|
|富山県     |        0|       54|                            0.4939|
|石川県     |        7|      171|                            1.4618|
|福井県     |        1|       92|                            1.1410|
|山梨県     |        2|      335|                            3.8815|
|長野県     |        4|      306|                            1.4216|
|岐阜県     |        3|      272|                            1.3072|
|静岡県     |        3|      526|                            1.3971|
|愛知県     |      134|     1333|                            1.7987|
|三重県     |        9|      318|                            1.7145|
|滋賀県     |        4|      144|                            1.0207|
|京都府     |       20|      800|                            3.0348|
|大阪府     |      119|     2011|                            2.2684|
|兵庫県     |       91|     1108|                            1.9828|
|奈良県     |        8|      176|                            1.2565|
|和歌山県   |       16|     1102|                           10.9958|
|鳥取県     |        0|      115|                            1.9536|
|島根県     |        0|       91|                            1.2685|
|岡山県     |        0|      181|                            0.9305|
|広島県     |        1|      552|                            1.9296|
|山口県     |        3|      164|                            1.1300|
|徳島県     |        1|       83|                            1.0567|
|香川県     |        1|      128|                            1.2853|
|愛媛県     |        3|      181|                            1.2644|
|高知県     |       12|      270|                            3.5319|
|福岡県     |        5|      626|                            1.2342|
|佐賀県     |        1|      100|                            1.1768|
|長崎県     |        1|      213|                            1.4929|
|熊本県     |        7|      467|                            2.5696|
|大分県     |        3|      167|                            1.3957|
|宮崎県     |        3|      170|                            1.4975|
|鹿児島県   |        0|      171|                            1.0022|
|沖縄県     |        3|      238|                            1.7088|

### 散布図

![covidP01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covidP01.png)

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
#https://www.mhlw.go.jp/content/10906000/000610653.pdf
res <- pdf_text("./covid19/000610653.pdf")
#都道府県名 陽性者数 検査人数 備考
txt<- sub("^.*備考","",sub("複数の検体を重複してカウントしているため.*$","",res))
txt<- gsub("※１","",txt)
txt<- gsub("3/13未確定","",txt)
txt<- gsub("3/16時点","",txt)
txt<- gsub("※2","",txt)
# stringsAsFactors = Fをつけて、Factor化を防ぐ。
covid<- read.table(text=txt,stringsAsFactors = F)
kable(covid,row.names =F)
```

|V1       |  V2|V3   |V4       |  V5|    V6|
|:--------|---:|:----|:--------|---:|-----:|
|北海道   | 157|1652 |滋賀県   |   4|   144|
|青森県   |   0|79   |京都府   |  20|   800|
|岩手県   |   0|29   |大阪府   | 119|  2011|
|宮城県   |   1|144  |兵庫県   |  91|  1108|
|秋田県   |   2|114  |奈良県   |   8|   176|
|山形県   |   0|133  |和歌山県 |  16|  1102|
|福島県   |   2|132  |鳥取県   |   0|   115|
|茨城県   |   3|464  |島根県   |   0|    91|
|栃木県   |   3|263  |岡山県   |   0|   181|
|群馬県   |  10|173  |広島県   |   1|   552|
|埼玉県   |  38|684  |山口県   |   3|   164|
|千葉県   |  36|※1  |徳島県   |   1|    83|
|東京都   | 124|1848 |香川県   |   1|   128|
|神奈川県 |  64|※1  |愛媛県   |   3|   181|
|新潟県   |  21|647  |高知県   |  12|   270|
|富山県   |   0|54   |福岡県   |   5|   626|
|石川県   |   7|171  |佐賀県   |   1|   100|
|福井県   |   1|92   |長崎県   |   1|   213|
|山梨県   |   2|335  |熊本県   |   7|   467|
|長野県   |   4|306  |大分県   |   3|   167|
|岐阜県   |   3|272  |宮崎県   |   3|   170|
|静岡県   |   3|※1  |鹿児島県 |   0|   171|
|愛知県   | 134|847  |沖縄県   |   3|   238|
|三重県   |   9|318  |合計     | 926| 18015|


```R
# 1から3列、4から6列に分けつなぐ。合計は取り除く。
d1<-covid[,1:3] ; d2<-covid[,4:6]
colnames(d1)<- colnames(d2)<- c("都道府県名", "陽性者数", "検査人数")
covid<- rbind(d1,d2)[1:47,]
kable(covid,row.names =F)
```

|都道府県名 | 陽性者数|検査人数 |
|:----------|--------:|:--------|
|北海道     |      157|1652     |
|青森県     |        0|79       |
|岩手県     |        0|29       |
|宮城県     |        1|144      |
|秋田県     |        2|114      |
|山形県     |        0|133      |
|福島県     |        2|132      |
|茨城県     |        3|464      |
|栃木県     |        3|263      |
|群馬県     |       10|173      |
|埼玉県     |       38|684      |
|千葉県     |       36|※1      |
|東京都     |      124|1848     |
|神奈川県   |       64|※1      |
|新潟県     |       21|647      |
|富山県     |        0|54       |
|石川県     |        7|171      |
|福井県     |        1|92       |
|山梨県     |        2|335      |
|長野県     |        4|306      |
|岐阜県     |        3|272      |
|静岡県     |        3|※1      |
|愛知県     |      134|847      |
|三重県     |        9|318      |
|滋賀県     |        4|144      |
|京都府     |       20|800      |
|大阪府     |      119|2011     |
|兵庫県     |       91|1108     |
|奈良県     |        8|176      |
|和歌山県   |       16|1102     |
|鳥取県     |        0|115      |
|島根県     |        0|91       |
|岡山県     |        0|181      |
|広島県     |        1|552      |
|山口県     |        3|164      |
|徳島県     |        1|83       |
|香川県     |        1|128      |
|愛媛県     |        3|181      |
|高知県     |       12|270      |
|福岡県     |        5|626      |
|佐賀県     |        1|100      |
|長崎県     |        1|213      |
|熊本県     |        7|467      |
|大分県     |        3|167      |
|宮崎県     |        3|170      |
|鹿児島県   |        0|171      |
|沖縄県     |        3|238      |

```R
# ※1を手入力。愛知は名古屋分を加える。 
covid[covid$都道府県名=="神奈川県",3] <- 2591
covid[covid$都道府県名=="静岡県",3] <- 526
covid[covid$都道府県名=="千葉県",3] <- 1686
# 名古屋分を加える
covid[covid$都道府県名=="愛知県",3] <- 486+847
covid$検査人数<- as.numeric(covid$検査人数)
summary(covid)
#  都道府県名           陽性者数        検査人数     
# Length:47          Min.   :  0.0   Min.   :  29.0  
# Class :character   1st Qu.:  1.0   1st Qu.: 138.5  
# Mode  :character   Median :  3.0   Median : 213.0  
#                    Mean   : 19.7   Mean   : 495.8  
#                    3rd Qu.: 11.0   3rd Qu.: 589.0  
#                    Max.   :157.0   Max.   :2591.0
#
```

### 塗り分け地図作成

#### パッケージの読み込み。地図データ(NipponMapに含まれる)をsf形式に。

```R
library(NipponMap)
library(sf)
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

## (注意)上のcovidデータの都道府県の並びがこの順序になっているか確認する。

#### 地図作成

#### NipponMap::JapanPrefMap関数を参考にしました。

#### 保存する場合 pngの横縦の比　4:3(800:600)

### 陽性者数

```R
dat<- covid$陽性者数
st_crs(m) <- "+proj=longlat +datum=WGS84"
m[,"Cases"]<- dat
# 見やすい塗り分け地図を描くのに沖縄県の位置を動かすのでコピーしたオブジェクトを使う。
m0 <- m
m0$geometry[[47]] <- m0$geometry[[47]] + c(3.5,14)
ylim <- c(31, 45)
xlim <- c(130, 149)
# png("covmap01.png",width=800,height=600)
par(mar=c(0,0,0,0))
breaks=c(0,seq(1,9,2),seq(11,81,10),seq(91,181,30))
plot(m0["Cases"], breaks=breaks, key.pos=1,key.width =lcm(1.5),key.length =0.5,
	xlim = xlim, ylim = ylim,main="",pal= rev(heat.colors(length(breaks)-1)) ) 
#lines(x = c(132,135,137,137), y = c(38, 38,40,43))
lines(x = c(0.9*par("usr")[1]+0.1*par("usr")[2],0.74*par("usr")[1]+0.26*par("usr")[2],0.63*par("usr")[1]+0.37*par("usr")[2],0.63*par("usr")[1]+0.37*par("usr")[2]), 
	y = c(0.5*par("usr")[3]+0.5*par("usr")[4],0.5*par("usr")[3]+0.5*par("usr")[4],0.36*par("usr")[3]+0.64*par("usr")[4],0.14*par("usr")[3]+0.86*par("usr")[4]))
text(x=0.9*par("usr")[1]+0.1*par("usr")[2],y=0.1*par("usr")[3]+0.9*par("usr")[4],
	labels="PCR検査 陽性者数(都道府県別:3/19時点)",pos=4,cex=1.2)
# dev.off()
```

### 人口１万人あたりのPCR検査実施人数

#### 都道府県の人口は地図データに入っているものを使います。

```R
dat<- covid$検査人数
st_crs(m) <- "+proj=longlat +datum=WGS84"
m[,"Tested"]<- dat
# 人口１万人あたりの検査数
m[,"TestedPerPop"]<- round((10000*m$Tested)/m$population,4)
# 見やすい塗り分け地図を描くのに沖縄県の位置を動かすのでコピーしたオブジェクトを使う。
m0 <- m
m0$geometry[[47]] <- m0$geometry[[47]] + c(3.5,14)
ylim <- c(31, 45)
xlim <- c(130, 149)
# png("covmap02.png",width=800,height=600)
par(mar=c(0,0,0,0))
breaks=c(seq(0,0.8,0.2),seq(1,2.5,0.5),seq(3,15,1))
plot(m0["TestedPerPop"], breaks=breaks, key.pos=1,key.width =lcm(1.5),key.length =0.5,
	xlim = xlim, ylim = ylim,main="",pal=rev(heat.colors(length(breaks)-1)) ) 
#lines(x = c(132,135,137,137), y = c(38, 38,40,43))
lines(x = c(0.9*par("usr")[1]+0.1*par("usr")[2],0.74*par("usr")[1]+0.26*par("usr")[2],0.63*par("usr")[1]+0.37*par("usr")[2],0.63*par("usr")[1]+0.37*par("usr")[2]), 
	y = c(0.5*par("usr")[3]+0.5*par("usr")[4],0.5*par("usr")[3]+0.5*par("usr")[4],0.36*par("usr")[3]+0.64*par("usr")[4],0.14*par("usr")[3]+0.86*par("usr")[4]))
text(x=0.9*par("usr")[1]+0.1*par("usr")[2],y=0.1*par("usr")[3]+0.9*par("usr")[4],
	labels="人口１万人あたりのPCR検査実施人数(都道府県別:3/19時点)",pos=4,cex=1.1)
# dev.off()
```

### 表

```R
covid$人口１万人あたりのPCR検査実施人数<- m$TestedPerPop
kable(covid)
```

### 散布図

```R
# png("covidP01.png",width=800,height=800)
plot(人口１万人あたりのPCR検査実施人数~陽性者数,pch=16,bty="l",las=1,data=covid)
box(bty="l",lwd=2)
text(x=covid$陽性者数,y=covid$人口１万人あたりのPCR検査実施人数,labels=covid$都道府県名,pos=3)
# dev.off()
```


