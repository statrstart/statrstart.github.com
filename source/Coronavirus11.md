---
title: COVID-19 testing(新型コロナウイルス：Coronavirus)でbarplot
date: 2020-04-05
tags: ["R","rvest","Coronavirus","Japan","新型コロナウイルス"]
excerpt: 日本(東京も)がいかに検査をしていないか。
---

# COVID-19 testing(Coronavirus)でbarplot

![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus11)  

### Wikipediaに国・地域別の検査数、人口100万人あたり検査数の表がありました。  
[Wikipedia:COVID-19 testing](https://en.wikipedia.org/wiki/COVID-19_testing)  

これを棒グラフにします。

# 国別で比較することで日本がいかに検査していないかがわかると思います。

## Japan : Tokyoのデータも入りました。

(参考)  
[データのじかん: データでみる世界各国の新型コロナウイルスの検査状況！](https://data.wingarc.com/covid-19-tests-25207)  
[How many tests for COVID-19 are being performed around the world?](https://ourworldindata.org/covid-testing#note-2)  

[CDC:Testing in U.S.](https://www.cdc.gov/coronavirus/2019-ncov/cases-updates/testing-in-us.html)  
[CORONAVIRUS DATA: Tracking COVID-19 testing across the U.S.](https://www.clickondetroit.com/health/2020/03/13/coronavirus-data-tracking-covid-19-testing-across-the-us/)

## 日本と東京は赤、日本以外のG7の国（G7の地域も含む）は青にしました。

## 韓国、シンガポール、台湾は緑にしました。

#### Total Tests

#### 国を抽出

![covtested01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covtested01.png)

#### 地域を抽出

![covtested02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covtested02.png)

### 日本の値に赤い破線を引きました。レンジは揃えています。

#### 人口を考慮にいれる。（人口 100万人あたり）

# 日本(東京も)、驚くほど検査していない。

#### 国を抽出

![covtested03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covtested03.png)

#### 地域を抽出

![covtested04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covtested04.png)

### 日本の値に赤い破線を引きました。レンジは揃えています。

## Rコード

### rvestパッケージを用いてデータの取り込み。加工。
#### ターゲットのテーブルが２番めから４番目に変更になりました。

```R
library("rvest")
# "COVID-19 testing"のデータ取得
html <- read_html("https://en.wikipedia.org/wiki/COVID-19_testing")
tbl<- html_table(html,fill = T)
# tbl[[2]]->tbl[[4]]
Wtest<- tbl[[4]][,1:6]
#
for (i in c(2,3,5)){
	Wtest[,i]<- as.numeric(gsub(",","",Wtest[,i]))
}
str(Wtest)
```

### 国と地域(Country or region)に分けてプロットします。
#### rangeは同じにします。

### Total Test

#### 国を抽出

##### 国と地域(Country or region)の区別　: がつくか否か

```R
# 国と地域(Country or region)の区別　: がつくか否か
dat<- Wtest[grep(":",Wtest[,1],invert=T),]
dat<- dat[!is.na(dat[,3]),]
lim<-max(Wtest[,2],na.rm=T)
# 日本の値
jnum<- Wtest[Wtest[,1]=="Japan",2]
# Testsで並べ替え
dat<- dat[order(dat[,2]),]
color<- is.element(dat[,1],"Japan")
col<- gsub("FALSE","lightblue",gsub("TRUE","red",color))
col2<- gsub("FALSE","black",gsub("TRUE","red",color))
# G7
g7<- grep("(United States|Italy|France|United Kingdom|Germany|Canada)",dat[,1])
col[g7]<- "blue"
col2[g7]<- "blue"
# アジア先進国
asia<- grep("(South Korea|Singapore|Taiwan)",dat[,1])
col[asia]<- "darkgreen"
col2[asia]<- "darkgreen"
# png("covtested01.png",width=800,height=1200)
par(mar=c(3,14,3,2),family="serif")
b<- barplot(dat[,2],horiz=T,col=col,xaxt="n",xlim=c(0,lim))
axis(side=1, at=axTicks(1), labels=formatC(axTicks(1), format="d", big.mark=','))
axis(2,at=b,labels=NA,col=col2,tck=-0.01)
text(x=par("usr")[1],y=b, labels = dat[,1], col = col2,pos=2,xpd=T)
#text(x=dat[,2],y=b, labels = dat[,4], col ="black",pos=4,xpd=T)
# bquote
title("Total Tests for COVID-19(Country)")
abline(v=jnum,lty=2,col="red")
# dev.off()
```

#### 地域を抽出

```R
dat<- Wtest[grep(":",Wtest[,1],invert=F),]
dat<- dat[!is.na(dat[,3]),]
lim<-max(Wtest[,2],na.rm=T)
jnum<- Wtest[Wtest[,1]=="Japan",2]
# Testsで並べ替え
dat<- dat[order(dat[,2]),]
col<- rep("lightblue",nrow(dat))
col2<- rep("black",nrow(dat))
Jpos<- grep("Japan",dat[,1])
col[Jpos]<- "red"
col2[Jpos]<- "red"
# G7
g7<- grep("(United States|Italy|France|United Kingdom|Germany|Canada)",dat[,1])
col[g7]<- "blue"
col2[g7]<- "blue"
# png("covtested02.png",width=800,height=800)
par(mar=c(3,14,3,2),family="serif")
b<- barplot(dat[,2],horiz=T,col=col,xaxt="n",xlim=c(0,lim))
axis(side=1, at=axTicks(1), labels=formatC(axTicks(1), format="d", big.mark=','))
axis(2,at=b,labels=NA,col=col2,tck=-0.01)
text(x=par("usr")[1],y=b, labels = dat[,1], col = col2,pos=2,xpd=T)
#text(x=dat[,2],y=b, labels = dat[,4], col ="black",pos=4,xpd=T)
# bquote
title("Total Tests for COVID-19(Region)")
abline(v=jnum,lty=2,col="red")
# dev.off()
```

### 人口100万人あたり

#### 国を抽出

```R
dat<- Wtest[grep(":",Wtest[,1],invert=T),]
dat<- dat[!is.na(dat[,3]),]
lim<-max(Wtest[,5],na.rm=T)
jnum<- Wtest[Wtest[,1]=="Japan",5]
# Tests /millionで並べ替え
dat<- dat[order(dat[,5]),]
color<- is.element(dat[,1],"Japan")
col<- gsub("FALSE","lightblue",gsub("TRUE","red",color))
col2<- gsub("FALSE","black",gsub("TRUE","red",color))
# G7
g7<- grep("(United States|Italy|France|United Kingdom|Germany|Canada)",dat[,1])
col[g7]<- "blue"
col2[g7]<- "blue"
# アジア先進国
asia<- grep("(South Korea|Singapore|Taiwan)",dat[,1])
col[asia]<- "darkgreen"
col2[asia]<- "darkgreen"
# png("covtested03.png",width=800,height=1200)
par(mar=c(3,14,3,2),family="serif")
b<- barplot(dat[,5],horiz=T,col=col,xaxt="n",xlim=c(0,lim))
axis(side=1, at=axTicks(1), labels=formatC(axTicks(1), format="d", big.mark=','))
axis(2,at=b,labels=NA,col=col2,tck=-0.01)
text(x=par("usr")[1],y=b, labels = dat[,1], col = col2,pos=2,xpd=T)
#text(x=dat[,2],y=b, labels = dat[,4], col ="black",pos=4,xpd=T)
# bquote
title("Tests /million for COVID-19(Country)")
abline(v=jnum,lty=2,col="red")
# dev.off()
```

#### 地域を抽出

```R
dat<- Wtest[grep(":",Wtest[,1],invert=F),]
dat<- dat[!is.na(dat[,3]),]
lim<-max(Wtest[,5],na.rm=T)
jnum<- Wtest[Wtest[,1]=="Japan",5]
# Tests /millionで並べ替え
dat<- dat[order(dat[,5]),]
col<- rep("lightblue",nrow(dat))
col2<- rep("black",nrow(dat))
Jpos<- grep("Japan",dat[,1])
col[Jpos]<- "red"
col2[Jpos]<- "red"
# G7
g7<- grep("(United States|Italy|France|United Kingdom|Germany|Canada)",dat[,1])
col[g7]<- "blue"
col2[g7]<- "blue"
# png("covtested04.png",width=800,height=800)
par(mar=c(3,14,3,2),family="serif")
b<- barplot(dat[,5],horiz=T,col=col,xaxt="n",xlim=c(0,lim))
axis(side=1, at=axTicks(1), labels=formatC(axTicks(1), format="d", big.mark=','))
axis(2,at=b,labels=NA,col=col2,tck=-0.01)
text(x=par("usr")[1],y=b, labels = dat[,1], col = col2,pos=2,xpd=T)
#text(x=dat[,2],y=b, labels = dat[,4], col ="black",pos=4,xpd=T)
# bquote
title("Tests /million for COVID-19(Region)")
abline(v=jnum,lty=2,col="red")
# dev.off()
```
