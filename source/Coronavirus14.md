---
title: Rで都道府県別塗り分け地図（コロプレス図）(新型コロナウイルス：Coronavirus)
date: 2020-07-20
tags: ["R","pdftools","sf","NipponMap", "BAMMtools","Coronavirus","Japan","新型コロナウイルス"]
excerpt: 都道府県別:人口100万人あたりの陽性者数等
---

# Rで塗り分け地図（コロプレス図）(新型コロナウイルス) 

![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus14)  

(参考:コロプレス図作成)[5. Plotting Simple Features](https://r-spatial.github.io/sf/articles/sf5.html)  

使用するデータ(厚生労働省：pdfファイル)  
[各都道府県の検査陽性者の状況（空港検疫、チャーター便案件を除く国内事例）](https://www.mhlw.go.jp/content/10906000/000636975.pdf)  

> 「PCR検査実施人数は、一部自治体について件数を計上している。」ので県別に比較はできない。
> ここでは"都道府県名","PCR検査陽性者","死亡"をとりあげます。
> 都道府県の人口は地図データに入っているものを使います。

#### pdfファイルから取り出して、加工した表  
(注意)「PCR検査実施人数は、一部自治体について件数を計上している。」ので県別に比較はできない。  
件数を計上している自治体は例えば、[国内における都道府県別のPCR検査陽性者数（2020年6月4日掲載分）](https://www.mhlw.go.jp/content/10906000/000636984.pdf)  
を見ればわかる。(※３ PCR検査実施人数は、一部自治体について件数を計上しているため、実際の人数より過大である。)  
※３のついている自治体は、「青森、岩手、宮城、福島、栃木、群馬、新潟、石川、福井、山梨、長野、三重、滋賀、大阪、広島、徳島、佐賀」（2020年6月4日現在）

|都道府県名 | 陽性者数| 検査実施人数| 入院治療等| うち重症| 退院又は療養解除| 死亡者数| 確認中|
|:----------|--------:|------------:|----------:|--------:|----------------:|--------:|------:|
|北海道     |     1326|        24768|         75|        5|             1149|      102|      0|
|青森       |       30|         1201|          4|        0|               25|        1|      0|
|岩手       |        0|         1224|          0|        0|                0|        0|      0|
|宮城       |      129|         5001|         28|        0|              100|        1|      0|
|秋田       |       16|         1032|          3|        0|               16|        0|      3|
|山形       |       75|         2803|          4|        0|               71|        1|      1|
|福島       |       84|         8456|          2|        0|               82|        0|      0|
|茨城       |      220|         6066|         20|        2|              190|       10|      0|
|栃木       |      118|        10552|         30|        0|               90|        0|      2|
|群馬       |      167|         6701|         12|        1|              136|       19|      0|
|埼玉       |     1668|        50480|        409|        4|             1192|       67|      0|
|千葉       |     1276|        23084|        235|        2|              995|       46|      0|
|東京       |     9223|       137338|       1894|       10|             7003|      326|      0|
|神奈川     |     1968|        15233|        262|        9|             1608|       98|      0|
|新潟       |       89|         5578|          5|        0|               83|        0|      1|
|富山       |      231|         4533|          3|        0|              206|       22|      0|
|石川       |      303|         3002|          7|        1|              269|       27|      0|
|福井       |      126|         3897|          4|        0|              114|        8|      0|
|山梨       |       77|         6427|          2|        0|               74|        1|      0|
|長野       |       84|         5055|          7|        0|               76|       NA|      1|
|岐阜       |      173|         6721|         15|        0|              151|        7|      0|
|静岡       |      104|         9608|         19|        0|               84|        1|      0|
|愛知       |      588|        15158|         68|        0|              486|       34|      0|
|三重       |       55|         3236|          7|        0|               46|        1|      1|
|滋賀       |      109|         3285|          5|        1|              103|        1|      0|
|京都       |      490|        13461|         77|        0|              395|       18|      0|
|大阪       |     2245|        51997|        286|        4|             1873|       86|      0|
|兵庫       |      801|        18644|         66|        0|              690|       45|      0|
|奈良       |      151|         5045|         46|        0|              103|        2|      0|
|和歌山     |       89|         4929|         16|        1|               70|        3|      0|
|鳥取       |        5|         2210|          2|        0|                3|        0|      0|
|島根       |       25|         1848|          1|        0|               24|        0|      0|
|岡山       |       36|         2286|          8|       NA|               28|       NA|      0|
|広島       |      205|         8806|         35|        0|              170|        3|      3|
|山口       |       42|         3133|          5|        0|               37|        0|      0|
|徳島       |       10|         1347|          5|        0|                4|        1|      0|
|香川       |       42|         3418|         14|        0|               28|        0|      0|
|愛媛       |       82|         2707|          0|        0|               77|        5|      0|
|高知       |       76|         2116|          2|        0|               71|        3|      0|
|福岡       |      972|        18945|         85|        3|              854|       33|      0|
|佐賀       |       47|         1774|          0|        0|               47|        0|      0|
|長崎       |       32|         4692|         15|        0|               16|        1|      0|
|熊本       |       50|         4527|          1|        0|               46|        3|      0|
|大分       |       60|         5675|          0|        0|               59|        1|      0|
|宮崎       |       20|         1770|          2|        0|               18|        0|      0|
|鹿児島     |      164|         8267|         75|        0|               89|        0|      0|
|沖縄       |      149|         3457|          4|        0|              142|        7|      0|

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
res <- pdf_text("https://www.mhlw.go.jp/content/10906000/000650237.pdf")
period<-paste0("令和",sub("時点.*$","",sub("^.*令和","",res)),"時点")
# c("都道府県名","PCR検査陽性者","PCR検査実施人数","入院治療等を要する者","うち重症","退院又は療養解除となった者の数","死亡","確認中")
txt<- gsub(",","",res)
txt<- sub("（その他）.*$","",txt)
txt<- sub("^.*北海道","北海道",txt)
txt<- gsub("   +","   ",txt)
txt<- gsub("   ",",",txt)
txt<- gsub(" ","",txt)
txt<- gsub("※4","",txt)
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

