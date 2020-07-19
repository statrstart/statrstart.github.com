---
title: 大阪府陽性者の属性(新型コロナウイルス：Coronavirus)
date: 2020-07-19
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

|date       |居住地 |年代   |性別 |退院 |
|:----------|:------|:------|:----|:----|
|2020-03-04 |吹田市 |60代   |女性 |○   |
|2020-03-06 |吹田市 |30代   |女性 |○   |
|2020-03-06 |吹田市 |60代   |男性 |○   |
|2020-03-06 |吹田市 |50代   |女性 |○   |
|2020-03-11 |吹田市 |50代   |男性 |○   |
|2020-03-12 |吹田市 |40代   |男性 |○   |
|2020-03-13 |吹田市 |60代   |男性 |○   |
|2020-03-14 |吹田市 |60代   |女性 |○   |
|2020-03-14 |吹田市 |30代   |男性 |○   |
|2020-03-19 |吹田市 |20代   |男性 |○   |
|2020-03-20 |吹田市 |60代   |男性 |○   |
|2020-03-20 |吹田市 |60代   |女性 |○   |
|2020-03-24 |吹田市 |20代   |男性 |○   |
|2020-03-26 |吹田市 |70代   |男性 |○   |
|2020-03-27 |吹田市 |50代   |男性 |○   |
|2020-03-28 |吹田市 |30代   |男性 |○   |
|2020-03-29 |吹田市 |40代   |男性 |○   |
|2020-03-29 |吹田市 |20代   |女性 |○   |
|2020-03-31 |吹田市 |20代   |女性 |○   |
|2020-04-01 |吹田市 |40代   |男性 |○   |
|2020-04-02 |吹田市 |20代   |男性 |○   |
|2020-04-03 |吹田市 |20代   |男性 |○   |
|2020-04-04 |吹田市 |50代   |男性 |○   |
|2020-04-04 |吹田市 |40代   |男性 |○   |
|2020-04-06 |吹田市 |50代   |男性 |○   |
|2020-04-06 |吹田市 |50代   |男性 |○   |
|2020-04-07 |吹田市 |30代   |男性 |○   |
|2020-04-07 |吹田市 |30代   |男性 |○   |
|2020-04-07 |吹田市 |50代   |女性 |○   |
|2020-04-09 |吹田市 |80代   |女性 |○   |
|2020-04-09 |吹田市 |10代   |女性 |○   |
|2020-04-09 |吹田市 |40代   |女性 |○   |
|2020-04-10 |吹田市 |20代   |男性 |○   |
|2020-04-11 |吹田市 |80代   |男性 |○   |
|2020-04-11 |吹田市 |20代   |男性 |○   |
|2020-04-11 |吹田市 |50代   |男性 |○   |
|2020-04-12 |吹田市 |20代   |男性 |○   |
|2020-04-12 |吹田市 |20代   |男性 |○   |
|2020-04-12 |吹田市 |20代   |女性 |○   |
|2020-04-12 |吹田市 |50代   |女性 |○   |
|2020-04-12 |吹田市 |70代   |男性 |○   |
|2020-04-12 |吹田市 |30代   |男性 |○   |
|2020-04-15 |吹田市 |40代   |男性 |○   |
|2020-04-15 |吹田市 |70代   |女性 |○   |
|2020-04-15 |吹田市 |40代   |女性 |○   |
|2020-04-16 |吹田市 |20代   |男性 |○   |
|2020-04-16 |吹田市 |20代   |女性 |○   |
|2020-04-16 |吹田市 |20代   |男性 |○   |
|2020-04-17 |吹田市 |30代   |男性 |○   |
|2020-04-19 |吹田市 |50代   |男性 |○   |
|2020-04-20 |吹田市 |40代   |男性 |○   |
|2020-04-20 |吹田市 |30代   |女性 |○   |
|2020-04-20 |吹田市 |50代   |女性 |○   |
|2020-04-22 |吹田市 |60代   |男性 |○   |
|2020-04-24 |吹田市 |20代   |男性 |○   |
|2020-04-27 |吹田市 |40代   |男性 |○   |
|2020-05-01 |吹田市 |30代   |男性 |○   |
|2020-05-02 |吹田市 |10代   |女性 |○   |
|2020-05-09 |吹田市 |30代   |女性 |○   |
|2020-05-13 |吹田市 |就学児 |女性 |○   |
|2020-07-04 |吹田市 |30代   |女性 |○   |
|2020-07-05 |吹田市 |20代   |男性 |○   |
|2020-07-07 |吹田市 |20代   |男性 |○   |
|2020-07-07 |吹田市 |20代   |女性 |○   |
|2020-07-12 |吹田市 |10代   |女性 |     |
|2020-07-14 |吹田市 |30代   |男性 |     |
|2020-07-15 |吹田市 |50代   |女性 |     |
|2020-07-15 |吹田市 |50代   |男性 |     |
|2020-07-15 |吹田市 |30代   |女性 |     |
|2020-07-15 |吹田市 |30代   |男性 |     |
|2020-07-15 |吹田市 |30代   |男性 |     |
|2020-07-15 |吹田市 |20代   |男性 |     |
|2020-07-15 |吹田市 |20代   |女性 |     |
|2020-07-15 |吹田市 |30代   |男性 |     |
|2020-07-15 |吹田市 |20代   |男性 |     |
|2020-07-15 |吹田市 |80代   |男性 |     |
|2020-07-16 |吹田市 |10代   |男性 |     |
|2020-07-16 |吹田市 |20代   |女性 |     |
|2020-07-17 |吹田市 |20代   |男性 |     |

