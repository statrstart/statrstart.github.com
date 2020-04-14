---
title: 韓国と日本のPCR検査実施人数比較 (新型コロナウイルス：Coronavirus)
date: 2020-04-14
tags: ["R", "knitr","Coronavirus","新型コロナウイルス","South Korea"]
excerpt: 韓国のデータ:KCDC,日本のデータ:厚生労働省の報道発表資料で作成
---

# 韓国と日本のPCR検査実施人数比較 (新型コロナウイルス：Coronavirus)
![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus08)

(関連ニュース)  [世界121カ国、新型コロナ検査で韓国に支援要請 2020年4月2日](https://jp.reuters.com/article/health-coronavirus-southkorea-testing-idJPKBN21J6L9)  

(参考)  
[Wikipedia:COVID-19 testing](https://en.wikipedia.org/wiki/COVID-19_testing)  
[データのじかん: データでみる世界各国の新型コロナウイルスの検査状況！](https://data.wingarc.com/covid-19-tests-25207)  
[How many tests for COVID-19 are being performed around the world?](https://ourworldindata.org/covid-testing#note-2)  

[CDC:Testing in U.S.](https://www.cdc.gov/coronavirus/2019-ncov/cases-updates/testing-in-us.html)  
[CORONAVIRUS DATA: Tracking COVID-19 testing across the U.S.](https://www.clickondetroit.com/health/2020/03/13/coronavirus-data-tracking-covid-19-testing-across-the-us/)

韓国のPCR検査実施人数等を表とグラフにします。韓国に比べて以下に日本の検査件数が少ないかがわかります。  
ちなみに、人口は世界の人口 （世銀）直近データ2018年によると  	
日本：126,529,000、韓国：51,635,000、日本の約４１％です。

さらに、日本、韓国、台湾、シンガポールの新型コロナウイルスのデータで棒グラフ、折れ線グラフを作成しました。  

関連した記事：[COVID-19 testing(新型コロナウイルス：Coronavirus)でbarplot](https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus11)  	
	
#### 韓国のデータ : [KCDC「News Room」「Press Release」](https://www.cdc.go.kr/board/board.es?mid=a30402000000&bid=0030)  

#### 日本のPCR検査実施人数は、厚生労働省の[報道発表資料](https://www.mhlw.go.jp/stf/houdou/index.html)から抜き出した。    

### 新型コロナウイルスのPCR検査実施人数と感染状況(韓国)

![pcr04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr04.png)

### 韓国のPCR検査の陽性率(%)

![pcr05](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr05.png)

### 韓国のPCR検査の暫定致死率(%)

![pcr06](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr06.png)

### 韓国の陽性者数（日別）

![pcr07](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr07.png)

### 韓国のPCR検査の結果（日別）

![pcr08](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr08.png)

### 日本、韓国、台湾、シンガポールの面積、人口、人口密度

|   country    |    area|         pop| Population.density|
|:------------:|-------:|-----------:|------------------:|
|    Japan     | 377,915| 127,103,388|                336|
| Korea, South |  99,720|  49,039,986|                492|
|  Singapore   |     697|   5,567,301|              7,988|
|    Taiwan    |  35,980|  23,359,928|                649|

### 日本、韓国、台湾、シンガポールのPCR検査の暫定致死率(%)
#### 米ジョンズ・ホプキンス大学のデータを使った。Rコードは省略。
（参考）[Rで折れ線グラフ、棒グラフ (新型コロナウイルス：Coronavirus)](https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus09)

![Coronavirus01_1_2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Coronavirus01_1_2.png)

#### 日本、韓国、台湾、シンガポールのTotal Tests for COVID-19

![pcr09](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr09.png)

#### 日本、韓国、台湾、シンガポールの陽性率(%) Positive/Tests*100

![pcr12](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr12.png)

# 日本の陽性率が非常に大きく、台湾は小さい。

#### 日本、韓国、台湾、シンガポールのTests /million people for COVID-19

![pcr10](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr10.png)

#### 日本、韓国、台湾、シンガポールのReported Confirmed

### 検査の数、１００万人あたりの検査人数をふまえたうえで、報告された感染者数をみると、

![pcr11](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr11.png)

### データから表を作成(韓国のPCR検査実施人数とその結果)

|           | 検査を受けた人| 感染者数| 死者|   陰性| 検査中|
|:----------|--------------:|--------:|----:|------:|------:|
|2020-02-01 |            371|       12|    0|    289|     70|
|2020-02-02 |            429|       15|    0|    327|     87|
|2020-02-03 |            429|       15|    0|    414|      0|
|2020-02-04 |            607|       16|    0|    462|    129|
|2020-02-05 |            714|       18|    0|    522|    174|
|2020-02-06 |            885|       23|    0|    693|    169|
|2020-02-07 |           1130|       24|    0|    842|    264|
|2020-02-08 |           1701|       24|    0|   1057|    620|
|2020-02-09 |           2340|       25|    0|   1355|    960|
|2020-02-10 |           2776|       27|    0|   1940|    809|
|2020-02-11 |           3629|       28|    0|   2736|    865|
|2020-02-12 |           5074|       28|    0|   4054|    992|
|2020-02-13 |           5797|       28|    0|   5099|    670|
|2020-02-14 |           6854|       28|    0|   6134|    692|
|2020-02-15 |           7519|       28|    0|   6853|    638|
|2020-02-16 |           7919|       29|    0|   7313|    577|
|2020-02-17 |           8171|       30|    0|   7733|    408|
|2020-02-18 |           9265|       31|    0|   8277|    957|
|2020-02-19 |          10411|       46|    0|   9335|   1030|
|2020-02-20 |          12161|       82|    0|  10446|   1633|
|2020-02-21 |          14816|      156|    1|  11953|   2707|
|2020-02-22 |          19621|      346|    2|  13794|   5481|
|2020-02-23 |          22633|      556|    4|  16038|   6039|
|2020-02-24 |          28615|      763|    7|  19127|   8725|
|2020-02-25 |          36716|      893|    8|  22550|  13273|
|2020-02-26 |          46127|     1146|   11|  28247|  16734|
|2020-02-27 |          57990|     1595|   12|  35298|  21097|
|2020-02-28 |          70940|     2022|   13|  44167|  24751|
|2020-02-29 |          85693|     2931|   16|  53608|  29154|
|2020-03-01 |          96985|     3526|   17|  61037|  32422|
|2020-03-02 |         109591|     4212|   22|  71580|  33799|
|2020-03-03 |         125851|     4812|   28|  85484|  35555|
|2020-03-04 |         136707|     5328|   32| 102965|  28414|
|2020-03-05 |         146541|     5766|   35| 118965|  21810|
|2020-03-06 |         164740|     6284|   42| 136624|  21832|
|2020-03-07 |         178189|     6767|   44| 151802|  19620|
|2020-03-08 |         188518|     7134|   50| 162008|  19376|
|2020-03-09 |         196618|     7382|   51| 171778|  17458|
|2020-03-10 |         210144|     7513|   54| 184179|  18452|
|2020-03-11 |         222395|     7755|   60| 196100|  18540|
|2020-03-12 |         234998|     7869|   66| 209402|  17727|
|2020-03-13 |         248647|     7979|   67| 222728|  17940|
|2020-03-14 |         261335|     8086|   72| 235615|  17634|
|2020-03-15 |         268212|     8162|   75| 243778|  16272|
|2020-03-16 |         274504|     8236|   75| 251297|  14971|
|2020-03-17 |         286716|     8320|   81| 261105|  17291|
|2020-03-18 |         295647|     8413|   84| 270888|  16346|
|2020-03-19 |         307024|     8565|   91| 282555|  15904|
|2020-03-20 |         316664|     8652|   94| 292487|  15525|
|2020-03-21 |         327509|     8799|  102| 303006|  15704|
|2020-03-22 |         331780|     8897|  104| 308343|  14540|
|2020-03-23 |         338036|     8961|  111| 315447|  13628|
|2020-03-24 |         348582|     9037|  120| 324105|  15440|
|2020-03-25 |         357896|     9137|  126| 334481|  14278|
|2020-03-26 |         364942|     9241|  131| 341332|  14369|
|2020-03-27 |         376961|     9332|  139| 352410|  15219|
|2020-03-28 |         387925|     9478|  144| 361883|  16564|
|2020-03-29 |         394141|     9583|  152| 369530|  15028|
|2020-03-30 |         395194|     9661|  158| 372002|  13531|
|2020-03-31 |         410564|     9786|  162| 383886|  16892|
|2020-04-01 |         421547|     9887|  165| 395075|  16585|
|2020-04-02 |         431743|     9976|  169| 403882|  17885|
|2020-04-03 |         443273|    10062|  174| 414303|  18908|
|2020-04-04 |         455032|    10156|  177| 424732|  20144|
|2020-04-05 |         461233|    10237|  183| 431425|  19571|
|2020-04-06 |         466804|    10284|  186| 437225|  19295|
|2020-04-07 |         477304|    10331|  192| 446323|  20650|
|2020-04-08 |         486003|    10384|  200| 457761|  17858|
|2020-04-09 |         494711|    10423|  204| 468779|  15509|
|2020-04-10 |         503051|    10450|  208| 477303|  15298|
|2020-04-11 |         510479|    10480|  211| 485929|  14070|
|2020-04-12 |         514621|    10512|  214| 490321|  13788|
|2020-04-13 |         518743|    10537|  217| 494815|  13391|
|2020-04-14 |         527438|    10564|  222| 502223|  14651|

### 陽性率、暫定致死率を計算し、表を作成(韓国）

|           | 結果判明| 感染者数|   陰性| 陽性率(%)| 死者| 暫定致死率(%)|
|:----------|--------:|--------:|------:|---------:|----:|-------------:|
|2020-02-01 |      301|       12|    289|      3.99|    0|         0.000|
|2020-02-02 |      342|       15|    327|      4.39|    0|         0.000|
|2020-02-03 |      429|       15|    414|      3.50|    0|         0.000|
|2020-02-04 |      478|       16|    462|      3.35|    0|         0.000|
|2020-02-05 |      540|       18|    522|      3.33|    0|         0.000|
|2020-02-06 |      716|       23|    693|      3.21|    0|         0.000|
|2020-02-07 |      866|       24|    842|      2.77|    0|         0.000|
|2020-02-08 |     1081|       24|   1057|      2.22|    0|         0.000|
|2020-02-09 |     1380|       25|   1355|      1.81|    0|         0.000|
|2020-02-10 |     1967|       27|   1940|      1.37|    0|         0.000|
|2020-02-11 |     2764|       28|   2736|      1.01|    0|         0.000|
|2020-02-12 |     4082|       28|   4054|      0.69|    0|         0.000|
|2020-02-13 |     5127|       28|   5099|      0.55|    0|         0.000|
|2020-02-14 |     6162|       28|   6134|      0.45|    0|         0.000|
|2020-02-15 |     6881|       28|   6853|      0.41|    0|         0.000|
|2020-02-16 |     7342|       29|   7313|      0.39|    0|         0.000|
|2020-02-17 |     7763|       30|   7733|      0.39|    0|         0.000|
|2020-02-18 |     8308|       31|   8277|      0.37|    0|         0.000|
|2020-02-19 |     9381|       46|   9335|      0.49|    0|         0.000|
|2020-02-20 |    10528|       82|  10446|      0.78|    0|         0.000|
|2020-02-21 |    12109|      156|  11953|      1.29|    1|         0.641|
|2020-02-22 |    14140|      346|  13794|      2.45|    2|         0.578|
|2020-02-23 |    16594|      556|  16038|      3.35|    4|         0.719|
|2020-02-24 |    19890|      763|  19127|      3.84|    7|         0.917|
|2020-02-25 |    23443|      893|  22550|      3.81|    8|         0.896|
|2020-02-26 |    29393|     1146|  28247|      3.90|   11|         0.960|
|2020-02-27 |    36893|     1595|  35298|      4.32|   12|         0.752|
|2020-02-28 |    46189|     2022|  44167|      4.38|   13|         0.643|
|2020-02-29 |    56539|     2931|  53608|      5.18|   16|         0.546|
|2020-03-01 |    64563|     3526|  61037|      5.46|   17|         0.482|
|2020-03-02 |    75792|     4212|  71580|      5.56|   22|         0.522|
|2020-03-03 |    90296|     4812|  85484|      5.33|   28|         0.582|
|2020-03-04 |   108293|     5328| 102965|      4.92|   32|         0.601|
|2020-03-05 |   124731|     5766| 118965|      4.62|   35|         0.607|
|2020-03-06 |   142908|     6284| 136624|      4.40|   42|         0.668|
|2020-03-07 |   158569|     6767| 151802|      4.27|   44|         0.650|
|2020-03-08 |   169142|     7134| 162008|      4.22|   50|         0.701|
|2020-03-09 |   179160|     7382| 171778|      4.12|   51|         0.691|
|2020-03-10 |   191692|     7513| 184179|      3.92|   54|         0.719|
|2020-03-11 |   203855|     7755| 196100|      3.80|   60|         0.774|
|2020-03-12 |   217271|     7869| 209402|      3.62|   66|         0.839|
|2020-03-13 |   230707|     7979| 222728|      3.46|   67|         0.840|
|2020-03-14 |   243701|     8086| 235615|      3.32|   72|         0.890|
|2020-03-15 |   251940|     8162| 243778|      3.24|   75|         0.919|
|2020-03-16 |   259533|     8236| 251297|      3.17|   75|         0.911|
|2020-03-17 |   269425|     8320| 261105|      3.09|   81|         0.974|
|2020-03-18 |   279301|     8413| 270888|      3.01|   84|         0.998|
|2020-03-19 |   291120|     8565| 282555|      2.94|   91|         1.062|
|2020-03-20 |   301139|     8652| 292487|      2.87|   94|         1.086|
|2020-03-21 |   311805|     8799| 303006|      2.82|  102|         1.159|
|2020-03-22 |   317240|     8897| 308343|      2.80|  104|         1.169|
|2020-03-23 |   324408|     8961| 315447|      2.76|  111|         1.239|
|2020-03-24 |   333142|     9037| 324105|      2.71|  120|         1.328|
|2020-03-25 |   343618|     9137| 334481|      2.66|  126|         1.379|
|2020-03-26 |   350573|     9241| 341332|      2.64|  131|         1.418|
|2020-03-27 |   361742|     9332| 352410|      2.58|  139|         1.489|
|2020-03-28 |   371361|     9478| 361883|      2.55|  144|         1.519|
|2020-03-29 |   379113|     9583| 369530|      2.53|  152|         1.586|
|2020-03-30 |   381663|     9661| 372002|      2.53|  158|         1.635|
|2020-03-31 |   393672|     9786| 383886|      2.49|  162|         1.655|
|2020-04-01 |   404962|     9887| 395075|      2.44|  165|         1.669|
|2020-04-02 |   413858|     9976| 403882|      2.41|  169|         1.694|
|2020-04-03 |   424365|    10062| 414303|      2.37|  174|         1.729|
|2020-04-04 |   434888|    10156| 424732|      2.34|  177|         1.743|
|2020-04-05 |   441662|    10237| 431425|      2.32|  183|         1.788|
|2020-04-06 |   447509|    10284| 437225|      2.30|  186|         1.809|
|2020-04-07 |   456654|    10331| 446323|      2.26|  192|         1.858|
|2020-04-08 |   468145|    10384| 457761|      2.22|  200|         1.926|
|2020-04-09 |   479202|    10423| 468779|      2.18|  204|         1.957|
|2020-04-10 |   487753|    10450| 477303|      2.14|  208|         1.990|
|2020-04-11 |   496409|    10480| 485929|      2.11|  211|         2.013|
|2020-04-12 |   500833|    10512| 490321|      2.10|  214|         2.036|
|2020-04-13 |   505352|    10537| 494815|      2.09|  217|         2.059|
|2020-04-14 |   512787|    10564| 502223|      2.06|  222|         2.101|

## Rコード

### データから表を作成

```R
library(knitr)
date<- seq(as.Date("2020-02-01"), as.Date("2020-04-14"), by = "day")
検査を受けた人<-c(371,429,429,607,714,885,1130,1701,2340,2776,3629,5074,5797,6854,7519,7919,8171,
	9265,10411,12161,14816,19621,22633,28615,36716,46127,57990,70940,85693,96985,109591,125851,
	136707,146541,164740,178189,188518,196618,210144,222395,234998,	248647,261335,268212,274504,
	286716,295647,307024,316664,327509,331780,338036,348582,357896,364942,376961,387925,394141,
	395194,410564,421547,431743,443273,455032,461233,466804,477304,486003,494711,503051,510479,
	514621,518743,527438)
感染者数<-c(12,15,15,16,18,23,24,24,25,27,28,28,28,28,28,29,30,31,46,82,156,346,556,763,893,1146,
	1595,2022,2931,3526,4212,4812,5328,5766,6284,6767,7134,7382,7513,7755,7869,7979,8086,8162,
	8236,8320,8413,8565,8652,8799,8897,8961,9037,9137,9241,9332,9478,9583,9661,9786,9887,9976,
	10062,10156,10237,10284,10331,10384,10423,10450,10480,10512,10537,10564)
死者<-c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,4,7,8,11,12,13,16,17,22,28,32,35,42,44,50,51,
	54,60,66,67,72,75,75,81,84,91,94,102,104,111,120,126,131,139,144,152,158,162,165,169,174,
	177,183,186,192,200,204,208,211,214,217,222)
陰性<-c(289,327,414,462,522,693,842,1057,1355,1940,2736,4054,5099,6134,6853,7313,7733,8277,9335,10446,
	11953,13794,16038,19127,22550,28247,35298,44167,53608,61037,71580,85484,102965,118965,136624,
	151802,162008,171778,184179,196100,209402,222728,235615,243778,251297,261105,270888,282555,
	292487,303006,308343,315447,324105,334481,341332,352410,361883,369530,372002,383886,395075,
	403882,414303,424732,431425,437225,446323,457761,468779,477303,485929,490321,494815,502223)
検査中<- 検査を受けた人- (陰性+感染者数)
#df<- data.frame(date,感染者数,死者,検査を受けた人_感染者除く,陰性,検査中)
#kable(df,row.names=F)
df<- data.frame(検査を受けた人,感染者数,死者,陰性,検査中)
rownames(df)<- date
kable(df)
```

### 陽性率、暫定致死率を計算し、表を作成

```R
# 陽性率、暫定致死率を計算
結果判明 <- 感染者数 + 陰性
陽性率 <- round(感染者数/結果判明*100,2)
暫定致死率 <- round(死者/感染者数*100,3)
#
df2 <- data.frame(結果判明,感染者数,陰性,陽性率,死者,暫定致死率)
colnames(df2)<- c("結果判明","感染者数","陰性","陽性率(%)","死者","暫定致死率(%)")
rownames(df2)<- date
kable(df2)
```

### 新型コロナウイルスのPCR検査実施人数と感染状況(韓国)

```R
#日本のPCR検査実施人数（結果判明した数）
Jpcr1<- c(rep(NA,5),16,151,NA,NA,174,NA,190,200,214,NA,NA,487,523,532)+c(rep(NA,5),9,566,NA,NA,764,NA,764,764,764,NA,NA,764,764,764)
# 3/19 : PCR検査実施人数が減少したのは、千葉県が人数でなく件数でカウントしていたことが判明したため、千葉県の件数を引いたことによる
Jpcr2<- c(603,693,778,874,913,1017,1061,1229,1380,1510,1688,1784,1855,5690,5948,6647,7200,7347,7457,8771,9195,9376,11231,
	12090,12197,12239,14322,14525,14072,18015,18134,18226+1173,18322+1189,22184+1417,21266+1426,22858+1484,24663+1513,
	26105+1530,26401+1530,26607+1530,30088+1580,32002+1677,32002+1679,36687+1930,39992+2061,40263+3547,40481+4862,48357+6125,
	52901+7768,54284+9274,57125+10817,61991+12071,63132+13420,63132+14741,72801+15921)+829
Jpcr<- c(Jpcr1,Jpcr2)
kj<-paste0(round(結果判明[length(結果判明)]/max(Jpcr,na.rm=T),1),"倍")
# 指数表示を抑制
options(scipen=2) 
#png("pcr04.png",width=800,height=600)
par(mar=c(4,6,4,2))
b<- barplot(t(df[,c(2,4,5)]),names.arg=gsub("2020-","",rownames(df)),col=c("red","lightblue","gray80"),
	ylim= c(0,max(検査を受けた人)*1.1),yaxt ="n",
	legend=T,args.legend = list(x="topleft",inset=c(0.03,0.03)))
# Add comma separator to axis labels
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1)  
#text(x=b,y=検査を受けた人,labels= 検査を受けた人,pos=3,col="blue")
points(x=b,y=Jpcr,pch=16)
lines(x=b,y=Jpcr,pch=16,lwd=2)
legend(x="topleft",inset=c(0.03,0.2),bty="n",legend="日本のPCR検査実施人数(データ：厚生労働省HP)",pch=16,lwd=2)
legend(x="topleft",inset=c(0.03,0.25),bty="n",legend="* 韓国の人口は日本の約４１％",cex=1.5)
legend(x="topleft",inset=c(0.03,0.3),bty="n",legend=paste("* PCR検査で結果判明した数は日本の",kj),cex=1.5)
legend(x="topleft",inset=c(0.03,0.35),bty="n",legend="（日本：チャーター便帰国者も含む）",cex=1.5)
#text(x=0,y=120000,labels="* 韓国の人口は日本の約４１％",pos=4,cex=1.5)
#text(x=0,y=110000,labels=paste("* PCR検査で結果判明した数は日本の",kj),pos=4,cex=1.5)
#text(x=0,y=100000,labels="（日本：チャーター便帰国者も含む）",pos=4,cex=1.5)
title("韓国と日本のPCR検査実施人数の推移")
#dev.off()
```

### 韓国のPCR検査の陽性率(%)(累計で計算)

```R
#png("pcr05.png",width=800,height=600)
par(mar=c(4,6,4,2))
plot(df2$"陽性率(%)",type="o",lwd=3,xaxt="n",xlab="",ylab="陽性率(%)",las=1)
axis(1,at=1:nrow(df2),labels=gsub("2020-","",rownames(df2)))
title("韓国のPCR検査の陽性率(%)の推移")
#dev.off()
```

### 韓国のPCR検査の暫定致死率(%)(累計で計算)

```R
#png("pcr06.png",width=800,height=600)
par(mar=c(4,6,4,2))
plot(df2$"暫定致死率(%)",type="o",lwd=3,xaxt="n",xlab="",ylab="暫定致死率(%)",las=1)
axis(1,at=1:nrow(df2),labels=gsub("2020-","",rownames(df2)))
title("韓国の暫定致死率(%)の推移")
#dev.off()
```

### 韓国の陽性者数（日別）

```R
#png("pcr07.png",width=800,height=600)
par(mar=c(4,6,4,2))
barplot(diff(df2$感染者数),names=gsub("2020-","",rownames(df2[-1,])),col="pink",las=1)
title("韓国の陽性者数（日別）")
#dev.off()
```

### 韓国のPCR検査の結果（日別）

```R
dat<-rbind(diff(df2$感染者数),diff(df2$陰性))
rownames(dat)<- c("陽性","陰性")
colnames(dat)<- gsub("2020-","",rownames(df2[-1,]))
#png("pcr08.png",width=800,height=600)
par(mar=c(4,6,4,2))
barplot(dat,names=gsub("2020-","",rownames(df[-1,])),col=c("red","lightblue"),las=1,legend=T,
	args.legend=list(x="topleft",inset=c(0.03,0.03)))
title("韓国のPCR検査の結果（日別）")
#dev.off()
```

### 日本、韓国、台湾、シンガポールの面積、人口、人口密度

```R
library(DataComputing)
library(knitr)
data("CountryData")
adata<- CountryData[grep("(Japan|Korea, South|Taiwan|Singapore)",CountryData$country),1:3]
# 人口密度計算
adata$"Population density"<- round(adata$pop/adata$area,0)
kable(data.frame(lapply(adata,function(x)formatC(x, format="f", big.mark=",",digits=0))),
	row.names=F,align=c("c",rep("r",3)))
```

### 日本、韓国、台湾、シンガポールのTotal Tests for COVID-19

```R
library("rvest")
# "COVID-19 testing"のデータ取得
html <- read_html("https://en.wikipedia.org/wiki/COVID-19_testing")
tbl<- html_table(html,fill = T)
# "covid19-testing"のtableが何番目か見つける
nodes<- html_nodes(html, "table")
class<-html_attr(nodes,"class")
num<-grep("covid19-testing",class)
#
Wtest<- tbl[[num]][,1:7]
str(Wtest)
#
for (i in c(3,4,5,6,7)){
	Wtest[,i]<- as.numeric(gsub(",","",Wtest[,i]))
}
str(Wtest)
save("Wtest",file="Wtest.Rdata")
#load("Wtest.Rdata")
asia4<- Wtest[grep("(Japan|South Korea|Singapore|Taiwan)",Wtest[,1]),]
```

#### 日本、韓国、台湾、シンガポールのTotal Tests for COVID-19

```R
# Testsで並べ替え
dat<- asia4[order(asia4[,"Tests"]),]
#png("pcr09.png",width=800,height=600)
par(mar=c(7,7,3,2),family="serif")
b<- barplot(dat[,"Tests"],horiz=T,col="pink",xaxt="n",names=dat[,1],xlim=c(0,max(dat[,"Tests"])*1.2),las=1)
axis(side=1, at=axTicks(1), labels=formatC(axTicks(1), format="d", big.mark=','))
text(x=dat[,"Tests"],y=b,labels= paste("As of",dat[,"Date"]),pos=4)
title("Total Tests for COVID-19(Japan,South Korea,Singapore,Taiwan)",
	"Data : [Wikipedia:COVID-19 testing](https://en.wikipedia.org/wiki/COVID-19_testing)")
#dev.off()
```

#### 日本、韓国、台湾、シンガポールの陽性率(%) Positive/Tests*100

```R
# %で並べ替え
dat<- asia4[order(asia4[,"%"]),]
#png("pcr12.png",width=800,height=600)
par(mar=c(7,7,3,2),family="serif")
b<- barplot(dat[,"%"],horiz=T,col="pink",xaxt="n",names=dat[,1],xlim=c(0,max(dat[,"%"])*1.2),las=1)
axis(side=1, at=axTicks(1), labels=formatC(axTicks(1), format="d", big.mark=','))
text(x=dat[,"%"],y=b,labels= paste("As of",dat[,"Date"]),pos=4)
title("Positive/Tests*100 for COVID-19(Japan,South Korea,Singapore,Taiwan)",
	"Data : [Wikipedia:COVID-19 testing](https://en.wikipedia.org/wiki/COVID-19_testing)")
#dev.off()
```

#### 日本、韓国、台湾、シンガポールのTests /million people for COVID-19

```R
# 人口100万人あたり
# Tests /millionpeopleで並べ替え
dat<- asia4[order(asia4[,"Tests /millionpeople"]),]
#png("pcr10.png",width=800,height=600)
par(mar=c(7,7,3,2),family="serif")
b<- barplot(dat[,"Tests /millionpeople"],horiz=T,col="pink",xaxt="n",names=dat[,1],xlim=c(0,max(dat[,"Tests /millionpeople"])*1.2),las=1)
axis(side=1, at=axTicks(1), labels=formatC(axTicks(1), format="d", big.mark=','))
text(x=dat[,"Tests /millionpeople"],y=b,labels= paste("As of",dat[,"Date"]),pos=4)
title("Tests /million people for COVID-19(Japan,South Korea,Singapore,Taiwan)",
	"Data : [Wikipedia:COVID-19 testing](https://en.wikipedia.org/wiki/COVID-19_testing)")
#dev.off()
```

#### 日本、韓国、台湾、シンガポールのReported Confirmed(報告された感染者)を計算、プロット

```R
# read.csvの際には、check.names=Fをつける
url<- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"
Confirmed<- read.csv(url,check.names=F)
# Country/Regionごとに集計
#Confirmed
Ctl<- aggregate(Confirmed[,5:ncol(Confirmed)], sum, by=list(Confirmed$"Country/Region"))
rownames(Ctl)<-Ctl[,1]
Ctl<- Ctl[,-1]
#
dat<-Ctl[grep("(Japan|Korea, South|Taiwan*|Singapore)",rownames(Ctl)),] 
#png("pcr11.png",width=800,height=600)
par(mar=c(3,5,4,8),family="serif")
matplot(t(dat),type="l",lty=1,lwd=3,xaxt="n",yaxt="n",bty="n",ylab="",xaxs="i")
box(bty="l",lwd=2)
axis(1,at=1:ncol(dat),labels=sub("/20","",colnames(dat)))
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
text(x=par("usr")[2],y=dat[,ncol(dat)],labels=paste0(rownames(dat),"\n ",formatC(dat[,ncol(dat)], format="d", big.mark=',')),pos=4,xpd=T)
title("Reported Confirmed : Japan , South Korea , Taiwan , Singapore")
#dev.off()
```

#### 日本、韓国、台湾、シンガポールのの致死率を計算、プロット

```R
url<- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv"
Deaths<- read.csv(url,check.names=F)
#Deaths
Dtl<- aggregate(Deaths[,5:ncol(Deaths)], sum, by=list(Deaths$"Country/Region"))
rownames(Dtl)<-Dtl[,1]
Dtl<- Dtl[,-1]
#
dat<-Dtl[grep("(Japan|Korea, South|Taiwan*|Singapore)",rownames(Dtl)),] 
#
dat<- dat[order(dat[,ncol(dat)],decreasing=T),]
knitr::kable(dat[,ncol(dat),drop=F])
#
# 致死率(%)計算
#DpC<- matrix(NA,nrow=nrow(dat),ncol=ncol(dat))
DpC<- NULL
for (i in rownames(dat)){
	temp<- round(dat[rownames(dat)== i,] / Ctl[rownames(Ctl)== i,]*100,2)
	DpC<- rbind(DpC,temp)
}
#
DpC<- DpC[order(DpC[,ncol(DpC)],decreasing=T),]
n<-nrow(DpC)
col<- rainbow(n)
pch<-rep(c(0,1,2,4,5,6,15,16,17,18),3)
#png("Coronavirus01_1_2.png",width=800,height=600)
par(mar=c(3,5,4,10),family="serif")
#40日めから
matplot(t(DpC)[40:ncol(DpC),],type="o",lwd=2,pch=pch,las=1,col=col,ylab="Reported Deaths/Reported Confirmed(%)",xaxt="n",bty="n")
box(bty="l",lwd=2)
axis(1,at=1:nrow(t(DpC)[40:ncol(DpC),]),labels=sub("/20","",rownames(t(DpC)[40:ncol(DpC),])))
legend(x=par("usr")[2],y=par("usr")[4],legend=rownames(DpC),pch=pch,lwd=2,col=col,bty="n",title="Country/Region",xpd=T)
title("Reported Deaths / Reported Confirmed (%) ")
#dev.off()
```