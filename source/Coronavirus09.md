---
title: Rで折れ線グラフ、棒グラフ (Coronavirus)[2020-03-19更新]
date: 2020-03-19
tags: ["R","DataComputing", "Coronavirus","Japan","新型コロナウイルス"]
excerpt: Rで折れ線グラフ、棒グラフ (Coronavirus)
---

# RでRで折れ線グラフ、棒グラフ (Coronavirus) 
![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus09)

## ちょっと工夫した折れ線グラフ、棒グラフを作りました。

## 新型コロナウイルスの感染状況
米ジョンズ・ホプキンス大学の新型コロナウイルスの感染状況をまとめたWebサイト  
[Coronavirus 2019-nCoV Global Cases by Johns Hopkins CSSE](https://gisanddata.maps.arcgis.com/apps/opsdashboard/index.html#/bda7594740fd40299423467b48e9ecf6)

データはGitHubから入手できます。  
[2019 Novel Coronavirus COVID-19 (2019-nCoV) Data Repository by Johns Hopkins CSSE](https://github.com/CSSEGISandData/COVID-19)  

使用するデータ（日次データになったので更新回数が減ってしまった。）  
[CSSE COVID-19 Dataset](https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data)

### 新型コロナウイルスに感染された方、回復された方、亡くなった方の数の推移（日別）

#### y軸のラベルの数値にコンマをつけ、x軸のラベルを選択して表示

![Coronavirus001](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Coronavirus001.png)

### 致死率(%):Deaths/Confirmed の推移

#### (%)の表示をy軸の上部に配置、x軸のラベルを選択して22 Jan.のように表示

![Coronavirus01_1](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Coronavirus01_1.png)

### 報告された感染者数が一定数超えた時点を起点とした折れ線グラフ（再掲）

#### 片対数グラフ（Semi-log plot） 
(参考)[Alessandro Strumia(physicist) Twitter:Days since reported cases reach 200](https://twitter.com/AlessandroStru4/status/1236391718318157830/photo/1)

##### Days since reported cases reach 80(except China)
![CoronavirusG1_2L](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/CoronavirusG1_2L.png)

### シンガポールは、報告された感染者の増加が日本より緩やかですが、人口が日本に比べて非常に少ない。
- 面積：約720平方キロメートル（東京23区と同程度）　
- 人口：約564万人（うちシンガポール人・永住者は399万人）（2019年1月） 
[外務省HP:シンガポール共和国（Republic of Singapore）基礎データ](https://www.mofa.go.jp/mofaj/area/singapore/data.html)

##### Days since reported cases reach 600
![CoronavirusG600](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/CoronavirusG600.png)

### 報告された感染者数が100人以上の国ごとの感染者数の棒グラフ

#### x軸のラベルの数値にコンマ、国ごとの値をグラフ右に表記

![Coronavirus01_2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Coronavirus01_2.png)

### 報告された感染者数が100人以上の国ごとの致死率の棒グラフ 

#### 日本と韓国のグラフの色、ラベルの色を変えた。

![Coronavirus01_3](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Coronavirus01_3.png)

#### 報告された感染者数 / 人口 * 100 (タイトルにexpression関数を使う)

![Coronavirus01_4](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Coronavirus01_4.png)

|country        |        pop| population_density| Confirmed| Confirmed_per_Pop|
|:--------------|----------:|------------------:|---------:|-----------------:|
|Indonesia      |  253609643|             133.16|       227|          0.000090|
|Pakistan       |  196174380|             246.42|       299|          0.000152|
|Brazil         |  202656788|              23.80|       372|          0.000184|
|Philippines    |  107668231|             358.89|       202|          0.000188|
|Thailand       |   67741401|             132.02|       212|          0.000313|
|Poland         |   38346279|             122.64|       251|          0.000655|
|Japan          |  127103388|             336.33|       889|          0.000699|
|Romania        |   21729871|              91.15|       260|          0.001197|
|Chile          |   17363894|              22.97|       238|          0.001371|
|Canada         |   34834841|               3.49|       657|          0.001886|
|US             |  318892103|              32.45|      7783|          0.002441|
|Australia      |   22507617|               2.91|       568|          0.002524|
|Malaysia       |   30073353|              91.17|       790|          0.002627|
|Greece         |   10775557|              81.66|       418|          0.003879|
|Portugal       |   10813834|             117.43|       448|          0.004143|
|United Kingdom |   63742977|             261.66|      2642|          0.004145|
|Czechia        |   10627448|             134.75|       464|          0.004366|
|Israel         |    7821850|             376.59|       433|          0.005536|
|Singapore      |    5567301|            7987.52|       313|          0.005622|
|China          | 1355692576|             141.26|     81102|          0.005982|
|Ireland        |    4832765|              68.77|       292|          0.006042|
|Finland        |    5268799|              15.58|       336|          0.006377|
|Netherlands    |   16877351|             406.26|      2058|          0.012194|
|Sweden         |    9723809|              21.59|      1279|          0.013153|
|France         |   66259012|             102.92|      9105|          0.013742|
|Slovenia       |    1988292|              98.08|       275|          0.013831|
|Belgium        |   10449361|             342.29|      1486|          0.014221|
|Germany        |   80996685|             226.87|     12327|          0.015219|
|Korea, South   |   49039986|             491.78|      8413|          0.017155|
|Bahrain        |    1314089|            1729.06|       256|          0.019481|
|Austria        |    8223062|              98.04|      1646|          0.020017|
|Denmark        |    5569077|             129.23|      1115|          0.020021|
|Estonia        |    1257921|              27.81|       258|          0.020510|
|Qatar          |    2123160|             183.25|       452|          0.021289|
|Iran           |   80840713|              49.05|     17361|          0.021476|
|Spain          |   47737941|              94.46|     13910|          0.029138|
|Norway         |    5147792|              15.90|      1550|          0.030110|
|Switzerland    |    8061516|             195.30|      3028|          0.037561|
|Luxembourg     |     520672|             201.34|       203|          0.038988|
|Italy          |   61680122|             204.69|     35713|          0.057900|
|Iceland        |     317351|               3.08|       250|          0.078777|

## 日本の人口あたり（報告された！！）感染者が少ないのは検査しないから。

R code : [韓国と日本のPCR検査実施人数比較 (新型コロナウイルス：Coronavirus)](https://gitpress.io/@statrstart/Coronavirus08)  

![pcr04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr04.png)

## Rコード

### データをGitHubから入手。(read.csvの際には、check.names=Fをつける)

```R
# read.csvの際には、check.names=Fをつける
url<- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Confirmed.csv"
Confirmed<- read.csv(url,check.names=F)
url<- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Recovered.csv"
Recovered<- read.csv(url,check.names=F)
url<- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_19-covid-Deaths.csv"
Deaths<- read.csv(url,check.names=F)
```
### 全世界の日毎の合計：Confirmed , Recovered , Deaths 別

```R
nCoV<-colSums(Confirmed[,5:ncol(Confirmed)])
nCoV<-rbind(nCoV,colSums(Recovered[,5:ncol(Recovered)]))
nCoV<-rbind(nCoV,colSums(Deaths[,5:ncol(Deaths)]))
rownames(nCoV)<- c("Confirmed","Recovered","Deaths")
```

### 感染者、回復された方、亡くなった方の数の推移（日別）

```R
# 指数表示を抑制
options(scipen=2) 
#png("Coronavirus001.png",width=800,height=600)
par(mar=c(5,6,3,2),family="serif")
matplot(t(nCoV),type="o",col=1:3,lwd=1.5,lty=1:3,pch=16:18,las=1,xaxt="n",yaxt="n",xlab="",ylab="",bty="l")
box(bty="l",lwd=2)
#axis(1,at=1:ncol(nCoV), labels =sub("/20","",colnames(nCoV)))
#表示するx軸ラベルを指定
axis(1,at=1:ncol(nCoV), labels =NA)
labels<-sub("/20","",colnames(nCoV))
labelpos<- c("2/1","2/10","2/20","3/1","3/10")
axis(1,at=1,labels =labels[1])
for (i in labelpos){
	at<- match(i,labels)
	axis(1,at=at,labels = i)
	}
# Add comma separator to axis labels
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
legend("topleft", legend = rownames(nCoV),col=1:3,lwd=1.5,lty=1:3,pch=16:18,inset =c(0.02,0.03))
title("Coronavirus [ Total Confirmed,Total Recovered,Total Deaths ]")
#dev.off()
```

### 致死率(%):Deaths/Confirmed の推移

```R
MR<- round(nCoV[3,]/nCoV[1,] *100,4)
#png("Coronavirus01_1.png",width=800,height=600)
par(mar=c(5,6,3,2),family="serif")
plot(MR,type="o",pch=16,lwd=2,cex=1.5,las=1,xaxt="n",ylab="Reported deaths / Reported cases",bty="l",xlab="")
box(bty="l",lwd=2)
labels<-sub("/20","",colnames(nCoV))
labels<-gsub("^.*/","",labels)
pos<-gsub("/.*$","",sub("/20","",colnames(nCoV)))
axis(1,at=1:ncol(nCoV),labels =NA)
#月の区切り
#axis(1,at=cumsum(as.vector(table(pos)))+0.5, labels =NA,tck=-0.1,lty=2 ,lwd=1)
axis(1,at=1,labels ="22")
for (i in c("1","10","20")){
	at<- grep("TRUE",is.element(labels,i))
	axis(1,at=at,labels = rep(i,length(at)))
	}
#Month<-c("January","February","March","April","May","June","July","August","September","October","November","December")
Month<-c("Jan.","Feb.","Mar.","Apr.","May","Jun.","Jul.","Aug.","Sep.","Oct.","Nov.","Dec.")
#cut(1:12,breaks = seq(0,12),right=T, labels =Month)
mon<-cut(as.numeric(names(table(pos))),breaks = seq(0,12),right=T, labels =Month)
# 月の中央
#mtext(text=mon,at=cumsum(as.vector(table(pos)))-as.vector(table(pos)/2),side=1,line=2) 
# 月のはじめ
mtext(text=mon,at=1+cumsum(as.vector(table(pos)))-as.vector(table(pos)),side=1,line=2) 
text(x=par("usr")[1],y=par("usr")[4],labels="(%)",pos=2,xpd=T,font=2)
title("Covid-19 : Death rates")
#dev.off()
```

### ConfirmedをCountry/Regionごとに集計

```R
timeline<- aggregate(Confirmed[,5:ncol(Confirmed)], sum, by=list(Confirmed$"Country/Region"))
rownames(timeline)<-timeline[,1]
timeline<- timeline[,-1]
```

### 報告された感染者数が一定数超えた時点を起点とした折れ線グラフ（再掲）

#### 片対数グラフ（Semi-log plot）ここでは、報告された感染者数 200人以上20000人未満

- min,max : 報告された感染者数 min 人以上、max 未満
- Sp : Starting pointとする感染者数
- length : Starting pointとする感染者数に合わせるための調整
- xlim : x軸の範囲

```R
min<- 200
max<- 40000
G1_2<- timeline[apply(timeline,1,max,na.rm=T)>= min & apply(timeline,1,max,na.rm=T)< max,] 
# Cruise Shipを除く
G1_2<-G1_2[grep("Cruise Ship",rownames(G1_2),invert =T),]
G1_2<-G1_2[order(apply(G1_2,1,max,na.rm=T),decreasing=T),]
col<- rainbow(nrow(G1_2))
#
#Starting point
Sp<- 80 # Starting pointとする感染者数
length<- 10 # Starting pointとする感染者数に合わせるための調整
xlim=c(-10,35) # 範囲
col<- rainbow(nrow(G1_2))
pch<- rep(c(0,1,2,4,5,6,15,16,17,18),5)
#png("CoronavirusG1_2L.png",width=800,height=600)
par(mar=c(5,5,4,20),family="serif")
# 
plot(1,1,type="n",xlab=paste0("Days since reported cases reach ",Sp),
	ylab="Number of reported cases (except China)",yaxt="n",log="y",
	ylim=c(0.9,4*10^4),xlim=xlim,yaxs="i")
abline(v=seq(-20,20,10),col=c("gray","gray","black","gray","gray"),lty=3)
for(i in 0:5){
  abline(h=seq(1,9)*10^i,col="gray",lty=3)
}
box(lwd=2.5)
#
for (i in 1:length(col)){
p0<- as.numeric(G1_2[i,])
p<-NULL
for (j in 1:(length(p0)-1)){
	p<- c(p,seq(p0[j],p0[j+1],length=length))
}
p1<- length(p[p<Sp])
p2<- length(p[p>=Sp])
lines(seq(-p1/length,(p2/length - 1/length),1/length),p,lwd=0.8,col=col[i])
points(seq(-p1,p2,length)/length,p0,cex=0.8,col=col[i],pch=pch[i])
if (i== grep("Japan",rownames(G1_2))){
	text(x=p2[length(p2)]/length,y=p0[length(p0)],labels="Japan",cex=1.2,col="black",pos=4)
	}
if (i== grep("Korea, South",rownames(G1_2))){
	text(x=p2[length(p2)]/length,y=p0[length(p0)],labels="South Korea",cex=1.2,col="black",pos=4)
	}
if (i== grep("Singapore",rownames(G1_2))){
	text(x=p2[length(p2)]/length,y=p0[length(p0)],labels="Singapore",cex=1.2,col="black",pos=4)
	}
}
for(i in 0:5){
  axis(side=2, at=10^i, labels=bquote(10^.(i)) ,las=1)
  axis(side=2, at=seq(2,9)*10^i, tck=-0.01,labels=F)
}
#legend(x="topleft",inset=c(0.03,0.01),ncol=2,legend=rownames(G1_2),pch=pch,lwd=1,col=col,xpd=T,
#	bty="n",x.intersp= 1,y.intersp =1.1,cex=1.2)
legend(x=par("usr")[2],y=10^par("usr")[4],legend=rownames(G1_2),pch=pch,lwd=1,col=col,xpd=T,bty="n",cex=1,ncol=2)
# dev.off()
```

### DeathsをCountry/Regionごとに集計

```R
timelineD<- aggregate(Deaths[,5:ncol(Deaths)], sum, by=list(Deaths$"Country/Region"))
rownames(timelineD)<-timelineD[,1]
timelineD<- timelineD[,-1]
```

### 最後の日付のデータのみ取り出す(drop=F : data.frameで)

#### Confirmed,Deathsのデータをmergeし、致死率計算

```R
# key : row.namesでmerge
DRbyC<- merge(timeline[,ncol(timeline),drop=F],timelineD[,ncol(timelineD),drop=F],by="row.names")
#DRbyC$Row.namesをrownames(DRbyC)に
rownames(DRbyC)<- DRbyC$Row.names
DRbyC<- DRbyC[,-1]
colnames(DRbyC)<- c("Confirmed","Deaths")
# death rate = Deaths/Confirmed *100 
DRbyC$Death.rate<- round(DRbyC$Deaths/DRbyC$Confirmed *100,4)
```

### 報告された感染者数 100人以上の国だけをとりだす。

```R
min<- 100
DR<- DRbyC[DRbyC$Confirmed >= min ,] 
# Cruise Shipを除く
DR<- DR[grep("Cruise Ship",rownames(DR),invert =T),]
```

### 報告された感染者数が100人以上の国ごとの感染者数の棒グラフ

```R
# Confirmedの昇順に並べ替え
DR<- DR[order(DR$Confirmed,decreasing=F),]
#png("Coronavirus01_2.png",width=800,height=800)
par(mar=c(5,10,3,7),family="serif")
b<- barplot(t(DR)[1,],las=1,horiz=T,xaxt="n")
axis(side=1, at=axTicks(1), labels=formatC(axTicks(1), format="d", big.mark=','))
text(x=t(DR)[1,],y=b,labels=formatC(t(DR)[1,], format="d", big.mark=','),pos=4,xpd=T,font=1)
title("Reported confirmed COVID-19 cases",font=4)
#dev.off()
```

### 報告された感染者数が100人以上の国ごとの致死率の棒グラフ 

```R
# Death.rateの昇順に並べ替え
DR<- DR[order(DR$Death.rate,decreasing=F),]
#
# Japan の色だけ変える
TF<- is.element(colnames(t(DR)),c("Japan"))
col<- gsub("TRUE","red",gsub("FALSE","lightblue",TF))
col2<- gsub("TRUE","red",gsub("FALSE","black",TF))
# 韓国の色も変えたいなら
col[grep("Korea, South",rownames(DR))]<- "orange"
col2[grep("Korea, South",rownames(DR))]<- "orange"
# png("Coronavirus01_3.png",width=800,height=800)
par(mar=c(6,10,4,3),family="serif")
b<- barplot(t(DR)[3,],las=1,col=col,horiz=T,names=NA)
axis(2, at = b,label=NA,tck= -0.008)
text(x=par("usr")[1],y=b, labels = colnames(t(DR)), col = col2,pos=2,xpd=T,font=3)
mtext("Reported deaths / Reported cases (%)",side=1,line=3)
title("Covid-19 : Death rates by country (%)")
#dev.off()
```

### githubで見つけたDataComputingパッケージの CountryDataデータ
[CountryData: Many variables on countries from the CIA factbook, 2014.](https://rdrr.io/github/DataComputing/DataComputing/man/CountryData.html)  

```R
#install.packages("remotes")
#remotes::install_github("DataComputing/DataComputing")
library(DataComputing)
data("CountryData")
#country: Name of the country.
#area: area (sq km), 2147
#pop: number of people
#
# 報告された感染者数 200人以上の国
min<- 200
G200<- timeline[apply(timeline,1,max,na.rm=T)>= min ,] 
# Cruise Shipを除く
G200<-G200[grep("Cruise Ship",rownames(G200),invert =T),]
G200<-G200[order(apply(G200,1,max,na.rm=T),decreasing=T),]
cdata<- CountryData[is.element(CountryData$country,rownames(G200)),1:3]
#nrow(G200) ; nrow(cdata) が等しくない
rownames(G200)[!is.element(rownames(G200),cdata$country)]
#[1] "US"      "Czechia"
#CountryData$country
# アメリカのnameがCountryDataは"United States" ジョンズ・ホプキンス大学のデータは"US"
# チェコ共和国のnameがCountryDataは"Czech Republic"ジョンズ・ホプキンス大学のデータは"Czechia"
( cdata<- CountryData[is.element(CountryData$country,c("Czech Republic","United States",rownames(G200))),1:3] )
# 確認(同数か否か)
nrow(G200) ;nrow(cdata)
#
# cdataのUnited StatesをUSに変更(ジョンズ・ホプキンス大学のデータに合わせる)
cdata$country<- sub("United States","US",cdata$country)
cdata$country<- sub("Czech Republic","Czechia",cdata$country)
# 人口密度(population density)
cdata$population_density<- round(cdata[,3]/cdata[,2],2)
# 最新の報告された感染者のみ取り出し、merge
dat<- G200[,ncol(G200),drop=F]
dat$country<- rownames(dat)
cdata<- merge(cdata,dat,by="country")
colnames(cdata)[5]<- "Confirmed"
# 報告された感染者 / 人口 *100
cdata$Confirmed_per_Pop<- round(cdata$Confirmed/cdata$pop*100,6)
# 報告された感染者 / 人口 *100 の昇順に並べ替え
cdata<- cdata[order(cdata$Confirmed_per_Pop,decreasing=F),]
knitr::kable(cdata[,c(1,3:6)],row.names=F)
```

#### barplot

```R
#png("Coronavirus01_4.png",width=800,height=800)
par(mar=c(5,8,4,2),family="serif")
barplot(cdata$Confirmed_per_Pop,names=cdata$country,las=1,horiz=T,col="lightblue")
#title("Reported confirmed / number of people *100 (Reported confirmed>=200)")
title(expression(paste("Reported confirmed / number of people *100 (Reported ", confirmed>=200,")")))
#dev.off()
```
