---
title: Rで折れ線グラフ、棒グラフ (新型コロナウイルス：Coronavirus)
date: 2020-04-08
tags: ["R","DataComputing", "Coronavirus","Japan","新型コロナウイルス"]
excerpt: 米ジョンズ・ホプキンス大学のデータ使用
---

# Rで折れ線グラフ、棒グラフ (新型コロナウイルス：Coronavirus) 
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

##### 死亡者数200人以上の国の死亡者数(表)

|               | 4/7/20|
|:--------------|------:|
|Italy          |  17127|
|Spain          |  14045|
|US             |  12722|
|France         |  10343|
|United Kingdom |   6171|
|Iran           |   3872|
|China          |   3335|
|Netherlands    |   2108|
|Belgium        |   2035|
|Germany        |   2016|
|Switzerland    |    821|
|Turkey         |    725|
|Brazil         |    686|
|Sweden         |    591|
|Canada         |    375|
|Portugal       |    345|
|Austria        |    243|
|Indonesia      |    221|
|Ireland        |    210|
|Denmark        |    203|

#### 死亡者数200人以上の国の致死率(%):Deaths/Confirmed の推移

![Coronavirus01_1_1](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Coronavirus01_1_1.png)

### 指定した国の致死率を計算、プロット(日本、韓国、台湾、シンガポール)

![Coronavirus01_1_2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Coronavirus01_1_2.png)

### 報告された感染者数が一定数超えた時点を起点とした折れ線グラフ

