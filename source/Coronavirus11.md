---
title: COVID-19 testing(Coronavirus)でbarplot
date: 2020-03-24
tags: ["R","rvest","Coronavirus","Japan","新型コロナウイルス"]
excerpt: COVID-19 testing(Coronavirus)でbarplot
---

# COVID-19 testing(Coronavirus)でbarplot

![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus11)  

### Wikipediaに国・地域別の検査数、人口100万人あたり検査数の表がありました。  
[Wikipedia:COVID-19 testing](https://en.wikipedia.org/wiki/COVID-19_testing)  

これを棒グラフにします。

# 国別で比較することで日本がいかに検査していないかがわかると思います。

(参考)  
[データのじかん: データでみる世界各国の新型コロナウイルスの検査状況！](https://data.wingarc.com/covid-19-tests-25207)  
[How many tests for COVID-19 are being performed around the world?](https://ourworldindata.org/covid-testing#note-2)  

[CDC:Testing in U.S.](https://www.cdc.gov/coronavirus/2019-ncov/cases-updates/testing-in-us.html)  
[CORONAVIRUS DATA: Tracking COVID-19 testing across the U.S.](https://www.clickondetroit.com/health/2020/03/13/coronavirus-data-tracking-covid-19-testing-across-the-us/)


#### Total Tests

#### Positive>=300

![covtested01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covtested01.png)

#### Positive<300

![covtested02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covtested02.png)

### 日本の値に赤い破線を引きました。レンジは揃えています。

#### 人口を加味（人口 100万人あたりの検査数）

# 日本、驚くほど検査していない。

#### Positive>=300

![covtested03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covtested03.png)

#### ggplot2,grid パッケージで作ってみたグラフ(更新はしません)

![overlay01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/overlay01.png)

#### Positive<300

![covtested04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covtested04.png)

### 日本の値に赤い破線を引きました。レンジは揃えています。

## Rコード

### rvestパッケージを用いてデータの取り込み。加工。

```R
library("rvest")
# "COVID-19 testing"のデータ取得
html <- read_html("https://en.wikipedia.org/wiki/COVID-19_testing")
tbl<- html_table(html,fill = T)
covid<- tbl[[2]][,1:6]
#
for (i in c(2,3,5)){
	covid[,i]<- as.numeric(gsub(",","",covid[,i]))
}
str(covid)
```

### Positive>=300とPositive<300に分けてプロットします。
#### rangeは同じにします。

### Total Test

#### Positive>=300だけを抽出

```R
min<- 300
dat<- covid[!is.na(covid[,3]),]
dat<- dat[dat[,3]>=min,]
#
lim<-max(covid[,2],na.rm=T)
# 日本の値をjnumへ
jnum<- dat[dat[,1]=="Japan",2]
# Testsで並べ替え
dat<- dat[order(dat[,2]),]
color<- is.element(dat[,1],"Japan")
col<- gsub("FALSE","lightblue",gsub("TRUE","red",color))
col2<- gsub("FALSE","black",gsub("TRUE","red",color))
# png("covtested01.png",width=800,height=800)
par(mar=c(3,12,3,3),family="serif")
b<- barplot(dat[,2],horiz=T,col=col,xaxt="n",xlim=c(0,lim))
axis(side=1, at=axTicks(1), labels=formatC(axTicks(1), format="d", big.mark=','))
axis(2,at=b,labels=NA,col=col2,tck=-0.01)
text(x=par("usr")[1],y=b, labels = dat[,1], col = col2,pos=2,xpd=T)
# bquote
title(bquote("Total Tests for COVID-19("~Positive>=.(min)~")"))
abline(v=jnum,lty=2,col="red")
# dev.off()
```

#### Positive<300だけを抽出

```R
max<- 300
dat<- covid[!is.na(covid[,3]),]
dat<- dat[dat[,3]<max,]
#
# Testsで並べ替え
dat<- dat[order(dat[,2]),]
color<- is.element(dat[,1],"Japan")
col<- gsub("FALSE","lightblue",gsub("TRUE","red",color))
col2<- gsub("FALSE","black",gsub("TRUE","red",color))
# png("covtested02.png",width=800,height=800)
par(mar=c(3,12,3,3),family="serif")
b<- barplot(dat[,2],horiz=T,col=col,xaxt="n",xlim=c(0,lim))
axis(side=1, at=axTicks(1), labels=formatC(axTicks(1), format="d", big.mark=','))
axis(2,at=b,labels=NA,col=col2,tck=-0.01)
text(x=par("usr")[1],y=b, labels = dat[,1], col = col2,pos=2,xpd=T)
# bquote
title(bquote("Total Tests for COVID-19("~Positive<.(max)~")"))
abline(v=jnum,lty=2,col="red")
# dev.off()
```

### 人口100万人あたり

#### Positive>=300だけを抽出

```R
min<- 300
dat<- covid[!is.na(covid[,3]),]
dat<- dat[dat[,3]>=min,]
#
lim<-max(covid[,5],na.rm=T)
jnum<- dat[dat[,1]=="Japan",5]
#
# Tests /millionで並べ替え
dat<- dat[order(dat[,5]),]
color<- is.element(dat[,1],"Japan")
col<- gsub("FALSE","lightblue",gsub("TRUE","red",color))
col2<- gsub("FALSE","black",gsub("TRUE","red",color))
# png("covtested03.png",width=800,height=800)
par(mar=c(3,12,3,3),family="serif")
b<- barplot(dat[,5],horiz=T,col=col,xaxt="n",xlim=c(0,lim))
axis(side=1, at=axTicks(1), labels=formatC(axTicks(1), format="d", big.mark=','))
axis(2,at=b,labels=NA,col=col2,tck=-0.01)
text(x=par("usr")[1],y=b, labels = dat[,1], col = col2,pos=2,xpd=T)
# bquote
title(bquote("Tests /million for COVID-19("~Positive>=.(min)~")"))
abline(v=jnum,lty=2,col="red")
# dev.off()
```

#### Positive<300だけを抽出

```R
max<- 300
dat<- covid[!is.na(covid[,3]),]
dat<- dat[dat[,3]<max,]
#
# Tests /millionで並べ替え
dat<- dat[order(dat[,5]),]
color<- is.element(dat[,1],"Japan")
col<- gsub("FALSE","lightblue",gsub("TRUE","red",color))
col2<- gsub("FALSE","black",gsub("TRUE","red",color))
# png("covtested04.png",width=800,height=800)
par(mar=c(3,12,3,3),family="serif")
b<- barplot(dat[,5],horiz=T,col=col,xaxt="n",xlim=c(0,lim))
axis(side=1, at=axTicks(1), labels=formatC(axTicks(1), format="d", big.mark=','))
axis(2,at=b,labels=NA,col=col2,tck=-0.01)
text(x=par("usr")[1],y=b, labels = dat[,1], col = col2,pos=2,xpd=T)
# bquote
title(bquote("Tests /million for COVID-19("~Positive<.(max)~")"))
abline(v=jnum,lty=2,col="red")
# dev.off()
```

#### ggplot2 gridパッケージ

都道府県データ : [Rで塗り分け地図（コロプレス図）(Coronavirus)](https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus10)  

```R
# install.packages("pdftools")
library(pdftools)
library(sf)
library(NipponMap)
#https://www.mhlw.go.jp/content/10906000/000610714.pdf
res <- pdf_text("./covid19/000610714.pdf")
#都道府県名 陽性者数 検査人数 備考
txt<- sub("^.*備考","",sub("複数の検体を重複してカウントしているため.*$","",res))
txt<- gsub("※１","",txt)
txt<- gsub("3/13未確定","",txt)
txt<- gsub("3/16時点","",txt)
txt<- gsub("※2","",txt)
# stringsAsFactors = Fをつけて、Factor化を防ぐ。
cov<- read.table(text=txt,stringsAsFactors = F)
# 1から3列、4から6列に分けつなぐ。合計は取り除く。
d1<-cov[,1:3] ; d2<-cov[,4:6]
colnames(d1)<- colnames(d2)<- c("都道府県名", "陽性者数", "検査人数")
cov<- rbind(d1,d2)[1:47,]
# ※1を手入力。愛知は名古屋分を加える。 
cov[cov$都道府県名=="神奈川県",3] <- 2591
cov[cov$都道府県名=="静岡県",3] <- 535
cov[cov$都道府県名=="千葉県",3] <- 1706
cov[cov$都道府県名=="愛知県",3] <- 847+486
cov$検査人数<- as.numeric(cov$検査人数)
#
shp <- system.file("shapes/jpn.shp", package = "NipponMap")[1]
m <- sf::read_sf(shp)
# 人口100万人あたりの検査数
cov$人口100万人あたりの検査数<- round((1000000*cov$検査人数)/m$population,0)
# 陽性者数>=20
df2<- cov[cov$陽性者数>=20,c(1,3,4)]
df3<- df[df[,1]=="Japan",c(1,2,5)]
colnames(df2)<- colnames(df3)
df2<- rbind(df3,df2)
#
library(ggplot2)
library(grid)
#
lim<-max(covid[,5],na.rm=T)*1.1
min<- 300
df<- covid[!is.na(covid[,3]),]
df<- df[df[,3]>=min,]
#
a<- ggplot(df, aes(x=reorder(df[,1],df[,5]), y=df[,5])) +
    geom_bar(stat='identity',color="black",fill="lightblue") +
    scale_y_continuous(expand = c(0,0), limits = c(0,lim),labels = function(x) formatC(x, format="d", big.mark=',')) +
    coord_flip()+
    xlab("")+
    ylab("Tests /million")+
    ggtitle(bquote("Tests /million for COVID-19("~Positive>=.(min)~")")) +
    theme_classic(base_size = 15, base_family = "serif")
#
b <- ggplot(df2, aes(x=reorder(df2[,1],df2[,2]), y=df2[,3])) + 
     geom_bar(stat='identity',color="black",fill="pink") +
     scale_y_continuous(expand = c(0,0), limits = c(0,max(df2[,3]))) +
     coord_flip()+
     theme_classic(base_size=12, base_family = "serif")+
     xlab("")+
     ylab("Tests /million")+
     ggtitle("Prefectures of Japan\n(More than 20 COVID-19 cases reported)")
#     theme(plot.margin = unit(c(0,0,0,0), "cm")) More than 100 COVID-19 cases reported
print(a)#メインのグラフ
print(b, vp = viewport(width=0.45, height=0.65, x=0.70,y=0.45))#サブグラフの幅、高さ、位置を設定
```
