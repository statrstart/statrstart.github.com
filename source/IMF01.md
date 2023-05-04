---
title: Rで国際通貨基金(IMF)のデータを取得する(その１)
date: 2023-05-03
tags: ["R", "imfr","tidyverse"]
excerpt: IMFのデータを取得し、グラフを作成。
---

# Rで国際通貨基金(IMF)のデータを取得する(その１)

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FIMF01&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

[RでGDPの推移を見る(世界銀行のデータ)](https://gitpress.io/@statrstart/WDI01)で
WDIパッケージを使って、世界銀行のデータを取得し、グラフを作成した。 

今回は、imfrパッケージを使ってIMFのデータを取得し、グラフを作成する。  

Package‘imfr’was removed from the CRAN repository.  
Archived on 2022-07-09 for policy violation. 

ということなので、[imfr package: https://github.com/christophergandrud/imfr](https://github.com/christophergandrud/imfr)からインストールする。

```R
remotes::install_github("christophergandrud/imfr")
``` 

### アメリカ，中国および日本の実効為替レートデータ

![EREER_IX](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/EREER_IX.png)

円弱い

### Rコード

```R
#remotes::install_github("christophergandrud/imfr")
require(imfr)
require(tidyverse)
require(scales)
require(knitr)
#
databases <- imf_databases()
IFS_param<-imf_parameters(database_id = "IFS")
#実効為替レートデータは　EREER_IX
#アメリカ、中国、日本のISO2
ISO2<- c( "JP" ,"CN", "US")
# データ取得
rate <- imf_dataset(database_id = "IFS",indicator = "EREER_IX",freq='A',ref_area = ISO2,return_raw = TRUE)
```

- database_id = “”: ダウンロードするデータベースのID

- indicator = “”: ダウンロードするIMFの指標ID

- ref_area = “”: ISOの２桁コードを使って国を指定

- start =, end = : データの開始年と終わりの年

- freq: 年次データ（A），四半期データ（Q）および月次データ（M）

- return_raw = TRUE: これを付けないとなぜかエラーになった。


```R
# データ編集
rate_Data<-rate %>% 
  unnest(Obs) %>% 
  select(country=`@REF_AREA`,year=`@TIME_PERIOD`,value=`@OBS_VALUE`) 
# グラフと凡例の対応付けをようにするため最終年の降順にするため工夫
dat<- as.data.frame(rate_Data)
# 数値に直す
dat$value<- as.numeric(dat$value)
dat$year<- as.integer(dat$year)
# 最終年のデータだけ取り出す
lg<-dat[dat$year==2022 ,c("country","value")]
# value降順でファクター化
dat$country<- factor(dat$country,levels=lg[order(-lg$value),"country"])
#
ggplot(dat, aes(x= year, y = value,color=country))+
	geom_line()+
	ylab("ENEER_IX")+
	theme_bw()
```

(参考)[貿易用語「EXW」「FOB」「CIF」とは?〜その②](http://mikasa-net.co.jp/%E8%B2%BF%E6%98%93%E7%94%A8%E8%AA%9E%E3%80%8Cexw%E3%80%8D%E3%80%8Cfob%E3%80%8D%E3%80%8Ccif%E3%80%8D%E3%81%A8%E3%81%AF%E3%80%9C%E3%81%9D%E3%81%AE%E2%91%A1/)

### 日本、中国、韓国　３国間の輸出データ：FOB(Free on Board=本船渡し)

![TXG_FOB_USD01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/TXG_FOB_USD01.png)

### アメリカ、日本、中国　３国間の輸出データ：FOB(Free on Board=本船渡し)

![TXG_FOB_USD02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/TXG_FOB_USD02.png)

- アメリカは中国から多く輸入している。

- 日本はアメリカより中国のほうが輸入、輸出とも多い。但し、中国への輸出額は2022年は大きく減った。

### Rコード

```R
#remotes::install_github("christophergandrud/imfr")
require(imfr)
require(tidyverse)
require(scales)
#Fetch the list of databases available through the IMF API
databases <- imf_databases()
DOT_param<-imf_parameters(database_id = "DOT")
knitr::kable(DOT_param$indicator)
```

|input_code  |description                                                         |
|:-----------|:-------------------------------------------------------------------|
|TXG_FOB_USD |Goods, Value of Exports, Free on board (FOB), US Dollars            |
|TMG_CIF_USD |Goods, Value of Imports, Cost, Insurance, Freight (CIF), US Dollars |
|TMG_FOB_USD |Goods, Value of Imports, Free on board (FOB), US Dollars            |
|TBG_USD     |Goods, Value of Trade Balance, US Dollars                           |

TXG_FOB_USDのデータを取得し、グラフを作成する。

#### 日本、中国、韓国　３国間の輸出データ：FOB(Free on Board=本船渡し)

```R
ISO2<- c( "JP" ,"CN", "KR")
# TXG_FOB_USDデータ取得
DOT <- imf_dataset(database_id = "DOT" , indicator = c("TXG_FOB_USD") ,freq='A',ref_area = ISO2 , start = 2010, end=2022,return_raw = TRUE)
# 単位を調べる
table(DOT$`@UNIT_MULT`)
#  6  <- 10^UNIT_MULT = 1,000,000: 単位: 100万ドル
# 722
DOT_Data<-DOT %>% 
  filter(`@COUNTERPART_AREA` %in% ISO2) %>% unnest(Obs) %>% 
  select(From=`@REF_AREA`, To=`@COUNTERPART_AREA`,Year=`@TIME_PERIOD`,Value=`@OBS_VALUE`) 
#
dat<- as.data.frame(DOT_Data)
#colnames(dat)<- c("From","To","Year","Value")
# 10億ドル単位にする
dat$Value<- as.numeric(dat$Value)/1000
dat$Year<- as.integer(dat$Year)
dat$From_To<- paste0(dat$From,"_",dat$To)
#
lg<-dat[dat$Year==2022 ,c("From_To","Value")]
dat$From_To<- factor(dat$From_To,levels=lg[order(-lg$Value),"From_To"])
#
ggplot(dat,aes(x=Year,y=Value,color=From_To)) +
	geom_line() +
	geom_point() +
	ylab("輸出_輸入（FOB）: 単位 10億ドル") +
	scale_x_continuous(breaks=seq(2000,2022,2),expand = rep(1e-2,2) )+
	scale_y_continuous(labels = comma)+
	theme_classic()
```

#### アメリカ、日本、中国　３国間の輸出データ：FOB(Free on Board=本船渡し)

```R
ISO2<- c( "JP" ,"CN", "US")
DOT <- imf_dataset(database_id = "DOT" , indicator = c("TXG_FOB_USD") ,freq='A',ref_area = ISO2 , start = 2010, end=2022,return_raw = TRUE)
DOT_Data<-DOT %>% 
  filter(`@FREQ` == "A" & `@COUNTERPART_AREA` %in% ISO2) %>% unnest(Obs) %>% 
  select(From=`@REF_AREA`, To=`@COUNTERPART_AREA`,Year=`@TIME_PERIOD`,Value=`@OBS_VALUE`) 
dat<- as.data.frame(DOT_Data)
# 10億ドル単位にする
dat$Value<- as.numeric(dat$Value)/1000
dat$Year<- as.integer(dat$Year)
dat$From_To<- paste0(dat$From,"_",dat$To)
lg<-dat[dat$Year==2022 ,c("From_To","Value")]
dat$From_To<- factor(dat$From_To,levels=lg[order(-lg$Value),"From_To"])
ggplot(dat,aes(x=Year,y=Value,color=From_To)) +
	geom_line() +
	geom_point() +
	ylab("輸出_輸入（FOB）: 単位 10億ドル")+
	scale_x_continuous(breaks=seq(2000,2022,2),expand = rep(1e-2,2) )+
	scale_y_continuous(labels = comma)+
	theme_bw() 
```
