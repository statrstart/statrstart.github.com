---
title: Rで塗り分け地図（コロプレス図）(Coronavirus)
date: 2020-03-22
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
|北海道     |      158|     1652|                             3.000|
|青森県     |        0|       85|                             0.619|
|岩手県     |        0|       29|                             0.218|
|宮城県     |        1|      148|                             0.630|
|秋田県     |        2|      114|                             1.050|
|山形県     |        0|      133|                             1.138|
|福島県     |        2|      132|                             0.651|
|茨城県     |        3|      464|                             1.562|
|栃木県     |        3|      263|                             1.310|
|群馬県     |       11|      173|                             0.862|
|埼玉県     |       41|      684|                             0.951|
|千葉県     |       41|     1706|                             2.744|
|東京都     |      135|     1848|                             1.404|
|神奈川県   |       65|     2591|                             2.864|
|新潟県     |       21|      647|                             2.725|
|富山県     |        0|       54|                             0.494|
|石川県     |        8|      175|                             1.496|
|福井県     |        1|       97|                             1.203|
|山梨県     |        2|      337|                             3.905|
|長野県     |        4|      306|                             1.422|
|岐阜県     |        3|      279|                             1.341|
|静岡県     |        3|      535|                             1.421|
|愛知県     |      139|     1333|                             1.799|
|三重県     |        9|      318|                             1.715|
|滋賀県     |        4|      144|                             1.021|
|京都府     |       21|      806|                             3.058|
|大阪府     |      123|     2025|                             2.284|
|兵庫県     |      100|     1120|                             2.004|
|奈良県     |        8|      177|                             1.264|
|和歌山県   |       17|     1110|                            11.076|
|鳥取県     |        0|      115|                             1.954|
|島根県     |        0|       91|                             1.268|
|岡山県     |        0|      181|                             0.930|
|広島県     |        2|      569|                             1.989|
|山口県     |        3|      164|                             1.130|
|徳島県     |        1|       83|                             1.057|
|香川県     |        1|      133|                             1.336|
|愛媛県     |        3|      181|                             1.264|
|高知県     |       12|      270|                             3.532|
|福岡県     |        5|      626|                             1.234|
|佐賀県     |        1|      102|                             1.200|
|長崎県     |        1|      213|                             1.493|
|熊本県     |        7|      476|                             2.619|
|大分県     |        8|      175|                             1.463|
|宮崎県     |        3|      179|                             1.577|
|鹿児島県   |        0|      171|                             1.002|
|沖縄県     |        3|      238|                             1.709|

### 散布図

![covidP01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covidP01.png)

#### (上のグラフでは見づらい)感染者１０人以下、人口１万人あたりのPCR検査実施人数 ２人以下の都道府県のみプロット

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
#https://www.mhlw.go.jp/content/10906000/000610714.pdf
res <- pdf_text("./covid19/000610714.pdf")
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
|北海道   | 158|1652 |滋賀県   |   4|   144|
|青森県   |   0|85   |京都府   |  21|   806|
|岩手県   |   0|29   |大阪府   | 123|  2025|
|宮城県   |   1|148  |兵庫県   | 100|  1120|
|秋田県   |   2|114  |奈良県   |   8|   177|
|山形県   |   0|133  |和歌山県 |  17|  1110|
|福島県   |   2|132  |鳥取県   |   0|   115|
|茨城県   |   3|464  |島根県   |   0|    91|
|栃木県   |   3|263  |岡山県   |   0|   181|
|群馬県   |  11|173  |広島県   |   2|   569|
|埼玉県   |  41|684  |山口県   |   3|   164|
|千葉県   |  41|※1  |徳島県   |   1|    83|
|東京都   | 135|1848 |香川県   |   1|   133|
|神奈川県 |  65|※1  |愛媛県   |   3|   181|
|新潟県   |  21|647  |高知県   |  12|   270|
|富山県   |   0|54   |福岡県   |   5|   626|
|石川県   |   8|175  |佐賀県   |   1|   102|
|福井県   |   1|97   |長崎県   |   1|   213|
|山梨県   |   2|337  |熊本県   |   7|   476|
|長野県   |   4|306  |大分県   |   8|   175|
|岐阜県   |   3|279  |宮崎県   |   3|   179|
|静岡県   |   3|※1  |鹿児島県 |   0|   171|
|愛知県   | 139|847  |沖縄県   |   3|   238|
|三重県   |   9|318  |合計     | 975| 18134|


