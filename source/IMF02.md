---
title: Rで国際通貨基金(IMF)のデータを取得する(その２)
date: 2023-05-04
tags: ["R", "imfr","tidyverse"]
excerpt: IMFのデータを取得し、グラフを作成。
---

# Rで国際通貨基金(IMF)のデータを取得する(その２)

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FIMF02&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

[RでGDPの推移を見る(世界銀行のデータ)](https://gitpress.io/@statrstart/WDI01)で
WDIパッケージを使って、世界銀行のデータを取得し、グラフを作成した。 

今回は、imfrパッケージを使ってIMFの貿易に関するデータを取得し、地図上にプロットする。  

Package‘imfr’was removed from the CRAN repository.  
Archived on 2022-07-09 for policy violation. 

ということなので、[imfr package: https://github.com/christophergandrud/imfr](https://github.com/christophergandrud/imfr)からインストールする。

（参考）  

1. [Downloading Data from the IMF API Using R](https://meshry.com/blog/downloading-data-from-the-imf-api-using-r/)

2. [Static and dynamic network visualization with R](https://kateto.net/network-visualization)

２つの国を結ぶのに国の位置情報が必要なので、いろんなコードとの対応付けするデータ「WEOcountry.R」を作成した。

作成に使ったデータは、

- countrycode::codelist <- データの中に、imf(WEO)コードも含む

- CoordinateCleaner::countryref <- 国の位置情報

- [menu.rda: https://github.com/mitsuoxv/imf-weo/tree/master/data](https://github.com/mitsuoxv/imf-weo/tree/master/data) <- データの中に、imf(WEO)コードも含む

これらを共通するコードにより、merge。RとlibreOffice Calcを使って編集。

なお、Sri Lanka、Nauru、Puerto Rico、Uzbekistan、Kosovo、West Bank and Gaza、Macao SAR の位置情報はネットで検索した。 

確認して、使ってください。<- 重要

### 中国が輸出しているアフリカの国

![ExpChina](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/ExpChina.png)

- 輸出額に応じて、線の太さを変えています。

### 日本が輸出しているアフリカの国

![ExpJapan](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/ExpJapan.png)

### アメリカが輸出しているアフリカの国

![ExpUSA](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/ExpUSA.png)

なお、leaflet パッケージを使った地図を書くコードは下に載せています。図は省略。

### Rコード

(注意) imfr パッケージは、githubから`remotes::install_github("christophergandrud/imfr")`でインストールする。

```R
#source("WEOcountry.R")
url="https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/"
source(paste0(url,"WEOcountry.R"))
# 
# remotes::install_github("christophergandrud/imfr")
require(imfr)
# sudo apt install libharfbuzz-dev libfribidi-dev
require(tidyverse)
#require(stringr)
require(knitr)
kable( head(WEOcountry) )
```

|Name                 |iso2c |iso3c |WEO |continent |region                     | destination_lon| destination_lat| capital.lon| capital.lat|
|:--------------------|:-----|:-----|:---|:---------|:--------------------------|---------------:|---------------:|-----------:|-----------:|
|Andorra              |AD    |AND   |171 |Europe    |Europe & Central Asia      |            1.50|          42.500|        1.52|       42.50|
|United Arab Emirates |AE    |ARE   |466 |Asia      |Middle East & North Africa |           54.00|          24.000|       54.37|       24.47|
|Afghanistan          |AF    |AFG   |512 |Asia      |South Asia                 |           65.00|          33.000|       69.18|       34.52|
|Antigua & Barbuda    |AG    |ATG   |311 |Americas  |Latin America & Caribbean  |          -61.80|          17.050|      -61.85|       17.12|
|Anguilla             |AI    |AIA   |312 |Americas  |Latin America & Caribbean  |          -63.05|          18.217|      -63.05|       18.22|
|Albania              |AL    |ALB   |914 |Europe    |Europe & Central Asia      |           20.00|          41.000|       19.82|       41.32|

```R
# 輸入国（アフリカの国）
Africa_ISO2<- WEOcountry$iso2c[WEOcountry$continent=="Africa"]
# 欠損値を取り除く
( Africa_ISO2<- Africa_ISO2[!is.na(Africa_ISO2)] )
# [1] "AO" "BF" "BI" "BJ" "BW" "CD" "CF" "CG" "CI" "CM" "CV" "DJ" "DZ" "EG" "ER"
#[16] "ET" "GA" "GH" "GM" "GN" "GQ" "GW" "KE" "KM" "LR" "LS" "LY" "MA" "MG" "ML"
#[31] "MR" "MU" "MW" "MZ" "NA" "NE" "NG" "RW" "SC" "SD" "SH" "SL" "SN" "SO" "SS"
#[46] "ST" "SZ" "TD" "TG" "TN" "TZ" "UG" "ZA" "ZM" "ZW" "RE"
# 輸出国（今回は、日本、中国、アメリカを調べる）
ISO2<- c("JP","CN","US")
WEOcountry[WEOcountry$iso2c %in% ISO2 ,c("Name", "iso2c", "destination_lon", "destination_lat") ]
#             Name iso2c destination_lon destination_lat
#44          China    CN             105              35
#103         Japan    JP             138              36
#213 United States    US             -97              38
```

#### 2022年のデータをダウンロード

```R
DOT <- imf_dataset(database_id = "DOT" , indicator = c("TXG_FOB_USD") ,freq='A',ref_area = ISO2 , start = 2022, end=2022,return_raw = TRUE)
# 輸入国がアフリカ地域のデータを抽出
DOT_Data<-DOT %>% 
  filter(`@COUNTERPART_AREA` %in% Africa_ISO2) %>% unnest(Obs) %>% 
  select(From=`@REF_AREA`, To=`@COUNTERPART_AREA`,Year=`@TIME_PERIOD`,Value=`@OBS_VALUE`) 
# 扱い慣れたデータフレームにしちゃう。
dat<- as.data.frame(DOT_Data)
#colnames(dat)<- c("From","To","Year","Value")
# 10億ドル単位にする
dat$Value<- as.numeric(dat$Value)/1000
dat$Year<- as.integer(dat$Year)
nrow(dat)
#[1] 162
# アフリカの国の位置データ
country<- WEOcountry[WEOcountry$iso2c %in% Africa_ISO2 ,c("Name", "iso2c", "destination_lon", "destination_lat") ]
#kable(country)
```
#### 地図を書くためのパッケージを読み込む

今回は、maps、igraphを使う。

```R
# 地図：maps　　矢印：arrowsでもいいけど、igraph:::igraph.Arrows <- カーブ矢印も書ける
require(maps)
require(igraph)
# 長ったらしい関数名（igraph.Arrows）を短く（Arrows）
Arrows <- igraph:::igraph.Arrows
```

#### 中国が輸出している国

`fromC="CN"`の部分を`fromC="JP"`とかfromC="US"に変えれば、よい。

```R
fromC="CN"
todat<-dat[dat$From==fromC ,]
# 中国の経度、緯度
lonlat<- as.numeric(WEOcountry[WEOcountry$iso2c %in% fromC ,c("destination_lon", "destination_lat") ])
# 地図を描く範囲
xlim<- range(c(lonlat[1],country$destination_lon) )
ylim<- range(c(lonlat[2],country$destination_lat) )
```

#### 地図を作成

```R
par(mfrow = c(1,1), mar=c(0,0,0,0))
map("world", col="grey30", fill=TRUE, bg="gray10", lwd=0.5,xlim=c(xlim[1]-5,xlim[2]+5),ylim=c(ylim[1]-25,ylim[2]+25))
# 中国の重心位置に点
points(x=lonlat[1], y=lonlat[2], pch=19,cex=1, col="blue")
# point: アフリカの国
points(x=country$destination_lon, y=country$destination_lat, pch=19,cex=0.5, col="tomato")
# 矢印の色
col="orange"
# 矢印を書く
for(i in 1:nrow(todat))  {
	from= lonlat
	to=country[country$iso2c==todat[i,"To"],c("destination_lon", "destination_lat")]
	lwd=ifelse(todat[i,"Value"] > 1 , round(log(todat[i,"Value"]),1) + 1 , todat[i,"Value"]+0.5 )
		Arrows(x1=from[1],y1=from[2], x2=as.numeric(to[1]),y2=as.numeric(to[2]) , 
			h.lwd=lwd, sh.lwd=lwd, sh.col=col, curve=0, width=1, size=1.5)
}
```

#### タイトルを付けてみる

当然、「中国」の部分は輸出国によって変える。

```R
text(x=mean(par("usr")[1:2]),y=par("usr")[3],labels="輸出：中国 -> アフリカの国々（2022）",cex=1.5,pos=3,col="white")
```

#### 参考1 のように leaflet パッケージを使う

```R
# パッケージを読み込む
require(leaflet)
require(leaflet.minicharts)
# データ結合
X_Flow=merge(todat,country,by.x="To",by.y="iso2c")
# インタラクティブな地図
leaflet() %>% 
  addTiles() %>%
  addFlows(lng0 = lonlat[1] , 
           lat0 = lonlat[2]  , 
           lng1 = X_Flow$destination_lon , 
           lat1 = X_Flow$destination_lat , 
           flow = X_Flow$Value , 
           dir = 1, 
           minThickness = 0.1,
           maxThickness = 2.5)
```
