---
title: 大阪府陽性者の属性(新型コロナウイルス：Coronavirus)
date: 2020-04-19
tags: ["R","jsonlite","Coronavirus","大阪府","新型コロナウイルス"]
excerpt: 大阪府 新型コロナウイルス感染症対策サイトのデータ
---

# 大阪府陽性者の属性(新型コロナウイルス：Coronavirus)

![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus12)  

(参考)[大阪府の最新感染動向](https://covid19-osaka.info/)  

[大阪府 新型コロナウイルス感染症対策サイト](https://github.com/codeforosaka/covid19)にあるデータを使います。

#### 例えば、吹田市の一覧表
##### ※退院とは新型コロナウイルス感染症が治癒した者
##### ※退院には死亡退院を含む

|date       |居住地 |年代 |性別 |退院 |
|:----------|:------|:----|:----|:----|
|2020-03-04 |吹田市 |60代 |女性 |○   |
|2020-03-06 |吹田市 |30代 |女性 |○   |
|2020-03-06 |吹田市 |60代 |男性 |○   |
|2020-03-06 |吹田市 |50代 |女性 |○   |
|2020-03-11 |吹田市 |50代 |男性 |○   |
|2020-03-12 |吹田市 |40代 |男性 |○   |
|2020-03-13 |吹田市 |60代 |男性 |     |
|2020-03-14 |吹田市 |60代 |女性 |○   |
|2020-03-14 |吹田市 |30代 |男性 |○   |
|2020-03-19 |吹田市 |20代 |男性 |○   |
|2020-03-20 |吹田市 |60代 |男性 |○   |
|2020-03-20 |吹田市 |60代 |女性 |○   |
|2020-03-24 |吹田市 |20代 |男性 |○   |
|2020-03-26 |吹田市 |70代 |男性 |○   |
|2020-03-27 |吹田市 |50代 |男性 |     |
|2020-03-28 |吹田市 |30代 |男性 |○   |
|2020-03-29 |吹田市 |40代 |男性 |○   |
|2020-03-29 |吹田市 |20代 |女性 |○   |
|2020-03-31 |吹田市 |20代 |女性 |○   |
|2020-04-01 |吹田市 |40代 |男性 |     |
|2020-04-02 |吹田市 |20代 |男性 |     |
|2020-04-03 |吹田市 |20代 |男性 |○   |
|2020-04-04 |吹田市 |50代 |男性 |○   |
|2020-04-04 |吹田市 |40代 |男性 |     |
|2020-04-06 |吹田市 |50代 |男性 |     |
|2020-04-06 |吹田市 |50代 |男性 |     |
|2020-04-07 |吹田市 |30代 |男性 |     |
|2020-04-07 |吹田市 |30代 |男性 |     |
|2020-04-07 |吹田市 |50代 |女性 |     |
|2020-04-09 |吹田市 |80代 |女性 |     |
|2020-04-09 |吹田市 |10代 |女性 |     |
|2020-04-09 |吹田市 |40代 |女性 |     |
|2020-04-10 |吹田市 |20代 |男性 |     |
|2020-04-11 |吹田市 |80代 |男性 |     |
|2020-04-11 |吹田市 |20代 |男性 |     |
|2020-04-11 |吹田市 |50代 |男性 |     |
|2020-04-12 |吹田市 |20代 |男性 |     |
|2020-04-12 |吹田市 |20代 |男性 |     |
|2020-04-12 |吹田市 |20代 |女性 |     |
|2020-04-12 |吹田市 |50代 |女性 |     |
|2020-04-12 |吹田市 |70代 |男性 |     |
|2020-04-12 |吹田市 |30代 |男性 |     |
|2020-04-15 |吹田市 |40代 |男性 |     |
|2020-04-15 |吹田市 |70代 |女性 |     |
|2020-04-15 |吹田市 |40代 |女性 |     |
|2020-04-16 |吹田市 |20代 |男性 |     |
|2020-04-16 |吹田市 |20代 |女性 |     |
|2020-04-16 |吹田市 |20代 |男性 |     |
|2020-04-17 |吹田市 |30代 |男性 |     |

#### 時系列

![covOsaka01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka01.png)

#### 居住地

![covOsaka02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka02.png)

#### 年代

![covOsaka03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka03.png)

#### 性別

![covOsaka04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka04.png)

### Rコード

#### (json形式)データを読み込み、「陽性者の属性」の部分を取り出す。

```R
#install.packages("jsonlite")
#install.packages("curl")
library(jsonlite)
library(knitr)
url<- "https://raw.githubusercontent.com/codeforosaka/covid19/development/data/data.json"
js<- fromJSON(url)
dat<- js[[1]][[2]][,c(8,4:7)]
# 居住地の「大阪府」は消し、「大阪府外」だけはもとに戻す。
dat$居住地<- gsub("大阪府","",dat$居住地)
dat$居住地<- gsub("^外$","大阪府外",dat$居住地)
```

#### 例えば、吹田市の一覧表
##### ※退院とは新型コロナウイルス感染症が治癒した者
##### ※退院には死亡退院を含む 

```R
kable(dat[dat$居住地=="吹田市",],row.names=F)
```

#### 時系列

```R
#date
tbl<- table(dat$date)
names(tbl)<- gsub("2020-","",names(tbl))
#元から日付順になっているのでこの部分は不要
tbl<- tbl[order(names(tbl))]
# png("covOsaka01.png",width=800,height=600)
par(mar=c(3,7,4,2),family="serif")
b<- barplot(tbl,las=1,ylim=c(0,max(tbl)*1.2),col="pink")
title("陽性者の人数：時系列(大阪府)",cex.main=1.5)
#dev.off()
```

#### 居住地

```R
tbl<- table(dat$居住地)
tbl<- tbl[order(tbl)]
# png("covOsaka02.png",width=800,height=800)
par(mar=c(3,7,4,2),family="serif")
b<- barplot(tbl,las=1,horiz=T,xlim=c(0,max(tbl)*1.2),col="pink")
text(x=tbl,y=b,labels=tbl,pos=4)
title("陽性者の属性:居住地(大阪府)",cex.main=1.5)
#dev.off()
```

#### 年代

```R
tbl<- table(dat$年代)
tbl<- tbl[order(tbl)]
# png("covOsaka03.png",width=800,height=600)
par(mar=c(3,7,4,2),family="serif")
b<- barplot(tbl,las=1,horiz=T,xlim=c(0,max(tbl)*1.2),col="pink")
text(x=tbl,y=b,labels=tbl,pos=4)
title("陽性者の属性:年代(大阪府)",cex.main=1.5)
#dev.off()
```

#### 性別

```R
tbl<- table(dat$性別)
tbl<- tbl[order(tbl)]
# png("covOsaka04.png",width=800,height=600)
par(mar=c(3,7,4,2),family="serif")
b<- barplot(tbl,las=1,horiz=T,xlim=c(0,max(tbl)*1.2),col="pink")
text(x=tbl,y=b,labels=tbl,pos=4)
title("陽性者の属性:性別(大阪府)",cex.main=1.5)
#dev.off()
```