```R
# 1から3列、4から6列に分けつなぐ。合計は取り除く。
d1<-covid[,1:3] ; d2<-covid[,4:6]
colnames(d1)<- colnames(d2)<- c("都道府県名", "陽性者数", "検査人数")
covid<- rbind(d1,d2)[1:47,]
kable(covid,row.names =F)
```

|都道府県名 | 陽性者数|検査人数 |
|:----------|--------:|:--------|
|北海道     |      158|1652     |
|青森県     |        0|85       |
|岩手県     |        0|29       |
|宮城県     |        1|148      |
|秋田県     |        2|114      |
|山形県     |        0|133      |
|福島県     |        2|132      |
|茨城県     |        3|464      |
|栃木県     |        3|263      |
|群馬県     |       11|173      |
|埼玉県     |       41|684      |
|千葉県     |       41|※1      |
|東京都     |      135|1848     |
|神奈川県   |       65|※1      |
|新潟県     |       21|647      |
|富山県     |        0|54       |
|石川県     |        8|175      |
|福井県     |        1|97       |
|山梨県     |        2|337      |
|長野県     |        4|306      |
|岐阜県     |        3|279      |
|静岡県     |        3|※1      |
|愛知県     |      139|847      |
|三重県     |        9|318      |
|滋賀県     |        4|144      |
|京都府     |       21|806      |
|大阪府     |      123|2025     |
|兵庫県     |      100|1120     |
|奈良県     |        8|177      |
|和歌山県   |       17|1110     |
|鳥取県     |        0|115      |
|島根県     |        0|91       |
|岡山県     |        0|181      |
|広島県     |        2|569      |
|山口県     |        3|164      |
|徳島県     |        1|83       |
|香川県     |        1|133      |
|愛媛県     |        3|181      |
|高知県     |       12|270      |
|福岡県     |        5|626      |
|佐賀県     |        1|102      |
|長崎県     |        1|213      |
|熊本県     |        7|476      |
|大分県     |        8|175      |
|宮崎県     |        3|179      |
|鹿児島県   |        0|171      |
|沖縄県     |        3|238      |

```R
# ※1を手入力。愛知は名古屋分を加える。 
covid[covid$都道府県名=="神奈川県",3] <- 2591
covid[covid$都道府県名=="静岡県",3] <- 535
covid[covid$都道府県名=="千葉県",3] <- 1706
covid[covid$都道府県名=="愛知県",3] <- 847+486
covid$検査人数<- as.numeric(covid$検査人数)
summary(covid)
#  都道府県名           陽性者数         検査人数     
# Length:47          Min.   :  0.00   Min.   :  29.0  
# Class :character   1st Qu.:  1.00   1st Qu.: 138.5  
# Mode  :character   Median :  3.00   Median : 213.0  
#                    Mean   : 20.74   Mean   : 499.0  
#                    3rd Qu.: 11.50   3rd Qu.: 597.5  
#                    Max.   :158.00   Max.   :2591.0 
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
title<- "PCR検査 陽性者数(都道府県別:3/20時点)"
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
title<- "人口１万人あたりのPCR検査実施人数(都道府県別:3/20時点)"
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

#### 感染者12人以下、人口１万人あたりのPCR検査実施人数 ２人以下の都道府県のみプロット

```R
# png("covidP01_1.png",width=800,height=800)
plot(人口１万人あたりのPCR検査実施人数~陽性者数,type="n",bty="l",las=1,xlim=c(0,12),ylim=c(0,2),data=covid)
box(bty="l",lwd=2)
text(x=covid$陽性者数,y=covid$人口１万人あたりのPCR検査実施人数,labels=covid$都道府県名)
# dev.off()
```

