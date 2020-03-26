---
title: Rで折れ線グラフ、棒グラフ (Coronavirus)[2020-03-26更新]
date: 2020-03-26
tags: ["R","DataComputing", "Coronavirus","Japan","新型コロナウイルス"]
excerpt: Rで折れ線グラフ、棒グラフ (Coronavirus)
---

# Rで折れ線グラフ、棒グラフ (Coronavirus) 
![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus09)

## ちょっと工夫した折れ線グラフ、棒グラフを作りました。

## 新型コロナウイルスの感染状況
米ジョンズ・ホプキンス大学の新型コロナウイルスの感染状況をまとめたWebサイト  
[Coronavirus 2019-nCoV Global Cases by Johns Hopkins CSSE](https://gisanddata.maps.arcgis.com/apps/opsdashboard/index.html#/bda7594740fd40299423467b48e9ecf6)

データはGitHubから入手できます。  
[2019 Novel Coronavirus COVID-19 (2019-nCoV) Data Repository by Johns Hopkins CSSE](https://github.com/CSSEGISandData/COVID-19)  

使用するデータ（3/22からファイル場所、名前変更）  
[CSSE COVID-19 Dataset](https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series)

### 新型コロナウイルスに感染された方、回復された方、亡くなった方の数の推移（日別）

#### y軸のラベルの数値にコンマをつけ、x軸のラベルを選択して表示

![Coronavirus001](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Coronavirus001.png)

### 致死率(%):Deaths/Confirmed の推移

#### (%)の表示をy軸の上部に配置、x軸のラベルを選択して22 Jan.のように表示

![Coronavirus01_1](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Coronavirus01_1.png)

### 報告された感染者数が一定数超えた時点を起点とした折れ線グラフ（再掲）

#### 片対数グラフ（Semi-log plot） 
(参考)[Alessandro Strumia(physicist) Twitter:Days since reported cases reach 200](https://twitter.com/AlessandroStru4/status/1236391718318157830/photo/1)

##### Days since reported cases reach 600
![CoronavirusG600](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/CoronavirusG600.png)

### 報告された感染者数が100人以上の国ごとの感染者数の棒グラフ

#### x軸のラベルの数値にコンマ、国ごとの値をグラフ右に表記

![Coronavirus01_2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Coronavirus01_2.png)

### 報告された感染者数が100人以上の国ごとの致死率の棒グラフ 

#### 日本と韓国のグラフの色、ラベルの色を変えた。

![Coronavirus01_3](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Coronavirus01_3.png)

#### 報告された感染者数 / 人口 * 100 (タイトルにbquote関数を使う)

![Coronavirus01_4](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Coronavirus01_4.png)

|country        |        pop| population_density| Confirmed| Confirmed_per_Pop|
|:--------------|----------:|------------------:|---------:|-----------------:|
|India          | 1236344631|             376.10|       657|          0.000053|
|Indonesia      |  253609643|             133.16|       790|          0.000312|
|Russia         |  142470272|               8.33|       658|          0.000462|
|Pakistan       |  196174380|             246.42|      1063|          0.000542|
|Philippines    |  107668231|             358.89|       636|          0.000591|
|Japan          |  127103388|             336.33|      1307|          0.001028|
|Brazil         |  202656788|              23.80|      2554|          0.001260|
|Thailand       |   67741401|             132.02|       934|          0.001379|
|South Africa   |   48375645|              39.68|       709|          0.001466|
|Poland         |   38346279|             122.64|      1051|          0.002741|
|Turkey         |   81619392|             104.16|      2433|          0.002981|
|Saudi Arabia   |   27345986|              12.72|       900|          0.003291|
|Romania        |   21729871|              91.15|       906|          0.004169|
|Malaysia       |   30073353|              91.17|      1796|          0.005972|
|China          | 1355692576|             141.26|     81661|          0.006024|
|Chile          |   17363894|              22.97|      1142|          0.006577|
|Ecuador        |   15654411|              55.21|      1173|          0.007493|
|Greece         |   10775557|              81.66|       821|          0.007619|
|Canada         |   34834841|               3.49|      3251|          0.009333|
|Australia      |   22507617|               2.91|      2364|          0.010503|
|Singapore      |    5567301|            7987.52|       631|          0.011334|
|United Kingdom |   63742977|             261.66|      9640|          0.015123|
|Czechia        |   10627448|             134.75|      1654|          0.015563|
|Finland        |    5268799|              15.58|       880|          0.016702|
|Korea, South   |   49039986|             491.78|      9137|          0.018632|
|US             |  318892103|              32.45|     65778|          0.020627|
|Qatar          |    2123160|             183.25|       537|          0.025292|
|Sweden         |    9723809|              21.59|      2526|          0.025977|
|Slovenia       |    1988292|              98.08|       528|          0.026555|
|Portugal       |   10813834|             117.43|      2995|          0.027696|
|Israel         |    7821850|             376.59|      2369|          0.030287|
|Ireland        |    4832765|              68.77|      1564|          0.032362|
|Iran           |   80840713|              49.05|     27017|          0.033420|
|Denmark        |    5569077|             129.23|      1862|          0.033435|
|Netherlands    |   16877351|             406.26|      6438|          0.038146|
|France         |   66259012|             102.92|     25600|          0.038636|
|Germany        |   80996685|             226.87|     37323|          0.046080|
|Belgium        |   10449361|             342.29|      4937|          0.047247|
|Norway         |    5147792|              15.90|      3084|          0.059909|
|Austria        |    8223062|              98.04|      5588|          0.067955|
|Spain          |   47737941|              94.46|     49515|          0.103723|
|Italy          |   61680122|             204.69|     74386|          0.120600|
|Switzerland    |    8061516|             195.30|     10897|          0.135173|
|Iceland        |     317351|               3.08|       737|          0.232235|
|Luxembourg     |     520672|             201.34|      1333|          0.256015|

## 日本の人口あたり（報告された！！）感染者が少ないのは検査しないから。

R code : [韓国と日本のPCR検査実施人数比較 (新型コロナウイルス：Coronavirus)](https://gitpress.io/@statrstart/Coronavirus08)  

![pcr04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr04.png)

## Rコード

### データをGitHubから入手。(read.csvの際には、check.names=Fをつける)

```R
# read.csvの際には、check.names=Fをつける
url<- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"
Confirmed<- read.csv(url,check.names=F)
url<- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv"
Deaths<- read.csv(url,check.names=F)
url<- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv"
Recovered<- read.csv(url,check.names=F)
#save(Confirmed,file="Confirmed.Rdata") ; save(Recovered,file="Recovered.Rdata") ; save(Deaths,file="Deaths.Rdata") 
```
### 全世界の日毎の合計：Confirmed , Deaths, Recovered  別

```R
# Confirmed , Deaths, Recoveredのデータ数が違うことがある。
# rbindを使うと不具合あり。もしくはエラーとなる。
nCoV1<-colSums(Confirmed[,5:ncol(Confirmed)])
nCoV2<-colSums(Deaths[,5:ncol(Deaths)])
nCoV3<-colSums(Recovered[,5:ncol(Recovered)])
lenmax<- max(c(length(nCoV1),length(nCoV2),length(nCoV3)))
nCoV<-matrix(NA,nrow=3,ncol=lenmax)
nCoV[1,1:length(nCoV1)]<- nCoV1
nCoV[2,1:length(nCoV2)]<- nCoV2
nCoV[3,1:length(nCoV3)]<- nCoV3
rownames(nCoV)<- c("Confirmed","Deaths","Recovered")
colnames(nCoV)<- names(nCoV1)
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
labelpos<- c("2/1","2/10","2/20","3/1","3/10","3/20")
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
# nCoVの2行目 / nCoVの1行目
MR<- round(nCoV[2,]/nCoV[1,] *100,4)
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

#### 片対数グラフ（Semi-log plot）ここでは、報告された感染者数 600人以上

- min,max : 報告された感染者数 min 人以上、max 未満
- Sp : Starting pointとする感染者数
- length : Starting pointとする感染者数に合わせるための調整
- xlim : x軸の範囲

```R
min<- 600
max<- +Inf
G600<- timeline[apply(timeline,1,max,na.rm=T)>= min & apply(timeline,1,max,na.rm=T)< max,] 
# Diamond Princessを除く
G600<-G600[grep("Diamond Princess",rownames(G600),invert =T),]
G600<-G600[order(apply(G600,1,max,na.rm=T),decreasing=T),]
col<- rainbow(nrow(G600))
#
#Starting point
Sp<- 600 # Starting pointとする感染者数
length<- 10 # Starting pointとする感染者数に合わせるための調整
xlim=c(-10,40) # 範囲
col<- rainbow(nrow(G600))
pch<- rep(c(0,1,2,4,5,6,15,16,17,18),5)
#png("CoronavirusG600.png",width=800,height=600)
par(mar=c(5,5,4,20),family="serif")
# 
plot(1,1,type="n",xlab=paste0("Days since reported cases reach ",Sp),
	ylab="Number of reported cases (log10)",yaxt="n",log="y",
	ylim=c(0.9,10^5),xlim=xlim,yaxs="i")
abline(v=seq(-20,20,10),col=c("gray","gray","black","gray","gray"),lty=3)
for(i in 0:5){
  abline(h=seq(1,9)*10^i,col="gray",lty=3)
}
box(lwd=2.5)
#
for (i in 1:length(col)){
p0<- as.numeric(G600[i,])
p<-NULL
for (j in 1:(length(p0)-1)){
	p<- c(p,seq(p0[j],p0[j+1],length=length))
}
p1<- length(p[p<Sp])
p2<- length(p[p>=Sp])
lines(seq(-p1/length,(p2/length - 1/length),1/length),p,lwd=0.8,col=col[i])
points(seq(-p1,p2,length)/length,p0,cex=0.8,col=col[i],pch=pch[i])
if (i== grep("Japan",rownames(G600))){
	text(x=p2[length(p2)]/length,y=p0[length(p0)],labels="Japan",cex=1.2,col="black",pos=4)
	}
if (i== grep("Korea, South",rownames(G600))){
	text(x=p2[length(p2)]/length,y=p0[length(p0)],labels="South Korea",cex=1.2,col="black",pos=4)
	}
#if (i== grep("Singapore",rownames(G600))){
#	text(x=p2[length(p2)]/length,y=p0[length(p0)],labels="Singapore",cex=1.2,col="black",pos=4)
#	}
}
for(i in 0:5){
  axis(side=2, at=10^i, labels=bquote(10^.(i)) ,las=1)
  axis(side=2, at=seq(2,9)*10^i, tck=-0.01,labels=F)
}
#legend(x="topleft",inset=c(0.03,0.01),ncol=2,legend=rownames(G600),pch=pch,lwd=1,col=col,xpd=T,
#	bty="n",x.intersp= 1,y.intersp =1.1,cex=1.2)
legend(x=par("usr")[2],y=10^par("usr")[4],legend=rownames(G600),pch=pch,lwd=1,col=col,xpd=T,bty="n",cex=1,ncol=2)
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

### 報告された感染者数 500人以上の国だけをとりだす。

```R
min<- 500
DR<- DRbyC[DRbyC$Confirmed >= min ,] 
# Diamond Princessを除く
DR<- DR[grep("Diamond Princess",rownames(DR),invert =T),]
```

### 報告された感染者数が500人以上の国ごとの感染者数の棒グラフ

```R
# Confirmedの昇順に並べ替え
DR<- DR[order(DR$Confirmed,decreasing=F),]
#png("Coronavirus01_2.png",width=800,height=800)
par(mar=c(5,10,3,7),family="serif")
b<- barplot(t(DR)[1,],las=1,horiz=T,xaxt="n")
axis(side=1, at=axTicks(1), labels=formatC(axTicks(1), format="d", big.mark=','))
text(x=t(DR)[1,],y=b,labels=formatC(t(DR)[1,], format="d", big.mark=','),pos=4,xpd=T,font=1)
title(bquote("Reported confirmed COVID-19 cases (Country/Region : "~Positive>=.(min)~")"))
#dev.off()
```

### 報告された感染者数が500人以上の国ごとの致死率の棒グラフ 

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
axis(2, at = b,labels=NA,tck= -0.008)
text(x=par("usr")[1],y=b, labels = colnames(t(DR)), col = col2,pos=2,xpd=T,font=3)
mtext("Reported deaths / Reported cases (%)",side=1,line=3)
title(bquote("Covid-19 : Death rates by country (%) (Country/Region : "~Positive>=.(min)~")"))
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
# 報告された感染者数 500人以上の国
min<- 500
G500<- timeline[apply(timeline,1,max,na.rm=T)>= min ,] 
# Diamond Princessを除く
G500<-G500[grep("Diamond Princess",rownames(G500),invert =T),]
G500<-G500[order(apply(G500,1,max,na.rm=T),decreasing=T),]
cdata<- CountryData[is.element(CountryData$country,rownames(G500)),1:3]
#nrow(G500) ; nrow(cdata) が等しくない
rownames(G500)[!is.element(rownames(G500),cdata$country)]
#[1] "US"      "Czechia"
#CountryData$country
# アメリカのnameがCountryDataは"United States" ジョンズ・ホプキンス大学のデータは"US"
# チェコ共和国のnameがCountryDataは"Czech Republic"ジョンズ・ホプキンス大学のデータは"Czechia"
( cdata<- CountryData[is.element(CountryData$country,c("Czech Republic","United States",rownames(G500))),1:3] )
# 確認(同数か否か)
nrow(G500) ;nrow(cdata)
#
# cdataのUnited StatesをUSに変更(ジョンズ・ホプキンス大学のデータに合わせる)
cdata$country<- sub("United States","US",cdata$country)
cdata$country<- sub("Czech Republic","Czechia",cdata$country)
# 人口密度(population density)
cdata$population_density<- round(cdata[,3]/cdata[,2],2)
# 最新の報告された感染者のみ取り出し、merge
dat<- G500[,ncol(G500),drop=F]
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
#title("Reported confirmed / number of people *100 (Reported confirmed>=500)")
#title(expression(paste("Reported confirmed / number of people *100 (Reported ", confirmed>=500,")")))
title(bquote("Reported confirmed / number of people *100 (Reported "~confirmed>=.(min)~")"))
#dev.off()
```
