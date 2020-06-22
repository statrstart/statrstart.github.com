---
title: 東京都の超過死亡(東京都のデータとインフルエンザ関連死亡迅速把握システム)
date: 2020-06-22
tags: ["R","超過死亡"]
excerpt: 東京都のデータとインフルエンザ関連死亡迅速把握システム
---

# 超過死亡(東京都のデータとインフルエンザ関連死亡迅速把握システム)

![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2Ftyouka01)  

(参考)  
[東京の４月死亡者数は例年に比べ１割増、新型コロナの超過死亡を示唆](https://www.bloomberg.co.jp/news/articles/2020-06-11/QBQYBXDWLU6901)   
[【日本】4月の自殺者数は大幅減少で過去5年で最少。自宅生活が奏功か。厚生労働省発表 2020/05/14](https://sustainablejapan.jp/2020/05/14/japan-suicide/49463)  

[コロナ感染死、把握漏れも「超過死亡」200人以上か 東京23区2～3月　必要な統計公表遅く、対策左右も 2020/5/24](https://www.nikkei.com/article/DGXMZO59508030U0A520C2NN1000/)   
＊ では、他の都市の「超過死亡」はどうなっているのか比較してみます。 

[反PCR検査拡充派の間で広まる医師ブログの不自然なデータ引用。「日本に超過死亡はない」の嘘 2020.05.16](https://hbol.jp/219193?cx_clicks_art_mdl=3_title)  
[「超過死亡グラフ改竄」疑惑に、国立感染研は誠実に答えよ！](https://webronza.asahi.com/politics/articles/2020052600001.html)  

[インフルエンザ関連死亡迅速把握システムについてのQ＆A](https://www.niid.go.jp/niid/ja/from-idsc/9627-jinsoku-qa.html)  

(使用したデータ)  
東京都発表のデータ（Rコード参照）  
[インフルエンザ関連死亡迅速把握システム ](https://www.niid.go.jp/niid/ja/flu-m/2112-idsc/jinsoku/)  
各都市のグラフ上部のコメント欄より作成した。

(注意)  
- 東京都発表のエクセルデータをコピペしてデータセットを作成(間違いがある可能性があります。)
- インフルエンザ関連死亡迅速把握システム2020/5/26のデータ（グラフ）で作成。(手入力しているので間違いがある可能性があります。)

#### 東京都 １〜４月の死者数（２０１５年〜２０２０年 : データ 東京都）

![TKtyouka01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/TKtyouka01.png)
- 上記の記事の通り、2020年の４月の死亡者数が例年に比べて多いのがわかります。
- 「4月の自殺者数は大幅減少で過去5年で最少。」ですのでそれを加味するとさらに例年より多くなります。

#### ２０２０年４月の死者数が過去５年間の４月の平均死者数をどのくらい上回っているか

![TKtyouka02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/TKtyouka02.png)

![TKtyouka03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/TKtyouka03.png)

#### 塗り分け地図(Rコードは省略)
（参考）[シェープファイルを読む](https://oku.edu.mie-u.ac.jp/~okumura/stat/shape.html)  

![TKmap01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/TKmap01.png)

![TKmap02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/TKmap02.png)

##### 島嶼部を除く全体。区市町村名の表示なし  
国土数値情報の「行政区域」の東京都データから作成したGeoJSON形式のデータをgithubに置いときました。

![TKmap03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/TKmap03.png)

#### 東京都 １〜４月の死者数（２０１１年〜２０２０年）
２０１１年からのデータがまだネット上にあったので作ってみました。  
２０２０年４月の値が上に乖離しているのがより鮮明になりました。

![TKtyouka01_2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/TKtyouka01_2.png)

#### 東京都 年別４月の超過死亡数(過去５年平均と比較して)（２０１６年〜２０２０年 : データ 東京都）

![TKtyouka01_3](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/TKtyouka01_3.png)

#### グラフ(インフルエンザ関連死亡迅速把握システムのデータ)

![cdeath01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/cdeath01.png)

### Rコード

#### データをダウンロード

```R
#year<- seq(2011,2020)
year<- seq(2015,2020)
month<- 2:5
for (i in year){
	for (j in month){
		url<- paste0("https://www.toukei.metro.tokyo.lg.jp/jsuikei/",i,"/js",substring(i,3,4),j,"a0000.xls")
		download.file(url, destfile= paste0("js",substring(i,3,4),j,"a0000.xls"))
	}
}
```

１シートに複数の表がのっているので、関数を使うのが面倒なのでコピペでデータセットを作成した。

#### 東京都 １〜４月の死者数（２０１５年〜２０２０年 : データ 東京都）

```R
text<-"2015,2016,2017,2018,2019,2020
1月,13116,10964,12418,12696,12995,12697
2月,9679,10318,10207,10960,10924,9715
3月,9879,10277,10400,10535,10266,10694
4月,9040,8779,9118,8891,9418,10107"
#
tokyo<- read.csv(text=text,check.names=F)
# png("TKtyouka01.png",width=800,height=600)
par(mar=c(4,6,4,5),family="serif")
matplot(tokyo,type="o",pch=16,lty=1,lwd=2,las=1,xlab="",ylab="",xaxt="n",yaxt="n",bty="n")
box(bty="l",lwd=2.5)
axis(1,at=1:nrow(tokyo),labels= rownames(tokyo))
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
text(x=nrow(tokyo),y=tokyo[4,],labels=colnames(tokyo),pos=4,xpd=T)
title("東京都 １〜４月の死者数（２０１５年〜２０２０年 : データ 東京都）",cex.main=1.5)
# dev.off()
```

#### 東京都 １〜４月の死者数（２０１１年〜２０２０年 : データ 東京都）

```R
text<-"2011,2012,2013,2014,2015,2016,2017,2018,2019,2020
1月,11007,11319,12208,12123,13116,10964,12418,12696,12995,12697
2月,8850,9967,9823,9519,9679,10318,10207,10960,10924,9715
3月,9490,9582,9290,9642,9879,10277,10400,10535,10266,10694
4月,8370,8431,9310,9404,9040,8779,9118,8891,9418,10107"
#
tokyo<- read.csv(text=text,check.names=F)
# png("TKtyouka01_2.png",width=800,height=600)
par(mar=c(4,6,4,5),family="serif")
matplot(tokyo[,-ncol(tokyo)],type="o",pch=15,lty=1,lwd=1,col=rainbow(ncol(tokyo)-1,alpha=0.8),
	las=1,xlab="",ylab="",xaxt="n",yaxt="n",bty="n")
lines(tokyo[,ncol(tokyo)],col="black",lwd=2)
points(tokyo[,ncol(tokyo)],col="black",pch=16)
box(bty="l",lwd=2.5)
axis(1,at=1:nrow(tokyo),labels= rownames(tokyo))
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
text(x=nrow(tokyo),y=tokyo[4,],labels=colnames(tokyo),pos=4,xpd=T)
title("東京都 １〜４月の死者数（２０１１年〜２０２０年 : データ 東京都）",cex.main=1.5)
# dev.off()
```

#### 東京都 年別４月の超過死亡数(過去５年平均と比較して)（２０１６年〜２０２０年 : データ 東京都）

```R
month<- 4
df<- NULL
for (i in 6:10){
	df<- c(df,round(tokyo[month,i]-mean(as.numeric(tokyo[month,(i-5):(i-1)]),0)))
}
names(df)<- seq(2016,2020)
col<- ifelse(df>=0,"pink","lightblue")
pos<- ifelse(df>=0,3,1)
min<- ifelse(min(df)<0,min(df)*1.2,0)
# png("TKtyouka01_3.png",width=800,height=600)
par(mar=c(4,6,4,5),family="serif")
b<- barplot(df,las=1,yaxt="n",ylim=c(min,max(df)*1.2),col=col)
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
abline(h=0,lwd=1)
text(x=b,y=df,labels=df,pos=pos)
title(paste0("東京都 ",month,"月の超過死亡数(過去５年平均と比較して)（２０１６年〜２０２０年）"),cex.main=1.5)
# dev.off()
```

#### ２０２０年４月の死者数が過去５年間の４月の平均死者数をどのくらい上回っているか

```R
# 東京４月の区市町村別死者数(２０１５年〜２０２０年)
text<- "2015,2016,2017,2018,2019,2020
総数,9040,8779,9118,8891,9418,10107
区部,6190,6066,6221,6027,6310,6783
千代田区,28,38,27,27,45,31
中央区,77,59,71,69,69,72
港区,126,121,91,131,116,132
新宿区,207,214,220,196,221,247
文京区,117,150,122,118,142,131
台東区,168,163,134,137,156,158
墨田区,201,200,202,199,211,230
江東区,331,321,320,291,322,358
品川区,243,248,259,241,252,270
目黒区,179,143,142,136,181,172
大田区,511,506,479,474,482,539
世田谷区,515,489,541,570,496,589
渋谷区,126,126,137,115,109,125
中野区,203,214,223,206,205,243
杉並区,366,356,357,319,376,353
豊島区,186,176,191,187,186,176
北区,271,281,284,293,265,294
荒川区,161,163,156,153,173,175
板橋区,358,330,426,373,363,439
練馬区,427,429,462,489,494,565
足立区,583,557,546,518,576,593
葛飾区,357,354,351,337,386,395
江戸川区,449,428,480,448,484,496
市部,2747,2627,2786,2767,2999,3204
八王子市,386,357,388,389,449,443
立川市,119,121,123,139,134,161
武蔵野市,95,71,65,86,87,99
三鷹市,98,94,120,109,122,143
青梅市,134,125,109,134,121,143
府中市,125,151,155,153,183,160
昭島市,83,65,92,78,89,96
調布市,131,137,120,142,162,156
町田市,285,258,292,296,321,325
小金井市,79,65,73,54,69,82
小平市,113,123,129,110,106,153
日野市,122,104,113,110,123,126
東村山市,108,104,116,139,119,146
国分寺市,83,84,80,63,70,99
国立市,44,43,39,45,48,54
福生市,39,54,59,57,47,43
狛江市,60,48,53,54,65,74
東大和市,60,61,64,64,66,66
清瀬市,55,66,55,59,63,68
東久留米市,96,83,71,86,88,102
武蔵村山市,63,50,51,43,53,68
多摩市,105,74,98,88,100,111
稲城市,50,48,49,44,52,51
羽村市,39,35,43,42,43,36
あきる野市,54,70,85,58,79,63
西東京市,121,136,144,125,140,136
町村部,103,86,111,97,109,120
郡部,74,62,78,70,72,81
瑞穂町,30,17,27,32,31,23
日の出町,31,29,28,23,23,29
檜原村,4,2,5,5,8,12
奥多摩町,9,14,18,10,10,17
島部,29,24,33,27,37,39
大島支庁,13,14,20,13,21,14
大島町,9,9,14,12,11,8
利島村,NA,NA,NA,1,NA,1
新島村,4,2,2,NA,4,3
神津島村,NA,3,4,NA,6,2
三宅支庁,3,1,2,4,7,9
三宅村,3,1,2,4,7,9
御蔵島村,NA,NA,NA,NA,NA,NA
八丈支庁,13,9,11,9,8,13
八丈町,13,9,11,9,8,13
青ヶ島村,NA,NA,NA,NA,NA,NA
小笠原支庁,NA,NA,NA,1,1,3
小笠原村,NA,NA,NA,1,1,3"
#
tokyo<- read.csv(text=text,check.names=F)
# 東京２３区
# 2020/2015_2019平均*100
df<- (round(tokyo[3:25,ncol(tokyo)]/rowMeans(tokyo[3:25,1:(ncol(tokyo)-1)],na.rm=T),3)-1)*100
df<- df[order(df)]
df<- c(df,(round(tokyo[2,ncol(tokyo)]/rowMeans(tokyo[2,1:(ncol(tokyo)-1)],na.rm=T),3)-1)*100)
# png("TKtyouka02.png",width=800,height=600)
par(mar=c(4,6,4,3),family="serif")
b<- barplot(df,las=1,horiz=T,col=c(rep("pink",23),"lightblue"),xlim=c(min(df),max(df)*1.1))
axis(1,at=max(df)*1.1,labels="(%)",tick=F,hadj= -0.5)
axis(2,at=b,labels=NA)
title("２０２０年４月の死者数が過去５年間の４月の平均死者数をどのくらい上回っているか(%)\n（東京２３区 : データ 東京都）")
# dev.off()
#
# 東京 市部
# 2020/2015_2019平均*100
df<- (round(tokyo[27:52,ncol(tokyo)]/rowMeans(tokyo[27:52,1:(ncol(tokyo)-1)],na.rm=T),3)-1)*100
df<- df[order(df)]
df<- c(df,(round(tokyo[26,ncol(tokyo)]/rowMeans(tokyo[26,1:(ncol(tokyo)-1)],na.rm=T),3)-1)*100)
# png("TKtyouka03.png",width=800,height=600)
par(mar=c(4,6,4,3),family="serif")
b<- barplot(df,las=1,horiz=T,col=c(rep("pink",26),"lightblue"),xlim=c(min(df),max(df)*1.1))
axis(1,at=max(df)*1.1,labels="(%)",tick=F,hadj= 0)
axis(2,at=b,labels=NA)
title("２０２０年４月の死者数が過去５年間の４月の平均死者数をどのくらい上回っているか(%)\n（東京 市部 : データ 東京都）")
# dev.off()
```

#### グラフ(インフルエンザ関連死亡迅速把握システムのデータ)
##### 超過死亡あり-> 1 ,超過死亡なし-> 0 ,報告なし-> NA

```R
# 超過死亡あり-> 1 ,超過死亡なし-> 0 ,報告なし-> NA
川崎<- c(NA,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
京都<- c(NA,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NA)
大坂<- c(NA,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
広島<- c(NA,0,0,0,0,0,0,0,0,0,0,0,0,0,NA,NA,NA,NA,NA)
北九州<- c(NA,0,0,0,0,0,0,0,0,0,0,NA,NA,NA,NA,NA,NA,NA,NA)
福岡<- c(NA,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
静岡<- c(NA,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
堺<- c(NA,0,0,0,0,0,0,0,0,0,0,0,0,0,NA,NA,NA,NA,NA)
浜松<- c(NA,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NA)
岡山<- c(NA,0,0,0,0,0,0,0,0,0,0,0,0,0,NA,NA,NA,NA,NA)
千葉<- c(NA,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
さいたま<- c(NA,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
仙台<- c(NA,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0)
名古屋<- c(NA,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0)
熊本<- c(NA,0,0,1,0,0,0,0,0,0,0,1,0,1,1,0,0,1,0)
東京<- c(NA,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0)
大都市の合計<- c(NA,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
# 報告なし
 札幌<- c(NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA)
 神戸<- c(NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA)
 新潟<- c(NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA)
 相模原<- c(NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA)
week<- c("48","49","50","51","52","1","2","3","4","5","6","7","8","9","10","11","12","13","14")
z<- data.frame(札幌,神戸,新潟,相模原,川崎,京都,大坂,広島,北九州,福岡,静岡,堺,浜松,岡山,千葉,さいたま,仙台,名古屋,熊本,東京,大都市の合計,
	check.names=F)
rownames(z)<- week
#
z<- t(z)
nr <- nrow(z)
nc <- ncol(z)
#image(t(z))
#png("cdeath01.png",width=800,height=600)
par(mar=c(4,8,6,10),family="serif")
plot(x=c(0,nc),y=c(0,nr), type="n",axes = F, xaxs = "i",yaxs="i",xlab="",ylab="")
abline(h=seq(1,nr))
abline(v=seq(1,nc))
box()
for (i in 1:nc){
	for (j in 1:nr){
		if (!is.na(z[j,i])){
			if (z[j,i]==1){
				rect(xleft=i-1, ybottom=j-1, xright=i, ytop=j,col ="red")
			}
			if (z[j,i]==0){
				rect(xleft=i-1, ybottom=j-1, xright=i, ytop=j,col ="lightblue")
			}
		}
		if (is.na(z[j,i])){
			rect(xleft=i-1, ybottom=j-1, xright=i, ytop=j,col ="lightgray")
		}			
	}
}
axis(3,at=seq(0.5,nc-0.5,1),labels=colnames(z),tck= -0.005,padj=1)
axis(3,at=c(0.5,5.5),labels=c("2019","2020"),tick=F,padj= -0.5,hadj= 0.8)
axis(3,at=nc,labels="(週)",tick=F,padj= -0.5,hadj= 0.8)
axis(2,at=seq(0.5,nr-0.5,1),labels=rownames(z),las=1,tck= -0.01)
legend("topright",inset=c(-0.22,0.03),pch=15,col=c("red","lightblue","lightgray"),
	legend=c("超過死亡あり","超過死亡なし","報告なし"),xpd=T,bty="n",cex=1.2)
title("超過死亡の状況(2019年48週から2020年14週)")
mtext("Data:[インフルエンザ関連死亡迅速把握システム ](https://www.niid.go.jp/niid/ja/flu-m/2112-idsc/jinsoku/) ",
	side=1,adj=1,padj= 1)
#dev.off()
```

##### 島嶼部を除く全体。区市町村名の表示あり
国土数値情報の「行政区域」の東京都データから作成したGeoJSON形式のデータを読み込んで使います。

```R
library(sf)
map<- st_read("https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/tokyo.geojson", 
	stringsAsFactors=FALSE)
#
# 東京４月の区市町村別死者数(２０１５年～２０２０年)
text<- "2015,2016,2017,2018,2019,2020
千代田区,28,38,27,27,45,31
中央区,77,59,71,69,69,72
港区,126,121,91,131,116,132
新宿区,207,214,220,196,221,247
文京区,117,150,122,118,142,131
台東区,168,163,134,137,156,158
墨田区,201,200,202,199,211,230
江東区,331,321,320,291,322,358
品川区,243,248,259,241,252,270
目黒区,179,143,142,136,181,172
大田区,511,506,479,474,482,539
世田谷区,515,489,541,570,496,589
渋谷区,126,126,137,115,109,125
中野区,203,214,223,206,205,243
杉並区,366,356,357,319,376,353
豊島区,186,176,191,187,186,176
北区,271,281,284,293,265,294
荒川区,161,163,156,153,173,175
板橋区,358,330,426,373,363,439
練馬区,427,429,462,489,494,565
足立区,583,557,546,518,576,593
葛飾区,357,354,351,337,386,395
江戸川区,449,428,480,448,484,496
八王子市,386,357,388,389,449,443
立川市,119,121,123,139,134,161
武蔵野市,95,71,65,86,87,99
三鷹市,98,94,120,109,122,143
青梅市,134,125,109,134,121,143
府中市,125,151,155,153,183,160
昭島市,83,65,92,78,89,96
調布市,131,137,120,142,162,156
町田市,285,258,292,296,321,325
小金井市,79,65,73,54,69,82
小平市,113,123,129,110,106,153
日野市,122,104,113,110,123,126
東村山市,108,104,116,139,119,146
国分寺市,83,84,80,63,70,99
国立市,44,43,39,45,48,54
福生市,39,54,59,57,47,43
狛江市,60,48,53,54,65,74
東大和市,60,61,64,64,66,66
清瀬市,55,66,55,59,63,68
東久留米市,96,83,71,86,88,102
武蔵村山市,63,50,51,43,53,68
多摩市,105,74,98,88,100,111
稲城市,50,48,49,44,52,51
羽村市,39,35,43,42,43,36
あきる野市,54,70,85,58,79,63
西東京市,121,136,144,125,140,136
瑞穂町,30,17,27,32,31,23
日の出町,31,29,28,23,23,29
檜原村,4,2,5,5,8,12
奥多摩町,9,14,18,10,10,17
大島町,9,9,14,12,11,8
利島村,NA,NA,NA,1,NA,1
新島村,4,2,2,NA,4,3
神津島村,NA,3,4,NA,6,2
三宅村,3,1,2,4,7,9
御蔵島村,NA,NA,NA,NA,NA,NA
八丈町,13,9,11,9,8,13
青ヶ島村,NA,NA,NA,NA,NA,NA
小笠原村,NA,NA,NA,1,1,3"
#
tokyo<- read.csv(text=text,check.names=F)
# 2020/2015_2019平均*100
df<- round((tokyo[1:53,ncol(tokyo)]/rowMeans(tokyo[1:53,1:(ncol(tokyo)-1)],na.rm=T)-1)*100,1)
# 並び順が一致しているか確認
all(names(df)== map[1:53,]$city)
dat<- as.numeric(df)
brk<- c(-16.5,-10,-5,0,seq(1,30,2),40,150) 
# legendのlabelを作成
labels<- as.vector(cut(brk[1:length(brk)-1],breaks=brk,include.lowest=T,right =F, dig.lab=5))
# 塗りつぶしに使うカラーパレット：rev関数で　白->赤
color<- c(rgb(0,0,1,0.7),rgb(0,0,1,0.3),"lightblue",rev(heat.colors(length(brk)-4)))
cols<-as.vector(cut(dat, breaks=brk,labels =color,include.lowest=T,right =F))
# png("TKmap03.png",width=860,height=600)
par(mar=c(0,0,4,0),family="serif")
plot(st_geometry(map[1:53,]),col=cols)
c=st_centroid(st_geometry(map[1:53,]))
text(st_coordinates(c),paste0(map[1:53,]$city,"\n",dat,"%"))
#text(st_coordinates(c),paste0(dat,"%"))
legend(x=138.93,y=35.65,legend=labels, fill=color,title ="上回り率(%)",ncol=2)
title("２０２０年４月の死者数が過去５年間の４月の平均死者数をどのくらい上回っているか(%)\n東京都（島嶼部を除く）")
# dev.off()
```
