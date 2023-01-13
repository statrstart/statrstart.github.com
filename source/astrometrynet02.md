---
title: astrometry.netとR その２
date: 2023-01-12
tags: ["R","sf","celestial","showtext","astrometry.net"]
excerpt: Rを使って星野写真に星の名前や天体名を記入する
---

# astrometry.netとR その２

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2Fastrometrynet02&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

## (2023-01-12)inarea 関数訂正。`RA`とすべきところを`"RA"`としていました。

astrometry.netを使って得たwcsファイルとRを使って星野写真に星の名前や天体名を記入する方法の自分のための備忘録です。  
こちらのpythonプログラム[Galaxy Annotator v0.9](https://github.com/rnanba/GalaxyAnnotator#readme)を見て、Rでもやってみました。 
 
（特徴）  
1. 星、メシエ天体、DSO、星座線のデータをパソコン内に持つ（あらかじめダウンロードする）。
2. 上記ファイルはcsvファイルなので編集しやすい。
3. 名前を記入する天体を視等級等で選択できる。
4. フォントを選べる。（showtext パッケージを使う。）
5. 星座名を表示したいときはlocator 関数を使い位置を決める。(やり方は調べてください。)
6. 星座線を変更したり、天体の種類(銀河、星雲、星団など)によって文字色を変えるとかもプログラムに手を加えればできる。

（作成したデータ）詳しくはデータ自体をみてください。 
 
1. ステラリウムのwesternをもとに作成した星座線データ。線の総数６７６本。  
[constellation_lineJ.csv](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/constellation_lineJ.csv)
- (参照) [astrometry.netとR（番外編：星座線](https://gitpress.io/@statrstart/Constellation01)  

2. [hip_majorJ.csv](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/hip_majorJ.csv)  
- 元データは[Astro Commonsさん](http://astro.starfree.jp/commons/index.html)
- いくつかの名称はネットで検索した。  

3. [messierPlusJ.csv](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/messierPlusJ.csv)  
- 元データは[Astro Commonsさん](http://astro.starfree.jp/commons/index.html)
- メシエ天体とその他必ず表示させたい天体（例：Flame Nebula）を記入する。 
- ファイルのPosition、Size、Offsetを調整することにより、ある程度文字の重なりを回避できる。

4. [NGC_lite.csv](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/NGC_lite.csv) 
- 元データは[OpenNGC](https://github.com/mattiaverga/OpenNGC)
- 位置情報のないもの、必要ない項目は削った。

OS : ubuntu20.04

(参考)  
1. astrometry.netのインストール  
[Building/installing the Astrometry.net code](http://astrometry.net/doc/build.html#build)    
[astrometry.netを入れ直す](https://nekomeshi312.livedoor.blog/archives/7704100.html)  
2. SIP ("Simple Imaging Polynomial") について   
[The SIP Convention for Representing Distortion in FITS Image Headers](https://irsa.ipac.caltech.edu/data/SPITZER/docs/files/spitzer/shupeADASS.pdf)
- AP_p_q、BP_p_qはWCSファイルに記述されているので`celestial::radec2xy`の出力にこの論文の(5)(6)式の処理をするだけでよい。

（サンプル画像について）  
- カメラ : PENTAX K-S1 + アストロトレーサー2  
- レンズ : RICOH XR RIKENON 50mm F2 S (35mm換算 : 75mm)  
- 使用したソフト : Siril , Raw Therapee で処理 -> 800 * 534 にリサイズ  

（注意）  
35mm換算:75mmより広角になると、当然、ラベル等のズレが大きくなります。  
実際、Nex-5 で17mmレンズを使った写真ではかなりのズレがでました。  

### 例１ 

#### 元画像

![image002.jpg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/image002.jpg)

#### celestial::radec2xy のみ

![astro02N.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/astro02N.png)

#### celestial::radec2xy + 自作 sip補正プログラム

![astro02Y.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/astro02Y.png)

### 例２ 

#### 元画像

![image001.jpg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/image001.jpg)

#### celestial::radec2xy のみ

![astro01N.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/astro01N.png)

#### celestial::radec2xy + 自作 sip補正プログラム

![astro01Y.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/astro01Y.png)

#### celestial::radec2xy + 自作 sip補正プログラム(銀河に楕円、日本語)

![astro01YeJ.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/astro01YeJ.png)

### Rコード

楕円を描く部分は一番下に載せておきます。（35mm換算75mmより望遠側で、sip補正したときには使えそうな気がします。）

#### 準備

- 画像ファイルはファイル名.jpg、WCSファイルはファイル名.wcs。この２つのファイル名は同じにすること
- 「作成したデータ」のところで説明した４つのデータをダウンロードしておく。
- 以下のプログラムでは、画像ファイルとWCSファイルは作業フォルダ、「作成したデータ」４つは作業フォルダ内のastrometryフォルダにおいている。

##### WCS ファイル（元画像は上で表示している）

[image001.wcs](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/image001.wcs)  
[image002.wcs](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/image002.wcs)

#### 自作プログラムの定義（３つ）

##### wcsファイルの必要なヘッダー部分だけ取り出す関数

```R
read.wcs=function(file){
	fcon = file(file, "rb")
# 80文字で一つのバラメータ(50あればよいが、10余分にとった)
	ll<-readChar(fcon, 80*60)
	close(fcon)
# 最初のHISTORY以降は削除
	ll<- gsub("HISTORY.*","",ll)
	key = NULL ; value = NULL
	for(i in 1:(nchar(ll)/80)){
		row = substr(ll,((80*(i-1))+1),(80*i))
		k = paste(strsplit(substr(row,1,8)," +")[[1]],collapse="",sep="")
		key = c(key, k) ; value=c(value,row)
	}
# value : /以降削除
	value = gsub("/.*","",value)
# value : =まで(key部分)削除
	value = gsub("^.*=","",value)
# hdr作成(データフレーム)
	hdr = data.frame(key=key,value=value)
	return(hdr)
}
```

##### エリア内にあるデータだけを抽出する関数(sf パッケージが必要)

```R
### R : sf -180 <= RA <= 180
## area内外の判断する。RAは -180<=RA<=180に変換したものを用意しなければならない。
inarea<- function(data,area,RA="RA",Dec="Dec"){
	require(sf)
	# RAは -180<=RA<=180に変換(元のデータは書き換えないこと)
	temp <- data
	temp[temp[,RA]>180,RA] <- temp[temp[,RA]>180,RA]-360
	df<-st_as_sf(data.frame(type=1:nrow(temp),RA=temp[,RA],Dec=temp[,Dec]),coords=c("RA","Dec"))
	# polygon
	s <- st_polygon(list(area)) 
	indata <- st_intersects(df,s,sparse = FALSE)
	# RAは変換前の値をかえす。
	return(data[indata,])
}
```

##### celestial::radec2xy の出力をsip補正する関数。入力xはマトリックス。

[The SIP Convention for Representing Distortion in FITS Image Headers](https://irsa.ipac.caltech.edu/data/SPITZER/docs/files/spitzer/shupeADASS.pdf) (5)(6)式

```R
sip<-function(x,header){
    require(celestial)
    if (length(dim(x)) == 2) {
        y = x[, 2]
        x = x[, 1]
    }
    x = as.numeric(x)
    y = as.numeric(y)
	CRPIX1 = as.numeric(header[header[, 1] == "CRPIX1", 2])
	CRPIX2 = as.numeric(header[header[, 1] == "CRPIX2", 2])
	AP_0_0 = as.numeric(header[header[, 1] == "AP_0_0", 2])
	AP_0_1 = as.numeric(header[header[, 1] == "AP_0_1", 2])
	AP_0_2 = as.numeric(header[header[, 1] == "AP_0_2", 2])
	AP_1_0 = as.numeric(header[header[, 1] == "AP_1_0", 2])
	AP_1_1 = as.numeric(header[header[, 1] == "AP_1_1", 2])
	AP_2_0 = as.numeric(header[header[, 1] == "AP_2_0", 2])
	BP_0_0 = as.numeric(header[header[, 1] == "BP_0_0", 2])
	BP_0_1 = as.numeric(header[header[, 1] == "BP_0_1", 2])
	BP_0_2 = as.numeric(header[header[, 1] == "BP_0_2", 2])
	BP_1_0 = as.numeric(header[header[, 1] == "BP_1_0", 2])
	BP_1_1 = as.numeric(header[header[, 1] == "BP_1_1", 2])
	BP_2_0 = as.numeric(header[header[, 1] == "BP_2_0", 2])
# [The SIP Convention for Representing Distortion in FITS Image Headers](https://irsa.ipac.caltech.edu/data/SPITZER/docs/files/spitzer/shupeADASS.pdf)
# (5)(6)式
# radec2xyの出力からオフセットを引いて、
	U = x-CRPIX1
	V = y-CRPIX2
# sip補正して、
	u = U + AP_0_0*U^0*V^0 + AP_0_1*U^0*V^1 + AP_0_2*U^0*V^2 + AP_1_0*U^1*V^0 + AP_1_1*U^1*V^1 + AP_2_0*U^2*V^0 
	v = V + BP_0_0*U^0*V^0 + BP_0_1*U^0*V^1 + BP_0_2*U^0*V^2 + BP_1_0*U^1*V^0 + BP_1_1*U^1*V^1 + BP_2_0*U^2*V^0 
# オフセットを加える。
	xx = u + CRPIX1
	yy = v + CRPIX2
# 出力はradec2xyの出力と一緒のマトリックスにする。
	output = as.matrix(data.frame(x=xx, y=yy))
	return(output)
}
```

#### 必要なパッケージの読み込みとフォントの決定

```R
require(sf)
require(celestial)
library(jpeg)
library(showtext)
## Loading Google fonts (https://fonts.google.com/)
font_add_google("GFS Didot", "GFS")
## system font
font_add("notoJ", "NotoSerifCJK-Bold.ttc")
font_add("noto", "NotoSerif-BoldItalic.ttf")
## Automatically use showtext to render text
showtext_auto()
```

#### 入力（プログラム上の説明を読んでください。）

```R
############### 入力（ここから） ###############
# 1) 入力するjpgファイルをimagename.jpg 、wcsファイルをimagename.wcsとしておく。
imagename<- "image001"
# 2) 星名を表示する星の最も暗い視等級
Mag <- 15
# 3) NGC名を表示するNGCの最も暗いB-Mag
# NAが 2682 ある。
#B.Mag <- 100 # NA も含めてすべて表示する場合
#B.Mag <- 0 # なにも表示しない場合は0を入れておく。
B.Mag <- 100
# 4) 星座線を表示する星座(略符)
# 指定する場合
#Constellation <- c("Cas","Cep","UMi","And","Cam","Per","Dra")
# 描かない場合
#Constellation <-""
# 画像上すべて
# Constellation <-c("And","Ant","Aps","Aql","Aqr","Ara","Ari","Aur","Boo","Cae","Cam","Cap","Car",
# "Cas","Cen","Cep","Cet","Cha","Cir","CMa","CMi","Cnc","Col","Com","CrA","CrB","Crt","Cru","Crv",
# "CVn","Cyg","Del","Dor","Dra","Equ","Eri","For","Gem","Gru","Her","Hor","Hya","Hyi","Ind","Lac",
# "Leo","Lep","Lib","LMi","Lup","Lyn","Lyr","Men","Mic","Mon","Mus","Nor","Oct","Oph","Ori","Pav",
# "Peg","Per","Phe","Pic","PsA","Psc","Pup","Pyx","Ret","Scl","Sco","Sct","Ser","Sex","Sge","Sgr",
# "Tau","Tel","TrA","Tri","Tuc","UMa","UMi","Vel","Vir","Vol","Vul")
# もしくは
#Constellation <-"All"
Constellation <-"And"
# 5) messierPlusJ.csv に記入している天体はすべて表示します。
# 記入したくない天体はmessierPlusJ.csvのSizeの項を0にします。
# 読み込む前にmessierPlusJ.csvのcex , pos , offset を適当に調整してください。
# 重なってみえにくい場合
# 1.天体名（例"Andromeda Galaxy"）、2.メシエ番号、3.NGC等の番号 上位3つまで
# prn<- 3
# 1.天体名（例"Andromeda Galaxy"）、2.メシエ番号、3.NGC等の番号　上位2つまで
# prn<- 2
# 1.天体名（例"Andromeda Galaxy"）、2.メシエ番号、3.NGC等の番号　上位1つ
# prn<- 1
prn <- 1
############### 入力（ここまで） ###############
```

#### wcsファイルとラベル等表示に使うファイル４つの読み込みと必要部分の抽出

```R
# wcsを読み込む。
hdr<- read.wcs(paste0(imagename,".wcs"))
width=as.numeric(hdr[hdr$key=="IMAGEW",2])
height=as.numeric(hdr[hdr$key=="IMAGEH",2])
# 画像の表示範囲をRA,Decに変換し、areaを求める。
area<- xy2radec(x=c(0,width,width,0), y=c(0,0,height,height), header=hdr)
area<- rbind(area,area[1,])
# メシエ天体 プラスアルファ
messier<- read.csv(file = "~/astrometry/messierPlusJ.csv", header = T)
messier<- inarea(messier,area)
# HIP major プラスアルファ
hip<- read.csv(file = "~/astrometry/hip_majorJ.csv", header = T)
hip<- inarea(hip,area)
# 指定した等級に関係なく表示する星（アルビレオなどにはPrn項に1を入れている。!is.na()）
hip <- hip[hip$Mag<=Mag | !is.na(hip$Prn) ,]
# NGC
ngc <- read.csv(file = "~/astrometry/NGC_lite.csv", header = T)
ngc<- inarea(ngc,area)
if (B.Mag != 100){
	ngc <- ngc[!is.na(ngc[,9]),]
	ngc <- ngc[ngc$B.Mag<=B.Mag,]
}
# 星座線
line<- read.csv(file = "~/astrometry/constellation_lineJ.csv", header = T)
line<- unique(rbind(inarea(line,area,RA="RA1",Dec="Dec1"),inarea(line,area,RA="RA2",Dec="Dec2")))
if ("All" %in% Constellation){
	pline<- line
	} else {
	pline<- line[is.element(line$Constellation,Constellation),]
}
```

#### sip補正なし(一応、比較のために載せておきます。)

```R
posM<- radec2xy(RA=messier$RA,Dec=messier$Dec, header=hdr)
posN<- radec2xy(RA=ngc$RA,Dec=ngc$Dec, header=hdr)
posH<- radec2xy(RA=hip$RA,Dec=hip$Dec, header=hdr)
posZ<- matrix(c(radec2xy(RA=pline$RA1,Dec=pline$Dec1, header=hdr),radec2xy(RA=pline$RA2,Dec=pline$Dec2, header=hdr)),nrow=nrow(pline))
```

#### sip補正あり

```R
posM<- sip(radec2xy(RA=messier$RA,Dec=messier$Dec, header=hdr),header=hdr)
posN<- sip(radec2xy(RA=ngc$RA,Dec=ngc$Dec, header=hdr),header=hdr)
posH<- sip(radec2xy(RA=hip$RA,Dec=hip$Dec, header=hdr),header=hdr)
posZ<- matrix(c( sip(radec2xy(RA=pline$RA1,Dec=pline$Dec1, header=hdr),header=hdr) , 
	sip(radec2xy(RA=pline$RA2,Dec=pline$Dec2, header=hdr),header=hdr)),nrow=nrow(pline))
```

#### プロット（英語）

```R
img <- readJPEG(paste0(imagename,".jpg")) 
width<- ncol(img)
height<- nrow(img)
#################### プロット ####################
# png("astro%02d.png",width=width,height=height,type = "cairo")
par(mar=rep(0,4),family="GFS") # 余白なしの設定
# (注意) ylim=c(height,0)
plot( 0,0, xlim=c(0,width), ylim=c(height,0), type="n", asp=1,axes=F,xlab="",ylab="",xaxs="i",yaxs="i")
# (注意) ybottom=height ytop=0
rasterImage(img, xleft=0, ybottom=height, xright=width, ytop=0)
# 
#### メシエ天体＆その他登録した天体
for (i in 1:nrow(messier)){
	if (prn >= 3){
		# 通称（common name ）ありの場合
		if (messier$CommonName[i]!=""){
			text(x=posM[i,1]-0.5,y=posM[i,2]-0.5,labels=paste0(messier$CommonName[i],"  ",messier$Name[i],"(",messier$NGC[i],")"),
				col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
		}
		# 通称（common name ）なしの場合
		if (messier$CommonName[i]==""){
			text(x=posM[i,1]-0.5,y=posM[i,2]-0.5,labels=paste0(messier$Name[i],"(",messier$NGC[i],")"),
				col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
			}
		}
	if (prn == 2){
		# 通称（common name ）ありの場合
		if (messier$CommonName[i]!=""){
			# メシエ番号あり
			if (messier$Name[i]!=""){
				text(x=posM[i,1]-0.5,y=posM[i,2]-0.5,labels=paste0(messier$CommonName[i],"  ",messier$Name[i]),
					col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
				}
			# メシエ番号なし
			if (messier$Name[i]==""){
				text(x=posM[i,1]-0.5,y=posM[i,2]-0.5,labels=paste0(messier$CommonName[i],"(",messier$NGC[i],")"),
					col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
				}
			}
		# 通称（common name ）なしの場合
		if (messier$CommonName[i]==""){
			text(x=posM[i,1]-0.5,y=posM[i,2]-0.5,labels=paste0(messier$Name[i],"(",messier$NGC[i],")"),
				col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
			}
		}
	if (prn == 1){
		# 通称（common name ）ありの場合
		if (messier$CommonName[i]!=""){
			text(x=posM[i,1]-0.5,y=posM[i,2]-0.5,labels=paste0(messier$CommonName[i]),
				col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
			}
		# 通称（common name ）なしの場合
		if (messier$CommonName[i]==""){
			# メシエ番号あり
			if (messier$Name[i]!=""){
				text(x=posM[i,1]-0.5,y=posM[i,2]-0.5,labels=paste0(messier$Name[i]),
					col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
				}
			# メシエ番号なし
			if (messier$Name[i]==""){
				text(x=posM[i,1]-0.5,y=posM[i,2]-0.5,labels=paste0(messier$NGC[i]),
				col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
				}
			}
		}
}
#### 星座線
for (i in 1:nrow(posZ)){
	segments(x0=posZ[i,1]-0.5, y0=posZ[i,2]-0.5, x1 =posZ[i,3]-0.5, y1=posZ[i,4]-0.5, col = "cyan",lwd=2)
}
#### NGC,IC
for (i in 1:nrow(ngc)){
	# messier表示した天体との２重表示を防ぐ
	if (!is.element(ngc$Name[i],messier$NGC)){
		text(x=posN[i,1]-0.5,y=posN[i,2]-0.5,labels=ngc$Name[i],col="green",pos=3,offset=0.5,cex=1)
	}
}
#### 星(hip)
for (i in 1:nrow(hip)){
	# 星の通称ありの場合
	if (hip$Name[i] != ""){
		text(x=posH[i,1]-0.5,y=posH[i,2]-0.5,labels=hip$Name[i],col="yellow",pos=3,offset=0.5,cex=1)
		}
	# 星の通称なしの場合
	if (hip$Name[i] == ""){
		text(x=posH[i,1]-0.5,y=posH[i,2]-0.5,labels=paste(hip$Num[i],hip$Constellation[i]),col="yellow",pos=3,offset=0.5,cex=1)
		}
}
# dev.off()
```

####  プロット（日本語）

```R
img <- readJPEG(paste0(imagename,".jpg")) 
width<- ncol(img)
height<- nrow(img)
#################### プロット ####################
# png("astro%02d.png",width=width,height=height,type = "cairo")
par(mar=rep(0,4),family="notoJ") # 余白なしの設定
# (注意) ylim=c(height,0)
plot( 0,0, xlim=c(0,width), ylim=c(height,0), type="n", asp=1,axes=F,xlab="",ylab="",xaxs="i",yaxs="i")
# (注意) ybottom=height ytop=0
rasterImage(img, xleft=0, ybottom=height, xright=width, ytop=0)
#
#### メシエ天体＆その他登録した天体
for (i in 1:nrow(messier)){
	if (prn >= 3){
		# 通称（common name ）ありの場合
		if (messier$CommonNameJ[i]!=""){
			text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$CommonNameJ[i],"  ",messier$Name[i],"(",messier$NGC[i],")"),
				col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
		}
		# 通称（common name ）なしの場合
		if (messier$CommonNameJ[i]==""){
			text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$Name[i],"(",messier$NGC[i],")"),
				col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
			}
		}
	if (prn == 2){
		# 通称（common name ）ありの場合
		if (messier$CommonNameJ[i]!=""){
			# メシエ番号あり
			if (messier$Name[i]!=""){
				text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$CommonNameJ[i],"  ",messier$Name[i]),
					col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
				}
			# メシエ番号なし
			if (messier$Name[i]==""){
				text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$CommonNameJ[i],"(",messier$NGC[i],")"),
					col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
				}
			}
		# 通称（common name ）なしの場合
		if (messier$CommonNameJ[i]==""){
			text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$Name[i],"(",messier$NGC[i],")"),
				col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
			}
		}
	if (prn == 1){
		# 通称（common name ）ありの場合
		if (messier$CommonNameJ[i]!=""){
			text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$CommonNameJ[i]),
				col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
			}
		# 通称（common name ）なしの場合
		if (messier$CommonNameJ[i]==""){
			# メシエ番号あり
			if (messier$Name[i]!=""){
				text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$Name[i]),
					col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
				}
			# メシエ番号なし
			if (messier$Name[i]==""){
				text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$NGC[i]),
				col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
				}
			}
		}
}
#### 星座線
for (i in 1:nrow(posZ)){
	segments(x0=posZ[i,1], y0=posZ[i,2], x1 =posZ[i,3], y1=posZ[i,4], col = "cyan",lwd=2)
}
#### NGC,IC
for (i in 1:nrow(ngc)){
# messier表示した天体との２重表示を防ぐ
	if (!is.element(ngc$Name[i],messier$NGC)){
		text(x=posN[i,1],y=posN[i,2],labels=ngc$Name[i],col="green",pos=3,offset=0.5,cex=0.8)
	}
}
#### 星(hip)
for (i in 1:nrow(hip)){
# 星の通称ありの場合
	if (hip$NameJ[i] != ""){
		text(x=posH[i,1],y=posH[i,2],labels=hip$NameJ[i],col="yellow",pos=3,offset=0.5,cex=0.8)
		}
# 星の通称なしの場合
	if (hip$NameJ[i] == ""){
		text(x=posH[i,1],y=posH[i,2],labels=paste(hip$Num[i],hip$Constellation[i]),col="yellow",pos=3,offset=0.5,cex=0.8)
		}
}
# dev.off()
```


#### 6) 楕円を描く

```R
########## sip補正をした場合のみ ##########
# 楕円を描くもっとも大きなB.Mag指定。 
el <- 12
# 楕円を描く天体
plNGC <- read.csv(file = "~/astrometry/NGC_lite.csv", header = T)
# 中心部が画像上にないものは表示しない
plNGC<- inarea(plNGC,area)
plNGC<- plNGC[!is.na(plNGC[,6]),]
plNGC<- plNGC[!is.na(plNGC[,9]),]
plNGC <- plNGC[plNGC$B.Mag<=el,]
#### 楕円
if (nrow(plNGC)!=0){
	theta=seq(-pi,pi,length=200)
	for (i in 1:nrow(plNGC)){
		cx=plNGC$RA[i]
		cy=plNGC$Dec[i]	
		a= plNGC$MajAx[i]/60	# MajAx
		b= plNGC$MinAx[i]/60	# MinAx
		t= plNGC$PosAng[i]*(pi/180)	# PosAng
		x=a*cos(theta)*cos(t)-b*sin(theta)+cx
		y=a*cos(theta)*sin(t)+b*cos(theta)+cy
		ellipse<- sip(radec2xy(RA=x,Dec=y, header=hdr),header=hdr)
		lines(x=ellipse[,1],y=ellipse[,2],col="white")
	}
}
```

