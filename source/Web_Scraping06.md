---
title: RでWebスクレイピング06(気象庁 過去の気象データ:prec_no,block_no)
date: 2019-10-21
tags: ["R", "rvest"]
excerpt: prec_no(都府県・地方区分番号),block_no(観測地点番号) 一覧を得る
---

# prec_no(都府県・地方区分番号),block_no(観測地点番号) 一覧を得る

## Rコード

```R
library(rvest)
#
##### prec_no #####
prec_url<-"http://www.data.jma.go.jp/obd/stats/etrn/select/prefecture00.php"
#prec_noの記述箇所の書式は
#<area shape="rect" alt="宗谷地方" coords="705,22,742,37" href="prefecture.php?prec_no=11&block_no=&year=&month=&day=&view=">
prec_html<-read_html(prec_url, encoding = "UTF-8")
# class属性がareaタグのノードを抽出
node_extracted <-html_nodes(prec_html, "area")
prec_name<-html_attr(node_extracted, "alt")
url_list<-html_attr(node_extracted,"href")
#substring(url_list, 24, 25)
prec_list<-data.frame(prec_no=substring(url_list, 24, 25),prec_name,url_list)
# 確認
head(prec_list,1)
tail(prec_list,1)
#
##### block_no #####
#
kisyo_list <- data.frame(matrix(rep(NA,4),nrow=1))
names(kisyo_list)<-c("prec_no","prec_name","block_no","block_name")
#
for ( num in 1:nrow(prec_list)){
  i<-as.vector(prec_list$url_list[num])
  block_url<- paste0("http://www.data.jma.go.jp/obd/stats/etrn/select/",i)
  block_html<-read_html(block_url, encoding = "UTF-8")
  # class属性がareaタグのノードを抽出
  node_extracted <-html_nodes(block_html, "area")
  block_name<-html_attr(node_extracted, "alt")
  url_list<-html_attr(node_extracted,"href") 
  block_no<-gsub("&","",substring(url_list, 34, 38))
  block_list<-data.frame(block_no,block_name)
  # 重複する列を削除
  #
  block_list<-unique(block_list)
  #
  # このような列を削除
  #   block_no           block_name
  #31     00ye       宗谷地方全地点
  #32     o=ye             留萌地方
  #33     o=ye             上川地方
  #34     o=ye 網走・北見・紋別地方
  #
  block_list<-block_list[block_list$block_no !="00ye" & block_list$block_no !="o=ye" ,]
  block_list[,3]<-rep(as.vector(prec_list$prec_no[num]),nrow(block_list))
  block_list[,4]<-rep(as.vector(prec_list$prec_name[num]),nrow(block_list))
  block_list<-block_list[,c(3,4,1,2)]
  colnames(block_list)<-c("prec_no","prec_name","block_no","block_name")
  #
  kisyo_list<-rbind(kisyo_list,block_list)
}
```

### 何度もアクセスしなくてすむように必ずデータを保存する。

```R
#save(kisyo_list,file="kisyo_list.Rdata")
#load("kisyo_list.Rdata")
```

### 使ってみる

#### block_nameが東京

```R
subset(kisyo_list, grepl("東京",kisyo_list$block_name))
```

   prec_no prec_name block_no block_name  
925      44    東京都    47662       東京

#### block_nameが札幌

```R
subset(kisyo_list, grepl("札幌",kisyo_list$block_name))
```

   prec_no prec_name block_no block_name  
93      14  石狩地方    47412       札幌

#### 鳥取県内の観測点（prec_nameが鳥取）

```R
subset(kisyo_list, grepl("鳥取",kisyo_list$prec_name))
```

prec_no prec_name block_no block_name  

187       69    鳥取県    47742         境  
387       69    鳥取県     0709       青谷  
586       69    鳥取県    47746       鳥取  
768       69    鳥取県     0711       岩井  
957       69    鳥取県    47744       米子  
1154      69    鳥取県     0713       倉吉  
1349      69    鳥取県     0714     菅俵原  
1546      69    鳥取県     0715     霊石山  
1745      69    鳥取県     0716       大山  
1944      69    鳥取県     0717     古峠山  
2143      69    鳥取県     0718       智頭  
2341      69    鳥取県     0938       日南  
2540      69    鳥取県     1177       関金  
2740      69    鳥取県     1178       若桜  
2940      69    鳥取県     1231       塩津  
3141      69    鳥取県     1304       茶屋  
3334      69    鳥取県     1385       佐治  
3533      69    鳥取県     1389       江尾  
3730      69    鳥取県     1391       鹿野  
3927      69    鳥取県     1519       湖山  

＊ block_noが４桁と５桁の観測点がある。観測項目が異なる。url:４桁::a1.php ,５桁::s1.php

#### 北海道は１４の地方に分けられている。（prec_nameを北海道としたら検索できない）

```R
unique(subset(kisyo_list, grepl("地方",kisyo_list$prec_name))$prec_name)
```

 [1] "宗谷地方"             "上川地方"             "留萌地方"              
 [4] "石狩地方"             "空知地方"             "後志地方"            
 [7] "網走・北見・紋別地方" "根室地方"             "釧路地方"            
[10] "十勝地方"             "胆振地方"             "日高地方"            
[13] "渡島地方"             "檜山地方"   

#### block_noが５桁の観測点の数

```R
nrow(subset(kisyo_list, nchar(block_no)==5))
```

[1] 160

#### block_noが４桁の観測点の数

```R
nrow(subset(kisyo_list, nchar(block_no)==4))
```

[1] 1508



