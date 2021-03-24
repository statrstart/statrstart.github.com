---
title: RでCLAMP(Climate Leaf Analysis Multivariate Programe)その２
date: 2021-03-15
tags: ["R", "CLAMP","vegan","investr"]
excerpt: Rを使ってCLAMP(気候と葉の多変量解析)その２
---

# RでCLAMP(Climate Leaf Analysis Multivariate Programe)その２

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCLAMP02&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

前回の記事 [RでCLAMP(Climate Leaf Analysis Multivariate Programe)その１](https://gitpress.io/@statrstart/CLAMP01)

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

前回は、１１項目の古気候条件の推定値だけを求め、グラフはあまり作成しませんでした。今回は、investrパッケージを使って
信頼区間、予測区間もプロットされたグラフを作成してみます。

### 使用するデータ

葉化石のデータは、[CLAMP Practice Files](http://clamp.ibcas.ac.cn/CLAMP_Practice.html)を使います。

現在の植生から得られた葉相観データとその地域の気候データは、「PhysgAsia2 calibration dataset.」との指定があります。

[CLAMP Calibration Data Sets](http://clamp.ibcas.ac.cn/CLAMP_Calibration.html)からリンクを辿り、
[PhysgAsia2 Calibration Files](http://clamp.ibcas.ac.cn/CLAMP_PhysgAsia2.html)からファイルを入手します。  

使用するRパッケージは、veganパッケージ（cca,predict.cca）とinvestrパッケージ

#### CCAGraph

![CLAMP02_1](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/CLAMP02_1.png)

![CLAMP02_2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/CLAMP02_2.png)

![CLAMP02_3](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/CLAMP02_3.png)

![CLAMP02_4](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/CLAMP02_4.png)

![CLAMP02_5](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/CLAMP02_5.png)

![CLAMP02_6](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/CLAMP02_6.png)

### modelのグラフ

![estclimate1](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/estclimate1.png)

![estclimate2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/estclimate2.png)

![estclimate3](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/estclimate3.png)

![estclimate4](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/estclimate4.png)

![estclimate5](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/estclimate5.png)

![estclimate6](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/estclimate6.png)

![estclimate7](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/estclimate7.png)

![estclimate8](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/estclimate8.png)

![estclimate9](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/estclimate9.png)

![estclimate10](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/estclimate10.png)

![estclimate11](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/estclimate11.png)


## Rcode

### veganパッケージの読み込み、葉相観データ・気候データの読み込み、CCA実行など

```R
library(vegan)
library(investr)
# urlから直接入手します。
leaves<- read.csv("http://clamp.ibcas.ac.cn/PhysgAsia2_files/PhysgAsia2.csv",row.names=1,check.names=F)
climate<- read.csv("http://clamp.ibcas.ac.cn/PhysgAsia2_files/HiResGridMetAsia2.csv",row.names=1,check.names=F)
# leavesデータ、climateデータの行名が一致しているかを確認する。
all(rownames(leaves)==rownames(climate))
# [1] TRUE
```

#### 葉化石のデータを入力（コンマで区切る）

```R
# fossil leaves data
site<- data.frame(matrix(c(
	0,83,9,0,5,13,3,0,0,0,2,12,19,20,23,25,15,22,12,67,20,22,57,0,59,33,6,2,0,98,3	# <- ここに入力
	),nrow=1))
colnames(site)<- colnames(leaves)
rownames(site)<- "site"
```

#### 現在の植生から得られた葉相観データとその地域の気候データを使ってCCA実行

```R
res <- cca(leaves~.,climate) 
# モデルの評価 ：並べ替え検定法(Permutation test)
anova(res)
#Model: cca(formula = leaves ~ MAT + WMMT + CMMT + GROWSEAS + GSP + MMGSP + `3-WET` + `3-DRY` + RH + SH + ENTHAL, data = climate)
#          Df ChiSquare     F Pr(>F)    
#Model     11   0.23911 25.23  0.001 *** <- 有意
#Residual 165   0.14216                 
# 予測に必要な部分の抽出
# Environment Biplot Scores
EBS<- round(summary(res)[[4]][,1:4],5)
# Site Biplot Scores
SBS<- round(summary(res)[[2]][,1:4],5)
```

### １１項目の回帰係数を求め係数の行列を作成（xとnlsの結果もとっておく）
グラフ作成の際に繰り返すのも面倒なので必要な部分は取っておきます。(リストestclim)

```R
co<- NULL
estclim<- list()
for (num in 1:11){
x<- NULL
for (i in 1:nrow(SBS)){
	x<- c(x,sum(EBS[num,]*SBS[i,])/sqrt(sum(EBS[num,]^2)))
}
#fm<-nls(climate[,num] ~a+b*x+c*x^2,start=c(a=1,b=1,c=-1)) 
df<- data.frame(x=x,y=climate[,num])
fm<-nls(y ~a+b*x+c*x^2,start=c(a=1,b=1,c=-1),data=df) 
estclim[[num]]<- list(fm,x)
co<- rbind(co,rev(coef(summary(fm))[,1]))
}
names(estclim)<- colnames(climate)
knitr::kable(co)
```

### 予測に必要な非線形回帰の係数

|          c|         b|          a|
|----------:|---------:|----------:|
| -0.5320794|  5.930249|  16.357911|
| -0.9232594|  3.444437|  25.204153|
| -0.4065136|  7.886783|   7.914066|
| -0.2998703|  2.577809|   9.011058|
| -4.3063540| 53.012785| 109.737195|
|  0.1470994|  3.843391|  11.184817|
| -0.4168687| 19.558055|  63.527074|
|  0.6583732|  4.952783|  11.991637|
|  0.3777119|  7.980050|  68.289634|
| -0.4610003|  3.461899|   9.302291|
| -0.2720693|  1.926624|  32.630057|

### 過去の気候条件を推定します。

```R
# Site scores (weighted averages of species scores)の推定
Fdat<- predict(res,type="wa",newdata=site)[1:4]
pred<- NULL
for(i in 1:11){
	G23<- sum(EBS[i,]*Fdat)/sqrt(sum(EBS[i,]^2))
	pred<- c(pred,co[i,3]+co[i,2]*G23+co[i,1]*(G23*G23))
}
names(pred)<- colnames(climate)
knitr::kable(t(round(pred,1)))
```
#### 過去の気候条件の推定値

| MAT| WMMT| CMMT| GROWSEAS|   GSP| MMGSP| 3-WET| 3-DRY|   RH|   SH| ENTHAL|
|---:|----:|----:|--------:|-----:|-----:|-----:|-----:|----:|----:|------:|
|  25| 27.5|   21|     12.3| 157.8|  12.9| 100.4|   3.7| 82.8| 15.1|   35.6|

CLAMP ONLINEで解析を行った場合の推定値は  
" 25.0"," 27.5"," 21.0"," 12.3","157.7"," 12.9","100.4","  3.7"," 82.8"," 15.1"," 35.6"  
で一致しています。(GSPだけが0.1違ってますが)

#### グラフ作成

CLAMP ONLINEでは、グラフも作成されます。Rでもやってみます。

#### CCAGraph（ordiplot関数だけで簡単に作成できますが、ちょっとだけきれいに）

グラフ作成に必要なのは 
- res
- Fdat(過去の気候条件のCCAの位置もプロットしたい場合)

```R
cols <- c(rep("red",3),"darkgreen",rep("blue",4),"darkgreen","black","black")
# 1-2
choice<- c(1,2)
plot(res, type = 'n',choice=choice)
points(res,"sites",pch=1,col="gray20",choice=choice)
# points(res,"sp",pch=4,col="red",choice=choice)
bp <- scores(res, display = 'bp',choice=choice)
mul <- ordiArrowMul(bp, fill = 0.75)
arrows(0, 0, mul * bp[,1], mul * bp[,2],length = 0.05, col = cols)
labs <- rownames(bp)
# 過去の気候条件のCCAの位置
points(Fdat[choice[1]],Fdat[choice[2]],pch=21,bg="green",col="red",cex=2)
text(ordiArrowTextXY(mul * bp, labs), labs, col = cols)
# 2-3
choice<- c(2,3)
plot(res, type = 'n',choice=choice)
points(res,"sites",pch=1,col="gray20",choice=choice)
# points(res,"sp",pch=4,col="red",choice=choice)
bp <- scores(res, display = 'bp',choice=choice)
mul <- ordiArrowMul(bp, fill = 0.75)
arrows(0, 0, mul * bp[,1], mul * bp[,2],length = 0.05, col = cols)
labs <- rownames(bp)
# 過去の気候条件のCCAの位置
points(Fdat[choice[1]],Fdat[choice[2]],pch=21,bg="green",col="red",cex=2)
text(ordiArrowTextXY(mul * bp, labs), labs, col = cols)
# 1-3
choice<- c(1,3)
plot(res, type = 'n',choice=choice)
points(res,"sites",pch=1,col="gray20",choice=choice)
# points(res,"sp",pch=4,col="red",choice=choice)
bp <- scores(res, display = 'bp',choice=choice)
mul <- ordiArrowMul(bp, fill = 0.75)
arrows(0, 0, mul * bp[,1], mul * bp[,2],length = 0.05, col = cols)
labs <- rownames(bp)
# 過去の気候条件のCCAの位置
points(Fdat[choice[1]],Fdat[choice[2]],pch=21,bg="green",col="red",cex=2)
text(ordiArrowTextXY(mul * bp, labs), labs, col = cols)
```

#### display="species"

```R
cols <- "blue"
# 1-2
choice<- c(1,2)
plot(res, type = 'n',display="species",choice=choice)
text(res,"sp",pch=4,col="red",choice=choice)
bp <- scores(res, display = 'bp',choice=choice)
mul <- ordiArrowMul(bp, fill = 0.75)
arrows(0, 0, mul * bp[,1], mul * bp[,2],length = 0.05, col = cols)
labs <- rownames(bp)
text(ordiArrowTextXY(mul * bp, labs), labs, col = cols)
# 2-3
choice<- c(2,3)
plot(res, type = 'n',display="species",choice=choice)
text(res,"sp",pch=4,col="red",choice=choice)
bp <- scores(res, display = 'bp',choice=choice)
mul <- ordiArrowMul(bp, fill = 0.75)
arrows(0, 0, mul * bp[,1], mul * bp[,2],length = 0.05, col = cols)
labs <- rownames(bp)
text(ordiArrowTextXY(mul * bp, labs), labs, col = cols)
# 1-3
choice<- c(1,3)
plot(res, type = 'n',display="species",choice=choice)
text(res,"sp",pch=4,col="red",choice=choice)
bp <- scores(res, display = 'bp',choice=choice)
mul <- ordiArrowMul(bp, fill = 0.75)
arrows(0, 0, mul * bp[,1], mul * bp[,2],length = 0.05, col = cols)
labs <- rownames(bp)
text(ordiArrowTextXY(mul * bp, labs), labs, col = cols)
```

#### models(investr::plotFit関数　信頼区間、予測区間も)

グラフ作成に必要なのは iは1から11
- estclim[[i]][[2]] : 点をプロットする際のxの値
- climate : 点をプロットする際のyの値
- estclim[[i]][[1]] : 非線形会期の結果
- Fdat,EBS,co(過去の気候条件のCCAの位置もプロットしたい場合)

(注意)作業フォルダに１１枚のグラフが保存される

```R
unit<- c(rep("(℃)",3),"(month)",rep("(cm)",4),"(%)","(g/Kg)","(kJ/Kg)")
for(i in 1:11){
	df<- data.frame(x=estclim[[i]][[2]],y=climate[,i])
	#fm<-nls(y ~a+b*x+c*x^2,start=c(a=1,b=1,c=-1),data=df) 
	png(paste0("estclimate",i,".png"),width=600,height=600)
	plotFit(estclim[[i]][[1]], data=df,interval = "both", pch = 16, shade = TRUE, 
        	col.conf = "skyblue3", col.pred = "lightskyblue1",las=1,
		xlab="Predicted data",ylab="Observeed data",bty="l")  
	box(bty="l",lwd=2.5)
	G23<- sum(EBS[i,]*Fdat)/sqrt(sum(EBS[i,]^2))
	pred<- co[i,3]+co[i,2]*G23+co[i,1]*(G23*G23)
	points(G23,pred,col="red",pch=21,bg="green",cex=2)
	title(paste(names(estclim)[i],unit[i]))
	dev.off()
}
```

#### modelの当てはまり具合:coefficients&cor

```R
for (i in 1:11){
	print(names(estclim)[i])
	print(summary(estclim[[i]][[1]])$coefficients)
	print(cor(climate[,i],predict(estclim[[i]][[1]])))
}
```

[1] "MAT"  
    Estimate Std. Error   t value      Pr(>|t|)  
a 16.3579106  0.2611738 62.632290 2.725286e-121  
b  5.9302490  0.1705780 34.765605  3.131740e-80  
c -0.5320794  0.1773889 -2.999508  3.100952e-03  
[1] 0.9351043  
 
[1] "WMMT"  
    Estimate Std. Error   t value      Pr(>|t|)  
a 25.2041529  0.2869906 87.822225 4.825193e-146  
b  3.4444367  0.2019746 17.053815  5.680496e-39  
c -0.9232594  0.1407144 -6.561229  5.888471e-10  
[1] 0.7914057  

[1] "CMMT"  
    Estimate Std. Error   t value     Pr(>|t|)  
a  7.9140657  0.3819396 20.720723 7.452156e-49  
b  7.8867830  0.2644334 29.825219 2.626785e-70  
c -0.4065136  0.2448512 -1.660247 9.866579e-02  
[1] 0.9170286  

[1] "GROWSEAS"  
    Estimate Std. Error   t value      Pr(>|t|)  
a  9.0110581 0.11933084 75.513235 6.361558e-135  
b  2.5778085 0.07672726 33.597036  5.576339e-78  
c -0.2998703 0.07947566 -3.773108  2.208427e-04  
[1] 0.930845  

[1] "GSP"  
    Estimate Std. Error   t value     Pr(>|t|)  
a 109.737195   6.455079 17.000133 8.012685e-39  
b  53.012785   4.515555 11.740037 8.173003e-24  
c  -4.306354   2.809540 -1.532761 1.271509e-01  
[1] 0.7233859  

[1] "MMGSP"  
    Estimate Std. Error    t value     Pr(>|t|)  
a 11.1848165  0.6096557 18.3461183 1.572144e-42  
b  3.8433907  0.3501525 10.9763339 1.234694e-21  
c  0.1470994  0.2153596  0.6830409 4.954894e-01  
[1] 0.6634864  

[1] "3-WET"   
    Estimate Std. Error    t value     Pr(>|t|)  
a 63.5270738   3.643143 17.4374341 4.902206e-40  
b 19.5580551   2.209388  8.8522486 9.579353e-16  
c -0.4168687   1.422290 -0.2930968 7.697974e-01  
[1] 0.5798722  

[1] "3-DRY"  
    Estimate Std. Error   t value     Pr(>|t|)  
a 11.9916369  0.8499925 14.107932 1.261883e-30  
b  4.9527832  0.5200531  9.523610 1.436536e-17  
c  0.6583732  0.2383090  2.762687 6.349199e-03  
[1] 0.6144506  

[1] "RH"   
    Estimate Std. Error  t value      Pr(>|t|)  
a 68.2896338  0.7718588 88.47426 1.369980e-146  
b  7.9800504  0.7642046 10.44230  3.991501e-20  
c  0.3777119  0.2704859  1.39642  1.643669e-01  
[1] 0.7416026  

[1] "SH"   
    Estimate Std. Error   t value     Pr(>|t|)  
a  9.3022912  0.2082150 44.676378 2.851895e-97  
b  3.4618990  0.1665372 20.787538 4.995837e-49  
c -0.4610003  0.1268174 -3.635151 3.656039e-04  
[1] 0.882988  

[1] "ENTHAL"  
    Estimate Std. Error    t value      Pr(>|t|)  
a 32.6300571 0.09595950 340.039866 1.466026e-247  
b  1.9266239 0.07577585  25.425301  1.728132e-60  
c -0.2720693 0.06086020  -4.470397  1.403800e-05  
[1] 0.9090342  
