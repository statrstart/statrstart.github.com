---
title: 大阪府陽性者の属性と市町村別陽性者マップ(新型コロナウイルス：Coronavirus)
date: 2022-09-04
tags: ["R","jsonlite","Coronavirus","大阪府","新型コロナウイルス"]
excerpt: 大阪府 新型コロナウイルス感染症対策サイトのデータ
---

# 大阪府陽性者の属性と市町村別陽性者マップ(新型コロナウイルス：Coronavirus)

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus12&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

> 2022/06/28 発表  
> 大阪市保健所管内において、1～３月の死亡が新たに９２件判明しましたので、「３　患者の状況」に計上しています。  

[大阪府 新型コロナウイルス感染症対策サイトデータ](https://raw.githubusercontent.com/codeforosaka/covid19/master/data/data.json)は
以下の形状漏れも訂正されました。(2002/2/10)  
  
(注意)大阪市保健所による計上漏れ7,625件、2002/2/3の陽性者数に計上。  
- 入力日 1/29　　511件
- 入力日 1/30　　632件
- 入力日 1/31　 2,046件
- 入力日 2/1　　1,895件
- 入力日 2/2　　2,541件
(注意)大阪市保健所による計上漏れが2,921件、2002/2/4の陽性者数に計上。  
- 入力日 2/3　　2,921件
(注意)大阪市保健所による計上漏れが1,384件、2002/2/5の陽性者数に計上。  
- 入力日 2/4　　1,384件
(注意)大阪市保健所による計上漏れが770件、2002/2/6の陽性者数に計上。  
- 入力日 2/5　　770件
(注意)大阪市保健所による計上漏れが約9,200件、2002/2/8の陽性者数に計上。  
- 本来公表日 2/4　　約2,300件
- 本来公表日 2/5　　約4,700件
- 本来公表日 2/6　  約1,500件
- 本来公表日 2/7　　約700件

(使用するデータ)  
[大阪府 新型コロナウイルス感染症対策サイト](https://github.com/codeforosaka/covid19)にあるデータを使います。  
地図の元データ：[国土数値情報 行政区域データ](https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-N03-v2_4.html#!)  
市町村別人口：[市町村別の年齢別人口と割合](http://www.pref.osaka.lg.jp/kaigoshien/toukei/ritu.html)  
[NHK](https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv)  

> ## 2020-11-16以降、陽性者の属性のデータ公開はなくなりましたので、陽性者の居住地、年齢、性別を用いたグラフ及び地図は更新されません。

## [大阪府 年代別重症者数と死亡者数(新型コロナウイルス：Coronavirus)](https://gitpress.io/@statrstart/Coronavirus21)  

#### 大阪府 : 月別の陽性者数と月別死亡者数

> 2022/06/28 発表  
> 大阪市保健所管内において、1～３月の死亡が新たに９２件(1月：1件,2月：56件,3月：35件)判明した。  
> 6月分がその分増えている。

![covOsaka09_02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka09_02.png)

#### 塗り分け地図(大阪市のデータは遅れがある)
データ：[【9月5日】新型コロナウイルス感染症患者の発生及び死亡について]  
[大阪府：新型コロナウイルス感染症患者の発生状況について](http://www.pref.osaka.lg.jp/iryo/osakakansensho/happyo.html)  
但し、「大阪市」については[新型コロナウイルス感染症にかかる大阪市内の発生状況及び大阪府モニタリング指標に関する大阪市の算定値について](https://www.city.osaka.lg.jp/kenko/page/0000502869.html)
と比較して、陽性者数の多い方のデータを使用する。 

##### PCR検査 陽性者数(大阪府市町村別)

![osakaCmap03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/osakaCmap03.png)

##### 人口１０００人あたりの検査陽性者数(大阪府市町村別)

- 人口１万人あたりから１０００人あたりに変更しました。（2021-04-07から）

![osakaCmap04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/osakaCmap04.png)

![osakaCmap05](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/osakaCmap05.png)

検査陽性者数100人あたり1人越え（2022-01-26：すべての市町村で達した。）43
- 2021-04-13:大阪市	2021-04-28:東大阪市	2021-05-02:守口市	2021-05-05:大東市
- 2021-05-11:八尾市	2021-05-13:門真市	2021-05-15:高石市	2021-05-17:松原市
- 2021-07-01:寝屋川市	2021-07-26:豊中市	2021-07-26:摂津市	2021-08-01:泉大津市
- 2021-08-01:四條畷市	2021-08-02:池田市	2021-08-04:岸和田市	2021-08-04:吹田市
- 2021-08-05:大阪狭山市	2021-08-07:堺市		2021-08-07:藤井寺市	2021-08-07:羽曳野市
- 2021-08-08:柏原市	2021-08-09:茨木市	2021-08-10:和泉市	2021-08-12:富田林市
- 2021-08-13:箕面市	2021-08-15:枚方市	2021-08-18:交野市	2021-08-20:忠岡町
- 2021-08-21:高槻市	2021-08-24:貝塚市	2021-08-24:熊取町	2021-08-24:島本町
- 2021-08-28:泉佐野市	2021-09-01:泉南市	2021-09-04:阪南市	2021-09-04:河内長野市
- 2021-09-26:田尻町	2022-01-12:河南町	2022-01-15:能勢町	2022-01-16:豊能町
- 2022-01-17:岬町	2022-01-18:太子町	2022-01-26:千早赤阪村

検査陽性者数100人あたり2人(50人あたり1人)越え（2022-02-09：すべての市町村で達した。）43
- 2021-08-08:大阪市	2021-08-30:東大阪市	2021-09-03:守口市	2021-09-03:門真市
- 2021-09-08:大東市	2021-09-17:摂津市	2021-10-08:八尾市	2022-01-07:松原市
- 2022-01-12:豊中市	2022-01-14:寝屋川市	2022-01-16:吹田市	2022-01-16:高石市
- 2022-01-17:泉大津市	2022-01-18:四條畷市	2022-01-19:岸和田市	2022-01-19:茨木市
- 2022-01-20:藤井寺市	2022-01-20:羽曳野市	2022-01-20:柏原市	2022-01-20:交野市
- 2022-01-20:枚方市	2022-01-21:池田市	2022-01-21:堺市		2022-01-21:箕面市
- 2022-01-21:富田林市	2022-01-22:和泉市	2022-01-22:貝塚市	2022-01-22:大阪狭山市	
- 2022-01-23:忠岡町	2022-01-25:阪南市	2022-01-25:高槻市	2022-01-25:泉佐野市
- 2022-01-26:島本町	2022-01-26:熊取町	2022-01-26:泉南市	2022-01-27:太子町
- 2022-01-28:河内長野市	2022-01-29:河南町	2022-01-31:田尻町	2022-02-04:能勢町
- 2022-02-06:千早赤阪村	2022-02-06:岬町		2022-02-09:豊能町

検査陽性者数100人あたり3人(33人あたり1人)越え（2022-02-27：すべての市町村で達した。） 43
- 2021-09-08:大阪市	2022-01-21:東大阪市	2022-01-23:大東市	2022-01-24:門真市
- 2022-01-24:守口市	2022-01-25:摂津市	2022-01-27:八尾市	2022-01-27:松原市
- 2022-01-28:高石市	2022-01-29:吹田市	2022-01-29:泉大津市	2022-01-29:寝屋川市
- 2022-01-29:四條畷市	2022-01-29:富田林市	2022-01-29:豊中市	2022-01-30:藤井寺市
- 2022-01-30:茨木市	2022-01-30:柏原市	2022-02-01:岸和田市	2022-02-01:堺市
- 2022-02-01:貝塚市	2022-02-01:枚方市	2022-02-01:和泉市	2022-02-01:羽曳野市
- 2022-02-01:交野市	2022-02-01:大阪狭山市	2022-02-02:池田市	2022-02-02:箕面市
- 2022-02-02:忠岡町	2022-02-03:泉佐野市	2022-02-03:太子町	2022-02-04:高槻市
- 2022-02-04:泉南市	2022-02-04:島本町	2022-02-04:熊取町	2022-02-05:阪南市
- 2022-02-08:河内長野市	2022-02-09:田尻町	2022-02-09:河南町	2022-02-13:千早赤阪村
- 2022-02-19:岬町	2022-02-22:能勢町	2022-02-27:豊能町

検査陽性者数100人あたり4人(25人あたり1人)越え（2022-04-02：すべての市町村で達した。） 43
- 2022-01-23:大阪市	2022-01-31:東大阪市	2022-02-01:守口市	2022-02-01:大東市
- 2022-02-02:門真市	2022-02-02:摂津市	2022-02-04:高石市	2022-02-05:泉大津市
- 2022-02-05:八尾市	2022-02-05:松原市	2022-02-05:四條畷市	2022-02-06:豊中市
- 2022-02-06:吹田市	2022-02-06:富田林市	2022-02-06:寝屋川市	2022-02-06:藤井寺市
- 2022-02-07:羽曳野市	2022-02-08:岸和田市	2022-02-08:貝塚市	2022-02-08:堺市
- 2022-02-08:茨木市	2022-02-08:和泉市	2022-02-08:柏原市	2022-02-08:大阪狭山市
- 2022-02-08:忠岡町	2022-02-09:交野市	2022-02-10:池田市	2022-02-10:枚方市
- 2022-02-10:箕面市	2022-02-11:泉佐野市	2022-02-13:島本町	2022-02-13:高槻市
- 2022-02-13:熊取町	2022-02-15:泉南市	2022-02-15:阪南市	2022-02-16:太子町
- 2022-02-16:河南町	2022-02-17:田尻町	2022-02-18:河内長野市	2022-02-19:千早赤阪村
- 2022-02-25:岬町	2022-03-21:能勢町	2022-04-02：豊能町

検査陽性者数100人あたり5人(20人あたり1人)越え（2022-07-13：すべての市町村で達した。）	43
- 2022-02-02:大阪市	2022-02-07:東大阪市	2022-02-08:大東市	2022-02-09:守口市
- 2022-02-10:門真市	2022-02-10:高石市	2022-02-11:摂津市	2022-02-11:四條畷市
- 2022-02-11:八尾市	2022-02-13:寝屋川市	2022-02-14:松原市	2022-02-15:豊中市
- 2022-02-15:貝塚市	2022-02-15:富田林市	2022-02-15:羽曳野市	2022-02-15:藤井寺市
- 2022-02-15:泉大津市	2022-02-16:吹田市	2022-02-16:茨木市	2022-02-16:堺市
- 2022-02-16:和泉市	2022-02-16:忠岡町	2022-02-16:岸和田市	2022-02-17:柏原市
- 2022-02-17:大阪狭山市	2022-02-17:交野市	2022-02-19:箕面市	2022-02-20:池田市
- 2022-02-20:泉佐野市	2022-02-20:熊取町	2022-02-22:枚方市	2022-02-22:島本町
- 2022-02-23:高槻市	2022-02-23:田尻町	2022-02-25:河南町	2022-02-26:太子町
- 2022-02-26:泉南市	2022-02-27:阪南市	2022-03-01:河内長野市	2022-03-03:岬町
- 2022-03-15:千早赤阪村	2022-05-27:豊能町	2022-07-13:能勢町

検査陽性者数100人あたり6人越え（2022-07-23：すべての市町村で達した。）	43
- 大阪市
- 2022-02-15:東大阪市	2022-02-18:守口市	2022-02-18:大東市	2022-02-20:八尾市
- 2022-02-20:門真市	2022-02-20:摂津市	2022-02-20:高石市	2022-02-20:四條畷市
- 2022-02-22:岸和田市	2022-02-22:泉大津市	2022-02-23:貝塚市	2022-02-23:寝屋川市
- 2022-02-23:羽曳野市	2022-02-23:松原市	2022-02-24:豊中市	2022-02-25:茨木市
- 2022-02-25:藤井寺市	2022-02-25:交野市	2022-02-26:富田林市	2022-02-26:和泉市
- 2022-02-26:忠岡町	2022-02-27:堺市		2022-03-01:吹田市	2022-03-01:柏原市
- 2022-03-01:大阪狭山市	2022-03-01:熊取町	2022-03-02:泉佐野市	2022-03-03:箕面市
- 2022-03-04:池田市	2022-03-05:田尻町	2022-03-09:枚方市	2022-03-09:島本町
- 2022-03-11:高槻市	2022-03-16:泉南市	2022-03-19:太子町	2022-03-23:河内長野市
- 2022-03-24:河南町	2022-04-02:阪南市	2022-04-13:岬町		2022-04-27:千早赤阪村
- 2022-07-14:豊能町	2022-07-23:能勢町

検査陽性者数100人あたり7人越え	（2022-07-30：すべての市町村で達した。）	43
- 大阪市
- 2022-02-23:東大阪市	2022-03-01:守口市	2022-03-01:四條畷市	2022-03-03:岸和田市
- 2022-03-03:大東市	2022-03-04:泉大津市	2022-03-04:摂津市	2022-03-05:八尾市
- 2022-03-05:門真市	2022-03-05:高石市	2022-03-08:貝塚市	2022-03-08:藤井寺市
- 2022-03-09:羽曳野市	2022-03-09:松原市	2022-03-10:豊中市	2022-03-10:交野市
- 2022-03-11:和泉市	2022-03-11:熊取町	2022-03-11:寝屋川市	2022-03-12:富田林市
- 2022-03-12:忠岡町	2022-03-15:茨木市	2022-03-16:堺市		2022-03-16:吹田市
- 2022-03-17:泉佐野市	2022-03-23:大阪狭山市	2022-03-24:池田市	2022-03-24:箕面市
- 2022-03-27:柏原市	2022-03-29:田尻町	2022-04-02:島本町	2022-04-03:枚方市
- 2022-04-05:高槻市	2022-04-14:泉南市	2022-04-15:太子町	2022-04-20:河南町
- 2022-05-03:河内長野市	2022-05-07:阪南市	2022-06-11:岬町		2022-07-09:千早赤阪村
- 2022-07-27:豊能町

検査陽性者数100人あたり8人越え		（2022-08-09：すべての市町村で達した。）	43
- 大阪市
- 2022-03-08:東大阪市	2022-03-17:岸和田市	2022-03-18:泉大津市	2022-03-19:四條畷市
- 2022-03-19:守口市	2022-03-20:大東市	2022-03-20:摂津市	2022-03-20:高石市
- 2022-03-23:四條畷市	2022-03-24:門真市	2022-03-26:貝塚市	2022-03-29:八尾市
- 2022-03-30:和泉市	2022-04-02:交野市	2022-04-02:熊取町	2022-04-02:豊中市
- 2022-04-06:寝屋川市	2022-04-06:藤井寺市	2022-04-07:羽曳野市	2022-04-08:吹田市
- 2022-04-08:松原市	2022-04-10:茨木市	2022-04-13:泉佐野市	2022-04-13:堺市
- 2022-04-16:富田林市	2022-04-19:箕面市	2022-04-19:大阪狭山市	2022-04-21:池田市
- 2022-04-29:島本町	2022-05-06:枚方市	2022-05-06:柏原市	2022-05-08:高槻市
- 2022-05-12:田尻町	2022-05-29:泉南市	2022-06-05:太子町	2022-06-21:河南町
- 2022-06-26:河内長野市	2022-07-12:阪南市	2022-07-23:千早赤阪村	2022-07-23:岬町
- 2022-08-03:豊能町	2022-08-09:能勢町

検査陽性者数100人あたり9人越え	（2022-08-17：すべての市町村で達した。）	43
- 大阪市
- 2022-03-27:東大阪市	2022-04-02:忠岡町	2022-04-09:岸和田市	2022-04-09:泉大津市
- 2022-04-12:摂津市	2022-04-12:高石市	2022-04-15:大東市	2022-04-17:守口市
- 2022-04-21:貝塚市	2022-04-23:門真市	2022-04-23:四條畷市	2022-04-26:交野市
- 2022-04-27:和泉市	2022-04-27:八尾市	2022-04-28:熊取町	2022-04-29:豊中市
- 2022-05-03:吹田市	2022-05-07:寝屋川市	2022-05-07:松原市	2022-05-08:藤井寺市
- 2022-05-09:羽曳野市	2022-05-10:大阪狭山市	2022-05-11:茨木市	2022-05-14:泉佐野市
- 2022-05-15:堺市	2022-05-17:箕面市	2022-05-28:富田林市	2022-06-04:池田市
- 2022-06-04:島本町	2022-06-23:枚方市	2022-07-05:高槻市	2022-07-05:柏原市
- 2022-07-09:田尻町	2022-07-14:太子町	2022-07-16:泉南市	2022-07-20:河南町
- 2022-07-20:河内長野市	2022-07-22:阪南市	2022-07-30:岬町		2022-08-02:千早赤阪村
- 2022-08-10:豊能町	2022-08-17:能勢町

検査陽性者数10人あたり1人越え	（2022-08-21：すべての市町村で達した。）	43
- 2022-03-11:大阪市	2022-04-19:忠岡町	2022-04-26:東大阪市	2022-04-29:岸和田市
- 2022-05-08:泉大津市	2022-05-10:摂津市	2022-05-10:高石市	2022-05-17:守口市
- 2022-05-19:大東市	2022-05-24:八尾市	2022-05-31:門真市	2022-06-02:貝塚市
- 2022-06-08:松原市	2022-06-09:豊中市	2022-06-11:大阪狭山市	2022-06-12:和泉市
- 2022-06-14:吹田市	2022-06-15:和泉市	2022-06-16:四條畷市	2022-06-19:交野市
- 2022-06-21:藤井寺市	2022-06-29:茨木市	2022-06-30:寝屋川市	2022-07-01:羽曳野市
- 2022-07-02:箕面市	2022-07-06:堺市		2022-07-08:泉佐野市	2022-07-12:島本町
- 2022-07-12:池田市	2022-07-16:富田林市	2022-07-16:枚方市	2022-07-19:田尻町
- 2022-07-20:高槻市	2022-07-21:柏原市	2022-07-23:泉南市	2022-07-23:太子町
- 2022-07-23:河南町	2022-07-27:河内長野市	2022-07-27:阪南市	2022-08-04:岬町
- 2022-08-09:千早赤阪村	2022-08-18:豊能町	2022-08-21:能勢町

検査陽性者数100人あたり11人越え(約9.1人に1人)	（2022-08-30：すべての市町村で達した。）	43
- 2022-04-05:大阪市	2022-05-22:東大阪市	2022-05-25:岸和田市	2022-06-16:忠岡町
- 2022-07-02:摂津市	2022-07-04:高石市	2022-07-05:守口市	2022-07-05:泉大津市
- 2022-07-10:八尾市	2022-07-11:松原市	2022-07-12:大東市	2022-07-12:四條畷市
- 2022-07-13:豊中市	2022-07-13:吹田市	2022-07-15:貝塚市	2022-07-15:箕面市
- 2022-07-15:藤井寺市	2022-07-15:門真市	2022-07-16:茨木市	2022-07-16:和泉市
- 2022-07-16:熊取町	2022-07-16:交野市	2022-07-17:大阪狭山市	2022-07-17:寝屋川市
- 2022-07-17:羽曳野市	2022-07-20:島本町	2022-07-20:堺市		2022-07-20:泉佐野市
- 2022-07-20:池田市	2022-07-23:枚方市	2022-07-24:富田林市	2022-07-25:田尻町
- 2022-07-25:高槻市	2022-07-26:柏原市	2022-07-28:河南町	2022-07-28:太子町
- 2022-07-28:泉南市	2022-08-01:阪南市	2022-08-02:河内長野市	2022-08-09:岬町
- 2022-08-18:千早赤阪村	2022-08-23:豊能町	2022-08-30:能勢町

検査陽性者数100人あたり12.5人越え(8人に1人)	41
- 2022-05-11:大阪市	2022-07-16:東大阪市	2022-07-16:岸和田市	2022-07-20:摂津市
- 2022-07-20:高石市	2022-07-21:忠岡町	2022-07-21:泉大津市	2022-07-21:守口市
- 2022-07-22:吹田市	2022-07-22:四條畷市	2022-07-23:大東市	2022-07-23:松原市
- 2022-07-23:豊中市	2022-07-23:八尾市	2022-07-23:貝塚市	2022-07-24:熊取町
- 2022-07-24:和泉市	2022-07-24:箕面市	2022-07-25:門真市	2022-07-26:茨木市
- 2022-07-26:島本町	2022-07-26:交野市	2022-07-26:藤井寺市	2022-07-27:寝屋川市
- 2022-07-27:泉佐野市	2022-07-27:堺市		2022-07-27:大阪狭山市	2022-07-28:羽曳野市
- 2022-07-28:池田市	2022-07-30:枚方市	2022-07-31:田尻町	2022-08-02:高槻市
- 2022-08-02:富田林市	2022-08-02:柏原市	2022-08-04:河南町	2022-08-06:泉南市
- 2022-08-06:太子町	2022-08-10:阪南市	2022-08-11:河内長野市	2022-08-17:岬町
- 2022-08-23:千早赤阪村

検査陽性者数100人あたり14.3人越え(7人に1人)	40
- 2022-07-13:大阪市	2022-07-26:岸和田市	2022-07-27:東大阪市	2022-07-28:高石市
- 2022-07-28:泉大津市	2022-07-28:摂津市	2022-07-29:忠岡町	2022-07-29:守口市
- 2022-07-29:貝塚市	2022-07-30:四條畷市	2022-07-30:吹田市	2022-07-31:松原市
- 2022-07-31:熊取町	2022-07-31:大東市	2022-08-02:八尾市	2022-08-02:門真市
- 2022-08-02:和泉市	2022-08-02:箕面市	2022-08-02:豊中市	2022-08-03:島本町
- 2022-08-03:茨木市	2022-08-03:交野市	2022-08-04:寝屋川市	2022-08-04:大阪狭山市
- 2022-08-04:泉佐野市	2022-08-05:藤井寺市	2022-08-05:堺市		2022-08-06:池田市
- 2022-08-06:羽曳野市	2022-08-08:枚方市	2022-08-09:田尻町	2022-08-11:高槻市
- 2022-08-11:柏原市	2022-08-11:富田林市	2022-08-17:泉南市	2022-08-17:太子町
- 2022-08-19:河南町	2022-08-19:阪南市	2022-08-23:河内長野市	2022-08-27:岬町

検査陽性者数100人あたり16.7人越え(6人に1人)	35
- 2022-07-26:大阪市	2022-08-05:岸和田市	2022-08-06:摂津市	2022-08-09:泉大津市
- 2022-08-09:忠岡町	2022-08-09:東大阪市	2022-08-09:高石市	2022-08-09:守口市
- 2022-08-10:貝塚市	2022-08-11:吹田市	2022-08-11:四條畷市	2022-08-11:熊取町
- 2022-08-12:門真市	2022-08-12:大東市	2022-08-12:松原市	2022-08-13:豊中市
- 2022-08-13:八尾市	2022-08-14:和泉市	2022-08-14:箕面市	2022-08-16:泉佐野市
- 2022-08-16:交野市	2022-08-16:茨木市	2022-08-16:寝屋川市	2022-08-17:大阪狭山市
- 2022-08-17:島本町	2022-08-18:田尻町	2022-08-18:堺市		2022-08-19:藤井寺市
- 2022-08-19:池田市	2022-08-20:枚方市	2022-08-20:羽曳野市	2022-08-24:富田林市
- 2022-08-25:高槻市	2022-08-26:柏原市	2022-08-30:泉南市

検査陽性者数100人あたり20人越え(5人に1人)	22
- 2022-08-09:大阪市	2022-08-20:岸和田市	2022-08-23:摂津市	2022-08-24:忠岡町
- 2022-08-25:泉大津市	2022-08-26:高石市	2022-08-26:東大阪市	2022-08-26:守口市
- 2022-08-27:熊取町	2022-08-29:門真市	2022-08-30:吹田市	2022-08-30:大東市
- 2022-08-30:貝塚市	2022-08-30:四條畷市	2022-09-01:泉佐野市	2022-09-02:松原市
- 2022-09-02:島本町	2022-09-03:豊中市	2022-09-04:八尾市	2022-09-04:茨木市
- 2022-09-04:交野市	2022-09-05:和泉市

#### 大阪府のコロナ死の数はどれだけの都道府県のコロナ死の合計に相当するのか？(人口最大化)

コードは[大阪府のコロナ死の数はどれだけの都道府県のコロナ死の合計に相当するのか？(人口最大化)](https://gitpress.io/@statrstart/Coronavirus23)  

![covid23_01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid23_01.png)

#### 大阪「市」のコロナ死の数はどれだけの都道府県のコロナ死の合計に相当するのか？(人口最大化)

![covid23_02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid23_02.png)

#### 大阪府 : 患者の状況（前日24時まで）

![covid21_13](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_13.png)

#### 大阪府：インフルエンザ報告数と新型コロナウイルス陽性者数（グラフと表）

![covid22_02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid22_02.png)

#### 大阪府：致死率７日移動平均(2022/1/1〜)

![covOsaka16](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka16.png)

#### 都道府県別の人口1万人あたり死亡者数 [ データ：ＮＨＫ ]

![nhkC04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/nhkC04.png)

#### 大阪府：年代別重症者数と死亡者数との差
[大阪府 年代別重症者数と死亡者数(新型コロナウイルス：Coronavirus)](https://gitpress.io/@statrstart/Coronavirus21)からひとつだけここに載せておきます。  

![covid21_06](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid21_06.png)

#### 近畿地方：新型コロナウイルス 累計感染者数の推移(データ：NHK 新型コロナ データ)

![covkinki](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covkinki.png)

#### 大阪府：新型コロナウイルス死亡者の推移
(注意)NHKのデータ使用（更新時間の違いのため大阪府のデータより１日分少ないことがあります。）

![covOsaka13](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka13.png)

#### 時系列

![covOsaka01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka01.png)

#### 週単位の陽性者増加比

![covOsaka08](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka08.png)

#### 大阪市長「公務日程」のカレンダー(2022年版)
- 公務時間は考慮していません。

![Okoumu2022_1](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Okoumu2022_1.png)
![Okoumu2022_2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Okoumu2022_2.png)

-----

#### 大阪市長「公務日程」のカレンダーと「公務日程なし・あり」の日数(2021年版)
- 公務時間は考慮していません。

![Okoumu2021_1](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Okoumu2021_1.png)
![Okoumu2021_2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Okoumu2021_2.png)

#### 大阪市：市長の公務ありなしのカレンダーと公務日程なしの月別日数(2020年)
- 公務時間は考慮していません。

![Okoumu01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Okoumu01.png)
![KoumuOsakashi](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/KoumuOsakashi.png)

#### 人口１万人あたりの検査陽性者数(大阪府市町村別)の推移 「2020-11-15までのデータ」

![covOsaka10](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka10.png)

#### 月別検査陽性者数（大阪府:大阪市と大阪市以外で色分け）「2020-11-15までのデータ」

![covOsaka09](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka09.png)
- 大阪市は人口の割合は約３割なのに６月以降の検査陽性者数の割合は約５割をしめる。

#### 月別の陽性者の属性:年代(大阪府)「2020-11-15までのデータ」

![covOsaka06](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka06.png)

#### 月別年代別の陽性者数と月別死亡者数「2020-11-15までのデータ」

![covOsaka06_2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka06_2.png)

- 8月に入ってから70歳以上の検査陽性者が増加。
- 死亡者数も8月に入ってから増加しているが、4、5月を見ると陽性者の増加と死亡者の増加する時期には一月ほどのずれがある。
- 本格的に死亡者が増加するのは来月だと思われる。  

#### 居住地「2020-11-15までのデータ」

![covOsaka02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka02.png)

#### 塗り分け地図：PCR検査 陽性者数(大阪府市町村別)「2020-11-15までのデータ」

![osakaCmap01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/osakaCmap01.png)

#### 塗り分け地図：人口１万人あたりの検査陽性者数(大阪府市町村別)「2020-11-15までのデータ」

![osakaCmap02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/osakaCmap02.png)

#### 年代「2020-11-15までのデータ」

![covOsaka03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka03.png)

#### 性別「2020-11-15までのデータ」

![covOsaka04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsaka04.png)

#### 吹田市の月別検査陽性者数「2020-11-15までのデータ」

![covOsuita](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covOsuita.png)

### Rコード

#### (json形式)データを読み込み、「陽性者の属性」の部分を取り出す。

```R
#install.packages("jsonlite")
#install.packages("curl")
library(jsonlite)
library(knitr)
library(TTR)
url<- "https://raw.githubusercontent.com/codeforosaka/covid19/master/data/data.json"
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

#### 大阪府:月別の陽性者数(大阪市と大阪市以外で色分け）

```R
m1<- table(factor(substring(dat[,1],6,7),level=c("01","02","03","04","05","06","07","08","09","10","11")))
m2<- table(factor(substring(dat[dat$居住地=="大阪市",1],6,7),level=c("01","02","03","04","05","06","07","08","09","10","11")))
#
#png("covOsaka09.png",width=800,height=600)
par(mar=c(4,6,4,8),family="serif")
b<- barplot(m1,col="slateblue",axes=F,names="",ylim=c(0,max(m1)*1.2))
barplot(m2,add=T,col="firebrick2",las=1,ylim=c(0,max(m1)*1.2),names=paste0(1:11,"月"))
legend(x="topleft",inset=c(0.01,0.05),legend=c("大阪市以外","大阪市"),pch=15,col=c("slateblue","firebrick2"),bty="n")
#
lines(x=b,y=par("usr")[4]*(m2/m1),col="darkgreen",lwd=3)
text(x=b[1],y=par("usr")[4],labels="大阪市の感染者の割合",pos=2,xpd=T,col="darkgreen")
axis(4,at=par("usr")[4]*seq(0,1,0.2),labels=seq(0,100,20),las=1,col="darkgreen")
text(x=par("usr")[2],y=par("usr")[4],labels="(%)",pos=3,xpd=T)
#
abline(h=par("usr")[4]*0.3045,col="darkgreen",lty=2)
text(x=par("usr")[2],y=par("usr")[4]*0.3045,labels="大阪市の人口の\n割合:30.45%",pos=4,xpd=T,col="darkgreen")
abline(h=par("usr")[4]*0.5,col="red",lty=2)
text(x=par("usr")[2],y=par("usr")[4]*0.5,labels="50%ライン",pos=4,xpd=T,col="red")
title("大阪府:月別の陽性者数(大阪市と大阪市以外で色分け）",cex.main=1.5)
#dev.off()
```

#### 吹田市の月別検査陽性者数

```R
#kable(dat[dat$居住地=="吹田市",],row.names=F)
data<- dat[dat$居住地=="吹田市",]
#各月ごとの検査陽性者数
monthsum<- table(factor(substring(data$date,6,7),levels=c("01","02","03","04","05","06","07","08","09","10","11")))
#
#png("covOsuita.png",width=800,height=600)
par(mar=c(3,7,3,2),family="serif")
b<- barplot(monthsum,las=1,col="red",names=paste0(1:11,"月"),ylim=c(0,max(monthsum)*1.2),yaxt="n")
# Add comma separator to axis labels
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
text(x= b[1:nrow(monthsum)], y=as.numeric(monthsum),labels=formatC(as.numeric(monthsum), format="d", big.mark=','),cex=1.2,pos=3)
legend("topleft",inset=c(0,0),xpd=T,bty="n",
	legend="データ：https://raw.githubusercontent.com/codeforosaka/covid19/master/data/data.json")
title("吹田市 : 月別の陽性者数",cex.main=1.5)
#dev.off()
```

#### 大阪市の月別検査陽性者数

```R
data<- dat[dat$居住地=="大阪市",]
#各月ごとの検査陽性者数
monthsum<- table(factor(substring(data$date,6,7),levels=c("01","02","03","04","05","06","07","08","09","10","11")))
#
#png("covOosakashi.png",width=800,height=600)
par(mar=c(3,7,3,2),family="serif")
b<- barplot(monthsum,las=1,col="red",names=paste0(1:11,"月"),ylim=c(0,max(monthsum)*1.2),yaxt="n")
# Add comma separator to axis labels
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
text(x= b[1:nrow(monthsum)], y=as.numeric(monthsum),labels=formatC(as.numeric(monthsum), format="d", big.mark=','),cex=1.2,pos=3)
legend("topleft",inset=c(0,0),xpd=T,bty="n",
	legend="データ：https://raw.githubusercontent.com/codeforosaka/covid19/master/data/data.json")
title("大阪市 : 月別の陽性者数",cex.main=1.5)
#dev.off()
```

#### 時系列

```R
#date
tbl<- table(dat$date)
names(tbl)<- gsub("2020-","",names(tbl))
#元から日付順になっているのでこの部分は不要
#tbl<- tbl[order(names(tbl))]
sma7<- round(SMA(tbl,7),2)
#png("covOsaka01.png",width=800,height=600)
par(mar=c(3,7,4,2),family="serif")
b<- barplot(tbl,las=1,ylim=c(0,max(tbl)*1.2),col="red")
lines(x=b,y=sma7,lwd=2.5,col="blue")
legend("topleft",inset=0.03,lwd=2.5,col="blue",legend="7日移動平均",cex=1.2)
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
Pos<- round(js[[10]][[3]]$value/js[[10]][[2]]*100,2)
# 致死率(%): 亡くなった人の数/陽性患者数*100
Dth<- round(js[[10]][[3]][[3]][[1]][grep("死亡",js[[10]][[3]][[3]][[1]]$attr),2]/js[[10]][[3]]$value*100,2)
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

#### 検査陽性率（％）７日移動平均（大阪府）

```R
library(TTR)
# 検査陽性率(%)
dat<- js[[2]][[2]]
dat<- merge(dat,js[[3]][[2]],by=1)
rownames(dat)<- sub("-","/",sub("-0","-",sub("^0","",substring(dat[,1],6,10))))
dat<- dat[,-1]
colnames(dat)<- c("陽性者数","検査実施件数")
# 検査陽性率(%)7日移動平均
sma<- round(runSum(dat$陽性者数,7)/runSum(dat$検査実施件数,7)*100,2)
#png("covOsaka07.png",width=800,height=600)
par(mar=c(3,7,4,3),family="serif")
plot(sma,type="l",lwd=2.5,las=1,xlab="",ylab="",xaxt="n",bty="n")
box(bty="l",lwd=2.5)
axis(1,at=1:length(sma),labels=rownames(dat))
text(x=par("usr")[2],y=sma[length(sma)],labels=paste0(rownames(dat)[nrow(dat)],"現在\n",sma[length(sma)]),xpd=T,cex=1.2)
title("検査陽性率（％）７日移動平均（大阪府）",cex.main=1.5)
#dev.off()
```

#### 週単位の陽性者増加比

```R
library(TTR)
dat<- js[[2]][[2]]
rownames(dat)<- sub("-","/",sub("-0","-",sub("^0","",substring(dat[,1],6,10))))
dat<- dat[,-1,drop=F]
#
e7<- runSum(dat,n=7)
b7<- runSum(dat,n=14) - e7
df<- round(e7/b7,2)
# InfにNAを入れる
df[df==Inf]<- NA
df<- data.frame(date=rownames(dat),zougen= df)
df<- df[40:nrow(df),]
#
#png("covOsaka08.png",width=800,height=600)
par(mar=c(4,6,4,7),family="serif")
plot(df[,2],type="l",lwd=2,las=1,ylim=c(0,11),xlab="",ylab="",xaxt="n",bty="n")
box(bty="l",lwd=2.5)
#
labelpos<- paste0(1:12,"/",1)
for (i in labelpos){
	at<- which(i==sub("-","/",sub("-0","-",sub("^0","",substring(df[,1],6,10)))))
	axis(1,at=at,labels = rep(paste0(sub("/1","",i),"月"),length(at)),tck= -0.02)
	}
mtext(text="2020年",at=1,side=1,line=2.5,cex=1.2) 
mtext(text="2021年",at=303,side=1,line=2.5,cex=1.2) 
abline(h=1,col="red",lty=2)
text(x=par("usr")[2],y=df[,2][nrow(df)],labels= paste0(df[,1][nrow(df)],"\n現在\n",df[,2][nrow(df)]),xpd=T,cex=1.2,col="red")
arrows(par("usr")[2]*1.08, 1.1,par("usr")[2]*1.08,1.68,length = 0.2,lwd=2.5,xpd=T)
text(x=par("usr")[2]*1.08,y=2,labels="増加\n傾向",xpd=T)
arrows(par("usr")[2]*1.08, 0.9,par("usr")[2]*1.08,0.32,length = 0.2,lwd=2.5,xpd=T)
text(x=par("usr")[2]*1.08,y=0,labels="減少\n傾向",xpd=T)
title("週単位の陽性者増加比(大阪府)",cex.main=1.5)
#dev.off()
```

#### 塗り分け地図

```R
library(sf)
library(BAMMtools)
osaka<- st_read("https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/osaka.geojson", 
	stringsAsFactors=FALSE)
map<- aggregate(osaka[,c("code2","sityo")], list(osaka$code2), unique)
dat<- js[[1]][[2]][,c(8,4:7)]
#is.element(dat$居住地,as.vector(map$sityo))
unique(dat$居住地[!is.element(dat$居住地,as.vector(map$sityo))])
#検査陽性者のいない市町村
map$sityo[!is.element(map$sityo,dat$居住地)]
#ないものの数を0としてカウント:factorを使ってtable
#"大阪府外" "調査中"は除く
tbl<- table(factor(dat$居住地, levels=map$sityo))
#knitr::kable(tbl)
```

##### PCR検査 陽性者数(大阪府市町村別)

```R
# 並び順が一致しているか確認
all(names(tbl)== map$sityo)
#
df<- as.vector(tbl)
# legendのタイトル
ltitle<- "検査陽性者数"
# グラフのタイトル
title<- "PCR検査 陽性者数(大阪府市町村別)"
#
##### ここ以降のRコードは共通 #####
#
# Jenksの自然分類法で分ける最大
i <- length(df)
brk <- getJenksBreaks(df,k=i+1)
while (length(unique(brk)) != length(brk)) { 
	brk <- getJenksBreaks(df,k=i+1)
	i=i-1
}
# legendのlabelを作成
labels<- as.vector(cut(brk[1:length(brk)-1],breaks=brk,include.lowest=T,right =F, dig.lab=5))
# 塗りつぶしに使うカラーパレット：rev関数で　白->赤
color<- rev(heat.colors(length(brk)-1))
cols<-as.vector(cut(df, breaks=brk,labels =color,include.lowest=T,right =F))
# png("osakaCmap01.png",width=800,height=800)
par(mar=c(0,0,4,0),family="serif")
plot(st_geometry(map),col=cols)
c=st_centroid(st_geometry(map))
text(st_coordinates(c),paste0(map$sityo,"\n",df,"人"))
legend(x=135.8,y=35,legend=labels, fill=color,title =ltitle,ncol=1,bty="n",xpd=T,cex=1.2)
title(title,cex.main=1.5)
# dev.off()
```

##### 人口１万人あたりの検査陽性者数(大阪府市町村別)

```R
#市町村別の年齢別人口と割合
#http://www.pref.osaka.lg.jp/kaigoshien/toukei/ritu.html
prof<- c("大阪市","堺市","岸和田市","豊中市","池田市","吹田市","泉大津市","高槻市","貝塚市","守口市","枚方市","茨木市","八尾市","泉佐野市","富田林市","寝屋川市","河内長野市","松原市","大東市","和泉市","箕面市","柏原市","羽曳野市","門真市","摂津市","高石市","藤井寺市","東大阪市","泉南市","四條畷市","交野市","大阪狭山市","阪南市","島本町","豊能町","能勢町","忠岡町","熊取町","田尻町","岬町","太子町","河南町","千早赤阪村")
pop<- c(2691185,839310,194911,395479,103069,374468,75897,351829,88694,143042,404152,280033,268800,100966,113984,237518,106987,120750,123217,186109,133411,71112,112683,123576,85007,56529,65438,502784,62438,56075,76435,57792,54276,29983,19934,10256,17298,44435,8417,15938,13748,16126,5378)
# 並び順が一致しているか確認
all(prof== map$sityo)
#
df<- round(as.vector(tbl)/pop*10000,2)
# legendのタイトル
ltitle<- "人口１万人あたりの\n検査陽性者数"
# グラフのタイトル
title<- "人口１万人あたりの検査陽性者数(大阪府市町村別)"
#
##### ここ以降のRコードは共通 #####
#
# Jenksの自然分類法で分ける最大
i <- length(df)
brk <- getJenksBreaks(df,k=i+1)
while (length(unique(brk)) != length(brk)) { 
	brk <- getJenksBreaks(df,k=i+1)
	i=i-1
}
# legendのlabelを作成
labels<- as.vector(cut(brk[1:length(brk)-1],breaks=brk,include.lowest=T,right =F, dig.lab=5))
# 塗りつぶしに使うカラーパレット：rev関数で　白->赤
color<- rev(heat.colors(length(brk)-1))
cols<-as.vector(cut(df, breaks=brk,labels =color,include.lowest=T,right =F))
# png("osakaCmap02.png",width=800,height=800)
par(mar=c(0,0,4,4),family="serif")
plot(st_geometry(map),col=cols)
c=st_centroid(st_geometry(map))
text(st_coordinates(c),paste0(map$sityo,"\n",df,"人"))
legend(x=135.8,y=35.1,legend=labels, fill=color,title =ltitle,ncol=1,bty="n",xpd=T,cex=1.2)
title(title,cex.main=1.5)
# dev.off()
```

#### 月別年代別の陽性者数と月別死亡者数

```R
library(jsonlite)
library(xts)
#「東洋経済オンライン」新型コロナウイルス 国内感染の状況
# https://toyokeizai.net/sp/visual/tko/covid19/
#著作権「東洋経済オンライン」
covid19 = fromJSON("https://raw.githubusercontent.com/kaz-ogiwara/covid19/master/data/data.json")
covid19[[5]][covid19[[5]]$en=="Osaka",]
#   code     ja    en value
#27   27 大阪府 Osaka  6845
# 大阪府(code:27)
code<- 27
data<- covid19[[4]]$deaths[code,]
from<- as.Date(paste0(data$from[[1]][1],"-",data$from[[1]][2],"-",data$from[[1]][3]))
data.xts<- xts(x=data$values[[1]],seq(as.Date(from),length=nrow(data$values[[1]]),by="days"))
#各月ごとの死亡者の合計
monthsum.xts<- apply.monthly(data.xts[,1],sum)
monthsum<- data.frame(coredata(monthsum.xts))
rownames(monthsum)<- substring(index(monthsum.xts),6,7)
if (rownames(monthsum)[nrow(monthsum)]!="11"){
	monthsum= rbind(monthsum,0)
}
#
#png("covOsaka06_2.png",width=800,height=600)
par(mar=c(3,7,3,2),family="serif")
mat <- matrix(c(1,1,1,1,2,2),3,2, byrow = TRUE)
layout(mat) 
#3月以降
barplot(t(tab2[-c(1,2),]),col=rainbow(9,0.7),beside=T,las=1,legend=T,names=paste0(sub("^0","",rownames(tab2[-c(1,2),])),"月"),
	args.legend = list(x = "topleft",inset= 0.03))
title("大阪府 : 月別年代別の陽性者数と月別死亡者数",cex.main=1.5)
b<- barplot(t(monthsum),las=1,col="red",names=paste0(3:11,"月"),ylim=c(0,max(monthsum)*1.2))
text(x= b[1:nrow(monthsum)], y=as.vector(monthsum)[,1],labels=as.vector(monthsum)[,1],cex=1.2,pos=3)
legend("topleft",inset=c(0,-0.1),xpd=T,bty="n",legend="データ：[東洋経済オンライン]\n(https://raw.githubusercontent.com/kaz-ogiwara/covid19/master/data/data.json)")
#dev.off()
```

##### 大阪府 vs 東京都 : 新型コロナウイルス 人口100万人あたりの死亡者数

```R
library(sf)
library(NipponMap)
shp <- system.file("shapes/jpn.shp", package = "NipponMap")[1]
m <- sf::read_sf(shp)
#[NHK:新型コロナ データ一覧](https://www3.nhk.or.jp/news/special/coronavirus/data-widget/)
nhkC<- read.csv("https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv")
# 東京都
code<-13
data<- nhkC[nhkC$都道府県コード==code,c(1,7)]
data.xts<- as.xts(read.zoo(data, format="%Y/%m/%d"))
data.xts<- round(data.xts[,1]*1000000/m$population[code],2)
# 大阪府
code<-27
data<- nhkC[nhkC$都道府県コード==code,c(1,7)]
tmp.xts<- as.xts(read.zoo(data, format="%Y/%m/%d"))
tmp.xts<- round(tmp.xts[,1]*1000000/m$population[code],2)
data.xts<- merge(data.xts,tmp.xts)
colnames(data.xts)<- c("Tokyo","Osaka")
#
#png("covOvsT01.png",width=800,height=600)
par(mar=c(5,4,5,6),family="serif")
matplot(coredata(data.xts),type="l",lwd=2.5,lty=1,las=1,xaxt="n",yaxt="n",ylim=c(0,max(data.xts,na.rm=T)*1.1),col=c("blue","red"),xlab="",ylab="",bty="n")
box(bty="l",lwd=2)
# Add comma separator to axis labels
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
#表示するx軸ラベルを指定
# 2020- を削除。01-01 -> 1/1 
labels<- sub("-","/",sub("-0","-",sub("^0","",sub("2020-","",index(data.xts)))))
# 毎月1日
labelpos<- paste0(1:12,"/",1)
for (i in labelpos){
	at<- match(i,labels)
	if (!is.na(at)){ axis(1,at=at,labels = paste0(sub("/1","",i),"月"),tck= -0.02)}
	}
#labelpos<- paste0(rep(1:12,each=2),"/",c(10,20))
#for (i in labelpos){
#	at<- match(i,labels)
#	if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.01)}
#	}
legend("topleft",inset=0.03,legend=colnames(data.xts),col=c("blue","red"),lwd=2.5,lty=1)
text(x=par("usr")[2],y=tail(data.xts,1),xpd=T,
	labels=paste0(colnames(data.xts),"\n",tail(data.xts,1),"人"))
title("大阪府 vs 東京都 : 新型コロナウイルス 人口100万人あたりの死亡者数",
	"データ：[NHK](https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv)",line=3)
#dev.off()
```

##### 人口１万人あたりの検査陽性者数(大阪府市町村別)の推移

```R
tbl<- table(js[[1]]$data$date,factor(js[[1]]$data$居住地, levels=map$sityo))
#rownames(tbl)[1]
#tail(rownames(tbl),1)
alldate<- seq(as.Date(rownames(tbl)[1]),as.Date(tail(rownames(tbl),1)),"days")
rname<- alldate[!is.element(alldate,as.Date(rownames(tbl)))]
# 0行列
mat0<- matrix(0, nrow=length(rname), ncol=ncol(tbl))
colnames(mat0)<- colnames(tbl)
rownames(mat0)<- as.character(rname)
mat<- rbind(tbl,mat0)
#日付順
tbl<- mat[rownames(mat)[order(rownames(mat))],]
tbl<- apply(tbl,2,cumsum)
#順序を確認
all(prof==colnames(tbl))
tbl<- t(apply(tbl,1,function(x){round(10000*x/pop,2)}))
#
# png("covOsaka10.png",width=800,height=600)
par(mar=c(4,3,4,4),family="serif")
matplot(tbl,type="l",lty=1,xlab="",ylab="",xaxt="n",bty="n",las=1,col=rainbow(ncol(tbl)))
box(bty="l",lwd=2.5)
#表示するx軸ラベルを指定
# 2020- を削除。01-01 -> 1/1 
labels<- sub("-","/",sub("-0","-",sub("^0","",sub("2020-","",rownames(tbl)))))
# 毎月1日
labelpos<- paste0(rep(1:12),"/",1)
for (i in labelpos){
	at<- match(i,labels)
	if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.02)}
	}
labelpos<- paste0(rep(1:12,each=2),"/",c(10,20))
for (i in labelpos){
	at<- match(i,labels)
	if (!is.na(at)){ axis(1,at=at,labels = sub("^.*/","",i),tck= -0.01,cex.axis=0.8)} 
	}
text(x=par("usr")[2],y=tbl[nrow(tbl),],labels=colnames(tbl),xpd=T)
text(x=par("usr")[1],y=par("usr")[4],labels="(人)",pos=2,xpd=T)
# グラフのタイトル
title("人口１万人あたりの検査陽性者数(大阪府市町村別)の推移")
legend=round(sort(tbl[nrow(tbl),],decreasing=T),2)
legend("topleft",legend=paste(names(legend),legend),inset=0.01,ncol=3,bty="n",cex=1.2)
#dev.off()
```

##### 地図:国土数値情報 行政区域データから作成

```R
#国土数値情報 行政区域データ 
#https://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-N03-v2_4.html#!
# install.packages("sf")
library(sf)
options(stringsAsFactors=FALSE)
osaka = st_read("./Osaka", options="ENCODING=CP932")
table(osaka$N03_007)
osaka2 = aggregate(osaka, list(osaka$N03_007), unique)
library(rmapshaper)
# データ量を約 1/333 に
osaka3 = ms_simplify(osaka2, keep=0.003, keep_shapes=TRUE)
plot(st_geometry(osaka3), graticule=TRUE, axes=TRUE)
#
#plot(st_geometry(osaka3))
#Group.1 N03_001  N03_003  N03_004
osaka = osaka3[ ,c("Group.1", "N03_003", "N03_004")]
names(osaka) = c("code","sigun","kusityo","geometry")
#作図しやすくするため
osaka$code2<- c(rep(27100,24),rep(27140,7),osaka$code[32:72])
osaka$sityo<- c(osaka$sigun[1:31],osaka$kusityo[32:72])
osaka<- osaka[,c(1,5,2,3,6,4)]
#osaka$sigunのNAに市名をいれる
osaka$sigun<- c(osaka$sigun[1:31],osaka$kusityo[32:62],osaka$sigun[63:72])
#できたデータをシェープファイル形式で保存するには
#st_write(osaka, "osaka.shp", layer_options="ENCODING=UTF-8")
#GeoJSON形式で保存する。
st_write(osaka, "./Osaka/osaka.geojson")
```

#### 市長日程２０２０年

```R
library(calendR)
library(rvest)
#これまでの市長日程
p<- c("0000342310","0000346760","0000351186","0000353763","0000361763","0000361768",
	"0000361957","0000361965","0000361978","0000361979","0000361980","0000361981")
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
koumu<- koumu[,1 ]
#
#公務日程なしの日付　曜日削除
days<- gsub("（.*）","",koumu)
days<- as.Date(paste0("2020-",gsub("日","",gsub("月","-",days))))
#png("KoumuOsakashi02.png",width=800,height=600)
mat <- matrix(c(1,1,1,1,1,1,2,2),4,2, byrow = TRUE)
layout(mat) 
par(mar=c(3,7,3,2),family="serif")
b<- barplot(table(substring(days,6,7)),las=1,ylim=c(0,31),col="firebrick2",names=paste0(1:12,"月"))
text(x=b,y=table(substring(days,6,7)),labels=table(substring(days,6,7)),pos=3)
legend(x="topleft",legend="市の考え方
大阪市ホームページにおいて、「公務日程なし」と記載している時でありましても、
行政的に随時連絡をとれる体制を整えており、市長は市政の必要に応じたマネジメント
を行っております。
https://www.city.osaka.lg.jp/seisakukikakushitsu/page/0000516041.html",bty="n")
title("「公務日程なし」の月別日数（大阪市：市長日程）[2020年]")
#
yeardata<- sum(table(substring(days,6,7)))
b<- barplot(matrix(c(yeardata,366-yeardata),nrow=2),horiz=T,col=c("brown3","royalblue3"))
# x:yeardata/2=90 yeardata+(366-yeardata)/2
text(x=c(90,273),y=b,labels=c(paste0("公務日程なし\n",yeardata,"日"),paste0("公務日程あり\n",(366-yeardata),"日")),cex=3)
title("２０２０年「公務日程なし・あり」の日数（大阪市：市長日程）")
#dev.off()
#
# 2020-01-01を１日目として何日目に当たるかを計算
no_koumu<- as.numeric(as.Date(days)-as.Date("2020-01-01")+1)
#
# Vector of dates
dates <- seq(as.Date("2020-01-01"), as.Date("2020-12-31"), by = "1 day")
# Vector of "公務日程あり" 
events <- rep("公務日程あり",length(dates))
# Adding more events
events[no_koumu] <- "公務日程なし"
# +2 : データのある日の次の日
#events[as.numeric(as.Date(last)-as.Date("2020-01-01")+2):length(dates)] <- NA
# Creating the calendar
#png("Okoumu02.png",width=800,height=600)
calendR(year = 2020,
        start = "S",
        special.days = events,
        special.col = c("lightblue","red"), # as events
	title = "「公務日程」のカレンダー（大阪市：市長日程より作成）",  # Change the title
        title.size = 15,                  # Font size of the title
        title.col = 2,                    # Color of the title
        subtitle = "[2020]" ,
	subtitle.size = 15,
	weeknames = c("月","火","水","木","金","土","日"),
	legend.pos = c(0.1,1.15))  
#dev.off()
```

#### 大阪府の重症者数の推移 [データ：都道府県別の発生動向「東洋経済オンライン」]

```R
library(xts)
#「東洋経済オンライン」新型コロナウイルス 国内感染の状況
# https://toyokeizai.net/sp/visual/tko/covid19/
#制作・運用：東洋経済オンライン編集部
# 都道府県別の発生動向
covid19 = read.csv("https://toyokeizai.net/sp/visual/tko/covid19/csv/prefectures.csv")
# serious discharged
data<- covid19[covid19$"prefectureNameJ"=="大阪府",c(1:3,9)]
time<- as.Date(paste0(data$year,"-",data$month,"-",data$date))
data$serious<- as.numeric(as.character((data$serious)))
data.xts<- xts(x=data$serious,time)
data.xts<- data.xts["2020-05-08 ::"]
# png("covOsaka14.png",width=800,height=600)
plot(data.xts,main="大阪府の重症者数の推移 [データ：都道府県別の発生動向「東洋経済オンライン」]")
# dev.off()
```

