---
title: RでIMFの世界経済見通し(WEO)データを扱う(その１)
date: 2023-05-13
tags: ["R", "imf-weo","rsdmx"]
excerpt: R用WEOデータ(2023/4)を見つけた。
---

# RでIMFの世界経済見通し(WEO)データを扱う(その１)

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FIMF_WEO01&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

IMFの世界経済見通し(WEO)データの2023年4月のデータは、

[Download entire World Economic Outlook database: April 2023](https://www.imf.org/en/Publications/WEO/weo-database/2023/April/download-entire-database) にあります。`SDMX Data`をクリックするとダウンロードされる`WEOApr2023-SDMXData.zip`を解凍。`WEO_PUB_APR2023.xml`がデータ本体。

`WEO_PUB_APR2023.xml`を`rsdmx::readSDMX`関数で取り込んで、データフレームに変換したんですが３，４分待っても処理が終わらないのでフリーズと勘違いしてRを強制終了。（と、いまになってわかった）

で、R用WEOデータ(2023/4)を探して、見つけました。

(データ)  

[mitsuoxv/imf-weo](https://github.com/mitsuoxv/imf-weo)　data -> data_2304.rda

データの作成方法も（ありがたいことに）公開されています。 data-raw -> setup_current.R

実際に、作成してみましたが、`weo_raw <- as_tibble(sdmx)` の部分で数分（性能のあまり良くないノートパソコンで８分）かかります。

### IMFの世界経済見通し(WEO)データ

このデータについて、調べたことをまとめておきます。（間違いがあるかも知れません。）

#### IMFのWEOデータには世界データ、グループデータも含まれている。

|Name                                                                               |ref_area |
|:----------------------------------------------------------------------------------|:--------|
|World                                                                              |001      |
|Advanced Economies                                                                 |110      |
|G7                                                                                 |119      |
|Other Advanced Economies (Advanced Economies excluding G7 and Euro Area countries) |123      |
|Euro area                                                                          |163      |
|Emerging Market and Developing Economies                                           |200      |
|Latin America and the Caribbean                                                    |205      |
|Middle East and Central Asia (MECA)                                                |400      |
|Emerging and Developing Asia                                                       |505      |
|ASEAN-5                                                                            |510      |
|Sub-Sahara Africa                                                                  |603      |
|Emerging and Developing Europe                                                     |903      |
|European Union                                                                     |998      |

##### ref_areaコードと国名との対応表は、

[Download entire World Economic Outlook database: April 2023](https://www.imf.org/en/Publications/WEO/weo-database/2023/April/download-entire-database)の
`SDMX Data Structure Definition`をクリックするとダウンロードされる `weoapr2023-sdmx-dsd.xlsx` の`REF_AREA`シート。  

ただ、このデータだと使い勝手が悪い(IMFコード <--> 国名　の対応のみ)ので、

1. 一般的に使われているiso2, iso3とも対応させるためにcountrycodeパッケージのcodelistとマージ

2. さらに、国、地域の重心データとも対応させるために、CoordinateCleanerパッケージのcountryrefとマージ

3. 重心データ等抜けのある箇所をネットで調べて埋めた。

(注意)

- 欠損値の箇所は空欄にしています。Namibiaのiso2コードが `NA` のため欠損値と誤認識されてしまうため。

- csvデータではなく、データを読み込むコードも含むRコードにしています。

	- `colClasses=c(rep("character",5),rep("numeric",4)),na.strings=""` とかオプション付けるのめんどくさいと思うので。

- 他のことにも使えるようにWEO(IMF)コードのない国、地域のデータもある

```R
url="https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/"
source(paste0(url,"WEOcountry.R"))
# これでデータが読み込まれる。
head(WEOcountry)
# WEOデータを扱う場合は、WEO(IMF)コードが欠損しているデータを取り除く
WEOcountry <- WEOcountry[!is.na(WEOcountry$WEO) , ]  
```

### （参考）data_2304データの軽量化(よく使いそうなデータだけにする)

特に、`concept`の種類が多すぎて、わけわからないので、自分なりに整理しました。

#### notes列、freq列削除

```R
head(data_2304)
# notes列(6列目)を取り除いて、d に入力 
d<- data_2304[,c(1:5,7:9)]
# freq列を調べる
table(d$freq)
#     A 
#510384 
# 年次データしかないので、freq列を取り除く
d<-d[,c(1:3,5:8)]
```

#### concept列の整理

```R
table(d$concept)
# 1000に満たない(686)データは使うことないので取り除く
#table(table(d$concept) < 1000)
#FALSE  TRUE 
#   44   101 
# 101ものデータが取り除くデータに該当する
# 残すデータ名を、nn に入れる
( nn<- names(table(d$concept)[table(d$concept) > 1000]) )
# [1] "BCA"          "BCA_NGDPD"    "GGR"          "GGR_NGDP"     "GGSB"        
# [6] "GGSB_NPGDP"   "GGX"          "GGX_NGDP"     "GGXCNL"       "GGXCNL_NGDP" 
#[11] "GGXONLB"      "GGXONLB_NGDP" "GGXWDG"       "GGXWDG_NGDP"  "GGXWDN"      
#[16] "GGXWDN_NGDP"  "LE"           "LP"           "LUR"          "NGAP_NPGDP"  
#[21] "NGDP"         "NGDP_D"       "NGDP_FY"      "NGDP_R"       "NGDP_RPCH"   
#[26] "NGDPD"        "NGDPDPC"      "NGDPPC"       "NGDPRPC"      "NGDPRPPPPC"  
#[31] "NGSD_NGDP"    "NID_NGDP"     "PCPI"         "PCPIE"        "PCPIEPCH"    
#[36] "PCPIPCH"      "PPPEX"        "PPPGDP"       "PPPPC"        "PPPSH"       
#[41] "TM_RPCH"      "TMG_RPCH"     "TX_RPCH"      "TXG_RPCH" 
#
# データ数の少ないものを取り除く
d<- d[d$concept %in% nn,]
# data_2304liteに入れて
data_2304lite<- d
# 保存
save(data_2304lite,file="data_2304lite.rda")
#
# WEOデータには観測データと予測データが含まれる。
table(d$lastactualdate)
#  2003   2004   2006   2008   2009   2010   2011   2012   2013   2014   2015 
#   294    294    294    294   1225   1372   1470    882    882   1176   2695 
#  2016   2017   2018   2019   2020   2021   2022 
#  1470   3626   4165   9261  33124 198499 113680 
# 単位
table(d$scale)
#     1  1e+06  1e+09 
#294980  19208 126910 
table(d$unit)
#     B      C      E      F      G      H      K      L      M      N      P 
# 28812   1372 115248   9604  10290  72030  92610  20580  10290  19208  30184 
#     S      T 
# 10290  20580 
```

#### unitについて

|code  |  Description                                         |	|
|------|------------------------------------------------------|-----------|
|B     |  Index                                               ||
|C     |  Index                                               |   2000=100|
|E     |  National currency                                   ||
|F     |  National currency per current international dollar  ||
|G     |  Percent                                             ||
|H     |  Percent change                                      ||
|K     |  Percent of GDP                                      ||
|L     |  Percent of potential GDP                            ||
|M     |  Percent of total labor force                        ||
|N     |  Persons                                             ||
|P     |  U.S. dollars                                        ||
|S     |  Purchasing power parity; 2017 international dollar  ||
|T     |  Purchasing power parity; international dollars      ||


#### conceptについて(`weo-database-guideline.pdf` で探したpdfファイルをみて、対応付けした。)

末尾が、`PCH`:変化率、`PC`:一人当たり、`_NGDP`:対GDP比、`_NPGDP`:対潜在GDP比

(例)

`NGDPD` -> `NGDP`(名目GDP) + `D`(単位：U.S.ドル)

`NGDPRPPPPC` -> `NGDPR`(実質GDP) + `PPP`(購買力平価換算) + `PC`(一人当たり)

|     コード      |            経済指標       |単位|
|------------------|---------------------------|-----------------|
|国民経済計算          |                           ||
|1. NGDP_R         |  国内総生産（実質）                |  各国通貨|
|2. NGDP_RPCH      |  国内総生産（実質）                |  変化率（％）|
|3. NGDP           |  国内総生産（名目）                |  各国通貨|
|4. NGDPD          |  国内総生産（名目）                |  U.S.ドル|
|5. PPPGDP         |  国内総生産（名目）（購買力平価換算）       |  購買力平価国際ドル|
|6. NGDP_D         |  GDPデフレーター                ||
|7. NGDPRPC        |  一人当たり国内総生産（実質）           |  各国通貨|
|8. NGDPRPPPPC     |  一人当たり国内総生産（実質）（購買力平価換算）  |  購買力平価国際ドル(2011)|
|9. NGDPPC         |  一人当たり国内総生産（名目）           |  各国通貨|
|10. NGDPDPC       |  一人当たり国内総生産（名目）           |  U.S.ドル|
|11. PPPPC         |  一人当たり国内総生産（名目）（購買力平価換算）  |  購買力平価国際ドル|
|12. NGAP_NPGDP    |  産出量ギャップ                  |  対潜在GDP比（％）|
|13. PPPSH         |  GDP対世界比（購買力平価換算）         |  総GDP比(%)|
|14. PPPEX         |  購買力平価（対ドル評価）             |  各国通貨/ドル|
|15. NID_NGDP      |  投資                       |  対GDP比（％）|
|16. NGSD_NGDP     |  国民総貯蓄                    |  対GDP比（％）|
|金融              |                           ||
|1. PCPI           |  消費者物価指数（年平均値）            ||
|2. PCPIPCH        |  インフレ率（消費者物価指数年平均値）　      |  変化率（％）|
|3. PCPIE          |  消費者物価指数（期末値）             ||
|4. PCPIEPCH       |  インフレ率（消費者物価指数期末値）        |  変化率（％）|
|貿易              |                           ||
|1. TM_RPCH        |  財サービス輸入量                 |  変化率（％）|
|2. TMG_RPCH       |  財輸入量                     |  変化率（％）|
|3. TX_RPCH        |  財サービス輸出量                 |  変化率（％）|
|4. TXG_RPCH       |  財輸出量                     |  変化率（％）|
|人口              |                           ||
|1. LUR            |  失業率                      |  対労働力人口比（％）|
|2. LE             |  就業者数                     |  人|
|3. LP             |  総人口                      |  人|
|財政              |                           ||
|1. GGR            |  財政収入額                    |  各国通貨|
|2. GGR_NGDP       |  財政収入額                    |  対GDP比（％）|
|3. GGX            |  財政支出額                    |  各国通貨|
|4. GGX_NGDP       |  財政支出額                    |  対GDP比（％）|
|5. GGXCNL         |  財政収支額                    |  各国通貨|
|6. GGXCNL_NGDP    |  財政収支額                    |  対GDP比（％）|
|7. GGSB           |  構造的財政収支                  |  各国通貨|
|8. GGSB_NPGDP     |  構造的財政収支                  |  対潜在GDP比（％）|
|9. GGXONLB        |  基礎的財政収支                  |  各国通貨|
|10. GGXONLB_NGDP  |  基礎的財政収支                  |  対GDP比（％）|
|11. GGXWDN        |  政府純債務額                   |  各国通貨|
|12. GGXWDN_NGDP   |  政府純債務額                   |  対GDP比（％）|
|13. GGXWDG        |  政府総債務額                   |  各国通貨|
|14. GGXWDG_NGDP   |  政府総債務額                   |  対GDP比（％）|
|15. NGDP_FY       |  会計年度別国内総生産（名目）           |  各国通貨|
|国際収支            |                           ||
|1. BCA            |  経常収支                     |  U.S.ドル|
|2. BCA_NGDPD      |  経常収支額                    |  対GDP比（％）|

