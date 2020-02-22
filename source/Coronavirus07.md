---
title: Rでtimeline (Coronavirus)
date: 2020-02-23
tags: ["R","rvest","Coronavirus","Japan","Diamond Princess"]
excerpt: Rでtimeline (Coronavirus)
---

# Rでtimeline (Coronavirus)
![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus07)

## 日本時間　2020.02.23 07:35 現在

### BNO News:Tracking coronavirus: Map, data and timelineのtimelineから日本関係の部分を取り出す。

新型コロナウィルスのまとめサイトとしても「BNO News」はおすすめです。  
このサイトのtimelineから日本関係の部分を取り出すRコードを考えてみました。  

## (注意)データの時間はGMT グリニッジ標準時 です。JST 日本標準時との時差は 9時間です。

Data : [BNO News:Tracking coronavirus: Map, data and timeline](https://bnonews.com/index.php/2020/02/the-latest-coronavirus-cases/)

### Diamond Princess関係以外の日本のTimeline
#### GMT グリニッジ標準時 UTC+0000とJST 日本標準時 UTC+0900時差は 9時間。

|x                                                                                                                             |
|:-----------------------------------------------------------------------------------------------------------------------------|
|22 February 17:30: 1 new case in Hokkaido Prefecture, Japan.                                                                  |
|22 February 14:10: 4 new cases in Aichi Prefecture, Japan.                                                                    |
|22 February 14:00: 1 new case in Tokyo, Japan.                                                                                |
|22 February 13:30: 1 new case in Chiba Prefecture, Japan.                                                                     |
|22 February 13:05: 4 new cases in Kanagawa Prefecture, Japan.                                                                 |
|22 February 12:47: 1 new case in Ishikawa Prefecture, Japan.                                                                  |
|22 February 11:30: 9 new cases in Hokkaido Prefecture, Japan.                                                                 |
|22 February 07:59: 1 new case in Wakayama Prefecture, Japan.                                                                  |
|22 February 04:30: 1 new case in Chiba Prefecture, Japan. The other case mentioned in the article was previously reported.    |
|22 February 03:00: 1 new case in Chiba Prefecture, Japan.                                                                     |
|21 February 23:52: 1 new case in Kumamoto Prefecture, Japan.                                                                  |
|21 February 19:50: 1 new case in Kumamoto Prefecture, Japan. The other case mentioned in the article was previously reported. |
|21 February 13:30: 1 new case in Kumamoto Prefecture, Japan.                                                                  |
|21 February 12:44: 2 new cases in Aichi Prefecture, Japan.                                                                    |
|21 February 11:45: 3 new cases in Tokyo, Japan.                                                                               |
|21 February 11:40: 1 new case in Chiba Prefecture, Japan.                                                                     |
|21 February 11:37: 1 new case in Ishikawa Prefecture, Japan.                                                                  |
|21 February 11:35: 1 new case in Saitama Prefecture, Japan.                                                                   |
|21 February 03:18: 3 new cases in Hokkaido Prefecture, Japan.                                                                 |
|20 February 14:21: 1 new case in Kanagawa Prefecture, Japan.                                                                  |
|20 February 13:43: 1 new case in Fukuoka Prefecture, Japan.                                                                   |
|20 February 11:00: 1 new case in Aichi Prefecture, Japan.                                                                     |
|20 February 09:38: 1 new case in Chiba Prefecture, Japan                                                                      |
|20 February 09:37: 1 new case in Kanagawa Prefecture, Japan.                                                                  |
|20 February 09:36: 1 new case in Okinawa Prefecture, Japan.                                                                   |
|20 February 09:35: 1 new case in Hokkaido Prefecture, Japan.                                                                  |
|20 February 06:15: 2 new cases in Japan.                                                                                      |
|20 February 02:31: 1 new case in Fukuoka Prefecture, Japan.                                                                   |
|19 February 12:25: 1 new case in Aichi Prefecture, Japan.                                                                     |
|19 February 11:45: 3 new cases in Tokyo, Japan.                                                                               |
|19 February 10:10: 1 new case in Japan.                                                                                       |
|19 February 09:10: 1 new case in Okinawa Prefecture, Japan.                                                                   |
|19 February 08:40: 1 new case in Hokkaido Prefecture, Japan.                                                                  |
|19 February 03:22: 1 new case in Hokkaido Prefecture, Japan.                                                                  |
|19 February 03:09: 2 new cases in Kanagawa Prefecture, Japan.                                                                 |
|18 February 13:10: 1 new case in Kanagawa Prefecture, Japan.                                                                  |
|18 February 12:03: 3 new cases in Wakayama Prefecture, Japan.                                                                 |
|18 February 12:02: 1 new case in Aichi Prefecture, Japan.                                                                     |
|18 February 12:01: 3 new cases in Tokyo, Japan.                                                                               |
|17 February 13:40: 1 new case in Japan.                                                                                       |
|17 February 07:14: 4 new cases in Wakayama Prefecture, Japan.                                                                 |
|17 February 02:51: 1 new case in Japan.                                                                                       |
|17 February 02:35: 1 new case in Japan.                                                                                       |


### Diamond Princess関係のTimeline
#### GMT グリニッジ標準時 UTC+0000とJST 日本標準時 UTC+0900時差は 9時間。

|x                                                                                                                                                                                                                                |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|22 February 13:10: 1 new case in Tochigi Prefecture, Japan. The patient is a former passenger of the “Diamond Princess” cruise ship.                                                                                           |
|20 February 11:25: 13 new cases in Japan. They were found on the “Diamond Princess” cruise ship off Yokohama, raising the ship’s total to 634.                                                                                |
|20 February 02:40: 2 new deaths in Japan. They were both passengers of the Diamond Princess cruise ship.                                                                                                                         |
|19 February 09:53: 79 new cases in Japan. They were found on the “Diamond Princess” cruise ship off Yokohama, raising the ship’s total to 621.                                                                                |
|18 February 10:00: 88 new cases in Japan. They were found on the “Diamond Princess” cruise ship off Yokohama, raising the ship’s total to 542.                                                                                |
|17 February 08:58: 85 new cases in Japan. They were found on the “Diamond Princess” cruise ship off Yokohama, raising the ship’s total to 454. The 14 other cases mentioned in the article (99 total) were reported at 06:55. |
|17 February 06:55: 14 new cases in Japan. They are Americans whose test results came in while they were being evacuated from the “Diamond Princess” cruise ship off Yokohama. This raises the ship’s total to 369.            |


## Rコード

```R
library(rvest)
# read_html() : 必要なHTMLを読み込み
html<-read_html("https://bnonews.com/index.php/2020/02/the-latest-coronavirus-cases/")
# html_nodes() : 必要なノードを取得
node1 <- html_nodes(html, "h4")
# html_text(), html_attr()など : 必要な情報を取得
text1<- html_text(node1)
date<- text1[grep("^[0-9]", text1)]
#date
node2<-html_nodes(html, "ul")
node2<-node2[grep("^<ul>\n<li>([0-9][0-9]:[0-9][0-9]|Total)",node2)]
y<- html_text(html_nodes(node2[1],"li"))
x<-list(c(date[1], y))
for (i in 2:length(date)){
  y<- html_text(html_nodes(node2[i],"li"))
  x<- c(x,list(c(date[i], y)))
}
#x
#Japanを含むニュース
jdat<-NULL
for ( i in 1:length(x)){
# 月日
dat<-unlist(x[[i]])
# Japan関係
y<-dat[grep("Japan",dat)]
jdat<-c(jdat,paste(dat[1],y))
}
jdat<-gsub("\\(Source\\)","",jdat)
# Diamond Princess関係とそれ以外
# Diamond Princess関係
DiPri<- jdat[grep("(Diamond Princess | cruise ship)",jdat)]
# それ以外(invert= T)
jpn<- jdat[grep("(Diamond Princess | cruise ship)",jdat,invert= T)]
#
knitr::kable(jpn,row.names =F)
#
knitr::kable(DiPri,row.names =F)
```

#### 古いtimeline(出力は下にあります)

```R
library("rvest")
# read_html() : 必要なHTMLを読み込み
html<-read_html("https://bnonews.com/index.php/2020/01/timeline-coronavirus-epidemic/")
# 以下は上と同じ
# html_nodes() : 必要なノードを取得
node1 <- html_nodes(html, "h4")
# html_text(), html_attr()など : 必要な情報を取得
text1<- html_text(node1)
date<- text1[grep("^[0-9]", text1)]
#date
node2<-html_nodes(html, "ul")
node2<-node2[grep("^<ul>\n<li>([0-9][0-9]:[0-9][0-9]|Total)",node2)]
y<- html_text(html_nodes(node2[1],"li"))
x<-list(c(date[1], y))
for (i in 2:length(date)){
  y<- html_text(html_nodes(node2[i],"li"))
  x<- c(x,list(c(date[i], y)))
}
#x
#Japanを含むニュース
jdat<-NULL
for ( i in 1:length(x)){
# 月日
dat<-unlist(x[[i]])
# Japan関係
y<-dat[grep("Japan",dat)]
jdat<-c(jdat,paste(dat[1],y))
}
jdat<-gsub("\\(Source\\)","",jdat)
# Diamond Princess関係とそれ以外
# Diamond Princess関係
DiPri<- jdat[grep("(Diamond Princess | cruise ship)",jdat)]
# それ以外(invert= T)
jpn<- jdat[grep("(Diamond Princess | cruise ship)",jdat,invert= T)]
#
knitr::kable(jpn,row.names =F)
#
knitr::kable(DiPri,row.names =F)
```

|x                                                                                                                        |
|:------------------------------------------------------------------------------------------------------------------------|
|16 February 10:29: 1 new case in Japan.                                                                                  |
|16 February 10:22: 5 new cases in Japan.                                                                                 |
|15 February 12:15: 1 new case in Japan.                                                                                  |
|15 February 09:05: 8 new cases in Japan.                                                                                 |
|15 February 07:03: 2 new cases in Japan. The third case in the article was previously reported.                          |
|15 February 03:18: 1 new case in Japan.                                                                                  |
|14 February 14:03: 1 new case in Japan.                                                                                  |
|14 February 14:00: 1 new case in Japan.                                                                                  |
|14 February 13:54: 1 new case in Japan.                                                                                  |
|14 February 13:50: 1 new case in Japan.                                                                                  |
|14 February 10:09: 2 new cases in Japan.                                                                                 |
|14 February 07:51: 1 new case in Japan.                                                                                  |
|14 February 00:43: 1 new case in Japan.                                                                                  |
|13 February 12:40: 1 new case in Japan.                                                                                  |
|13 February 11:55: 1 new case, a fatality, in Japan. This is the first death in Japan. (Source 1)                        |
|13 February 11:15: 1 new case in Japan.                                                                                  |
|13 February 09:05: 1 new case in Japan.                                                                                  |
|11 February 06:57: 2 new cases in Japan.                                                                                 |
|9 February 03:06: 1 new case in Japan.                                                                                   |
|6 February                                                                                                               |
|5 February 19:02: 1 new case in Japan.                                                                                   |
|5 February 19:01: 1 new case in Japan.                                                                                   |
|4 February 16:49: 1 new case in Japan.                                                                                   |
|4 February 14:01: 1 new case in Japan.                                                                                   |
|4 February 13:12: 1 new case in Japan.                                                                                   |
|3 February                                                                                                               |
|2 February                                                                                                               |
|1 February 14:51: 3 new cases in Japan.                                                                                  |
|31 January 20:02: 2 new asymptomatic cases in Japan.                                                                     |
|31 January 10:19: 1 new case in Japan.                                                                                   |
|30 January 13:40: 1 new case in Japan.                                                                                   |
|30 January 13:30: 1 new case in Japan.                                                                                   |
|30 January 12:36: 1 new case in Japan.                                                                                   |
|30 January 00:13: 3 new cases in Japan. Three people who were evacuated from Wuhan have tested positive for coronavirus. |
|29 January 14:01: 1 new case in Japan.                                                                                   |
|28 January 22:35: 1 new case in Japan.                                                                                   |
|28 January 09:06: 2 new cases in Japan. (Source 1, Source 2)                                                             |
|27 January                                                                                                               |
|26 January 10:55: 1 new case in Japan.                                                                                   |
|25 January 07:00: 1 new case in Japan.                                                                                   |
|24 January                                                                                                               |
|23 January 22:21: 1 new case in Japan.                                                                                   |
|22 January                                                                                                               |



|x                                                                                                                                                                                                                                    |
|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|16 February 01:35: 70 new cases in Japan. They were found on the “Diamond Princess” cruise ship off Yokohama, raising the ship’s total to 355.                                                                                    |
|15 February 08:47: 67 new cases in Japan. They were found on the “Diamond Princess” cruise ship off Yokohama, raising the ship’s total to 285.                                                                                    |
|13 February 03:10: 44 new cases in Japan. They were found on the “Diamond Princess” cruise ship off Yokohama, raising the ship’s total to 218.                                                                                    |
|12 February 02:53: 1 new case in Japan. It is one of the quarantine officers who was working on board the “Diamond Princess” cruise ship off Yokohama. This case is not included in the total for the ship’s passengers and crew. |
|11 February 23:55: 39 new cases in Japan. They were found on the “Diamond Princess” cruise ship off Yokohama, raising the ship’s total to 174.                                                                                    |
|10 February 05:13: 65 new cases in Japan. They were found on the “Diamond Princess” cruise ship off Yokohama, raising the ship’s total to 135.                                                                                    |
|9 February 07:18: 6 new cases in Japan. They were found on the “Diamond Princess” cruise ship off Yokohama, raising the ship’s total to 70.                                                                                       |
|8 February 00:32: 3 new cases in Japan. They were found on the “Diamond Princess” cruise ship off Yokohama, raising the ship’s total to 64.                                                                                       |
|7 February 00:39: 41 new cases in Japan. They were found on a cruise ship off Yokohama, raising the ship’s total to 61.                                                                                                             |
|5 February 23:49: 10 new cases in Japan. They were found on a cruise ship off Yokohama, raising the ship’s total to 20.                                                                                                             |
|4 February 23:14: 10 new cases in Japan. They were found on a cruise ship off Yokohama.                                                                                                                                              |

