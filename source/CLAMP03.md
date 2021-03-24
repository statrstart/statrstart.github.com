---
title: RでCLAMP(Climate Leaf Analysis Multivariate Programe)その３
date: 2021-03-16
tags: ["R", "CLAMP","vegan"]
excerpt: Rを使ってCLAMP(気候と葉の多変量解析)その３
---

# RでCLAMP(Climate Leaf Analysis Multivariate Programe)その３

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCLAMP03&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

前々回の記事 [RでCLAMP(Climate Leaf Analysis Multivariate Programe)その１](https://gitpress.io/@statrstart/CLAMP01)
前回の記事 [RでCLAMP(Climate Leaf Analysis Multivariate Programe)その２](https://gitpress.io/@statrstart/CLAMP02)

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

前回は、investrパッケージを使って信頼区間、予測区間もプロットされたグラフを作成しました。  
今回は、ブートストラップ法を使ってCCAの信頼区間を求め、それを元に予測値の信頼区間を求めヒストグラムも作成してみます。  
# (注意) CLAMPによる予測値の信頼区間を求める方法として正しいかどうかはわかりません。

### 使用するデータ

葉化石のデータは、[CLAMP Practice Files](http://clamp.ibcas.ac.cn/CLAMP_Practice.html)を使います。

現在の植生から得られた葉相観データとその地域の気候データは、「PhysgAsia2 calibration dataset.」との指定があります。

[CLAMP Calibration Data Sets](http://clamp.ibcas.ac.cn/CLAMP_Calibration.html)からリンクを辿り、
[PhysgAsia2 Calibration Files](http://clamp.ibcas.ac.cn/CLAMP_PhysgAsia2.html)からファイルを入手します。  

使用するRパッケージは、veganパッケージ

#### 表(ブートストラップ法を使っていますので信頼区間の値は一定ではありません)

|         | ブートストラップ推定値|  2.5%| 97.5%|
|:--------|----------------------:|-----:|-----:|
|MAT      |                   25.0|  23.1|  26.9|
|WMMT     |                   27.6|  25.3|  29.2|
|CMMT     |                   20.5|  17.2|  23.7|
|GROWSEAS |                   12.3|  11.8|  12.9|
|GSP      |                  168.7| 112.8| 238.9|
|MMGSP    |                   14.6|   9.0|  20.4|
|3-WET    |                   99.5|  70.8| 148.3|
|3-DRY    |                    5.0|   1.3|  13.7|
|RH       |                   81.4|  75.5|  86.6|
|SH       |                   15.3|  13.8|  17.4|
|ENTHAL   |                   35.7|  35.0|  36.6|

#### ヒストグラム(ブートストラップ法を使っていますのでグラフはその都度多少変化します）

![CLAMP03_1.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/CLAMP03_1.png)

- CLAMPで求めた推定値を青線実線、CLAMP(ブートストラップ)で求めた推定値を赤線実線、2.5%と97.5%は赤線破線。

## Rcode

```R
library(vegan)
# urlから直接入手します。
leaves0<- read.csv("http://clamp.ibcas.ac.cn/PhysgAsia2_files/PhysgAsia2.csv",row.names=1,check.names=F)
climate0<- read.csv("http://clamp.ibcas.ac.cn/PhysgAsia2_files/HiResGridMetAsia2.csv",row.names=1,check.names=F)
# leaves0データ、climate0データの行名が一致しているかを確認する。
all(rownames(leaves0)==rownames(climate0))
# [1] TRUE
# fossil leaves data
site<- data.frame(matrix(c(
	0,83,9,0,5,13,3,0,0,0,2,12,19,20,23,25,15,22,12,67,20,22,57,0,59,33,6,2,0,98,3
	),nrow=1))
colnames(site)<- colnames(leaves0)
rownames(site)<- "site"
#
# ブートストラップ法による信頼区間の構成
n <- nrow(leaves0)
M <- 2000
predmat<- NULL
for(MM in 1:M){
nx <- sample(1:n, replace=TRUE)
leaves<- leaves0[nx,]
climate<- climate0[nx,]
res <- cca(leaves,climate) 
# 予測に必要な部分の抽出
# Environment Biplot Scores
EBS<- round(summary(res)[[4]][,1:4],5)
# Site Biplot Scores
SBS<- round(summary(res)[[2]][,1:4],5)
# １１項目の回帰係数を求め係数の行列を作成
co<- NULL
for (num in 1:11){
x<- NULL
for (i in 1:nrow(SBS)){
	x<- c(x,sum(EBS[num,]*SBS[i,])/sqrt(sum(EBS[num,]^2)))
}
df<- data.frame(x=x,y=climate[,num])
tryCatch({
fm<-nls(y ~a+b*x+c*x^2,start=c(a=1,b=1,c=-1),data=df) }
, error = function(e) {
    		})
co<- rbind(co,rev(coef(summary(fm))[,1]))
}
#names(estclim)<- colnames(climate)
# Site scores (weighted averages of species scores)の推定
Fdat<- predict(res,type="wa",newdata=site)[1:4]
pred<- NULL
for(j in 1:11){
	G23<- sum(EBS[j,]*Fdat)/sqrt(sum(EBS[j,]^2))
	pred<- c(pred,co[j,3]+co[j,2]*G23+co[j,1]*(G23*G23))
}
predmat<- rbind(predmat,pred)
}
# 列名をclimate0と同じにする
colnames(predmat)<- colnames(climate0)
nrow(predmat)
#
pvec<- NULL
for(i in 1:11){
	temp<- c(mean(predmat[,i]),quantile(predmat[,i], c(0.025, 0.975)))
	pvec<- rbind(pvec,round(temp,1))
}
rownames(pvec)<- colnames(climate0)
colnames(pvec)[1]<- "ブートストラップ推定値"
knitr::kable(pvec)
#
# 推定値
# 前回求めた推定値
xx<- c(25.0,27.5 ,21.0,12.3,157.8,12.9,100.4, 3.7 ,82.8,15.1, 35.6)
# png("CLAMP03_1.png",width=800,height=600)
par(mfrow=c(3,4))
for(i in 1:11){
	hist(predmat[,i],col="lightgray",xlab="",main=colnames(predmat)[i])
	# 前回求めた推定値
	abline(v=xx[i],col="blue",lwd=1)
	# ブートストラップ推定値
	abline(v=mean(predmat[,i]),col="red",lwd=1)
	# 95％信頼区間
	abline(v=quantile(predmat[,i], c(0.025, 0.975)),col="red",lty=2) 
}
par(mfrow=c(1,1))
# dev.off()
```
