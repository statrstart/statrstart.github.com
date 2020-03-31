---
title: Rで塗り分け地図（コロプレス図）(新型コロナウイルス：Coronavirus)
date: 2020-03-31
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

#### 表  

|都道府県名 | 陽性者数| 検査人数| 人口１万人あたりのPCR検査実施人数|
|:----------|--------:|--------:|---------------------------------:|
|北海道     |      177|     2076|                             3.770|
|青森県     |        7|      132|                             0.961|
|岩手県     |        0|       54|                             0.406|
|宮城県     |        6|      208|                             0.886|
|秋田県     |        4|      240|                             2.210|
|山形県     |        0|      198|                             1.694|
|福島県     |        2|      203|                             1.000|
|茨城県     |       20|      921|                             3.101|
|栃木県     |       12|      439|                             2.187|
|群馬県     |       18|      253|                             1.260|
|埼玉県     |       84|     1249|                             1.736|
|千葉県     |      160|     2078|                             3.343|
|東京都     |      449|     2986|                             2.269|
|神奈川県   |      115|     3311|                             3.659|
|新潟県     |       31|     1024|                             4.313|
|富山県     |        1|       79|                             0.723|
|石川県     |       11|      211|                             1.804|
|福井県     |       15|      160|                             1.984|
|山梨県     |        5|      454|                             5.260|
|長野県     |        8|      475|                             2.207|
|岐阜県     |       21|      629|                             3.023|
|静岡県     |        4|      701|                             1.862|
|愛知県     |      170|     2460|                             3.320|
|三重県     |       11|      437|                             2.356|
|滋賀県     |        6|      217|                             1.538|
|京都府     |       54|     1080|                             4.097|
|大阪府     |      217|     2980|                             3.361|
|兵庫県     |      136|     2399|                             4.293|
|奈良県     |       11|      292|                             2.085|
|和歌山県   |       17|     1452|                            14.488|
|鳥取県     |        0|      169|                             2.871|
|島根県     |        0|      130|                             1.812|
|岡山県     |        4|      309|                             1.588|
|広島県     |        6|      901|                             3.150|
|山口県     |        6|      257|                             1.771|
|徳島県     |        1|      123|                             1.566|
|香川県     |        1|      243|                             2.440|
|愛媛県     |        4|      250|                             1.746|
|高知県     |       15|      359|                             4.696|
|福岡県     |       23|     1033|                             2.037|
|佐賀県     |        1|      137|                             1.612|
|長崎県     |        2|      331|                             2.320|
|熊本県     |       11|      856|                             4.710|
|大分県     |       28|     1626|                            13.589|
|宮崎県     |        3|      272|                             2.396|
|鹿児島県   |        1|      263|                             1.541|
|沖縄県     |        9|      332|                             2.384|

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
# ４ベージの２ページめ
#res <- pdf_text("./covid19/000612830.pdf")[[2]]
res <- pdf_text("./covid19/000617079.pdf")
#都道府県名 陽性者数 検査人数 備考
txt<- sub("^.*備考","",sub("複数の検体を重複してカウントしているため.*$","",res))
txt<- gsub("※１","",txt)
txt<- gsub("※1","",txt)
txt<- gsub("3/13未確定","",txt)
txt<- gsub("3/16時点","",txt)
txt<- gsub("※2","",txt)
txt<- gsub(",","",txt)
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
title(title)
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
title(title)
# dev.off()
```

### 表

```R
Jtest$人口１万人あたりのPCR検査実施人数<- round((10000*Jtest$検査人数)/m$population,3)
kable(Jtest)
```

### 散布図

```R
# png("covidP01.png",width=800,height=800)
plot(人口１万人あたりのPCR検査実施人数~陽性者数,type="n",bty="l",las=1,data=Jtest)
box(bty="l",lwd=2)
text(x=Jtest$陽性者数,y=Jtest$人口１万人あたりのPCR検査実施人数,labels=Jtest$都道府県名)
# dev.off()
```

#### 感染者24人以下、人口１万人あたりのPCR検査実施人数 3人以下の都道府県のみプロット

```R
# png("covidP01_1.png",width=800,height=800)
plot(人口１万人あたりのPCR検査実施人数~陽性者数,type="n",bty="l",las=1,xlim=c(0,24),ylim=c(0,3),data=Jtest)
box(bty="l",lwd=2)
text(x=Jtest$陽性者数,y=Jtest$人口１万人あたりのPCR検査実施人数,labels=Jtest$都道府県名)
# dev.off()
```

