---
title: RでCLAMP(Climate Leaf Analysis Multivariate Programe)その１
date: 2021-03-15
tags: ["R", "CLAMP","vegan"]
excerpt: Rを使ってCLAMP(気候と葉の多変量解析)その１
---

# RでCLAMP(Climate Leaf Analysis Multivariate Programe)その１

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCLAMP01&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

> CLAMP(Climate Leaf Analysis Multivariate Programe) : 詳しくは[CLAMP online](http://clamp.ibcas.ac.cn/CLAMP_Home.html) 

『CLAMPとは、[葉化石から推定する古気候(成田)](https://www.jstage.jst.go.jp/article/chitoka/80/0/80_37/_pdf)から抜粋すると、    
CLAMPは広葉樹葉の葉相観を用いた古気候解析法の一つであり，現在の植生から得られた葉相観データとその地域の気候データをもとに，
多変量解析の一手法である正準対応分析（Canonical Correspondence Analysis：CCA）を用いて化石群集の葉相観が示す過去の気候条件を
求める手法である（Wolfe 1995； 矢部 2002）．』とのこと

上記のサイトではこの解析をする方法として２つ紹介している
- [CLAMP online解析](http://clamp.ibcas.ac.cn/CLAMP_Analysis_Online2/enterdata.do)で行う
- [How do I do a "classic" CLAMP Analysis?](http://clamp.ibcas.ac.cn/CLAMP_Classic.html)にあるようにCANOCOでCCAを行い、
推定したSite scoresを計算用のexcelファイルに貼り付けて過去の気候条件を求める。

計算用のexcelファイルを眺めてたらRでもできそうなのでやってみました。

[Climate-Leaf Analysis Workshop. 'Paleoclimate Reconstruction and Fossil Leaves'.](https://www.researchgate.net/publication/309619449_Climate-Leaf_Analysis_Workshop_%27Paleoclimate_Reconstruction_and_Fossil_Leaves%27_Alberta_Palaeontology_Society_-_Paleo_2016)
にも「Note that the ‘Vegan’ and’ Rcmdr’ package in R statistical software can also run theconstrained ordinationanalyses requiredfor CLAMP.
If you are (or know of) an R expert, this is certainly another option. 」て書いてあったのも動機です。

今回は、最初にCLAMPで求めることができる１１項目の古気候条件のうち「年平均気温（MAT）」を求めます。（いくつかグラフも作成）  
次に、同様にして、１１項目の古気候条件を推定してみます。（推定値だけを求める）  

### 使用するデータ

葉化石のデータは、[CLAMP Practice Files](http://clamp.ibcas.ac.cn/CLAMP_Practice.html)を使います。

現在の植生から得られた葉相観データとその地域の気候データは、「PhysgAsia2 calibration dataset.」との指定があります。

[CLAMP Calibration Data Sets](http://clamp.ibcas.ac.cn/CLAMP_Calibration.html)からリンクを辿り、
[PhysgAsia2 Calibration Files](http://clamp.ibcas.ac.cn/CLAMP_PhysgAsia2.html)からファイルを入手します。  

使用するRパッケージは、veganパッケージ（cca,predict.cca）

### veganパッケージの読み込み、葉相観データ・気候データの読み込み、CCA実行など

```R
library(vegan)
# urlから直接入手します。頻繁に使う場合はダウンロードして使いましょう。
leaves<- read.csv("http://clamp.ibcas.ac.cn/PhysgAsia2_files/PhysgAsia2.csv",row.names=1,check.names=F)
climate<- read.csv("http://clamp.ibcas.ac.cn/PhysgAsia2_files/HiResGridMetAsia2.csv",row.names=1,check.names=F)
# 現在の植生から得られた葉相観データとその地域の気候データを使ってCCA実行
res <- cca(leaves~.,climate) 
# plot
# png("clampord01.png",width=600,height=600)
par(mfrow=c(2,2),mar=c(4,4,2,1))
ordiplot(res)
ordiplot(res,c(1,3))
ordiplot(res,c(2,3))
par(mfrow=c(1,1))
# dev.off()
# きれいにプロット（例）
# png("clampord02.png",width=600,height=600)
par(mar=c(4,4,2,1))
# 1-2
cols<- rainbow(11)
choice<- c(1,2)
plot(res, type = 'n',choice=choice)
points(res,"sites",pch=1,col="gray20",choice=choice)
points(res,"sp",pch=4,col="red",choice=choice)
bp <- scores(res, display = 'bp',choice=choice)
mul <- ordiArrowMul(bp, fill = 0.75)
arrows(0, 0, mul * bp[,1], mul * bp[,2],length = 0.05, col = cols)
labs <- rownames(bp)
text(ordiArrowTextXY(mul * bp, labs), labs, col = cols)
# dev.off()
```

#### 作成したグラフ

![clampord01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/clampord01.png)

![clampord02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/clampord02.png)

### 「年平均気温（MAT）」を求めるため式の係数を求める

ここがCLAMPのもっとも大事なところです。「a "classic" CLAMP Analysis」ではexcelファイルにはじめから係数が入力されていました。  
非線形の式なのでnls関数を使います。

```R
# CCA1からCCA4までを使うので[,1:4]としている
# Environment Biplot Scores
EBS<- round(summary(res)[[4]][,1:4],5)
# Site Biplot Scores
SBS<- round(summary(res)[[2]][,1:4],5)
# 気候を求める関数(a、b、c が求める回帰係数)
# y~ a+b*x+c*x^2 
# 「年平均気温（MAT）」の回帰係数を求めてみる
x<- NULL
for (i in 1:nrow(SBS)){
	x<- c(x,sum(EBS[1,]*SBS[i,])/sqrt(sum(EBS[1,]^2)))
}
# nls関数を使って係数を求める
fm<-nls(climate[,1] ~a+b*x+c*x^2,start=c(a=1,b=1,c=-1)) 
summary(fm) # 抜粋
#  Estimate Std. Error t value Pr(>|t|)    
# a  16.3579     0.2612   62.63   <2e-16 ***
# b   5.9302     0.1706   34.77   <2e-16 ***
# c  -0.5321     0.1774   -3.00   0.0031 **    
# 残差
#residuals(fm)
# 後ほど１１項目の係数行列を作成する場合は逆順にする 
co<- rev(coef(summary(fm))[,1])
# 推定値の下でのあてはめ値は
# predict(fm)
# 葉相観データから求めた「年平均気温（MAT）」と実際の観測値との散布図
# png("clampord03.png",width=600,height=600)
plot(predict(fm),climate[,1],pch=16,col="brown3",las=1,xlab="推定値",ylab="実測値",xlim=c(0,30),ylim=c(0,30),xaxs="i",yaxs="i")
abline(0,1,col="blue")
title("葉相観データから求めた年平均気温(MAT)と実際の観測値")
# dev.off()
```

#### 葉相観データから求めた「年平均気温（MAT）」と実際の観測値との散布図

![clampord03](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/clampord03.png)

```R
# fossil leaves data(Suranaree_Test_Filled.xlsxのresultシートのピンク色の部分)
Suranaree<- data.frame(matrix(c(
	0,83,9,0,5,13,3,0,0,0,2,12,19,20,23,25,15,22,12,67,20,22,57,0,59,33,6,2,0,98,3
	),nrow=1))
colnames(Suranaree)<- colnames(leaves)
rownames(Suranaree)<- "Suranaree"
# Site scores (weighted averages of species scores)の推定
Fdat<- predict(res,type="wa",newdata=Suranaree)[1:4]
G23<- sum(EBS[1,]*Fdat)/sqrt(sum(EBS[1,]^2))
pred<- co[3]+co[2]*G23+co[1]*(G23*G23)
names(pred)<- "MAT"
round(pred,1)
```

MAT   
 25     

### １１項目の古気候条件を推定(前半部は再掲)

```R
library(vegan)
# urlから直接入手します。頻繁に使う場合はダウンロードして使いましょう。
leaves<- read.csv("http://clamp.ibcas.ac.cn/PhysgAsia2_files/PhysgAsia2.csv",row.names=1,check.names=F)
climate<- read.csv("http://clamp.ibcas.ac.cn/PhysgAsia2_files/HiResGridMetAsia2.csv",row.names=1,check.names=F)
# 現在の植生から得られた葉相観データとその地域の気候データを使ってCCA実行
res <- cca(leaves~.,climate) 
# CCA1からCCA4までを使うので[,1:4]としている
# Environment Biplot Scores
EBS<- round(summary(res)[[4]][,1:4],5)
# Site Biplot Scores
SBS<- round(summary(res)[[2]][,1:4],5)
# １１項目の回帰係数を求め行列を作成
co<- NULL
for (num in 1:11){
x<- NULL
for (i in 1:nrow(SBS)){
	x<- c(x,sum(EBS[num,]*SBS[i,])/sqrt(sum(EBS[num,]^2)))
}
fm<-nls(climate[,num] ~a+b*x+c*x^2,start=c(a=1,b=1,c=-1)) 
co<- rbind(co,rev(coef(summary(fm))[,1]))
}
# fossil leaves data
Suranaree<- data.frame(matrix(c(
	0,83,9,0,5,13,3,0,0,0,2,12,19,20,23,25,15,22,12,67,20,22,57,0,59,33,6,2,0,98,3
	),nrow=1))
colnames(Suranaree)<- colnames(leaves)
rownames(Suranaree)<- "Suranaree"
# Site scores (weighted averages of species scores)の推定
Fdat<- predict(res,type="wa",newdata=Suranaree)[1:4]
#
pred<- NULL
for(i in 1:11){
	G23<- sum(EBS[i,]*Fdat)/sqrt(sum(EBS[i,]^2))
	pred<- c(pred,co[i,3]+co[i,2]*G23+co[i,1]*(G23*G23))
}
names(pred)<- colnames(climate)
knitr::kable(t(round(pred,1)))
```

Rで求めた結果

| MAT| WMMT| CMMT| GROWSEAS|   GSP| MMGSP| 3-WET| 3-DRY|   RH|   SH| ENTHAL|
|---:|----:|----:|--------:|-----:|-----:|-----:|-----:|----:|----:|------:|
|  25| 27.5|   21|     12.3| 157.8|  12.9| 100.4|   3.7| 82.8| 15.1|   35.6|

 
CLAMP ONLINEから求めた結果  

" 25.0"," 27.5"," 21.0"," 12.3","157.7"," 12.9","100.4","  3.7"," 82.8"," 15.1"," 35.6"


