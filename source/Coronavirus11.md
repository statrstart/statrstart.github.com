---
title: COVID-19 testing(Coronavirus)でbarplot
date: 2020-03-27
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

#### Positive>=500

![covtested01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covtested01.png)

#### Positive<500

![covtested02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covtested02.png)

### 日本の値に赤い破線を引きました。レンジは揃えています。

#### 人口を加味（人口 100万人あたりの検査数）

# 日本、驚くほど検査していない。

#### Positive>=500

![covtested03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covtested03.png)

#### Positive<500

![covtested04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covtested04.png)

### 日本の値に赤い破線を引きました。レンジは揃えています。

## Rコード

### rvestパッケージを用いてデータの取り込み。加工。

```R
library("rvest")
# "COVID-19 testing"のデータ取得
html <- read_html("https://en.wikipedia.org/wiki/COVID-19_testing")
tbl<- html_table(html,fill = T)
Wtest<- tbl[[2]][,1:6]
#
for (i in c(2,3,5)){
	Wtest[,i]<- as.numeric(gsub(",","",Wtest[,i]))
}
str(Wtest)
```

### Positive>=500とPositive<500に分けてプロットします。
#### rangeは同じにします。

### Total Test

#### Positive>=500だけを抽出

```R
min<- 500
dat<- Wtest[!is.na(Wtest[,3]),]
dat<- dat[dat[,3]>=min,]
#
lim<-max(Wtest[,2],na.rm=T)
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

#### Positive<500だけを抽出

```R
max<- 500
dat<- Wtest[!is.na(Wtest[,3]),]
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

#### Positive>=500だけを抽出

```R
min<- 500
dat<- Wtest[!is.na(Wtest[,3]),]
dat<- dat[dat[,3]>=min,]
#
lim<-max(Wtest[,5],na.rm=T)
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

#### Positive<500だけを抽出

```R
max<- 500
dat<- Wtest[!is.na(Wtest[,3]),]
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

