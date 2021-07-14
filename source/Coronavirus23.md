---
title: 大阪府のコロナ死の数はどれだけの都道府県のコロナ死の合計に相当するのか？(人口最大化)
date: 2021-07-15
tags: ["R","lpSolve","NipponMap"]
excerpt: NHK:新型コロナデータ
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

- 大阪府（赤の部分）の死亡者数は「３５の都道府県」（黄色の部分）の死亡者数の合計より5人多い。
- 大阪府の人口約８８７万人に対して「３５の都道府県」の人口の合計は「５４８０万人」である。

#### (おまけ) 大阪「市」のコロナ死の数はどれだけの都道府県のコロナ死の合計に相当するのか？(人口最大化)
- 大阪「市」だけでも2021/7/13 現在1141人の方が亡くなっています。 

[新型コロナウイルス感染症にかかる大阪市内の発生状況及び大阪府モニタリング指標に関する大阪市の算定値について](https://www.city.osaka.lg.jp/kenko/page/0000502869.html)  

![covid23_02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid23_02.png)

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
dOsaka<- 1141
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
