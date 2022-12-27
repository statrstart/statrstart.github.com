---
title: astrometry.netとR（番外編：星座線）
date: 2022-12-27
tags: ["R","celestial","stellarium"]
excerpt: 星座線いろいろ
---

# astrometry.netとR（番外編：星座線）

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FConstellation01&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

作図するときに使う星や星座線や天体のデータを検索している際に以下の文章が目に止まりました。    
 
「国際天文学連合が1930年に発表した「星座の科学的区画法」では、88の星座が決められ、どこからどこまでが何座なのか、その境界線を定めています。
しかしながら、"星座の星の結び方に関しては、世界共通の決まりというのは、現在でも存在しません。"」  
	[星空ナビ：星座](https://www.astroarts.co.jp/products/hoshizora-navi/walk/201010/index-j.shtml)より抜粋。

「日本でよく見る」星座線は、天体写真家・作歌の藤井旭さんが自身の星座解説本のために作ったオリジナルな結び方、
業界でひそかに言われる「藤井結び」と呼ばれるものだったのです。つまり「日本風星座線」はガラパゴス的だったんですね。  
	[Stellariumの日本風化](https://zawazawa.jp/Beyond/topic/15)より抜粋。  

じゃあ、星座線データによって、どの星座がどのくらいちがうものかと思って検索してみても、見つかりません。  
というわけでRで図を作成してみました。  

なお、OS:Ubuntuです。Stellarium（ステラリウム）をインストールしました。  

星座線のデータは、`/usr/share/stellarium/skycultures`の各々のフォルダ中の「constellationship.fab」です。  
データの形式は、各星座線ごとに「星座名（略）、線の数、始点の星、終点の星、始点の星、終点の星、..... 」です。

western○○以外は星座線の数は少なく、天球にしめる範囲も狭いので除外します。  

#### とりあえず、作成した図。データ：ステラリウムのwestern

一応、両端の処理もしています。

![stella_W0.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/stella_W0.png)

でも、こういう図だと個々の星座の形がわかりにくいので星座線ごとに分けます。

### Stellarium（ステラリウム）

インストールしたStellariumのパージョンによって入っている星座線データが違うようです。  
western_SnT、western_reyには一部の星座線が一つの点でしかないものもあります。バグなのか本来そういうものなのかはわかりません。

#### ステラリウムのwestern(定番)

![stella_W.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/stella_W.png)

#### ステラリウムのwestern_hlad

![stella_Whlad.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/stella_Whlad.png)

#### ステラリウムのwestern_SnT

![stella_WSnT.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/stella_WSnT.png)

#### ステラリウムのwestern_rey

![stella_Wrey.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/stella_Wrey.png)

### ネット上で見つけた星座線のデータ

以下の４つのデータを見つけました。ありがたく使わせてもらいます。

[Astro Commons](http://astro.starfree.jp/commons/)   
[星空横丁](http://hoshizora.yokochou.com/star/)    
[星の備忘録:星座名・星座線データ](https://star-records.blog.jp/constellation_line.txt)   
[Stellariumの日本風化](https://zawazawa.jp/Beyond/topic/15)  

見ていただいたらわかりますが、  
- [Astro Commons](http://astro.starfree.jp/commons/)のデータは、ステラリウムのwesternとほとんど変わりません。  
- [星空横丁](http://hoshizora.yokochou.com/star/) のデータは、ステラリウムのwestern_SnTとほぼ同じですがwestern_SnTのように抜けたデータはありません。
- [星の備忘録:星座名・星座線データ](https://star-records.blog.jp/constellation_line.txt)  ,[Stellariumの日本風化](https://zawazawa.jp/Beyond/topic/15)は「日本風」。しかも、データ形式がステラリウムと同じなので一部ケアレスミスを修正するだけで同じ変換コードが使えます。

#### Astro Commons さん

![Con88_J1.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Con88_J1.png)

#### 星空横丁 さん

![Con88_J2.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Con88_J2.png)

#### 星の備忘録 さん

![Con88_J3.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Con88_J3.png)

#### Stellariumの日本風化 さん

![Con88_J4.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Con88_J4.png)

#### おまけ コードはなし(今回、彩りがないのでステラリウムのjapanese_moon_stations星座線を使った星座地図をのせときます)

もちろん、Ｒで作成しました。

![Japan28.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Japan28.png)

作成したjapanese_moon_stations星座線データ：[japanese_moon_stations.csv](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/japanese_moon_stations.csv)

### Rコード

Astro Commons さんと星空横丁 さんのは、サイトから必要なデータをダウンロードして、マージして、csvで保存。表計算ソフトで修正すればできますので省略。  

#### 使用するデータ

(注意)元データのある場所、保存場所は適当に変更してください。

[Constellation88.csv](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/Constellation88.csv) 

- 星座の位置は[星の備忘録:星座名・星座線データ「88星座名一覧」](https://star-records.blog.jp/cons_nameData.txt)のものを使わせていただきました。但し、
「へび」を1つに統合。位置は平均をとった。89 -> 88 

[hip.csv](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/hip.csv)  

- 元データは[Astro Commons : ヒッパルコス星表](http://astro.starfree.jp/commons/hip/)のhip_lite_a.csv、hip_lite_b.csvをつなげたもの。hip_lite.csv とした。  
celestial パッケージを使った。

[constellation_lineJ.csv](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/constellation_lineJ.csv)

- ステラリウムのwesternをもとに作成した星座線データ。線の総数６７６本。

#### hip.csv を作成した手順です。celestial パッケージを使いました。（一応、参考に）

```R
# hip.csv
require(celestial)
hip<- read.csv("~/Rwork/astrometry/hip_lite.csv",header=F)
hip$RA<- round(hms2deg(paste0(hip[,2],":",hip[,3],":",hip[,4])),6)
#赤緯：符号（0：- 1：+）
hugou <- ifelse(hip[,5]==0,"-", "+") # Dec の符号
hip$Dec<- round(dms2deg(paste0(hugou,hip[,6],":",hip[,7],":",hip[,8])),6)
# "HIP","RA","Dec","Mag"
hip<-hip[,c(1,10,11,9)]
write.csv(hip,file="~/Rwork/astrometry/hip.csv",row.names=F)
```

#### ステラリウム形式のデータを変換したコード

Ubuntuの場合、ステラリウムconstellationship.fab形式のデータは`/usr/share/stellarium/skycultures`にある各々のフォルダ中にある。  
星の備忘録さん、Stellariumの日本風化さんのデータはダウンロード（必要なら解凍）。一部ミスを訂正しておく。

変換したいデータの"#"をとって、readLines関数でまずデータを読み取る。

```R
### ステラリウム：constellationship.fab形式のデータを変換。
# ll<- readLines("/usr/share/stellarium/skycultures/western/constellationship.fab")
# ll<- readLines("/usr/share/stellarium/skycultures/western_hlad/constellationship.fab")
# ll<- readLines("/usr/share/stellarium/skycultures/western_SnT/constellationship.fab")
# ll<- readLines("/usr/share/stellarium/skycultures/western_rey/constellationship.fab")
#
# [星の備忘録:星座名・星座線データ](https://star-records.blog.jp/constellation_line.txt) 
# 一箇所訂正：Cen 26 -> Cen 25
# ll<- readLines("~/Downloads/constellation_line.txt") 
#
# [Stellariumの日本風化](https://zawazawa.jp/Beyond/topic/15)
# 訂正(コードの中で訂正するようにしてます。)：Cvn -> CVn ; Tra -> TrA
# ll<- readLines("~/Downloads/constellationship.fab") 
```

変換します。

1. readLines関数で読み取ったデータの不要な行をカット。
2. 一行を「星座名、始点星、終点星」といった形に分割していく。
3. 列名を変更したり、列順を変えたりしながら「hip.csv」「Constellation88.csv」とマージする。

```R
# "#"（コメントアウトのある行を削除）
ll<- ll[grep("#",ll,invert=T)]
# "."（.のある行を削除 : western_rey）
ll<- ll[grep("\\.",ll,invert=T)]
line<- NULL
# 88は星座の数。データに合わせて変更する。
for (i in 1:88){
	l<- read.table(text=ll[i])
	Con<- as.character(l[1])
# as.numericをつけないとint型になり扱いが面倒になる。matrix(as.numeric(.....
	line<- rbind(line,data.frame(Constellation=rep(Con,l[2]),matrix(as.numeric(l[3:ncol(l)]),ncol=2,byrow=T)) )
}
# 列名変更：X1-> HIP1 ; X2->HIP2
colnames(line)[2:3]<- c("HIP1","HIP2")
#
# hip.csvを読み込む
hip<- read.csv("~/Rwork/astrometry/hip.csv")
hip<- hip[,1:3]
cline<- merge(line,hip,by.x="HIP1",by.y="HIP",sort=F)
nrow(cline) ; nrow(line)
colnames(cline)[4:5]<- c("RA1","Dec1")  
#
cline<- merge(cline,hip,by.x="HIP2",by.y="HIP",sort=F)
nrow(cline) ; nrow(line)
colnames(cline)[6:7]<- c("RA2","Dec2")  
#
cline<-cline[,c(3:1,4:7)]
#
# ステラリウムのデータでCVnがCvn , TrAがTra になっているものがある。確認してあったら直す。
unique(cline$Constellation)
cline$Constellation[cline$Constellation=="Cvn"] <- "CVn"
cline$Constellation[cline$Constellation=="Tra"] <- "TrA"
unique(cline$Constellation)
# 星座情報データConstellation88.csvを読み込む
b<- read.csv("~/Rwork/astrometry/Constellation88.csv")
b<- b[,1:4]
# sort=TでConstellation順
res<- merge(cline,b,by="Constellation",sort=T)
nrow(cline) ; nrow(res)
res<- res[,c(8,1:7,9:10)]
# ファイル名は上書きし内容の適時変更する。
write.csv(res,file="~/Rwork/astrometry/constellation_lineJ.csv",row.names=F)
```

#### 全体図

```R
name<- read.csv("./astrometry/Constellation88.csv")
ll<-read.csv("./astrometry/constellation_lineJ.csv")
# nrow(ll)
# 0度またぎ線
ll0 <- ll[abs(ll$RA1-ll$RA2)>300,]
# 0度またがない線
ll <- ll[abs(ll$RA1-ll$RA2)<=300,]
RA_lim  <- c(0,360)
DEC_lim <- c(-90,90)
#png("stella_W0.png",width=800,height=600)
plot(NA,type="n",xlim=RA_lim,ylim=DEC_lim,xaxs="i",yaxs="i",las=1,xlab="",ylab="")
segments(ll$RA1,ll$Dec1,ll$RA2,ll$Dec2,col="red")
# 0度またぎ線(ダミーの点を作ってその点と結ぶ)
for (i in 1:nrow(ll0)){
	if (ll0$RA1[i]>ll0$RA2[i]){ # RA1__360 , 0__RA2
		segments(ll0$RA1[i],ll0$Dec1[i],ll0$RA2[i]+360,ll0$Dec2[i],col="red")
		segments(ll0$RA1[i]-360,ll0$Dec1[i],ll0$RA2[i],ll0$Dec2[i],col="red")
	}else{ # 0__RA1 , RA2__360
		segments(ll0$RA1[i],ll0$Dec1[i],ll0$RA2[i]-360,ll0$Dec2[i],col="red")
		segments(ll0$RA1[i]+360,ll0$Dec1[i],ll0$RA2[i],ll0$Dec2[i],col="red")
	}
}
text(x=name$RA, y=name$Dec,labels= name$NameJ,xpd=T)
#dev.off()
```

#### 星座分割図

```R
name<- read.csv("./astrometry/Constellation88.csv")
#
Constellation <-c("And","Ant","Aps","Aql","Aqr","Ara","Ari","Aur","Boo","Cae","Cam","Cap","Car",
	"Cas","Cen","Cep","Cet","Cha","Cir","CMa","CMi","Cnc","Col","Com","CrA","CrB","Crt","Cru",
	"Crv","CVn","Cyg","Del","Dor","Dra","Equ","Eri","For","Gem","Gru","Her","Hor","Hya","Hyi",
	"Ind","Lac","Leo","Lep","Lib","LMi","Lup","Lyn","Lyr","Men","Mic","Mon","Mus","Nor","Oct",
	"Oph","Ori","Pav","Peg","Per","Phe","Pic","PsA","Psc","Pup","Pyx","Ret","Scl","Sco","Sct",
	"Ser","Sex","Sge","Sgr","Tau","Tel","TrA","Tri","Tuc","UMa","UMi","Vel","Vir","Vol","Vul")

ll<-read.csv("./astrometry/constellation_lineJ.csv")
#
#png("stella_W.png",width=1100,height=800)
par(mfrow=c(8,11),mar=c(0,0,2,0))
for (num in 1:88){
	if (is.element(num,c(1,62,67,71,82)) ){
		l<- ll[ll$No %in% num,]
		l$RA1[l$RA1>325] <- l$RA1[l$RA1>325] - 360
		l$RA2[l$RA2>325] <- l$RA2[l$RA2>325] - 360
		xmin<- min(l$RA1,l$RA2)
		xmax<- max(l$RA1,l$RA2)
		ymin<- min(l$Dec1,l$Dec2)
		ymax<- max(l$Dec1,l$Dec2)
	} else{
		l<- ll[ll$No %in% num,]
		xmin<- min(l$RA1,l$RA2)
		xmax<- max(l$RA1,l$RA2)
		ymin<- min(l$Dec1,l$Dec2)
		ymax<- max(l$Dec1,l$Dec2)
	}
plot(NA,type="n",xlim=c(xmin,xmax),ylim=c(ymin,ymax),xaxs="i",yaxs="i",las=1,xlab="",ylab="",xaxt="n",yaxt="n")
segments(l$RA1,l$Dec1,l$RA2,l$Dec2,lwd=1.5,col="navyblue")
title(paste0(name$NameJ[num],"座") )
}
#dev.off()
```
