---
title: Rで棒グラフ02 (Coronavirus)[更新]
date: 2020-02-23
tags: ["R","barplot","Coronavirus","Japan","Diamond Princess"]
excerpt: Rで棒グラフ02 (Coronavirus)[更新]
---

# Rで棒グラフ02 (Coronavirus)[更新]
![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus05)

Data : [BNO News(https://bnonews.com/)](https://bnonews.com/)  

[twitter : Dr. Iwata](https://twitter.com/georgebest1969/status/1229739024669011968)   
[youtube : Diamond Princess is COVID-19 mill. How I got in the ship and was removed from it within one day](https://www.youtube.com/watch?v=vtHYZkLuKcI)

## 日本時間　2020.02.23 07:35 現在

### Countries,territories or areas with reported confirmed COVID-19cases

#### Japan & Diamond Princess のところのグラフの色を変える

![BNO01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/BNO01.png)

### Countries,territories or areas with reported confirmed COVID-19cases

#### Japan & Diamond Princess のところのグラフの色と文字色を変える

![BNO02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/BNO02.png)

## Rコード

### rvest パッケージを使ってデータを入手。データの加工

```R
library(rvest)
#
# BNO News
html <- read_html("https://bnonews.com/index.php/2020/02/the-latest-coronavirus-cases/")
tbl <- html_table(html,fill=T)
#
CHINA<- tbl[[1]]
OTHER_PLACES<- tbl[[2]]
#
colnames(CHINA)<- CHINA[1,]
CHINA<- CHINA[-1,1:4]
CHINA[,2]<- as.numeric(gsub("\\,","",CHINA[,2]))
CHINA[,3]<- as.numeric(gsub("\\,","",CHINA[,3]))
#TOTAL1<- CHINA[CHINA[,1]=="TOTAL",]
#TOTAL1[1,1] <- colnames(TOTAL1)[1]
#colnames(TOTAL1)[1]<- "TOTAL"
# CHINA<- CHINA[CHINA[,1] != "TOTAL",]
# knitr::kable(CHINA,row.names =F)
#
colnames(OTHER_PLACES)<- OTHER_PLACES[1,]
OTHER_PLACES<- OTHER_PLACES[-1,1:4]
OTHER_PLACES[,2]<- gsub("\\*","",OTHER_PLACES[,2])
OTHER_PLACES[,2]<- as.numeric(gsub("\\,","",OTHER_PLACES[,2]))
OTHER_PLACES[,3]<- as.numeric(gsub("\\,","",OTHER_PLACES[,3]))
#TOTAL2<- OTHER_PLACES[OTHER_PLACES[,1]=="TOTAL",]
#TOTAL2[1,1] <- colnames(TOTAL2)[1]
#colnames(TOTAL2)[1]<- "TOTAL"
# OTHER_PLACES<- OTHER_PLACES[OTHER_PLACES[,1] !="TOTAL",]
# knitr::kable(OTHER_PLACES,row.names =F)
#
bp<- OTHER_PLACES[OTHER_PLACES[,1]!="TOTAL",][,1:2]
bp<- bp[order(bp[,2],decreasing =F),]
```

### Japan & Diamond Princess のところのグラフの色を変える

```R
TF<- is.element(bp[,1],c("Japan","Diamond Princess"))
col<- gsub("TRUE","red",gsub("FALSE","lightblue",TF))
# png("BNO01.png",width=800,height=600)
par(mar=c(6,10,4,5))
b<- barplot(bp[,2],names.arg=bp[,1],las=1,col=col,horiz=T)
axis(2, at = b,label=NA,tck= -0.008)
text(x=bp[,2],y=b,labels=bp[,2],pos=4,xpd=T)
title("Countries,territories or areas with reported confirmed COVID-19cases\n(excluding mainland China)",
	"Data : BNO News(https://bnonews.com/)")
# dev.off()
```

### Japan & Diamond Princess のところのグラフの色と文字色を変える

```R
TF<- is.element(bp[,1],c("Japan","Diamond Princess"))
col<- gsub("TRUE","red",gsub("FALSE","lightblue",TF))
col2<- gsub("TRUE","red",gsub("FALSE","black",TF))
# png("BNO02.png",width=800,height=600)
par(mar=c(6,10,4,5))
b<- barplot(bp[,2],las=1,col=col,horiz=T)
axis(2, at = b,label=NA,tck= -0.008)
text(x=par("usr")[1],y=b, labels = bp[,1], col = col2,pos=2,xpd=T)
text(x=bp[,2],y=b,labels=bp[,2],pos=4,xpd=T)
title("Countries,territories or areas with reported confirmed COVID-19cases\n(excluding mainland China)",
	"Data : BNO News(https://bnonews.com/)")
# dev.off()
```