#### 片対数グラフ（Semi-log plot） 
(参考)[Alessandro Strumia(physicist) Twitter:Days since reported cases reach 200](https://twitter.com/AlessandroStru4/status/1236391718318157830/photo/1)

##### Days since reported cases reach 600
![CoronavirusG600](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/CoronavirusG600.png)

### 報告された感染者数が1000人以上の国ごとの感染者数の棒グラフ

#### x軸のラベルの数値にコンマ、国ごとの値をグラフ右に表記

![Coronavirus01_2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Coronavirus01_2.png)

### 報告された感染者数が1000人以上の国ごとの致死率の棒グラフ 

#### 日本と韓国のグラフの色、ラベルの色を変えた。

![Coronavirus01_3](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Coronavirus01_3.png)

#### 報告された感染者数 / 人口 * 100 (タイトルにbquote関数を使う)

![Coronavirus01_4](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Coronavirus01_4.png)

|country              |        pop| population_density| Confirmed| Confirmed_per_Pop|
|:--------------------|----------:|------------------:|---------:|-----------------:|
|India                | 1236344631|             376.10|      5311|          0.000430|
|Indonesia            |  253609643|             133.16|      2738|          0.001080|
|Egypt                |   86895099|              86.77|      1450|          0.001669|
|Mexico               |  120286655|              61.23|      2439|          0.002028|
|Pakistan             |  196174380|             246.42|      4035|          0.002057|
|Japan                |  127103388|             336.33|      3906|          0.003073|
|Ukraine              |   44291413|              73.38|      1462|          0.003301|
|Thailand             |   67741401|             132.02|      2258|          0.003333|
|Iraq                 |   32585692|              74.34|      1122|          0.003443|
|Philippines          |  107668231|             358.89|      3764|          0.003496|
|Morocco              |   32987206|              73.87|      1184|          0.003589|
|South Africa         |   48375645|              39.68|      1749|          0.003615|
|Algeria              |   38813722|              16.30|      1468|          0.003782|
|Argentina            |   43024374|              15.47|      1628|          0.003784|
|Colombia             |   46245297|              40.60|      1780|          0.003849|
|Russia               |  142470272|               8.33|      7497|          0.005262|
|China                | 1355692576|             141.26|     82718|          0.006102|
|Brazil               |  202656788|              23.80|     14034|          0.006925|
|Peru                 |   30147935|              23.46|      2954|          0.009798|
|Saudi Arabia         |   27345986|              12.72|      2795|          0.010221|
|Poland               |   38346279|             122.64|      4848|          0.012643|
|Malaysia             |   30073353|              91.17|      3963|          0.013178|
|Greece               |   10775557|              81.66|      1832|          0.017001|
|Dominican Republic   |   10349741|             212.65|      1956|          0.018899|
|Romania              |   21729871|              91.15|      4417|          0.020327|
|Korea, South         |   49039986|             491.78|     10331|          0.021066|
|Ecuador              |   15654411|              55.21|      3747|          0.023936|
|Australia            |   22507617|               2.91|      5895|          0.026191|
|New Zealand          |    4401916|              16.44|      1160|          0.026352|
|Singapore            |    5567301|            7987.52|      1481|          0.026602|
|Croatia              |    4470534|              78.99|      1282|          0.028677|
|Chile                |   17363894|              22.97|      5116|          0.029463|
|Moldova              |    3583288|             105.85|      1056|          0.029470|
|Serbia               |    7209764|              93.06|      2447|          0.033940|
|Turkey               |   81619392|             104.16|     34109|          0.041790|
|United Arab Emirates |    5628805|              67.33|      2359|          0.041909|
|Finland              |    5268799|              15.58|      2308|          0.043805|
|Czechia              |   10627448|             134.75|      5017|          0.047208|
|Canada               |   34834841|               3.49|     17872|          0.051305|
|Slovenia             |    1988292|              98.08|      1059|          0.053262|
|Panama               |    3608431|              47.84|      2100|          0.058197|
|Iran                 |   80840713|              49.05|     62589|          0.077423|
|Sweden               |    9723809|              21.59|      7693|          0.079115|
|United Kingdom       |   63742977|             261.66|     55949|          0.087773|
|Estonia              |    1257921|              27.81|      1149|          0.091341|
|Denmark              |    5569077|             129.23|      5266|          0.094558|
|Qatar                |    2123160|             183.25|      2057|          0.096884|
|Portugal             |   10813834|             117.43|     12442|          0.115056|
|Netherlands          |   16877351|             406.26|     19709|          0.116778|
|Ireland              |    4832765|              68.77|      5709|          0.118131|
|Norway               |    5147792|              15.90|      6086|          0.118225|
|Israel               |    7821850|             376.59|      9248|          0.118233|
|US                   |  318892103|              32.45|    396223|          0.124250|
|Germany              |   80996685|             226.87|    107663|          0.132923|
|Austria              |    8223062|              98.04|     12639|          0.153702|
|France               |   66259012|             102.92|    110065|          0.166113|
|Belgium              |   10449361|             342.29|     22194|          0.212396|
|Italy                |   61680122|             204.69|    135586|          0.219821|
|Switzerland          |    8061516|             195.30|     22253|          0.276040|
|Spain                |   47737941|              94.46|    141942|          0.297336|
|Iceland              |     317351|               3.08|      1586|          0.499762|
|Luxembourg           |     520672|             201.34|      2970|          0.570417|

## 日本の人口あたり（報告された！！）感染者が少ないのは検査しないから。

R code : [韓国と日本のPCR検査実施人数比較 (新型コロナウイルス：Coronavirus)](https://gitpress.io/@statrstart/Coronavirus08)  

![pcr04](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/pcr04.png)

### Plot in Plot

![overlay01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/overlay01.png)

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
axis(1,at=1:ncol(nCoV), labels =NA,tck= -0.01)
labels<-sub("/20","",colnames(nCoV))
labelpos<- paste0(rep(1:12,each=3),"/",c(1,10,20))
axis(1,at=1,labels =labels[1],tick=F)
for (i in labelpos){
	at<- match(i,labels)
	if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.02)}
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

#### 死亡者数　200人以上の国の致死率(%):Deaths/Confirmed の推移

```R
# Country/Regionごとに集計
#Confirmed
Ctl<- aggregate(Confirmed[,5:ncol(Confirmed)], sum, by=list(Confirmed$"Country/Region"))
rownames(Ctl)<-Ctl[,1]
Ctl<- Ctl[,-1]
#Deaths
Dtl<- aggregate(Deaths[,5:ncol(Deaths)], sum, by=list(Deaths$"Country/Region"))
rownames(Dtl)<-Dtl[,1]
Dtl<- Dtl[,-1]
#
# 死亡者数　200人以上の国 
#
min<- 200
max<- Inf
dat<-Dtl[apply(Dtl,1,max,na.rm=T)>=min & apply(Dtl,1,max,na.rm=T)< max,] 
# "Diamond Princess"を除く
dat<-dat[grep("Diamond Princess",rownames(dat),invert = T),]
#rownames(dat)
dat<- dat[order(dat[,ncol(dat)],decreasing=T),]
knitr::kable(dat[,ncol(dat),drop=F])
#
# 致死率(%)計算
#DpC<- matrix(NA,nrow=nrow(dat),ncol=ncol(dat))
DpC<- NULL
for (i in rownames(dat)){
	temp<- round(dat[rownames(dat)== i,] / Ctl[rownames(Ctl)== i,]*100,2)
	DpC<- rbind(DpC,temp)
}
#
DpC<- DpC[order(DpC[,ncol(DpC)],decreasing=T),]
n<-nrow(DpC)
col<- rainbow(n)
pch<-rep(c(0,1,2,4,5,6,15,16,17,18),3)
#png("Coronavirus01_1_1.png",width=800,height=600)
par(mar=c(3,5,4,10),family="serif")
#40日めから
matplot(t(DpC)[40:ncol(DpC),],type="o",lwd=2,pch=pch,las=1,col=col,ylab="Reported Deaths/Reported Confirmed(%)",xaxt="n")	
axis(1,at=1:nrow(t(DpC)[40:ncol(DpC),]),labels=sub("/20","",rownames(t(DpC)[40:ncol(DpC),])))
legend(x=par("usr")[2],y=par("usr")[4],legend=rownames(DpC),pch=pch,lwd=2,col=col,bty="n",title="Country/Region",xpd=T)
title(bquote("Reported Deaths / Reported Confirmed (%) ( Reported"~Deaths>=.(min)~")"))
#dev.off()
```

### 指定した国の致死率を計算、プロット

```R
dat<-Dtl[grep("(Japan|Korea, South|Taiwan*|Singapore)",rownames(Dtl)),] 
#
dat<- dat[order(dat[,ncol(dat)],decreasing=T),]
knitr::kable(dat[,ncol(dat),drop=F])
#
# 致死率(%)計算
#DpC<- matrix(NA,nrow=nrow(dat),ncol=ncol(dat))
DpC<- NULL
for (i in rownames(dat)){
	temp<- round(dat[rownames(dat)== i,] / Ctl[rownames(Ctl)== i,]*100,2)
	DpC<- rbind(DpC,temp)
}
#
DpC<- DpC[order(DpC[,ncol(DpC)],decreasing=T),]
n<-nrow(DpC)
col<- rainbow(n)
pch<-rep(c(0,1,2,4,5,6,15,16,17,18),3)
#png("Coronavirus01_1_2.png",width=800,height=600)
par(mar=c(3,5,4,10),family="serif")
#40日めから
matplot(t(DpC)[40:ncol(DpC),],type="o",lwd=2,pch=pch,las=1,col=col,ylab="Reported Deaths/Reported Confirmed(%)",xaxt="n",bty="n")
box(bty="l",lwd=2)
axis(1,at=1:nrow(t(DpC)[40:ncol(DpC),]),labels=sub("/20","",rownames(t(DpC)[40:ncol(DpC),])))
legend(x=par("usr")[2],y=par("usr")[4],legend=rownames(DpC),pch=pch,lwd=2,col=col,bty="n",title="Country/Region",xpd=T)
title("Reported Deaths / Reported Confirmed (%) ")
#dev.off()
```

### 報告された感染者数が一定数超えた時点を起点とした折れ線グラフ

#### 片対数グラフ（Semi-log plot）ここでは、報告された感染者数 600人以上

- min,max : 報告された感染者数 min 人以上、max 未満
- Sp : Starting pointとする感染者数
- length : Starting pointとする感染者数に合わせるための調整
- xlim : x軸の範囲

```R
min<- 600
max<- +Inf
G600<- Ctl[apply(Ctl,1,max,na.rm=T)>= min & apply(Ctl,1,max,na.rm=T)< max,] 
# Diamond Princessを除く
G600<-G600[grep("Diamond Princess",rownames(G600),invert =T),]
G600<-G600[order(apply(G600,1,max,na.rm=T),decreasing=T),]
col<- rainbow(nrow(G600))
#
#Starting point
Sp<- 600 # Starting pointとする感染者数
length<- 10 # Starting pointとする感染者数に合わせるための調整
xlim=c(-10,45) # 範囲
col<- rainbow(nrow(G600))
pch<- rep(c(0,1,2,4,5,6,15,16,17,18),6)
#png("CoronavirusG600.png",width=800,height=600)
par(mar=c(5,4,4,2),family="serif")
# 
plot(1,1,type="n",xlab=paste0("Days since reported cases reach ",Sp),
	ylab="Number of reported cases (log10)",yaxt="n",log="y",
	ylim=c(0.9,2*10^5),xlim=xlim,yaxs="i")
abline(v=seq(-20,40,10),col=c("gray","gray","black","gray","gray","gray","gray"),lty=3)
for(i in 0:6){
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
for(i in 0:6){
  axis(side=2, at=10^i, labels=bquote(10^.(i)) ,las=1)
  axis(side=2, at=seq(2,9)*10^i, tck=-0.01,labels=F)
}
legend(x="bottomright",inset=c(0.03,0.01),ncol=4,legend=rownames(G600),pch=pch,lwd=1,col=col,xpd=T,
	bty="n",x.intersp= 1,y.intersp =1,cex=1)
#legend(x=par("usr")[2],y=10^par("usr")[4],legend=rownames(G600),pch=pch,lwd=1,col=col,xpd=T,bty="n",cex=1,ncol=2)
# dev.off()
```

### 最後の日付のデータのみ取り出す(drop=F : data.frameで)

#### Confirmed,Deathsのデータをmergeし、致死率計算

```R
# key : row.namesでmerge
DRbyC<- merge(Ctl[,ncol(Ctl),drop=F],Dtl[,ncol(Dtl),drop=F],by="row.names")
#DRbyC$Row.namesをrownames(DRbyC)に
rownames(DRbyC)<- DRbyC$Row.names
DRbyC<- DRbyC[,-1]
colnames(DRbyC)<- c("Confirmed","Deaths")
# death rate = Deaths/Confirmed *100 
DRbyC$Death.rate<- round(DRbyC$Deaths/DRbyC$Confirmed *100,4)
```

### 報告された感染者数 1000人以上の国だけをとりだす。

```R
min<- 1000
DR<- DRbyC[DRbyC$Confirmed >= min ,] 
# Diamond Princessを除く
DR<- DR[grep("Diamond Princess",rownames(DR),invert =T),]
```

### 報告された感染者数が1000人以上の国ごとの感染者数の棒グラフ

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

### 報告された感染者数が1000人以上の国ごとの致死率の棒グラフ 

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
# 報告された感染者数 1000人以上の国
min<- 1000
G1000<- Ctl[apply(Ctl,1,max,na.rm=T)>= min ,] 
# Diamond Princessを除く
G1000<-G1000[grep("Diamond Princess",rownames(G1000),invert =T),]
G1000<-G1000[order(apply(G1000,1,max,na.rm=T),decreasing=T),]
cdata<- CountryData[is.element(CountryData$country,rownames(G1000)),1:3]
#nrow(G1000) ; nrow(cdata) が等しくない
rownames(G1000)[!is.element(rownames(G1000),cdata$country)]
#[1] "US"      "Czechia"
#CountryData$country
# アメリカのnameがCountryDataは"United States" ジョンズ・ホプキンス大学のデータは"US"
# チェコ共和国のnameがCountryDataは"Czech Republic"ジョンズ・ホプキンス大学のデータは"Czechia"
( cdata<- CountryData[is.element(CountryData$country,c("Czech Republic","United States",rownames(G1000))),1:3] )
# 確認(同数か否か)
nrow(G1000) ;nrow(cdata)
#
# cdataのUnited StatesをUSに変更(ジョンズ・ホプキンス大学のデータに合わせる)
cdata$country<- sub("United States","US",cdata$country)
cdata$country<- sub("Czech Republic","Czechia",cdata$country)
# 人口密度(population density)
cdata$population_density<- round(cdata[,3]/cdata[,2],2)
# 最新の報告された感染者のみ取り出し、merge
dat<- G1000[,ncol(G1000),drop=F]
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
#title("Reported confirmed / number of people *100 (Reported confirmed>=1000)")
#title(expression(paste("Reported confirmed / number of people *100 (Reported ", confirmed>=1000,")")))
title(bquote("Reported confirmed / number of people *100 (Reported "~confirmed>=.(min)~")"))
#dev.off()
```

### Plot in Plot

```R
load("Wtest.Rdata")
load("Jtest.Rdata")
shp <- system.file("shapes/jpn.shp", package = "NipponMap")[1]
m <- sf::read_sf(shp)
for (i in 1:47){
	Jtest[i,1]<- sub(Jtest[i,1],m$name[i],Jtest[i,1])
}
# 人口100万人あたりの検査数
Jtest$人口100万人あたりの検査数<- round((1000000*Jtest$検査人数)/m$population,0)
# 陽性者数 > 20
df2<- Jtest[Jtest$陽性者数>20,c(1,3,4)]
df3<- Wtest[Wtest[,1]=="Japan",c(1,2,5)]
colnames(df2)<- colnames(df3)
df2<- rbind(df3,df2)
#
lim<-max(Wtest[,5],na.rm=T)*1.1
min<- 1000
df<- Wtest[!is.na(Wtest[,3]),]
df<- df[df[,3]>=min,]
jnum<- df[df[,1]=="Japan",5]
#
# Tests /millionで並べ替え
df<- df[order(df[,5]),]
color<- is.element(df[,1],"Japan")
col<- gsub("FALSE","lightblue",gsub("TRUE","red",color))
col2<- gsub("FALSE","black",gsub("TRUE","red",color))
#
# デフォルト:par(mar=c(5,4,4,2)+0.1)
#par(fig=c(0,1,0,1),mar=c(3,5,3,2),family="serif")
# png("overlay01.png",width=800,height=800)
par(mfrow=c(1,1),fig=c(0,1,0,1),mar=c(3,12,3,2),family="serif")
b<- barplot(df[,5],horiz=T,col=col,xaxt="n",xlim=c(0,lim))
axis(side=1, at=axTicks(1), labels=formatC(axTicks(1), format="d", big.mark=','))
axis(2,at=b,labels=NA,col=col2,tck=-0.01)
text(x=par("usr")[1],y=b, labels = df[,1], col = col2,pos=2,xpd=T)
# bquote
title(bquote("Tests /million for COVID-19("~Positive>=.(min)~")"))
abline(v=jnum,lty=2,col="red")
arrows(x0=df[df[,1]=="Japan",5]*4, y0=grep("TRUE",color)+0.5, x1=15000, y1=25,col="red", lty=1, lwd=5)
#par(mar=c(10,16,10,2.5),family="serif",new=T)
#右上
#par(fig=c(0.5,1,0.5,1),family="serif",new=T)
#右下
par(fig=c(0.5,1,0,0.5)+c(-0.1,-0.1,0.1,0.2),mar=c(3,6,4,2),family="serif",new=T)
b<- barplot(rev(df2[,3]),horiz=T,col=c(rep("pink",nrow(df2)-1),"red"),las=1)
axis(2,at=b,labels=NA,col=col2,tck=-0.01)
text(x=par("usr")[1],y=b, labels =rev(df2[,1]), col = c(rep("black",nrow(df2)-1),"red"),pos=2,xpd=T)
title("Tests /million:Prefectures of Japan\n(More than 20 COVID-19 cases reported)")
abline(v=jnum,lty=2,col="red")
# dev.off()
```

