---
title: 韓国と日本のPCR検査実施人数比較 (新型コロナウイルス：Coronavirus)
date: 2020-05-12
tags: ["R", "knitr","Coronavirus","新型コロナウイルス","South Korea"]
excerpt: 韓国のデータ:KCDC,日本のデータ:厚生労働省の報道発表資料で作成
---

# 韓国と日本のPCR検査実施人数比較 (新型コロナウイルス：Coronavirus)
![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus08)

(注意)日本の厚生労働省報道発表資料（5月2日、5月3日公表について）
- 5月2日公表の感染者及ぶ死亡者（累計）= 5月3日公表の感染者及ぶ死亡者（累計）  
- PCR検査の実施人数は5月2日公開なし、5月3日は公開  
よって、5月2日はPCR検査の実施人数、感染者、死亡者すべてNA。5月3日にまとめた。

### 日本と韓国の新型コロナウイルスに関する情報開示の比較
「データの信頼性」という観点からみてみると、

(参考)[COVID-19](https://oku.edu.mie-u.ac.jp/~okumura/python/COVID-19.html)  

#### 韓国(KCDC)
[Press Release: 8 additional cases have been confirmed Date2020-04-23 11:11](https://www.cdc.go.kr/board/board.es?mid=a30402000000&bid=0030)  

#### 日本(厚生労働省の報道発表資料)
[新型コロナウイルス感染症の現在の状況と厚生労働省の対応について（令和２年４月21日版）](https://www.mhlw.go.jp/stf/newpage_10965.html)  
- 都道府県から公表された死亡者数の合計は244（+21）名であるが、うち58名については個々の陽性者との突合作業中のため、計上するに至っていない。

[新型コロナウイルス感染症の現在の状況と厚生労働省の対応について（令和２年４月22日版）](https://www.mhlw.go.jp/stf/newpage_10989.html)  
- 退院した者のうち616名、死亡者のうち74名については、個々の陽性者との突合作業中。従って、入退院等の状況の合計とPCR検査陽性者数は一致しない。

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

さらに、日本、韓国、台湾、シンガポール、香港の新型コロナウイルスのデータで棒グラフ、折れ線グラフを作成しました。  

関連した記事：[COVID-19 testing(新型コロナウイルス：Coronavirus)でbarplot](https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus11)  	
	
#### 韓国のデータ : [KCDC「News Room」「Press Release」](https://www.cdc.go.kr/board/board.es?mid=a30402000000&bid=0030)  

#### 日本のPCR検査実施人数は、厚生労働省の[報道発表資料](https://www.mhlw.go.jp/stf/houdou/index.html)から抜き出した。    

### 新型コロナウイルスのPCR検査実施人数と感染状況(韓国)「累計」

![pcr04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr04.png)

### 日本と韓国の新型コロナウイルスによる死亡者数推移(累計で計算)

![pcr04_2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr04_2.png)

日本の新型コロナウイルスによる死亡者数はもっと多いのではないか。  
根拠：[日本法医病理学会HP:法医解剖、検案からの検体に対する新型コロナウイルス検査状況(pdf) 2020/04/26](http://houibyouri.kenkyuukai.jp/images/sys/information/20200426120049-FBA602CC495A4A1159A5054BB8D4C46E97C42C6E0152A56914D1185B840CD9C5.pdf)  
法医解剖、検案からの検体に対する新型コロナウイルス検査状況  
○ 回答機関: 26 機関  
- 実施件数
	- 保健所: 9 件
	- 他の検査機関: 2 件
- 拒否件数
	- 保健所: 12 件
	- 他の検査機関: 0 件

### 日本と韓国のPCR検査の陽性率(%)「累計」

![pcr05](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr05.png)

### 日本と韓国のPCR検査の暫定致死率(%)「累計」

![pcr06](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr06.png)

## ここからは差分をとって、日別のデータをグラフにした。

### 韓国のPCR検査の結果（日別）

![pcr08](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr08.png)

### 日本と韓国の検査陽性者数（日別）

![pcr07](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr07.png)

### 日本と韓国の検査者数（韓国の場合は「結果が判明した数」）（日別）

![pcr07_2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr07_2.png)

日本のデータでありえない箇所（検査者数がマイナス!）がある。

### 日本と韓国のPCR検査の検査陽性率(%)の推移(日別)

厚生労働省のデータは差分をとると、検査者数がマイナスだったり、検査人数より陽性者が多かったりするのでy軸の範囲を0%から50%にしています。

![pcr07_3](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr07_3.png)

・・・・・・。

### 韓国の(報告された)陽性者数 対数表示（日別）
対数表示にして結果判明した数に対する陽性者数の増減をわかりやすくしてみた。

![pcr08_2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr08_2.png)

- 最近では結果判明した2千人〜１万人に対して陽性者数がひと桁の日が出始めたのがわかります。
（参考）[韓国で新たな国内感染者「ゼロ」に　新型ウイルスで日常が様変わり](https://www.bbc.com/japanese/52489356)  

- しかし、ここ数日は検査陽性者数の増加傾向が見られます。
（参考）[South Korea, Hailed for Pandemic Response, Backtracks on Reopening After COVID-19 Cases Jump 5/8/20 at 5:43 PM](https://www.newsweek.com/south-korea-hailed-pandemic-response-backtracks-reopening-after-covid-19-cases-jump-1502864)
	- 13 new cases to a single person who attended five nightclubs and bars in the country's capital city of Seoul.
	- Officials think he may have come in contact with over 1,500 people during his night out.

### 日本の(報告された)感染者数 対数表示（日別）

![pcr08_3](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr08_3.png)

データの信頼性(データのとり方の一貫性)が劣るのでおかしな箇所(検査人数より陽性者が多い!)が見受けられます。

### 日本、韓国、台湾、シンガポール、香港の面積、人口、人口密度

|   country    |    area|         pop| Population.density|
|:------------:|-------:|-----------:|------------------:|
|    Japan     | 377,915| 127,103,388|                336|
| Korea, South |  99,720|  49,039,986|                492|
|    Taiwan    |  35,980|  23,359,928|                649|
|  Hong Kong   |   1,104|   7,112,688|              6,443|
|  Singapore   |     697|   5,567,301|              7,988|

### Confirmed、 Deaths、Deaths/Confirmed (%)の表（米ジョンズ・ホプキンス大学のデータを使った。）

|             | Confirmed| Deaths| Deaths/Confirmed (%)|
|:------------|---------:|------:|--------------------:|
|Japan        |    15,847|    633|                 3.99|
|Korea, South |    10,936|    258|                 2.36|
|Taiwan*      |       440|      7|                 1.59|
|Hong Kong    |     1,047|      4|                 0.38|
|Singapore    |    23,822|     21|                 0.09|

- 日本：検査陽性者数及び（報告された）死亡者数で韓国を追い抜いた。
- シンガポール：（報告された）感染者が人口（約５５７万人）に対して非常に多い。
- 台湾の感染者の数は圧倒的に少ない。

(関連ニュース)  
[台湾、コロナ封じ込め成功　新規感染者ゼロも引き締め2020年04月16日07時07分](https://www.jiji.com/jc/article?k=2020041500944&g=int)  

#### 日本、韓国、台湾、シンガポール、香港のTotal Tests for COVID-19

![pcr09](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr09.png)

#### 日本、韓国、台湾、シンガポール、香港の検査陽性率(%) Positive/Tests*100

![pcr12](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr12.png)

シンガポールの検査陽性率が非常に大きく、日本がそれについで大きい。台湾、香港は小さい。

(関連ニュース)  
[シンガポールの新型コロナ感染者、1日で2割増 2020/4/17](https://www.nikkei.com/article/DGXMZO58164630X10C20A4EAF000/)  

#### 日本、韓国、台湾、シンガポール、香港のTests /million people for COVID-19

![pcr10](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr10.png)

人口を考慮に入れると、日本の検査数が少ないのがわかります。

#### 日本、韓国、台湾、シンガポール、香港のReported Confirmed

![pcr11](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr11.png)

### 日本、韓国、台湾、シンガポール、香港のPCR検査の暫定致死率(%)

![Coronavirus01_1_2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Coronavirus01_1_2.png)

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
|2020-04-15 |         534552|    10591|  225| 508935|  15026|
|2020-04-16 |         538775|    10613|  229| 513894|  14268|
|2020-04-17 |         546463|    10635|  230| 521642|  14186|
|2020-04-18 |         554834|    10653|  232| 530631|  13550|
|2020-04-19 |         559109|    10661|  234| 536205|  12243|
|2020-04-20 |         563035|    10674|  236| 540380|  11981|
|2020-04-21 |         571014|    10683|  237| 547610|  12721|
|2020-04-22 |         577959|    10694|  238| 555144|  12121|
|2020-04-23 |         583971|    10702|  240| 563130|  10139|
|2020-04-24 |         589520|    10708|  240| 569212|   9600|
|2020-04-25 |         595161|    10718|  240| 575184|   9259|
|2020-04-26 |         598285|    10728|  242| 578558|   8999|
|2020-04-27 |         601660|    10738|  243| 582027|   8895|
|2020-04-28 |         608514|    10752|  244| 588559|   9203|
|2020-04-29 |         614197|    10761|  246| 595129|   8307|
|2020-04-30 |         619881|    10765|  247| 600482|   8634|
|2020-05-01 |         623069|    10774|  248| 603610|   8685|
|2020-05-02 |         627562|    10780|  250| 608286|   8496|
|2020-05-03 |         630973|    10793|  250| 611592|   8588|
|2020-05-04 |         633921|    10801|  252| 614944|   8176|
|2020-05-05 |         640237|    10804|  254| 620575|   8858|
|2020-05-06 |         643095|    10806|  255| 624280|   8009|
|2020-05-07 |         649388|    10810|  256| 630149|   8429|
|2020-05-08 |         654863|    10822|  256| 635174|   8867|
|2020-05-09 |         660030|    10840|  256| 640037|   9153|
|2020-05-10 |         663886|    10874|  256| 642884|  10128|
|2020-05-11 |         668492|    10909|  256| 646661|  10922|
|2020-05-12 |         680890|    10936|  258| 653624|  16330|

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
|2020-04-15 |   519526|    10591| 508935|      2.04|  225|         2.124|
|2020-04-16 |   524507|    10613| 513894|      2.02|  229|         2.158|
|2020-04-17 |   532277|    10635| 521642|      2.00|  230|         2.163|
|2020-04-18 |   541284|    10653| 530631|      1.97|  232|         2.178|
|2020-04-19 |   546866|    10661| 536205|      1.95|  234|         2.195|
|2020-04-20 |   551054|    10674| 540380|      1.94|  236|         2.211|
|2020-04-21 |   558293|    10683| 547610|      1.91|  237|         2.218|
|2020-04-22 |   565838|    10694| 555144|      1.89|  238|         2.226|
|2020-04-23 |   573832|    10702| 563130|      1.87|  240|         2.243|
|2020-04-24 |   579920|    10708| 569212|      1.85|  240|         2.241|
|2020-04-25 |   585902|    10718| 575184|      1.83|  240|         2.239|
|2020-04-26 |   589286|    10728| 578558|      1.82|  242|         2.256|
|2020-04-27 |   592765|    10738| 582027|      1.81|  243|         2.263|
|2020-04-28 |   599311|    10752| 588559|      1.79|  244|         2.269|
|2020-04-29 |   605890|    10761| 595129|      1.78|  246|         2.286|
|2020-04-30 |   611247|    10765| 600482|      1.76|  247|         2.294|
|2020-05-01 |   614384|    10774| 603610|      1.75|  248|         2.302|
|2020-05-02 |   619066|    10780| 608286|      1.74|  250|         2.319|
|2020-05-03 |   622385|    10793| 611592|      1.73|  250|         2.316|
|2020-05-04 |   625745|    10801| 614944|      1.73|  252|         2.333|
|2020-05-05 |   631379|    10804| 620575|      1.71|  254|         2.351|
|2020-05-06 |   635086|    10806| 624280|      1.70|  255|         2.360|
|2020-05-07 |   640959|    10810| 630149|      1.69|  256|         2.368|
|2020-05-08 |   645996|    10822| 635174|      1.68|  256|         2.366|
|2020-05-09 |   650877|    10840| 640037|      1.67|  256|         2.362|
|2020-05-10 |   653758|    10874| 642884|      1.66|  256|         2.354|
|2020-05-11 |   657570|    10909| 646661|      1.66|  256|         2.347|
|2020-05-12 |   664560|    10936| 653624|      1.65|  258|         2.359|

## Rコード

### データから表を作成

```R
library(knitr)
date<- seq(as.Date("2020-02-01"), as.Date("2020-05-12"), by = "day")
検査を受けた人<-c(371,429,429,607,714,885,1130,1701,2340,2776,3629,5074,5797,6854,7519,7919,8171,
	9265,10411,12161,14816,19621,22633,28615,36716,46127,57990,70940,85693,96985,109591,125851,
	136707,146541,164740,178189,188518,196618,210144,222395,234998,	248647,261335,268212,274504,
	286716,295647,307024,316664,327509,331780,338036,348582,357896,364942,376961,387925,394141,
	395194,410564,421547,431743,443273,455032,461233,466804,477304,486003,494711,503051,510479,
	514621,518743,527438,534552,538775,546463,554834,559109,563035,571014,577959,583971,589520,
	595161,598285,601660,608514,614197,619881,623069,627562,630973,633921,640237,643095,649388,
	654863,660030,663886,668492,680890)
感染者数<-c(12,15,15,16,18,23,24,24,25,27,28,28,28,28,28,29,30,31,46,82,156,346,556,763,893,1146,
	1595,2022,2931,3526,4212,4812,5328,5766,6284,6767,7134,7382,7513,7755,7869,7979,8086,8162,
	8236,8320,8413,8565,8652,8799,8897,8961,9037,9137,9241,9332,9478,9583,9661,9786,9887,9976,
	10062,10156,10237,10284,10331,10384,10423,10450,10480,10512,10537,10564,10591,10613,10635,
	10653,10661,10674,10683,10694,10702,10708,10718,10728,10738,10752,10761,10765,10774,10780,
	10793,10801,10804,10806,10810,10822,10840,10874,10909,10936)
死者<-c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,4,7,8,11,12,13,16,17,22,28,32,35,42,44,50,51,
	54,60,66,67,72,75,75,81,84,91,94,102,104,111,120,126,131,139,144,152,158,162,165,169,174,
	177,183,186,192,200,204,208,211,214,217,222,225,229,230,232,234,236,237,238,240,240,240,242,
	243,244,246,247,248,250,250,252,254,255,256,256,256,256,256,258)
陰性<-c(289,327,414,462,522,693,842,1057,1355,1940,2736,4054,5099,6134,6853,7313,7733,8277,9335,10446,
	11953,13794,16038,19127,22550,28247,35298,44167,53608,61037,71580,85484,102965,118965,136624,
	151802,162008,171778,184179,196100,209402,222728,235615,243778,251297,261105,270888,282555,
	292487,303006,308343,315447,324105,334481,341332,352410,361883,369530,372002,383886,395075,
	403882,414303,424732,431425,437225,446323,457761,468779,477303,485929,490321,494815,502223,
	508935,513894,521642,530631,536205,540380,547610,555144,563130,569212,575184,578558,582027,
	588559,595129,600482,603610,608286,611592,614944,620575,624280,630149,635174,640037,642884,
	646661,653624)
検査中<- 検査を受けた人- (陰性+感染者数)
#df<- data.frame(date,感染者数,死者,検査を受けた人_感染者除く,陰性,検査中)
#kable(df,row.names=F)
df<- data.frame(検査を受けた人,感染者数,死者,陰性,検査中)
rownames(df)<- date
kable(df)
```

### 検査陽性率、暫定致死率を計算し、表を作成

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

[新型コロナウイルス感染症の現在の状況と厚生労働省の対応について（令和２年４月21日版）](https://www.mhlw.go.jp/stf/newpage_10965.html)  
- 都道府県から公表された死亡者数の合計は244（+21）名であるが、うち58名については個々の陽性者との突合作業中のため、計上するに至っていない。

[新型コロナウイルス感染症の現在の状況と厚生労働省の対応について（令和２年４月22日版）](https://www.mhlw.go.jp/stf/newpage_10989.html)  
- 退院した者のうち616名、死亡者のうち74名については、個々の陽性者との突合作業中。従って、入退院等の状況の合計とPCR検査陽性者数は一致しない。

(注意)  
- 5月2日公表の感染者及ぶ死亡者（累計）= 5月3日公表の感染者及ぶ死亡者（累計）  
- PCR検査の実施人数は5月2日公開なし、5月3日は公開  
よって、5月2日はPCR検査の実施人数、感染者、死亡者すべてNA。5月3日にまとめた。

```R
#日本のPCR検査実施人数と結果（結果判明した数）
Jpcr1<- c(rep(NA,6),151,NA,NA,174,NA,190,200,214,NA,NA,487,523,532)+c(rep(NA,6),566,NA,NA,764,NA,764,764,764,NA,NA,764,764,764)
# 3/19 : PCR検査実施人数が減少したのは、千葉県が人数でなく件数でカウントしていたことが判明したため、千葉県の件数を引いたことによる
Jpcr2<- c(603,693,778,874,913,1017,1061,1229,1380,1510,1688,1784,1855,5690,5948,6647,7200,7347,7457,8771,9195,9376,11231,
	12090,12197,12239,14322,14525,14072,18015,18134,18226+1173,18322+1189,22184+1417,21266+1426,22858+1484,24663+1513,
	26105+1530,26401+1530,26607+1530,30088+1580,32002+1677,32002+1679,36687+1930,39992+2061,40263+3547,40481+4862,48357+6125,
	52901+7768,54284+9274,57125+10817,61991+12071,63132+13420,63132+14741,72801+15921,76425+16982,81825+18049,86800+18743,
	91050+19446,91695+20292,94826+21070,101818+21903,107430+22328,112108+23046,117367+23404,122700+23925,123633+24612,
	124456+25407,133578+26139,136695+26731,137338+27442,145243+28078,NA,153047+29375,153581+30176,154646+30868,156866+31232,
	157563+31638,169546+31638,179043+32125,180478+32949,183845+33530,188646+34174)+829
Jpcr<- c(Jpcr1,Jpcr2)
Confirmed<- c(rep(NA,6),25,NA,NA,26,NA,28,29,33,NA,NA,59,66,73,84,93,105,132,144,156,164,186,210,230,239,254,268,284,317,348,
	407,454,487,513,567,619,674,714,777,809,824,868,907,943,996,1046,1089,1128,1193,1291,1387,1499,1693,1866,1953,2178,
	2381,2617,2935,3271,3654,3906,4257,4768,5347,6005,6748,7255,7645,8100,8582,9167,9795,10361,10751,11119,11496,11919,
	12388,12829,13182,13385,13576,13852,14088,14281,NA,14839,15057,15231,15354,15463,15547,15649,15747,15798,15874)
Deaths<- c(rep(NA,6),0,NA,NA,0,NA,0,0,1,NA,NA,1,1,1,1,1,1,1,1,1,1,3,4,5,5,6,6,6,6,6,6,6,7,9,12,15,19,21,22,24,28,29,31,33,35,36,
	41,42,43,45,46,49,52,54,56,57,60,63,69,70,73,80,81,85,88,94,98,102,109,119,136,148,154,161,171,186,277,287,317,334,348,
	351,376,389,415,432,NA,492,510,521,543,551,557,600,613,621,643)
Jdf<- data.frame(Tested=Jpcr,Confirmed,Deaths)
kj<-paste0(round(結果判明[length(結果判明)]/max(Jpcr,na.rm=T),1),"倍")
# 指数表示を抑制
options(scipen=2) 
#png("pcr04.png",width=800,height=600)
par(mar=c(4,6,4,2),family="serif")
b<- barplot(t(df[,c(2,4,5)]),names.arg=gsub("2020-","",rownames(df)),col=c("red","lightblue","gray80"),
	ylim= c(0,max(検査を受けた人)*1.1),yaxt ="n",
	legend=T,args.legend = list(x="topleft",inset=c(0.03,0.03)))
# Add comma separator to axis labels
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1)  
#text(x=b,y=検査を受けた人,labels= 検査を受けた人,pos=3,col="blue")
points(x=b,y=Jpcr,pch=16)
lines(x=b,y=Jpcr,pch=16,lwd=2)
legend(x="topleft",inset=c(0.03,0.2),bty="n",legend="日本のPCR検査実施人数(データ：厚生労働省HP)",pch=16,lwd=2)
legend(x="topleft",inset=c(0.01,0.25),bty="n",legend="* 韓国の人口は日本の約４１％",cex=1.5)
legend(x="topleft",inset=c(0.01,0.3),bty="n",legend=paste("* PCR検査で結果判明した数は日本の",kj),cex=1.5)
legend(x="topleft",inset=c(0.01,0.35),bty="n",legend="（日本：チャーター便帰国者及び空港検疫も含む）",cex=1.5)
#text(x=0,y=120000,labels="* 韓国の人口は日本の約４１％",pos=4,cex=1.5)
#text(x=0,y=110000,labels=paste("* PCR検査で結果判明した数は日本の",kj),pos=4,cex=1.5)
#text(x=0,y=100000,labels="（日本：チャーター便帰国者及び空港検疫も含む）",pos=4,cex=1.5)
title("韓国と日本のPCR検査実施人数の推移",cex.main=2)
#dev.off()
```

### 日本と韓国の新型コロナウイルスによる死亡者数推移(累計で計算)

```R
# 日本、韓国の人口
# DataComputingパッケージの"CountryData"より
Jpop<- 127103388
Kpop<- 49039986
#
date2<- sub("-","/",sub("-0","-",sub("^0","",sub("2020-","",date))))
Jpos <- Deaths
#
jp<- round(max(Jpos,na.rm=T)*1000000/Jpop,2)
kr<- round(max(死者,na.rm=T)*1000000/Kpop,2)
#
ylim<- c(0,max(c(Jpos,死者),na.rm=T)*1.1)
#png("pcr04_2.png",width=800,height=600)
par(mar=c(5,6,4,2),family="serif")
plot(死者,type="o",pch=16,col="blue",lwd=2,xaxt="n",xlab="",ylab="死亡者数(人)",las=1,ylim=ylim,bty="n")
box(bty="l",lwd=2)
lines(Jpos,col="red",lwd=2)
points(Jpos,col="red",pch=16)
#表示するx軸ラベルを指定
axis(1,at=1:length(date2),labels =NA,tck= -0.01)
labels<- date2
labelpos<- paste0(rep(1:12,each=3),"/",c(1,10,20))
axis(1,at=1,labels =labels[1],tick=F)
for (i in labelpos){
	at<- match(i,labels)
	if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.02)}
	}
legend("topleft",inset=0.03,pch=16,lwd=2,cex=1.5,col=c("red","blue"),legend=c("日本","韓国"),bty="n")
legend("topleft",inset=c(0.03,0.15),cex=1.5,bty="n",
	legend=paste("新型コロナウイルスによる死亡者数(人口100万あたり)\n　日本：",jp,"\n　韓国：",kr))
title("日本と韓国の新型コロナウイルスによる死亡者数推移","Data : 日本(厚生労働省の報道発表資料) 韓国(KCDC)",cex.main=2)
#dev.off()
```

### 日本と韓国のPCR検査の検査陽性率(%)推移(累計で計算)

```R
date2<- sub("-","/",sub("-0","-",sub("^0","",sub("2020-","",date))))
Jpos <- round(Confirmed/Jpcr*100,2)
ylim<- c(0,max(c(Jpos,df2$"陽性率(%)"),na.rm=T)*1.1)
#png("pcr05.png",width=800,height=600)
par(mar=c(5,6,4,2),family="serif")
plot(df2$"陽性率(%)",type="o",pch=16,col="blue",lwd=2,xaxt="n",xlab="",ylab="陽性率(%)",las=1,ylim=ylim,bty="n")
box(bty="l",lwd=2)
lines(Jpos,col="red",lwd=2)
points(Jpos,col="red",pch=16)
#表示するx軸ラベルを指定
axis(1,at=1:length(date2),labels =NA,tck= -0.01)
labels<- date2
labelpos<- paste0(rep(1:12,each=3),"/",c(1,10,20))
axis(1,at=1,labels =labels[1],tick=F)
for (i in labelpos){
	at<- match(i,labels)
	if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.02)}
	}
legend("topleft",inset=0.03,pch=16,lwd=2,cex=1.5,col=c("red","blue"),legend=c("日本","韓国"),bty="n")
title("日本と韓国のPCR検査の検査陽性率(%)の推移","Data : 日本(厚生労働省の報道発表資料) 韓国(KCDC)",cex.main=2)
#dev.off()
```

### 日本と韓国のPCR検査の暫定致死率(%)推移(累計で計算)

```R
date2<- sub("-","/",sub("-0","-",sub("^0","",sub("2020-","",date))))
Jpos <- round(Deaths/Confirmed*100,2)
ylim<- c(0,max(c(Jpos,df2$"暫定致死率(%)"),na.rm=T)*1.1)
#png("pcr06.png",width=800,height=600)
par(mar=c(5,6,4,2),family="serif")
plot(df2$"暫定致死率(%)",type="o",pch=16,col="blue",lwd=2,xaxt="n",xlab="",ylab="暫定致死率(%)",las=1,ylim=ylim,bty="n")
box(bty="l",lwd=2)
lines(Jpos,col="red",lwd=2)
points(Jpos,col="red",pch=16)
#表示するx軸ラベルを指定
axis(1,at=1:length(date2),labels =NA,tck= -0.01)
labels<- date2
labelpos<- paste0(rep(1:12,each=3),"/",c(1,10,20))
axis(1,at=1,labels =labels[1],tick=F)
for (i in labelpos){
	at<- match(i,labels)
	if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.02)}
	}
legend("topleft",inset=0.03,pch=16,lwd=2,cex=1.5,col=c("red","blue"),legend=c("日本","韓国"),bty="n")
title("日本と韓国の暫定致死率(%)の推移","Data : 日本(厚生労働省の報道発表資料) 韓国(KCDC)",cex.main=2)
#dev.off()
```

### 韓国のPCR検査の結果（日別）

```R
dat<-rbind(diff(df2$感染者数),diff(df2$陰性))
rownames(dat)<- c("陽性","陰性")
colnames(dat)<- gsub("2020-","",rownames(df2[-1,]))
#png("pcr08.png",width=800,height=600)
par(mar=c(4,6,4,2),family="serif")
barplot(dat,names=gsub("2020-","",rownames(df[-1,])),col=c("red","lightblue"),las=1,legend=T,
	args.legend=list(x="topleft",inset=c(0.03,0.03)))
title("韓国のPCR検査の結果（日別）",cex.main=2)
#dev.off()
```

### 日本と韓国の検査陽性者数（日別）

```R
date2<- sub("-","/",sub("-0","-",sub("^0","",sub("2020-","",date[-1]))))
ylim<- max(max(diff(Jdf$Confirmed),na.rm=T),max(diff(df$感染者数),na.rm=T))*1.2
#png("pcr07.png",width=800,height=600)
par(mar=c(4,6,4,2),family="serif")
barplot(diff(Jdf$Confirmed),col=rgb(1,0,0,alpha=0.5),axes=F,ylim=c(0,ylim))
barplot(diff(df$感染者数),names=date2,col=rgb(0,1,0,alpha=0.5),las=1,add=T,ylim=c(0,ylim))
legend("topleft",inset=c(0.03,0.08),pch=15,col=c(rgb(1,0,0,alpha=0.5),rgb(0,1,0,alpha=0.5)),legend=c("日本","韓国"),bty="n",cex=1.5)
title("日本と韓国の検査陽性者数（日別）",cex.main=1.5)
#dev.off()
```

### 日本と韓国の検査者数（韓国の場合は「結果が判明した数」）（日別）

```R
date2<- sub("-","/",sub("-0","-",sub("^0","",sub("2020-","",date[-1]))))
kdf<- diff(結果判明)
jdf<- diff(Jpcr)
ymin<- min(min(kdf,na.rm=T),min(jdf,na.rm=T))
ymax<- max(max(kdf,na.rm=T),max(jdf,na.rm=T))
#png("pcr07_2.png",width=800,height=600)
par(mar=c(4,6,4,2),family="serif")
plot(jdf,type="o",pch=16,cex=1,lwd=2,col="red",xlab="",ylab="",xaxt="n",yaxt="n",bty="n",ylim=c(ymin,ymax),
	panel.first=grid(NA,NULL,lty=2,col="darkgray"))
box(bty="l",lwd=2)
lines(kdf,lwd=2,col="blue")
points(kdf,pch=16,cex=1,col="blue")
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
#表示するx軸ラベルを指定
axis(1,at=1:length(date2),labels =NA,tck= -0.01)
labels<- date2
labelpos<- paste0(rep(1:12,each=3),"/",c(1,10,20))
axis(1,at=1,labels =labels[1],tick=F)
for (i in labelpos){
	at<- match(i,labels)
	if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.02)}
	}
legend("topleft",inset=0.03,pch=16,lwd=2,cex=1.5,col=c("red","blue"),legend=c("日本","韓国"),bty="n")
title("日本と韓国の検査者数（韓国の場合は「結果が判明した数」）（日別）",cex.main=1.5)
#dev.off()
```

### 日本と韓国のPCR検査の検査陽性率(%)の推移(日別)

```R
date2<- sub("-","/",sub("-0","-",sub("^0","",sub("2020-","",date[-1]))))
Jpos <- (diff(Confirmed)/diff(Jpcr))*100
Kpos <- (diff(感染者数)/diff(感染者数+陰性))*100
#ylim<- c(0,max(c(Jpos,df2$"陽性率(%)"),na.rm=T)*1.1)
#png("pcr07_3.png",width=800,height=600)
par(mar=c(5,6,4,2),family="serif")
plot(Jpos,type="o",pch=16,col="red",lwd=2,xaxt="n",xlab="",ylab="陽性率(%)",las=1,bty="n",ylim=c(0,50))
box(bty="l",lwd=2)
lines(Kpos,col="blue",lwd=2)
points(Kpos,col="blue",pch=16)
#表示するx軸ラベルを指定
axis(1,at=1:length(date2),labels =NA,tck= -0.01)
labels<- date2
labelpos<- paste0(rep(1:12,each=3),"/",c(1,10,20))
axis(1,at=1,labels =labels[1],tick=F)
for (i in labelpos){
	at<- match(i,labels)
	if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.02)}
	}
legend("topleft",inset=0.03,pch=16,lwd=2,cex=1.5,col=c("red","blue"),legend=c("日本","韓国"),bty="n")
title("日本と韓国のPCR検査の検査陽性率(%)の推移(日別)","Data : 日本(厚生労働省の報道発表資料) 韓国(KCDC)",cex.main=2)
#dev.off()
```

### 韓国の(報告された)感染者数 対数表示（日別）

```R
date2<- sub("-","/",sub("-0","-",sub("^0","",sub("2020-","",date[-1]))))
dat<- diff(df2$感染者数)
dat[dat==0]<- NA
dat2<- diff(df2$結果判明)
ylim<- c(0.9,max(dat2,na.rm=T)*1.2)
#png("pcr08_2.png",width=800,height=600)
par(mar=c(4,5,4,2),family="serif")
b<- barplot(rep(NA,length(dat)),names=date2,las=1,log="y",ylim=ylim)
abline(h=10^(0:4),col="darkgray",lwd=1.2,lty=3)
for (i in 1:9){
	abline(h=i*10^(0:4),col="darkgray",lwd=0.8,lty=3)
}
barplot(dat,col="red",las=1,log="y",ylim=ylim,axes=F,add=T)
lines(x=b,y=dat2,lwd=2,col="darkgreen")
points(x=b,y=dat2,pch=16,col="darkgreen")
#text(x=par("usr")[2],y=dat2[length(dat2)],labels="結果判明",col="darkgreen",xpd=T)
legend("topleft",inset=0.03,bty="n",legend="PCR検査結果判明\nConfirmed+Tested negative",lwd=2,lty=1,pch=16,col="darkgreen")
title("韓国の検査陽性者数 対数表示（日別）",cex.main=1.5)
#dev.off()
```

### 日本の(報告された)感染者数 対数表示（日別）

```R
date2<- sub("-","/",sub("-0","-",sub("^0","",sub("2020-","",date[-1]))))
dat<- diff(Jdf$Confirmed)
dat[dat==0]<- NA
dat2<- diff(Jdf$Tested)
# 韓国のグラフにyの範囲を揃える
ylim<- c(0.9,max(diff(df2$結果判明),na.rm=T)*1.2)
#png("pcr08_3.png",width=800,height=600)
par(mar=c(4,5,4,),family="serif")
b<- barplot(rep(NA,length(dat)),names=date2,las=1,log="y",ylim=ylim)
abline(h=10^(0:4),col="darkgray",lwd=1.2,lty=3)
for (i in 1:9){
	abline(h=i*10^(0:4),col="darkgray",lwd=0.8,lty=3)
}
barplot(dat,col="red",las=1,log="y",ylim=ylim,axes=F,add=T)
lines(x=b,y=dat2,lwd=2,col="darkgreen")
points(x=b,y=dat2,pch=16,col="darkgreen")
legend("topleft",inset=0.03,bty="n",legend="PCR検査実施人数",lwd=2,lty=1,pch=16,col="darkgreen")
title("日本の検査陽性者数 対数表示（日別）",cex.main=1.5)
#dev.off()
```

### 日本、韓国、台湾、シンガポール、香港の面積、人口、人口密度

```R
library(DataComputing)
library(knitr)
data("CountryData")
adata<- CountryData[grep("(Japan|Korea, South|Taiwan|Singapore|Hong Kong)",CountryData$country),1:3]
# 人口密度計算
adata$"Population density"<- round(adata$pop/adata$area,0)
#人口で並べ替える(降順)
adata<- adata[order(adata$pop,decreasing=T),]
kable(data.frame(lapply(adata,function(x)formatC(x, format="f", big.mark=",",digits=0))),
	row.names=F,align=c("c",rep("r",3)))
```

### 日本、韓国、台湾、シンガポール、香港のTotal Tests for COVID-19

```R
library("rvest")
# "COVID-19 testing"のデータ取得
html <- read_html("https://en.wikipedia.org/wiki/COVID-19_testing")
tbl<- html_table(html,fill = T)
# "covid19-testing"のtableが何番目か見つける
nodes<- html_nodes(html, "table")
class<-html_attr(nodes,"class")
#num<-grep("plainrowheaders",class)
num<- 3
#
Wtest<- tbl[[num]][,c(1:3,5,7:9)]
str(Wtest)
#
for (i in c(3:9)){
	Wtest[,i]<- as.numeric(gsub(",","",Wtest[,i]))
}
str(Wtest)
save("Wtest",file="Wtest.Rdata")
#load("Wtest.Rdata")
#asia5<- Wtest[grep("(Japan|South Korea|Singapore|Taiwan|Hong Kong)",Wtest[,1]),]
```
## (注)国と地域の表が別になっていた

```R
num<- 4
#
Wtest2<- tbl[[num]][,1:8]
str(Wtest2)
#
for (i in 4:8){
	Wtest2[,i]<- as.numeric(gsub(",","",Wtest2[,i]))
}
str(Wtest2)
save("Wtest2",file="Wtest2.Rdata")
(asia5<- Wtest[grep("(Japan|South Korea|Singapore|Taiwan)",Wtest[,1]),])
colnames(asia5)[1]<- "Country or Subdivision"
colnames(asia5)[2]<- "Date"
colnames(asia5)[3]<- "Tests"
colnames(asia5)[6]<- "Tests /millionpeople"
(asia5 <- asia5[!is.na(asia5[,4]),])
temp<- Wtest2[grep("(Taiwan|Hong Kong)",Wtest2[,"Subdivision"]),]
(temp <- temp[!is.na(temp[,4]),2:8])
colnames(temp)[1]<- "Country or Subdivision"
colnames(temp)[2]<- "Date"
( asia5<- rbind(asia5,temp) )
```

#### 日本、韓国、台湾、シンガポール、香港のTotal Tests for COVID-19

```R
# Testsで並べ替え
dat<- asia5[order(asia5[,"Tests"]),]
#png("pcr09.png",width=800,height=600)
par(mar=c(7,7,3,2),family="serif")
b<- barplot(dat[,"Tests"],horiz=T,col="pink",xaxt="n",names=dat[,1],xlim=c(0,max(dat[,"Tests"])*1.2),las=1)
axis(side=1, at=axTicks(1), labels=formatC(axTicks(1), format="d", big.mark=','))
text(x=dat[,"Tests"],y=b,labels= paste("As of",dat[,"Date"],"\n",formatC(dat[,"Tests"],format="d",big.mark=',')),pos=4)
title("Total Tests for COVID-19(Japan,South Korea,Singapore,Taiwan,Hong Kong)",
	"Data : [Wikipedia:COVID-19 testing](https://en.wikipedia.org/wiki/COVID-19_testing)")
#dev.off()
```

#### 日本、韓国、台湾、シンガポール、香港の陽性率(%) Positive/Tests*100

```R
# %で並べ替え
dat<- asia5[order(asia5[,"%"]),]
#png("pcr12.png",width=800,height=600)
par(mar=c(7,7,3,2),family="serif")
b<- barplot(dat[,"%"],horiz=T,col="pink",xaxt="n",names=dat[,1],xlim=c(0,max(dat[,"%"])*1.2),las=1)
axis(side=1, at=axTicks(1), labels=axTicks(1))
text(x=dat[,"%"],y=b,labels= paste("As of",dat[,"Date"],"\n",dat[,"%"],"%"),pos=4)
title("Positive/Tests*100 for COVID-19(Japan,South Korea,Singapore,Taiwan,Hong Kong)",
	"Data : [Wikipedia:COVID-19 testing](https://en.wikipedia.org/wiki/COVID-19_testing)")
#dev.off()
```

#### 日本、韓国、台湾、シンガポール、香港のTests /million people for COVID-19

```R
# 人口100万人あたり
# Tests /millionpeopleで並べ替え
dat<- asia5[order(asia5[,"Tests /millionpeople"]),]
#png("pcr10.png",width=800,height=600)
par(mar=c(7,7,3,2),family="serif")
b<- barplot(dat[,"Tests /millionpeople"],horiz=T,col="pink",xaxt="n",names=dat[,1],xlim=c(0,max(dat[,"Tests /millionpeople"])*1.2),las=1)
axis(side=1, at=axTicks(1), labels=formatC(axTicks(1), format="d", big.mark=','))
text(x=dat[,"Tests /millionpeople"],y=b,labels= paste("As of",dat[,"Date"],"\n",formatC(dat[,"Tests /millionpeople"],format="d",big.mark=',')),pos=4)
title("Tests /million people for COVID-19(Japan,South Korea,Singapore,Taiwan,Hong Kong)",
	"Data : [Wikipedia:COVID-19 testing](https://en.wikipedia.org/wiki/COVID-19_testing)")
#dev.off()
```

#### 日本、韓国、台湾、シンガポール、香港のReported Confirmed(報告された感染者)を計算、プロット

```R
# read.csvの際には、check.names=Fをつける
url<- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"
Confirmed<- read.csv(url,check.names=F)
# Country/Regionごとに集計
#Confirmed
Ctl<- aggregate(Confirmed[,5:ncol(Confirmed)], sum, by=list(Confirmed$"Country/Region"))
rownames(Ctl)<-Ctl[,1]
Ctl<- Ctl[,-1]
#Japan,South Korea,Taiwan,Singapore
datC<-Ctl[grep("(Japan|Korea, South|Taiwan*|Singapore)",rownames(Ctl)),] 
#Hong Kong
HK<- Confirmed[Confirmed$"Province/State"=="Hong Kong",5:ncol(Confirmed)]
rownames(HK)<- "Hong Kong"
datC<- rbind(datC,HK)
#png("pcr11.png",width=800,height=600)
par(mar=c(4,5,4,10),family="serif")
matplot(t(datC),type="l",lty=1,lwd=3,xaxt="n",yaxt="n",bty="n",ylab="",xaxs="i")
box(bty="l",lwd=2)
#y軸ラベル
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
#表示するx軸ラベルを指定
labels<- sub("/20","",colnames(datC))
#日
labels<-gsub("^.*/","",labels)
#月
pos<-gsub("/.*$","",sub("/20","",colnames(datC)))
axis(1,at=1:ncol(datC), labels =NA,tck= -0.01)
for (i in c("1","10","20")){
	at<- grep("TRUE",is.element(labels,i))
	axis(1,at=at,labels = rep(i,length(at)))
	}
Month<-c("Jan.","Feb.","Mar.","Apr.","May","Jun.","Jul.","Aug.","Sep.","Oct.","Nov.","Dec.")
mon<-cut(as.numeric(names(table(pos))),breaks = seq(0,12),right=T, labels =Month)
# 月の中央
#mtext(text=mon,at=cumsum(as.vector(table(pos)))-as.vector(table(pos)/2),side=1,line=2) 
# 月のはじめ
mtext(text=mon,at=1+cumsum(as.vector(table(pos)))-as.vector(table(pos)),side=1,line=2) 
text(x=par("usr")[2],y=datC[,ncol(datC)],labels=paste(rownames(datC),":",formatC(datC[,ncol(datC)], format="d", big.mark=',')),pos=4,xpd=T)
title("Reported Confirmed : Japan , South Korea , Taiwan , Singapore , Hong Kong")
#dev.off()
```

#### 日本、韓国、台湾、シンガポール、香港の致死率を計算、プロット

```R
url<- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv"
Deaths<- read.csv(url,check.names=F)
#Deaths
Dtl<- aggregate(Deaths[,5:ncol(Deaths)], sum, by=list(Deaths$"Country/Region"))
rownames(Dtl)<-Dtl[,1]
Dtl<- Dtl[,-1]
#
datD<-Dtl[grep("(Japan|Korea, South|Taiwan*|Singapore)",rownames(Dtl)),] 
#Hong Kong
HK<- Deaths[Deaths$"Province/State"=="Hong Kong",5:ncol(Deaths)]
rownames(HK)<- "Hong Kong"
datD<- rbind(datD,HK)
datD<- datD[order(datD[,ncol(datD)],decreasing=T),]
# 亡くなった人の数
knitr::kable(datD[,ncol(datD),drop=F])
#
# 致死率(%)計算
#DpC<- matrix(NA,nrow=nrow(datD),ncol=ncol(datD))
DpC<- NULL
for (i in rownames(datD)){
	temp<- round(datD[rownames(datD)== i,] / datC[rownames(datC)== i,]*100,2)
	DpC<- rbind(DpC,temp)
}
#
DpC<- DpC[order(DpC[,ncol(DpC)],decreasing=T),]
n<-nrow(DpC)
col<- rainbow(n)
#pch<-rep(c(0,1,2,4,5,6,15,16,17,18),3)
#png("Coronavirus01_1_2.png",width=800,height=600)
par(mar=c(3,5,4,10),family="serif")
#40日めから
matplot(t(DpC)[40:ncol(DpC),],type="l",lty=1,lwd=3,las=1,col=col,ylab="Reported Deaths/Reported Confirmed(%)",xaxt="n",bty="n")
box(bty="l",lwd=2)
axis(1,at=1:nrow(t(DpC)[40:ncol(DpC),]),labels=sub("/20","",rownames(t(DpC)[40:ncol(DpC),])))
legend(x=par("usr")[2],y=par("usr")[4],legend=rownames(DpC),lty=1,lwd=3,col=col,bty="n",title="Country/Region",xpd=T)
title("Reported Deaths / Reported Confirmed (%) ")
#dev.off()
```

#### 表

```R
library(knitr)
x<- datC[,ncol(datC),drop=F]
colnames(x)<- "Confirmed"
y<- datD[,ncol(datD),drop=F]
colnames(y)<- "Deaths"
x<- merge(x,y,by =0)
rownames(x)<- x[,1]
x<- x[,-1]
y<- DpC[,ncol(DpC),drop=F]
colnames(y)<- "Deaths/Confirmed (%)"
x<-merge(x,y,by =0)
x[,1]<-factor(x[,1],levels=c("Japan","Korea, South","Taiwan*" ,"Hong Kong", "Singapore"))
x<- x[order(x[,1],decreasing=F),]
kable(data.frame(Confirmed=formatC(x[,2], format="f", big.mark=",",digits=0),x[,3:4],check.names=F,row.names=x[,1]),
	row.names=T,align=rep("r",3))
```
