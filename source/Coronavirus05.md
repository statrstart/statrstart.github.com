---
title: Rで棒グラフ02 (Coronavirus)[更新]
date: 2020-02-25
tags: ["R","barplot","Coronavirus","Japan","Diamond Princess"]
excerpt: Rで棒グラフ02 (Coronavirus)[更新]
---

# Rで棒グラフ02 (Coronavirus)[更新]
![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus05)

Data : [BNO News(https://bnonews.com/)](https://bnonews.com/)  
Data : PCR検査実施人数	
[報道発表資料　2020年2月](https://www.mhlw.go.jp/stf/houdou/houdou_list_202002.html)  
- 国内の状況について
- 新型コロナウイルス感染症の現在の状況と厚生労働省の対応について

韓国の検査数は  
[韓国の感染者２０４人に　１日で倍増＝大邱の教会関係者が１４４人 2020.02.21 18:44 ](https://jp.yna.co.kr/view/AJP20200221005500882?section=search)  
[新型肺炎感染者計３４６人に　大邱・慶尚北道で新たに１３１人＝韓国 2020.02.22 11:29  ](https://jp.yna.co.kr/view/AJP20200222000300882?section=search)  
[新型肺炎感染者１６９人増え６０２人　死者５人に＝韓国 2020.02.23 18:41 ](https://jp.yna.co.kr/view/AJP20200223001600882?section=search)  
[新型肺炎感染者数８３３人に増加　死者は８人に＝韓国 2020.02.24 18:46 ](https://jp.yna.co.kr/view/AJP20200224004400882?section=search)  
[新型コロナ感染者１４４人増え計９７７人　死者１０人＝韓国 2020.02.25 18:58 ](https://jp.yna.co.kr/view/AJP20200225005400882?section=search)  

### 日本のPCR検査実施人数

![pcr01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr01.png)

## 日本時間　2020.02.25 21:41 現在

### Countries,territories or areas with reported confirmed COVID-19cases

#### Japan & Diamond Princess のところのグラフの色を変える

![BNO01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/BNO01.png)

### Countries,territories or areas with reported confirmed COVID-19cases

#### Japan & Diamond Princess のところのグラフの色と文字色を変える

![BNO02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/BNO02.png)

## Rコード

### 日本のPCR検査実施人数

```R
# jpn : 国内事例（チャーター便帰国者を除く）
# charter : チャーター便帰国者事例（水際対策で確認)
date<- seq(as.Date("2020-02-07"), as.Date("2020-02-23"), by = "day")
jpn<- c(151,NA,NA,174,NA,190,200,214,NA,NA,487,523,532,603,693,778,874)
charter<- c(566,NA,NA,764,NA,764,764,764,NA,NA,764,764,764,829,829,829,829)
# 日本のPCR検査実施人数
dat<- data.frame(charter,jpn)
rownames(dat)<- date
# png("pcr01.png",width=800,height=600)
barplot(t(dat),names.arg=gsub("2020-","",rownames(dat)),las=1,col=c("lightblue","pink"),legend=T,
	args.legend = list(x="topleft",inset=c(0.03,0.03),
	legend=c("国内事例（チャーター便帰国者を除く）","チャーター便帰国者事例（水際対策で確認)")))
title("日本のPCR検査実施人数")
text(x=0,y=1150,labels="[韓国]\n感染の有無を調べるために検査を受けた人（感染者除く）は
2/21 １万６１９６人、2/22 １万９２７５人、
2/23 ２万５５７７人　
(日本の ２９倍,チャーター便含めても １５倍)
2/24 ３万１９２３人、2/25 ３万９３２３人",pos=4,cex=1.4)
# dev.off()
```

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
# png("BNO01.png",width=800,height=800)
par(mar=c(6,10,4,5))
b<- barplot(bp[,2],names.arg=bp[,1],las=1,col=col,horiz=T)
axis(2, at = b,label=NA,tck= -0.008)
text(x=bp[,2],y=b,labels=bp[,2],pos=4,xpd=T)
title("Countries,territories or areas with reported confirmed COVID-19cases\n(excluding mainland China)",
	"Data : BNO News(https://bnonews.com/)")
# dev.off()
```

### Japan & Diamond Princess のところのグラフの色と文字色を変える
#### fontも変えてみました。

```R
TF<- is.element(bp[,1],c("Japan","Diamond Princess"))
col<- gsub("TRUE","red",gsub("FALSE","lightblue",TF))
col2<- gsub("TRUE","red",gsub("FALSE","black",TF))
# png("BNO02.png",width=800,height=800)
par(mar=c(6,10,4,5),family="serif")
b<- barplot(bp[,2],las=1,col=col,horiz=T,font=2)
axis(2, at = b,label=NA,tck= -0.008)
text(x=par("usr")[1],y=b, labels = bp[,1], col = col2,pos=2,xpd=T,font=3)
text(x=bp[,2],y=b,labels=bp[,2],pos=4,xpd=T,font=1)
title("Countries,territories or areas with reported confirmed COVID-19cases\n(excluding mainland China)",
	"Data : BNO News(https://bnonews.com/)",font=4)
# dev.off()
```

