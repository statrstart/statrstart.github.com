---
title: RでWebスクレイピング01(気象庁 震源リスト)
date: 2019-09-16
tags: ["R", "rvest"]
excerpt: 陰影段彩図　+「気象庁 震源リスト」その１
---

# RでWebスクレイピング01(気象庁 震源リスト)

＊Rコードは２０１９年９月１６日に実行しました。  

陰影段彩図に「気象庁 震源リスト」から得た震源の位置をプロットします。  
今回は「気象庁 震源リスト」からデータを抜き出して、加工するまでです。

## Rコード

### 気象庁　震源リストにあるデータの期間を調べる

rvestパッケージを使います。

```R
#install.packages("rvest")
library("rvest")
webdata<-read_html("http://www.data.jma.go.jp/svd/eqev/data/daily_map/")
# class属性がliタグのノードを抽出
node_extracted <-html_nodes(webdata, "li")
# ノードからテキストを抽出。
data <- data.frame(html_text(node_extracted),stringsAsFactors = F)
day<-subset(data,grepl("..年..月..日", data[,1]))
ymd<-gsub("日","",gsub("月","",gsub("年","", rev(day[,1]))))
head(ymd,1) ; tail(ymd,1)
```

[1] "20180301"  
[1] "20190914"  

＊２０１９年９月１６日１１時現在　２０１８年３月１日から２０１９年９月１４日までのデータがあることがわかります。  
（これより過去の震源は、地震月報（カタログ編）: http://www.data.jma.go.jp/svd/eqev/data/bulletin/index.html） 

### 震源リストにあるデータを取得する

データの年月日はymdに入っているので必要なその中から必要なデータの年月日を変数dateに入れます。

今回は20190724から17日間

```R
#震源リストにある全期間のデータを取得する場合
#date<-ymd
#
#期間を指定する場合
date<-gsub("-","",seq(as.Date("2019-07-24"), len=17, by="1 day"))
#
eqdata<-read.table(text="",col.names=c("time", "longitude", "latitude", "depth", "mag"))
for (i in date){
  url<-paste0("http://www.data.jma.go.jp/svd/eqev/data/daily_map/",i,".html")
  #
  doc<-readLines(url,encoding ="UTF-8")
  kensaku<-paste0(substr(i,1,4)," ",gsub("\\<0"," ",substr(i,5,6))," ",gsub("\\<0"," ",substr(i,7,8)))
  #
  x<-doc[grep(paste0("\\<",kensaku),doc)]
  #
  #全角文字 ° が入っているので半角スペース２つに変換する
  x<-gsub("°", "  ",x)
  time<-paste0(substr(x,1,4),"-",substr(x,6,7),"-",substr(x,9,10)," ",substr(x,12,16),":",substr(x,18,21))
  #
  #南緯、西経の場合も考慮に入れると
  latitude = as.numeric(paste0(substr(x,23,23),as.character(as.numeric(substr(x,24,25))+as.numeric(substr(x,28,29))/60+as.numeric(substr(x,31,31))/600)))
  longitude = as.numeric(paste0(substr(x,34,34),as.character(as.numeric(substr(x,35,37))+as.numeric(substr(x,40,41))/60+as.numeric(substr(x,43,43))/600)))
  depth<-as.numeric(substr(x,48,50))
  mag<-as.numeric(substr(x,55,58))
  eq<-data.frame(time,longitude,latitude,depth,mag)
  eqdata<-rbind(eqdata,subset(eq,mag>=-4))
}
#
#重複した行を取り除く
eqdata<-unique(eqdata)
head(eqdata,1) ; tail(eqdata,1)
```
1 2019- 7-24 00:00:50.3  140.5883 36.84167     6 0.8  

46316 2019- 8- 9 23:59:25.7  135.5333   35.035    14 0.2

### データを保存する（特に長い期間のデータを取得した場合は保存しましょう）

```R
save(eqdata,file="eqdata20190724_0809.Rdata")
```

### データを加工する

プロットする際に震源の深さによって色を分けようと思うのでその準備。  

as.vector(cut( , breaks= , labels = , right = F)) を使うと楽です。

```R
#震源の深さによって色を分ける
eqdep<-c(-Inf,10,20,40,80,150,Inf)
eqcol<-c("red","orange","yellow","green","blue","purple")
#"D<10km"->"red" ,"10km<=D<20km"->"orange" ,"20km<=D<40km"->"yellow" ,"40km<=D<80km"->"green" ,"80km<=D<150km"->"blue","150km<=D"->"purple"
# cut関数 なに以上なになに未満となるようにright = F
eqdata$col<-as.vector(cut(eqdata$depth, breaks=eqdep, labels = eqcol, right = F))
#並べ替え:マグニチュードの昇順
sortlist <- order(eqdata$mag)
eq<- eqdata[sortlist,]
head(eq,1) ; tail(eq,1)
```

11815 2019- 8- 8 03:20:55.5    139.01    35.28     1  -1 red  

1034 2019- 7-28 03:31: 6.7  137.3967    33.16   393 6.6 purple  

