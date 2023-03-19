---
title: astrometry.netとR その４(更新)
date: 2023-03-19
tags: ["R","sf","jpeg","showtext","astrometry.net"]
excerpt: Rを使って星野写真に星の名前や天体名を記入する(関数化)
---

# astrometry.netとR その４

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2Fastrometrynet04&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 
 
（作成したデータ）source関数で読み込むようにしました。 

2023-03-11 : サンプルデータを３つ追加(赤緯によって精度がどう変化するか？)

2023-03-19 : plotAstro.Rに春、夏、冬の大三角形を描く簡単な関数等を追加。 
 
1. ステラリウムのwesternをもとに作成した星座線データ。線の総数６７６本。  
[constellation_lineJ.R](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/constellation_lineJ.R)

2. [星の備忘録:星座名・星座線データ](https://star-records.blog.jp/constellation_line.txt) と
[Stellariumの日本風化](https://zawazawa.jp/Beyond/topic/15)をもとに作成した星座線データ。  
[constellation_lineJF.R](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/constellation_lineJF.R)  
- (参照) [astrometry.netとR（番外編：星座線](https://gitpress.io/@statrstart/Constellation01)  

3. [hip_majorJ.R](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/hip_majorJ.R)  
- 元データは[Astro Commonsさん](http://astro.starfree.jp/commons/index.html)
- いくつかの名称はネットで検索した。  

4. [messierPlusJ.R](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/messierPlusJ.R)  
- 元データは[Astro Commonsさん](http://astro.starfree.jp/commons/index.html)
- メシエ天体とその他必ず表示させたい天体（例：Flame Nebula）を記入する。 
- ファイルのPosition、Size、Offsetを調整することにより、ある程度文字の重なりを回避できる。

5. [NGC_lite.R](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/NGC_lite.R) 
- 元データは[opendatasoft:NGC/IC/Messier Catalog ](https://data.opendatasoft.com/explore/dataset/ngc-ic-messier-catalog%40datastro/table/?sort=m)
- 位置情報のないもの、必要ない項目は削った。位置が等しいデータは一つを残して項目Nameを空にした。

6. [boundaryline.R](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/boundaryline.R)  
- 元データは[IAU](https://www.iau.org/public/themes/constellations/)  

OS : ubuntu20.04  
R version 4.2.2 Patched (2022-11-10 r83330)  

(使用したカメラとレンズ)  

(カメラ) Nex-5   
(レンズ) 銘匠光学(TTArtisan) 17mm F1.4  (公開されたレンズプロファイルで補正[RawTherapee使用])
- [TTArtisan:DownloadCenter](https://ttartisan.com/?DownloadCenter/)
- [銘匠光学 TTArtisan 17mm F1.4 APS-C Correction File:https://ttartisan.com/static/upload/file/20220601/1654070780198089.rar](https://ttartisan.com/static/upload/file/20220601/1654070780198089.rar)

### プログラム本体 (plotAstro.R)
1. read.wcs : wcsファイルの必要なヘッダー部分だけ取り出す関数
2. inarea :  エリア内にあるデータだけを抽出する関数
3. rdsip2xy : 赤緯、赤経->画像xy(astrometry.netのsolve-fieldだけに適応したSIP補正)
4. xysip2rd : 画像xy->赤緯、赤経(astrometry.netのsolve-fieldだけに適応したSIP補正)
5. locator2 : locatorの出力をコピペしやすいようにコンマで区切って表示する関数
6. plotAstro : astrometry.netのsolve-fieldで得たwcsファイルを使って画像に星、天体等の名称、星座線等を引くための関数
7. plotAstroJ : plotAstro関数とほぼ同じ。ただ、星、天体等の名称を日本語で記入する。

### plotAstro関数

`plotAstro(image,starM=4,ngcM=14,Const="All",prn=1,el=12,boundary=FALSE,condata=FALSE)`

## (重要) あらかじめ入力するjpgファイル名、wcsファイル名を同じにすること。（例）ohoshisama.jpg 、ohoshisama.wcs 

- starM : 星名を表示する星の最も暗い視等級(但し、PrnがNAでない星は表示する)
- ngcM : NGC名を表示するNGCの最も暗いB.Mag
	- ngcM = 100 : NA も含めてすべて表示する場合
	- ngcM = 0 : 表示したくない場合
- Const : 星座線を表示する星座(略符)
	- Const = c("Cas","Cep","UMi") : 指定する場合 
	- Const = "" : 描かない場合 
	- Const = "All" : すべて（星座線の線分のどちらかに端が画像上にある）描く場合 
- prn : messierPlusJ.csv に記入している天体の名称の表示数 1 or 2 or 3
	- prn = 1 : 天体名（例"Andromeda Galaxy"）、2.メシエ番号、3.NGC等の番号　上位1つ
	- prn = 2 : 天体名（例"Andromeda Galaxy"）、2.メシエ番号、3.NGC等の番号　上位2つまで
	- prn = 3 : 天体名（例"Andromeda Galaxy"）、2.メシエ番号、3.NGC等の番号 上位3つまで
- el : 楕円を描くNGCの最も暗いB.Mag
- boundary : 星座境界線
	- boundary=FALSE : 星座境界線を描かない
	- boundary=TRUE : 星座境界線を描く
- condata : 星座線
	- condata=FALSE : 洋風
	- condata=TRUE : 和風

#### read.csv 関数　+ データ でデータを読み込むRコード

```R
url="https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/"
source(paste0(url,"constellation_lineJ.R"))
source(paste0(url,"constellation_lineJF.R"))
source(paste0(url,"hip_majorJ.R"))
source(paste0(url,"messierPlusJ.R"))
source(paste0(url,"boundaryline.R"))
source(paste0(url,"NGC_lite.R"))
```

#### write.csv で保存しておくと、データの追加、削除、変更がしやすい。

```R
# write.csv(hip_majorJ,file="hip_majorJ.csv",row.names=F)
# write.csv(messierPlusJ,file="messierPlusJ.csv",row.names=F)
# write.csv(NGC_lite,file="NGC_lite.csv",row.names=F)
# write.csv(constellation_lineJ,file="constellation_lineJ.csv",row.names=F)
# write.csv(constellation_lineJF,file="constellation_lineJF.csv",row.names=F)
# write.csv(boundaryline,file="boundaryline.csv",row.names=F)
######################## 必要なデータの読み込み(write.csv で保存した場合) ########################
#messierPlusJ<- read.csv(file = "messierPlusJ.csv")
#hip_majorJ<- read.csv(file = "hip_majorJ.csv")
#NGC_lite <- read.csv(file = "NGC_lite.csv")
#constellation_lineJ <- read.csv(file = "constellation_lineJ.csv")
#constellation_lineJF <- read.csv(file = "constellation_lineJF.csv")
#boundaryline<- read.csv(file = "boundaryline.csv")
```

#### プログラム本体 (plotAstro.R)

```R
require(jpeg)
require(sf)
source(paste0(url,"plotAstro.R"))
```

#### image009.jpg、image009.wcsを作業ディレクトリにダウンロード
（注意）もし、image009.jpg、image009.wcsがあるなら上書きします。

```R
download.file(paste0(url,"image009.jpg"),"image009.jpg",mode = "wb")
download.file(paste0(url,"image009.wcs"),"image009.wcs")
```

#### 元画像
![image009.jpg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/image009.jpg)

```R
# png("astro091.png",width=800,height=533)
plotAstro("image009")
# dev.off()
```

![astro091.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/astro091.png)

```R
# linuxの場合 : フォント変更
# png("astro092.png",width=800,height=533)
par(family="serif",font=4)
plotAstro(image="image009",condata=TRUE,boundary=TRUE)
# 北極星を丸で囲ってみる(locator関数で座標を得た方が簡単にできる)
hdr=read.wcs("image009.wcs")
stars=hip_majorJ[hip_majorJ$Name=="Polaris",]
pos=rdsip2xy(RA=stars$RA,Dec=stars$Dec,header=hdr)
points(x=pos[,1],y=pos[,2],pch=1,col="orange",cex=1.5)
# 北極星とアンドロメダ大銀河を線で結ぶ。
NGCs=messierPlusJ[messierPlusJ$Name=="M31",]
pos2=rdsip2xy(RA=NGCs$RA,Dec=NGCs$Dec,header=hdr)
segments(x0=pos[,1],y0=pos[,2],x1=pos2[,1],y1=pos2[,2],col="orange",lty=2)
# dev.off()
```

![astro092.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/astro092.png)

```R
# linuxの場合 : フォント変更
# 日本語を使う
# png("astro093.png",width=800,height=533)
par(family="Noto Serif CJK JP Black")
plotAstroJ(image="image009",starM=5,ngcM=0,el=5,condata=TRUE,boundary=TRUE)
# 星座名を書く座標を得る。（7箇所）
# xy<-locator2(7)
# 星座名を書く7箇所クリックすると、下のように表示される(上x座標、下y座標)
#[1] "111.45,83.4,239.21,595.07,373.82,737.17,289.69"
#[1] "221.3,344.74,312.94,59.85,366.55,471.28,453.21"
# 星座名記入
# locator2(7)の出力xyを使って、x=xy$x , y=xy$y とする場合は
# seiza<- data.frame(x=xy$x, y=xy$y ,name=c("Draco","Ursa Minor","Cepheus","Andromeda","Cassiopeia","Perseus","Camelopardalis"))
# 打ち出された値をコピペして使う場合は
seiza<- data.frame(x=c(111.45,83.4,239.21,595.07,373.82,737.17,289.69), y=c(221.3,344.74,312.94,59.85,366.55,471.28,453.21) ,
	name=paste0(c("りゅう","こぐま","ケフェウス","アンドロメダ","カシオペア","ペルセウス","きりん"),"座"))
text(x=seiza$x,y=seiza$y,labels=seiza$name ,col="red")
# dev.off()
```

![astro093.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/astro093.png)

```R
# showtext パッケージ
require(showtext)
## system font
font_add("NotoJ", "NotoSerifCJK-Bold.ttc")
# png("astro094.png",width=800,height=533)
par(family="NotoJ")
showtext_begin()
plotAstroJ(image="image009",starM=5,ngcM=0,el=5,condata=TRUE,boundary=TRUE)
# 打ち出された値をコピペ
seiza<- data.frame(x=c(111.45,83.4,239.21,595.07,373.82,737.17,289.69), y=c(221.3,344.74,312.94,59.85,366.55,471.28,453.21) ,
	name=paste0(c("りゅう","こぐま","ケフェウス","アンドロメダ","カシオペア","ペルセウス","きりん"),"座"))
text(x=seiza$x,y=seiza$y,labels=seiza$name ,col="red")
showtext_end()
# dev.off()
```

![astro094.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/astro094.png)

#### image17_1.jpg、image17_1.wcs, image17_2.jpg、image17_2.wcs, image17_3.jpg、image17_3.wcsを作業ディレクトリにダウンロード
（注意）同じ名前のデータがあったら上書きします。

#### astrometry.netのsolve-field

（注意） `-9 --uniformize 0` オプションを付けると速いが、最適なカタログが選択されない場合がある。

```
solve-field -u 'focalmm' -H 25 -z 2 -O image17_1.jpg
```

```R
download.file(paste0(url,"image17_1.jpg"),"image17_1.jpg",mode = "wb")
download.file(paste0(url,"image17_1.wcs"),"image17_1.wcs")
download.file(paste0(url,"image17_2.jpg"),"image17_2.jpg",mode = "wb")
download.file(paste0(url,"image17_2.wcs"),"image17_2.wcs")
download.file(paste0(url,"image17_3.jpg"),"image17_3.jpg",mode = "wb")
download.file(paste0(url,"image17_3.wcs"),"image17_3.wcs")
```

#### 元画像
![image17_1.jpg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/image17_1.jpg)

![image17_2.jpg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/image17_2.jpg)

![image17_3.jpg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/image17_3.jpg)

```R
file="image17_1"
#
# showtext パッケージ
require(showtext)
## system font
font_add("NotoJ", "NotoSerifCJK-Bold.ttc")
# png("astro%02d.png",width=1150,height=766)
par(family="NotoJ")
showtext_begin()
plotAstroJ(file,starM=4,ngcM=0,el=7,condata=TRUE,boundary=TRUE,Const="")
#「冬の大三角」
# オリオン座のベテルギウス（Betelgeuse)
# おおいぬ座のシリウス（Sirius）
# こいぬ座のプロキオン（Procyon）
# を線で結ぶ。
huyu3(file)
# locator2(3)
# [1] "237.76,192.05,789.33"
# [1] "210.02,694.98,430.18"
text(x=c(237.76,192.05,789.33),y=c(210.02,694.98,430.18),labels=paste0(c("こいぬ","おおいぬ","オリオン"),"座"),col="red")
showtext_end()
# dev.off()
#
# file="image17_2"
# file="image17_3"
# font_add("NotoJ", "NotoSerifCJK-Bold.ttc")
# png("astro%02d.png",width=1150,height=766)
# par(family="NotoJ")
# showtext_begin()
# plotAstroJ(file,starM=4,ngcM=0,el=7,condata=TRUE,boundary=TRUE)
# showtext_end()
# dev.off()
```

![astro17_1.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/astro17_1.png)

![astro17_2.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/astro17_2.png)

![astro17_3.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/astro17_3.png)

### 星景

#### 元画像

![image17_6.jpg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/image17_6.jpg)

#### プログラム実行後の出力画像の余分な線、文字をGimpを使って「黒」で消した画像

![astro17_6G.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/astro17_6G.png)

#### ２つの画像を比較明合成（Sirilを使った）

![astro17_6_2.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/astro17_6_2.png)
