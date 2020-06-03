---
title: Rで都道府県別塗り分け地図（コロプレス図）(新型コロナウイルス：Coronavirus)
date: 2020-06-03
tags: ["R","pdftools","sf","NipponMap", "BAMMtools","Coronavirus","Japan","新型コロナウイルス"]
excerpt: 都道府県別:人口100万人あたりの陽性者数等
---

# Rで塗り分け地図（コロプレス図）(新型コロナウイルス) 

![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus14)  

(参考:コロプレス図作成)[5. Plotting Simple Features](https://r-spatial.github.io/sf/articles/sf5.html)  

使用するデータ(厚生労働省：pdfファイル)  
[各都道府県の検査陽性者の状況（空港検疫、チャーター便案件を除く国内事例）](https://www.mhlw.go.jp/content/10906000/000636582.pdf)  

> 「PCR検査実施人数は、一部自治体について件数を計上している。」ので県別に比較はできない。
> ここでは"都道府県名","PCR検査陽性者","死亡"をとりあげます。
> 都道府県の人口は地図データに入っているものを使います。

#### pdfファイルから取り出して、加工した表  

|都道府県名 | 陽性者数| 検査実施人数| 入院治療等| うち重症| 退院又は療養解除| 死亡者数| 確認中|
|:----------|--------:|------------:|----------:|--------:|----------------:|--------:|------:|
|北海道     |     1096|        14593|        197|       11|              812|       87|      0|
|青森       |       27|          857|          0|        0|               26|        1|      0|
|岩手       |        0|          695|          0|        0|                0|        0|      0|
|宮城       |       88|         2952|          0|        0|               87|        1|      0|
|秋田       |       16|          935|          0|        0|               16|        0|      0|
|山形       |       69|         2665|          3|        1|               66|        0|      0|
|福島       |       81|         4588|          6|        0|               75|        0|      0|
|茨城       |      168|         4691|          5|        0|              153|       10|      0|
|栃木       |       66|         3973|         14|        1|               53|        0|      0|
|群馬       |      149|         3713|          8|        1|              122|       19|      0|
|埼玉       |     1003|        21810|         50|        4|              905|       48|      0|
|千葉       |      906|        14881|         37|        4|              824|       45|      0|
|東京       |     5283|        15282|        391|       26|             4586|      306|      0|
|神奈川     |     1373|         9974|        164|       19|             1123|       86|      0|
|新潟       |       83|         4216|          1|        0|               81|        0|      1|
|富山       |      227|         3407|         12|        0|              193|       22|      0|
|石川       |      298|         2733|         46|        2|              227|       25|      0|
|福井       |      122|         2675|          2|        1|              112|        8|      0|
|山梨       |       64|         4088|          4|        0|               59|        1|      0|
|長野       |       76|         2733|          5|        0|               71|       NA|      0|
|岐阜       |      151|         3652|          3|        1|              141|        7|      0|
|静岡       |       76|         3539|          2|        0|               73|        1|      0|
|愛知       |      508|        10211|         12|        0|              457|       34|      5|
|三重       |       45|         2508|          0|        0|               44|        1|      0|
|滋賀       |      100|         1874|          8|        1|               91|        1|      0|
|京都       |      358|         8135|         16|        1|              325|       17|      0|
|大阪       |     1783|        31646|         93|       15|             1602|       84|      4|
|兵庫       |      699|        11206|         25|        4|              632|       42|      0|
|奈良       |       92|         2545|          2|        0|               88|        2|      0|
|和歌山     |       63|         3713|          3|        0|               57|        3|      0|
|鳥取       |        3|         1353|          0|        0|                3|        0|      0|
|島根       |       24|         1132|          2|        1|               22|        0|      0|
|岡山       |       25|         1716|          0|       NA|               25|       NA|      0|
|広島       |      167|         7011|          6|        0|              158|        3|      0|
|山口       |       37|         1771|          1|        1|               36|        0|      0|
|徳島       |        5|          745|          0|        0|                4|        1|      0|
|香川       |       28|         2202|          0|        0|               28|        0|      0|
|愛媛       |       82|         2262|         24|        1|               54|        4|      0|
|高知       |       74|         1801|          0|        0|               71|        3|      0|
|福岡       |      774|        12967|        121|        4|              626|       27|      0|
|佐賀       |       47|         1428|          0|        0|               45|        0|      2|
|長崎       |       17|         2798|          0|        0|               16|        1|      0|
|熊本       |       48|         3939|          1|        0|               44|        3|      0|
|大分       |       60|         4050|          1|        0|               58|        1|      0|
|宮崎       |       17|         1391|          0|        0|               17|        0|      0|
|鹿児島     |       10|         1880|          0|        0|               10|        0|      0|
|沖縄       |      142|         2872|          3|        2|              137|        6|      0|

#### 陽性者数

![covmap21](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covmap21.png)

### ここからは、人口を考慮に入れて作図します。

#### 人口100万人あたりのPCR検査陽性者数

![covmap22](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covmap22.png)

#### 人口100万人あたりの新型コロナウイルスによる死亡者数

![covmap23](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covmap23.png)

### 人口100万人あたりのPCR検査陽性者数の棒グラフ(都道府県別)の棒グラフ

![covidB21](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covidB21.png)

### 散布図(人口100万人あたりのPCR検査陽性者数,人口100万人あたりの新型コロナウイルスによる死亡者数)

![covidP21](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covidP21.png)

#### 人口100万人あたりのPCR検査陽性者数80人以下、人口100万人あたりの新型コロナウイルスによる死亡者数5人以下の都道府県のみプロット

![covidP22](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covidP22.png)

## Rコード

### pdfファイルからデータの取り込み。加工。

- pdfファイルからデータの取り込み（pdftools::pdf_text）
- 余分な部分を削除(sub,gsub関数)
- data.frameへ（read.table(text=txt,stringsAsFactors = F)　）

```R
# install.packages("pdftools")
library(pdftools)
library(knitr)
#
res <- pdf_text("https://www.mhlw.go.jp/content/10906000/000636582.pdf")
#res <- pdf_text("./covid19/000636582.pdf")
period<-paste0("令和",sub("時点.*$","",sub("^.*令和","",res)),"時点")
# c("都道府県名","PCR検査陽性者","PCR検査実施人数","入院治療等を要する者","うち重症","退院又は療養解除となった者の数","死亡","確認中")
txt<- gsub(",","",res)
txt<- sub("（その他）.*$","",txt)
txt<- sub("^.*北海道","北海道",txt)
txt<- gsub("   +","   ",txt)
txt<- gsub("   ",",",txt)
txt<- gsub(" ","",txt)
txt<- gsub("※5","",txt)
txt<- gsub("-","NA",txt)
txt<- gsub("\n,","\n",txt)
# stringsAsFactors = Fをつけて、Factor化を防ぐ。
Jtest<- read.csv(text=txt,stringsAsFactors = F,h=F)
colnames(Jtest)<- c("都道府県名","陽性者数","検査実施人数","入院治療等","うち重症","退院又は療養解除","死亡者数","確認中")
# 「PCR検査実施人数は、一部自治体について件数を計上している。」ので県別に比較はできない。
# ここでは"都道府県名","PCR検査陽性者","死亡"をとりあげる。
summary(Jtest)
kable(Jtest)
save(Jtest,file="Jtest.Rdata")
#load("Jtest.Rdata")
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
#png("covmap21.png",width=800,height=800)
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
#dev.off()
```

#### 人口100万人あたりのPCR検査陽性者数

#### 都道府県の人口は地図データに入っているものを使います。

```R
# 人口100万人あたりの陽性者数
dat<- round((1000000*Jtest$陽性者数)/m$population,1)
# legendのタイトル
ltitle<- ""
# グラフのタイトル
title<- "人口100万人あたりのPCR検査陽性者数(都道府県別)"
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
#png("covmap22.png",width=800,height=800)
par(mar=c(0,0,4,0))
JapanPrefMap(col=cols)
legend(x=144,y=40, legend=labels, fill=color,title =ltitle)
title(paste(title,period))
#dev.off()
```

### 人口100万人あたりの新型コロナウイルスによる死亡者数

```R
# 人口100万人あたりの死亡者数
dat<- round((1000000*Jtest$死亡者数)/m$population,1)
# legendのタイトル
ltitle<- ""
# グラフのタイトル
title<- "人口100万人あたりの新型コロナウイルスによる死亡者数(都道府県別)"
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
#png("covmap23.png",width=800,height=800)
par(mar=c(0,0,4,0))
JapanPrefMap(col=cols)
legend(x=144,y=40, legend=labels, fill=color,title =ltitle)
title(paste(title,period))
#dev.off()
```

### 人口100万人あたりのPCR検査陽性者数の棒グラフ

```R
dat<- Jtest[,c("都道府県名","陽性者数")]
dat$人口100万人あたりのPCR検査陽性者数<- round((1000000*Jtest$陽性者数)/m$population,1)
dat<- dat[order(dat$人口100万人あたりのPCR検査陽性者数),]
# グラフのタイトル
title<- "人口100万人あたりのPCR検査陽性者数(人)(都道府県別)"
#
#png("covidB21.png",width=800,height=800)
par(mar=c(3,7,4,2))
b<- barplot(dat$人口100万人あたりのPCR検査陽性者数,names=dat$都道府県名,horiz=T,col="pink",las=1,
	xlim=c(0,max(dat$人口100万人あたりのPCR検査陽性者数)*1.2))
text(x=dat$人口100万人あたりのPCR検査陽性者数,y=b,labels=paste(dat$人口100万人あたりのPCR検査陽性者数,"人"),pos=4)
title(paste(title,period))
#dev.off()
```

### 散布図(人口100万人あたりのPCR検査陽性者数,人口100万人あたりの新型コロナウイルスによる死亡者数)

```R
x<- round((1000000*Jtest$陽性者数)/m$population,1)
y<- round((1000000*Jtest$死亡者数)/m$population,1)
#png("covidP21.png",width=800,height=800)
plot(x,y,type="n",bty="l",las=1,
	xlab="人口100万人あたりのPCR検査陽性者数",ylab="人口100万人あたりの新型コロナウイルスによる死亡者数")
box(bty="l",lwd=2)
text(x=x,y=y,labels=Jtest$都道府県名)
title(paste0("散布図 その1 (",period,")\n(人口100万人あたりのPCR検査陽性者数,人口100万人あたりの新型コロナウイルスによる死亡者数)"))
#dev.off()
```

#### 人口100万人あたりのPCR検査陽性者数80人以下、人口100万人あたりの新型コロナウイルスによる死亡者数5人以下の都道府県のみプロット

```R
x<- round((1000000*Jtest$陽性者数)/m$population,1)
y<- round((1000000*Jtest$死亡者数)/m$population,1)
#png("covidP22.png",width=800,height=800)
plot(x,y,type="n",bty="l",las=1,xlim=c(0,80),ylim=c(0,5),
	xlab="人口100万人あたりのPCR検査陽性者数",ylab="人口100万人あたりの新型コロナウイルスによる死亡者数")
box(bty="l",lwd=2)
text(x=x,y=y,labels=Jtest$都道府県名)
title(paste0("散布図 その２ (",period,")\n(人口100万人あたりのPCR検査陽性者数,人口100万人あたりの新型コロナウイルスによる死亡者数)"))
#dev.off()
```

