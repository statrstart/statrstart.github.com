---
title: 大阪府のコロナ死の数はどれだけの都道府県のコロナ死の合計に相当するのか？(人口最大化)
date: 2021-10-06
tags: ["R","lpSolve","NipponMap"]
excerpt: 0-1ナップサック問題(NHK:新型コロナデータを使う）
---

# 大阪府のコロナ死の数はどれだけの都道府県のコロナ死の合計に相当するのか？(人口最大化)

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus23&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

(使用するデータ)  
[NHK:新型コロナデータ](https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv)  
人口のデータはNipponMapパッケージのjpn.shpより抽出

> 組み合わせはいくつもありますが、選択された都道府県の人口の合計が最大になるような組み合わせを求めます。(0-1ナップサック問題)

0-1ナップサック問題  
各都道府県のコロナ死亡者のベクトルをpopulation，人口のテーブルをdeathsとする。
大阪府のコロナ死亡者以下で，人口が最大となるような都道府県の組み合わせを求める。

#### 大阪府のコロナ死の数はどれだけの都道府県のコロナ死の合計に相当するのか？(人口最大化)

![covid23_01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid23_01.png)

#### (おまけ) 大阪「市」のコロナ死の数はどれだけの都道府県のコロナ死の合計に相当するのか？(人口最大化)
- 大阪「市」だけでも2021/10/6 現在1285人の方が亡くなっています。（人口約９０５万人の神奈川県よりも多い。） 

[新型コロナウイルス感染症にかかる大阪市内の発生状況及び大阪府モニタリング指標に関する大阪市の算定値について](https://www.city.osaka.lg.jp/kenko/page/0000502869.html)  

![covid23_02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid23_02.png)

![covOvsT02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOvsT02.png)

#### (おまけ2)大阪市長「公務日程」のカレンダーと「公務日程なし・あり」の日数(2021年版)

データは[大阪市：市長日程](https://www.city.osaka.lg.jp/seisakukikakushitsu/page/0000329708.html)の「これまでの市長日程」

![Okoumu2021_1](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Okoumu2021_1.png)

![Okoumu2021_2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Okoumu2021_2.png)

### Rコード

(注意)  
今回は、tapply関数を使いましたが、都道府県の順番が変わってしまい、塗り分け地図を描く際に困ります。  
INDEX=factor(.. ,levels=都道府県の順番)とする必要があります。

```R
library(NipponMap)
library(lpSolve)
shp <- system.file("shapes/jpn.shp", package = "NipponMap")[1]
m <- sf::read_sf(shp)
#[NHK](https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv)
nhkC<- read.csv("https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv",stringsAsFactors = F)
# tapplyをそのまま使うと順番が変わってしまうのでfactor(,levels=)を使う。
tmp<- tapply(nhkC[,6], factor(nhkC[,3],levels=unique(nhkC[,3])),sum,na.rm=T)
deaths<-matrix(tmp,nrow=1)   # コロナ死亡者テーブル
population<-m$population     # 人口ベクトル
# 都道府県コード
i<- 27
# 大阪府のコロナ死亡者 deaths[,i]
# 0-1ナップサック問題
res<- lp("max", population, deaths, "<=", deaths[,i], all.bin=T)
res
#
respref<- res$solution
names(respref)<- as.vector(unique(nhkC$都道府県名))
names(respref)[respref==1]
#
# 確認
sum(deaths*respref)
deaths[,i]
deaths[,i]-sum(deaths*respref)
res$objval/population[i]
# 塗り分け地図を描く
cols = rep("white", 47)
cols[i]<- "red"
cols[which(respref==1)]<- "yellow"
#png("covid23_01.png",width=800,height=600)
par(mar=c(3,3,4,3),family="serif")
JapanPrefMap(col=cols)
legend<- paste0(c(names(tmp)[which(respref==1)],"合計")," : ",c(tmp[which(respref==1)],sum(deaths*respref)),"人")
legend(145,39, legend=legend,xpd=T,ncol=2,title=paste0(names(respref)[i]," : ",deaths[,i],"人"),title.col="red")
#
legend2<- paste0(c(paste0(names(respref)[i],"　　　　  "),paste0(sum(respref),"都道府県合計")),"   ",
formatC(c(population[i],res$objval), format="d", big.mark=','),"人")
legend(145,42, legend=legend2,xpd=T,title="人口",title.col="red")
title(paste0(names(respref)[i],"のコロナ死の数はどれだけの都道府県のコロナ死の合計に相当するのか？(人口最大化)"))
text(x=par("usr")[1]*1.02,y=par("usr")[4],labels=paste(tail(nhkC[nhkC[,2]==i,][,1],1),"現在"),xpd=T,cex=1.5,col="red")
#dev.off()
```

#### 大阪市

```R
library(sf)
library(NipponMap)
library(lpSolve)
#大阪「市」を赤で塗りつぶすために大阪府の市町村マップを読み込む 
osaka<- st_read("https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/osaka.geojson", 
	stringsAsFactors=FALSE)
map<- aggregate(osaka[,c("code2","sityo")], list(osaka$code2), unique)
shp <- system.file("shapes/jpn.shp", package = "NipponMap")[1]
m <- sf::read_sf(shp)
#[NHK](https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv)
nhkC<- read.csv("https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv",stringsAsFactors = F)
#load("nhkC.Rdata")
# tapplyをそのまま使うと順番が変わってしまうのでfactor(,levels=)を使う。
tmp<- tapply(nhkC[,6], factor(nhkC[,3],levels=unique(nhkC[,3])),sum,na.rm=T)
deaths<-matrix(tmp,nrow=1)   # コロナ死亡者テーブル
population<-m$population     # 人口ベクトル
# 大阪「市」のコロナ死亡者
dOsaka<- 1160
# 大阪「市」の人口
popOsaka<- 2691185
res<- lp("max", population, deaths, "<=", dOsaka, all.bin=T)
res
respref<- res$solution
names(respref)<- as.vector(unique(nhkC$都道府県名))
names(respref)[respref==1]
# 確認
sum(deaths*respref)
cols = rep("white", 47)
#cols[i]<- "red"
cols[which(respref==1)]<- "yellow"
#png("covid23_02.png",width=800,height=600)
par(mar=c(3,3,4,3),family="serif")
JapanPrefMap(col=cols)
#大阪「市」を赤で塗りつぶす
plot(st_geometry(map[1,]),add=T,col="red")
legend<- paste0(c(names(tmp)[which(respref==1)],"合計")," : ",c(tmp[which(respref==1)],sum(deaths*respref)),"人")
legend(145,39, legend=legend,xpd=T,ncol=2,title=paste0("大阪「市」 : ",dOsaka,"人"),title.col="red")
#
legend2<- paste0(c("大阪「市」　　　  ",paste0(sum(respref),"都道府県合計")),"   ",
formatC(c(popOsaka,res$objval), format="d", big.mark=','),"人")
legend(145,42, legend=legend2,xpd=T,title="人口",title.col="red")
title("大阪「市」のコロナ死の数はどれだけの都道府県のコロナ死の合計に相当するのか？(人口最大化)")
text(x=par("usr")[1]*1.02,y=par("usr")[4],labels=paste(tail(nhkC[nhkC[,2]==i,][,1],1),"現在"),xpd=T,cex=1.5,col="red")
#dev.off()
```

#### 大阪市長「公務日程」のカレンダーと「公務日程なし・あり」の日数(2021年版)

```R
# https://www.city.osaka.lg.jp/seisakukikakushitsu/page/0000329708.html
library(calendR)
library(rvest)
#これまでの市長日程
p<- c("0000361982","0000387274","0000387276","0000387279","0000387280","0000387281","0000387282")
#
koumu<- NULL
for ( i in p){
page<- paste0("https://www.city.osaka.lg.jp/seisakukikakushitsu/page/",i,".html")
# 読み込み 
html <- read_html (page, encoding = "UTF-8")
x<- html_table(html)[[1]]
x1<- x[x$内容=="公務日程なし",c(1,3)]
koumu<- rbind(koumu,x1[order(as.numeric(rownames(x1)),decreasing=T),])
}
#
#koumu<- koumu[-c(1:14),1 ]
koumu<- koumu[,1 ]
#
#公務日程なしの日付　曜日削除
days<- gsub("（.*）","",koumu)
days<- as.Date(paste0("2021-",gsub("日","",gsub("月","-",days))))

#市長日程予定が１番目のtable。これまでの市長日程は２番めのtable
p<-"0000329708"
page<- paste0("https://www.city.osaka.lg.jp/seisakukikakushitsu/page/",p,".html")
# 読み込み 
html <- read_html (page, encoding = "UTF-8")
x<- html_table(html)[[2]]
last<- x[1,1]
x1<- x[x$内容=="公務日程なし",c(1,3)]
koumu<- x1[order(as.numeric(rownames(x1)),decreasing=T),1]
koumu<- gsub("（.*）","",koumu)
koumu<- as.Date(paste0("2021-",gsub("日","",gsub("月","-",koumu))))
days<- c(days,koumu)
last<- as.Date(paste0("2021-",gsub("日","",gsub("月","-",last))))
#2021
# 2021-01-01を１日目として何日目に当たるかを計算
no_koumu<- as.numeric(as.Date(days)-as.Date("2021-01-01")+1)
#
# Vector of dates
dates <- seq(as.Date("2021-01-01"), as.Date("2021-12-31"), by = "1 day")
# Vector of "公務日程あり" 
events <- rep("公務日程あり",length(dates))
# Adding more events
events[no_koumu] <- "公務日程なし"
# +2 : データのある日の次の日
events[as.numeric(as.Date(last)-as.Date("2021-01-01")+2):length(dates)] <- NA
# Creating the calendar
#png("Okoumu2021_1.png",width=800,height=600)
calendR(year = 2021,
        start = "S",
        special.days = events,
        special.col = c("lightblue","red"), # as events
	title = "「公務日程」のカレンダー（大阪市：市長日程より作成）",  # Change the title
        title.size = 15,                  # Font size of the title
        title.col = 2,                    # Color of the title
        subtitle = "[2021]" ,
	subtitle.size = 15,
	weeknames = c("月","火","水","木","金","土","日"),
	legend.pos = c(0.1,1.15))  
#dev.off()
#
#png("Okoumu2021_2.png",width=800,height=600)
mat <- matrix(c(1,1,1,1,1,1,2,2),4,2, byrow = TRUE)
layout(mat) 
b<- barplot(table(substring(days,6,7)),las=1,ylim=c(0,31),col="brown3",names=paste0(1:8,"月"))
text(x=b,y=table(substring(days,6,7)),labels=table(substring(days,6,7)),pos=3,cex=1.5)
title(paste0("「公務日程なし」の月別日数（大阪市：市長日程）[2021-01-01〜",last,"]"),cex.main=2)
#
no<- sum(table(substring(days,6,7)))
yes<- as.Date(last)-as.Date("2020-12-31")-no
na<- as.Date("2021-12-31")-as.Date(last)
b<- barplot(matrix(c(no,yes,na),nrow=3),horiz=T,col=c("brown3","royalblue3","lightgray"),xaxt="n")
text(x=c(no/2,no+yes/2),y=b,labels=c(paste0("公務日程なし\n",no,"日"),paste0("公務日程あり\n",yes,"日")),cex=2.5,col="white")
title(paste0("2021年「公務日程なし・あり」の日数（大阪市：市長日程）[2021-01-01〜",last,"]"),cex.main=2)
#dev.off()
```
