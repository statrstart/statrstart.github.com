---
title: COVID-19 testing(Coronavirus)でbarplot
date: 2020-03-21
tags: ["R","rvest","Coronavirus","Japan","新型コロナウイルス"]
excerpt: COVID-19 testing(Coronavirus)でbarplot
---

# COVID-19 testing(Coronavirus)でbarplot

![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus11)  

### Wikipediaに国・地域別の検査数、人口100万人あたり検査数の表がありました。  
[Wikipedia:COVID-19 testing](https://en.wikipedia.org/wiki/COVID-19_testing)  

これを棒グラフにします。

#### Total Tests

![covtested01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covtested01.png)

#### 人口 100万人あたりの検査数

![covtested02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covtested02.png)

## Rコード

### rvestパッケージを用いてデータの取り込み。加工。

```R
library("rvest")
# "COVID-19 testing"のデータ取得
html <- read_html("https://en.wikipedia.org/wiki/COVID-19_testing")
tbl<- html_table(html,fill = T)
covid<- tbl[[2]][,1:6]
str(covid)
#'data.frame':	75 obs. of  6 variables:
# $ Country or region: chr  "Armenia" "Australia" "Austria" "Bahrain" ...
# $ Total Tests      : chr  "813" "114,166" "15,613" "17,022" ...
# $ Positive         : chr  "1" "1,066" "2,203" "168" ...
# $ As of            : chr  "18 Mar" "21 Mar" "20 Mar" "19 Mar" ...
# $ Tests /million   : chr  "274" "4,530" "1,754" "10,846" ...
# $ Positive /1,000  : num  NA 9.3 141 9.9 3.63 80 78 9 14.3 8.7 ...
for (i in c(2,3,5)){
	covid[,i]<- as.numeric(gsub(",","",covid[,i]))
}
str(covid)
#'data.frame':	75 obs. of  6 variables:
# $ Country or region: chr  "Armenia" "Australia" "Austria" "Bahrain" ...
# $ Total Tests      : num  813 114166 15613 17022 19000 ...
# $ Positive         : num  1 1066 2203 168 69 ...
# $ As of            : chr  "18 Mar" "21 Mar" "20 Mar" "19 Mar" ...
# $ Tests /million   : num  274 4530 1754 10846 2002 ...
# $ Positive /1,000  : num  NA 9.3 141 9.9 3.63 80 78 9 14.3 8.7 ...
```

### Positive>=300だけを抽出

```R
min<- 300
dat<- covid[!is.na(covid$Positive),]
dat<- dat[dat$Positive>=min,]
```

#### Total Tests

```R
# Total Testsで並べ替え
dat<- dat[order(dat$"Total Tests"),]
color<- is.element(dat$"Country or region","Japan")
col<- gsub("FALSE","lightblue",gsub("TRUE","red",color))
col2<- gsub("FALSE","black",gsub("TRUE","red",color))
# png("covtested01.png",width=800,height=800)
par(mar=c(3,12,3,3),family="serif")
b<- barplot(dat$"Total Tests",horiz=T,col=col,xaxt="n")
axis(side=1, at=axTicks(1), labels=formatC(axTicks(1), format="d", big.mark=','))
axis(2,at=b,labels=NA,col=col2,tck=-0.01)
text(x=par("usr")[1],y=b, labels = dat$"Country or region", col = col2,pos=2,xpd=T)
# bquote
title(bquote("Total Tests for COVID-19("~Positive>=.(min)~")"))
# dev.off()
```

#### 人口100万人あたり

```R
# Tests /millionで並べ替え
dat<- dat[order(dat$"Tests /million"),]
color<- is.element(dat$"Country or region","Japan")
col<- gsub("FALSE","lightblue",gsub("TRUE","red",color))
col2<- gsub("FALSE","black",gsub("TRUE","red",color))
# png("covtested02.png",width=800,height=800)
par(mar=c(3,12,3,3),family="serif")
b<- barplot(dat$"Tests /million",horiz=T,col=col,xaxt="n")
axis(side=1, at=axTicks(1), labels=formatC(axTicks(1), format="d", big.mark=','))
axis(2,at=b,labels=NA,col=col2,tck=-0.01)
text(x=par("usr")[1],y=b, labels = dat$"Country or region", col = col2,pos=2,xpd=T)
# bquote
title(bquote("Tests /million for COVID-19("~Positive>=.(min)~")"))
# dev.off()
```


