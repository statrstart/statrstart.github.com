---
title: Rで塗り分け地図（コロプレス図）(新型コロナウイルス：Coronavirus)
date: 2020-03-29
tags: ["R","pdftools","sf","NipponMap", "BAMMtools","Coronavirus","Japan","新型コロナウイルス"]
excerpt: Rで塗り分け地図（コロプレス図）(Coronavirus)
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
|北海道     |      168|     1929|                             3.503|
|青森県     |        6|      116|                             0.845|
|岩手県     |        0|       44|                             0.331|
|宮城県     |        2|      180|                             0.767|
|秋田県     |        2|      207|                             1.906|
|山形県     |        0|      165|                             1.412|
|福島県     |        2|      177|                             0.872|
|茨城県     |       10|      716|                             2.411|
|栃木県     |       10|      343|                             1.708|
|群馬県     |       14|      241|                             1.200|
|埼玉県     |       66|     1033|                             1.436|
|千葉県     |       56|     1824|                             2.934|
|東京都     |      265|     2182|                             1.658|
|神奈川県   |       89|     3053|                             3.374|
|新潟県     |       29|      920|                             3.875|
|富山県     |        0|       69|                             0.631|
|石川県     |        8|      195|                             1.667|
|福井県     |        6|      119|                             1.476|
|山梨県     |        4|      401|                             4.646|
|長野県     |        5|      371|                             1.724|
|岐阜県     |       16|      374|                             1.797|
|静岡県     |        3|      645|                             1.713|
|愛知県     |      157|     2204|                             2.974|
|三重県     |        9|      387|                             2.087|
|滋賀県     |        6|      138|                             0.978|
|京都府     |       32|      996|                             3.778|
|大阪府     |      157|     2712|                             3.059|
|兵庫県     |      118|     2031|                             3.634|
|奈良県     |        9|      231|                             1.649|
|和歌山県   |       17|     1405|                            14.019|
|鳥取県     |        0|      141|                             2.395|
|島根県     |        0|      109|                             1.519|
|岡山県     |        1|      243|                             1.249|
|広島県     |        4|      722|                             2.524|
|山口県     |        6|      210|                             1.447|
|徳島県     |        1|      104|                             1.324|
|香川県     |        1|      191|                             1.918|
|愛媛県     |        3|      223|                             1.558|
|高知県     |       12|      314|                             4.107|
|福岡県     |       11|      777|                             1.532|
|佐賀県     |        1|      124|                             1.459|
|長崎県     |        2|      279|                             1.955|
|熊本県     |        8|      595|                             3.274|
|大分県     |       25|     1389|                            11.609|
|宮崎県     |        3|      235|                             2.070|
|鹿児島県   |        1|      215|                             1.260|
|沖縄県     |        4|      285|                             2.046|

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
res <- pdf_text("./covid19/000614565.pdf")
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

#### 感染者12人以下、人口１万人あたりのPCR検査実施人数 3人以下の都道府県のみプロット

```R
# png("covidP01_1.png",width=800,height=800)
plot(人口１万人あたりのPCR検査実施人数~陽性者数,type="n",bty="l",las=1,xlim=c(0,12),ylim=c(0,3),data=Jtest)
box(bty="l",lwd=2)
text(x=Jtest$陽性者数,y=Jtest$人口１万人あたりのPCR検査実施人数,labels=Jtest$都道府県名)
# dev.off()
```

