---
title: Rで塗り分け地図（コロプレス図）(Coronavirus)
date: 2020-03-25
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
|北海道     |      163|     1794|                             3.258|
|青森県     |        2|       85|                             0.619|
|岩手県     |        0|       36|                             0.271|
|宮城県     |        1|      162|                             0.690|
|秋田県     |        2|      200|                             1.842|
|山形県     |        0|      147|                             1.258|
|福島県     |        2|      164|                             0.808|
|茨城県     |        5|      576|                             1.940|
|栃木県     |        6|      299|                             1.489|
|群馬県     |       13|      209|                             1.041|
|埼玉県     |       58|      898|                             1.248|
|千葉県     |       48|     1755|                             2.823|
|東京都     |      172|     2013|                             1.530|
|神奈川県   |       80|     2904|                             3.209|
|新潟県     |       28|      812|                             3.420|
|富山県     |        0|       67|                             0.613|
|石川県     |        8|      192|                             1.641|
|福井県     |        1|      114|                             1.414|
|山梨県     |        4|      370|                             4.287|
|長野県     |        5|      339|                             1.575|
|岐阜県     |       12|      317|                             1.523|
|静岡県     |        3|      584|                             1.551|
|愛知県     |      148|     1895|                             2.557|
|三重県     |        9|      368|                             1.984|
|滋賀県     |        5|      173|                             1.226|
|京都府     |       26|      930|                             3.528|
|大阪府     |      142|     2519|                             2.841|
|兵庫県     |      115|     1607|                             2.876|
|奈良県     |        9|      214|                             1.528|
|和歌山県   |       17|     1316|                            13.131|
|鳥取県     |        0|      129|                             2.191|
|島根県     |        0|      105|                             1.464|
|岡山県     |        1|      219|                             1.126|
|広島県     |        3|      656|                             2.293|
|山口県     |        4|      192|                             1.323|
|徳島県     |        1|       96|                             1.222|
|香川県     |        1|      160|                             1.607|
|愛媛県     |        3|      215|                             1.502|
|高知県     |       12|      307|                             4.016|
|福岡県     |        9|      703|                             1.386|
|佐賀県     |        1|      115|                             1.353|
|長崎県     |        1|      253|                             1.773|
|熊本県     |        7|      543|                             2.988|
|大分県     |       18|      743|                             6.210|
|宮崎県     |        3|      205|                             1.806|
|鹿児島県   |        0|      196|                             1.149|
|沖縄県     |        4|      271|                             1.946|

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

#### 全４ページの２ページめ

```R
# install.packages("pdftools")
library(pdftools)
library(knitr)
#https://www.mhlw.go.jp/content/10906000/000612830.pdf
# ４ベージの２ページめ
res <- pdf_text("./covid19/000612830.pdf")[[2]]
#都道府県名 陽性者数 検査人数 備考
txt<- sub("^.*備考","",sub("複数の検体を重複してカウントしているため.*$","",res))
txt<- gsub("※１","",txt)
txt<- gsub("※1","",txt)
txt<- gsub("3/13未確定","",txt)
txt<- gsub("3/16時点","",txt)
txt<- gsub("※2","",txt)
txt<- gsub(",","",txt)
# stringsAsFactors = Fをつけて、Factor化を防ぐ。
covid<- read.table(text=txt,stringsAsFactors = F,nrow=24)
#kable(covid,row.names =F)
#
# 1から3列、4から6列に分けつなぐ。合計は取り除く。
d1<-covid[,1:3] ; d2<-covid[,4:6]
colnames(d1)<- colnames(d2)<- c("都道府県名", "陽性者数", "検査人数")
covid<- rbind(d1,d2)[1:47,]
#kable(covid,row.names =F)
#
#神奈川県においてはクルーズ船を含む2835件の検査が行われた。
#千葉県において3/20までに1716件、
#大阪府において3/22までに2350件の検査が行われた。
#なお、千葉県は3/21より、神奈川県は3/23より、大阪府は3/22より検査人数を計上している。
# ※1を手入力。 
covid[covid$都道府県名=="神奈川県",3] <- covid[covid$都道府県名=="神奈川県",3] + 2835
covid[covid$都道府県名=="千葉県",3] <- covid[covid$都道府県名=="千葉県",3] + 1716
covid[covid$都道府県名=="大阪府",3] <- covid[covid$都道府県名=="大阪府",3] + 2350
#
#covid$陽性者数<- as.numeric(covid$陽性者数)
#covid$検査人数<- as.numeric(covid$検査人数)
summary(covid)
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

## (注意)上のcovidデータの都道府県の並びがこの順序になっているか確認する。

### 地図作成

BAMMtoolsパッケージのgetJenksBreaks関数を使い値の区切りを決めます。  
グループの数も指定せずに済むようにしました。

#### 陽性者数

```R
dat<- covid$陽性者数
# legendのタイトル
ltitle<- "陽性者数"
# グラフのタイトル
title<- "PCR検査 陽性者数(都道府県別:3/24時点)"
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
dat<- round((10000*covid$検査人数)/m$population,3)
# legendのタイトル
ltitle<- ""
# グラフのタイトル
title<- "人口１万人あたりのPCR検査実施人数(都道府県別:3/24時点)"
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
covid$人口１万人あたりのPCR検査実施人数<- round((10000*covid$検査人数)/m$population,3)
kable(covid)
```

### 散布図

```R
# png("covidP01.png",width=800,height=800)
plot(人口１万人あたりのPCR検査実施人数~陽性者数,type="n",bty="l",las=1,data=covid)
box(bty="l",lwd=2)
text(x=covid$陽性者数,y=covid$人口１万人あたりのPCR検査実施人数,labels=covid$都道府県名)
# dev.off()
```

#### 感染者12人以下、人口１万人あたりのPCR検査実施人数 3人以下の都道府県のみプロット

```R
# png("covidP01_1.png",width=800,height=800)
plot(人口１万人あたりのPCR検査実施人数~陽性者数,type="n",bty="l",las=1,xlim=c(0,12),ylim=c(0,3),data=covid)
box(bty="l",lwd=2)
text(x=covid$陽性者数,y=covid$人口１万人あたりのPCR検査実施人数,labels=covid$都道府県名)
# dev.off()
```