#### 時系列

![covOsaka01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka01.png)

#### 検査結果

![covOsaka05](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka05.png)

#### 居住地

![covOsaka02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka02.png)

#### 月別の陽性者の属性:年代(大阪府)

![covOsaka06](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka06.png)

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
names(js)
#[1] "patients"                   "patients_summary"          
#[3] "inspections_summary"        
#    "contacts1_summary"  府民向け相談窓口への相談件数   
#[5] "contacts2_summary" 新型コロナ受診相談センターへの相談件数          
#    "transmission_route_summary" 感染経路不明者（リンク不明者） 
#[7] "treated_summary" 陰性確認済（退院者累計）           "lastUpdate"                
#[9] "main_summary" 
# "patients"「陽性者の属性」の部分を取り出す。
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
dat$性別[dat$性別=="男"]<- "男性"
dat$性別[dat$性別=="女"]<- "女性"
tbl<- table(dat$性別)
tbl<- tbl[order(tbl)]
# png("covOsaka04.png",width=800,height=600)
par(mar=c(3,7,4,2),family="serif")
b<- barplot(tbl,las=1,horiz=T,xlim=c(0,max(tbl)*1.2),col="pink")
text(x=tbl,y=b,labels=tbl,pos=4)
title("陽性者の属性:性別(大阪府)",cex.main=1.5)
#dev.off()
```

#### "patients_summary" "inspections_summary" "lastUpdate" "main_summary"

```R
# 検査陽性率(%): 陽性患者数/検査実施人数*100
Pos<- round(js[[9]][[3]]$value/js[[9]][[2]]*100,2)
# 致死率(%): 亡くなった人の数/陽性患者数*100
Dth<- round(js[[9]][[3]][[3]][[1]][grep("死亡",js[[9]][[3]][[3]][[1]]$attr),2]/js[[9]][[3]]$value*100,2)
#
dat<- js[[2]][[2]]
dat<- merge(dat,js[[3]][[2]],by=1)
rownames(dat)<- sub("-","/",sub("-0","-",sub("^0","",substring(dat[,1],6,10))))
dat<- dat[,-1]
dat[,3]<- dat[,2]-dat[,1]
colnames(dat)<- c("陽性者数","検査実施人数","陰性者数")
ritsu1<- paste("・検査陽性率(%) :",Pos,"%")
ritsu2<- paste("・致  死  率   (%) :",Dth,"%")
#png("covOsaka05.png",width=800,height=600)
par(mar=c(3,7,4,2),family="serif")
barplot(t(dat[,c(1,3)]),names=rownames(dat),las=1,col=c("red","lightblue"))
legend("topleft",inset=0.03,bty="n",pch=15,col=c("red","lightblue"),cex=1.5,
	legend=c("陽性者数","検査実施人数-陽性者数"))
legend("topleft",inset=c(0,0.15),bty="n",cex=1.5,legend=c(paste0(js[[8]],"現在"),ritsu1,ritsu2))
title("検査結果(大阪府)",cex.main=1.5)
#dev.off()
```

#### 月別の陽性者の属性:年代(大阪府)

```R
month<- substring(js[[1]]$data$date,6,7)
tab<- table(month,js[[1]]$data$年代)
#"80代","90代","100代" -> "80歳以上"
tab<- cbind(tab,rowSums(tab[,c("80代","90代","100代")]))
colnames(tab)[ncol(tab)]<- "80歳以上"
#"未就学児","就学児"-> "10歳未満"
tab<- cbind(tab,rowSums(tab[,c("未就学児","就学児")]))
colnames(tab)[ncol(tab)]<- "10歳未満"
tab2<- tab[,c("10歳未満","10代","20代","30代","40代","50代","60代","70代","80歳以上")]
#
#png("covOsaka06.png",width=800,height=600)
par(mar=c(3,7,4,2),family="serif")
barplot(t(tab2),col=rainbow(9,0.7),beside=T,las=1,legend=T,names=paste0(sub("^0","",rownames(tab2)),"月"),
	args.legend = list(x = "topleft",inset= 0.03))
title("月別の陽性者の属性:年代(大阪府)",cex.main=1.5)
#dev.off()
```
