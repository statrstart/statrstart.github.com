---
title: 世界と東アジアの感染者の状況(新型コロナウイルス：Coronavirus)
date: 2020-11-14
tags: ["R","TTR","Coronavirus","新型コロナウイルス"]
excerpt: 隔離中、死亡、回復
---

# 東アジアの感染者の状況(新型コロナウイルス：Coronavirus)

![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus15)  

東アジアとシンガポール、東南アジアで日本より人口あたり死亡者数の多いフィリピンとインドネシアの感染者の状況。

(使用するデータ)詳しくはRコード参照  
人口：DataComputing package  
検査数：Our World in Data  
感染者総数、死亡、回復：CSSE at Johns Hopkins University(Confirmed,Deaths,Recovered)  

#### 世界：感染者の状況（隔離中、死亡、回復）

![Coronavirus001](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Coronavirus001.png)

#### 世界：致死率(%):Deaths/Confirmed の推移

![Coronavirus01_1](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Coronavirus01_1.png)

#### 世界 : 週単位の陽性者増加比

![zoukaworld01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/zoukaworld01.png)

### 東アジアの感染者の状況

#### 日本
![Japan](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Japan.png)

- 左側に「人口」「１００万人あたりの検査数」「１００万人あたりの感染者数」「感染率」「１００万人あたりの死亡者数」「致死率」を載せるようにしました。
- 日本の「１００万人あたりの検査数」は世界でも少ない方です。「感染率」が４％ほどあるので検査数が足りているとは思えません。

#### 韓国
![KoreaSouth](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/KoreaSouth.png)

- 「感染率」は１％を切りました。

#### 中国
![China](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/China.png)

- 国としての「検査数」のデータはありませんが、ニュースをみるとかなりの数の検査をやっているようです。

#### 香港
![HongKong](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/HongKong.png)

- 「１００万人あたりの検査数」8万以上。「感染率」0.3％弱

#### 台湾
![Taiwan](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Taiwan.png)

- 先手先手の完璧な対応だったのがグラフをみてもわかります。「感染率」0.6％弱

#### モンゴル
![Mongolia](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Mongolia.png)

- 人口が少ないとはいえ、「死亡者数」が0

### 東南アジア(シンガポール、フィリピン、インドネシア)

#### シンガポール
![Singapore](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Singapore.png)

- 「１００万人あたりの検査数」9万以上でも、「感染率」9%以上というのは外国人労働者が多く、人口密度が高いからでしょうか。

#### フィリピン
![Philippines](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Philippines.png)

#### インドネシア
![Indonesia](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Indonesia.png)

### 週単位の陽性者増加比(日本、韓国、中国、台湾、香港、シンガポール)
（注意）ｙ軸は対数表示にしています。

![zouka01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/zouka01.png)

### Rコード

#### CSSE at Johns Hopkins University(Confirmed,Deaths,Recovered) データ読み込み

```R
# read.csvの際には、check.names=Fをつける
url<- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"
Confirmed<- read.csv(url,check.names=F)
url<- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv"
Deaths<- read.csv(url,check.names=F)
url<- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv"
Recovered<- read.csv(url,check.names=F)
save(Confirmed,file="Confirmed.Rdata") ; save(Recovered,file="Recovered.Rdata") ; save(Deaths,file="Deaths.Rdata") 
#load("Confirmed.Rdata") ; load("Recovered.Rdata") ; load("Deaths.Rdata")
#
### 全世界の日毎の合計：Confirmed , Deaths, Recovered  別
#
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

#### 世界：療養中、回復された方、亡くなった方の数の推移(新型コロナウイルス）（日別）

```R
# 指数表示を抑制
options(scipen=2) 
#
XY <- data.frame(Under_Isolation=nCoV[1,]-(nCoV[2,] + nCoV[3,]), Deaths=nCoV[2,], Recovered=nCoV[3,])
rownames(XY)<- sub("/20","",colnames(nCoV))
#png("Coronavirus001.png",width=800,height=600)
par(mar=c(5,6,4,7),family="serif")
b<- barplot(t(XY),col=c(rgb(1,1,0,0.8),rgb(1,0,0,0.8),rgb(0,1,0,0.8)),yaxt="n",ylim=c(0,max(nCoV[1,],na.rm=T)*1.1),xaxt="n",
	legend=T,args.legend=list(x="topleft",inset=0.03))
lines(x=b,y=nCoV[1,],lwd=3)
#表示するx軸ラベルを指定
#axis(1,at=b[1]:b[nrow(XY)], labels =NA,tck= -0.01)
labels<- rownames(XY)
#axis(1,at=b[1],labels =labels[1],tick=F)
labelpos<- paste0(rep(1:12,each=3),"/",1)
for (i in labelpos){
	at<- b[match(i,labels)]
	if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.02)}
	}
labelpos<- paste0(rep(1:12,each=3),"/",c(10,20))
for (i in labelpos){
	at<- b[match(i,labels)]
	if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.01)}
	}
# Add comma separator to axis labels
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
text(x=par("usr")[2],y=c(XY[nrow(XY),1]/2,XY[nrow(XY),1]+max(XY[,2],na.rm=T)/2,XY[nrow(XY),1]+max(XY[,2],na.rm=T)+max(XY[,3],na.rm=T)/2),
	labels=formatC(c(XY[nrow(XY),1],max(XY[,2],na.rm=T),max(XY[,3],na.rm=T)),format="d", big.mark=','),xpd=T,pos=4)
text(x=par("usr")[2],y=max(nCoV[1,],na.rm=T),
	labels= paste0("Confirmed\n",formatC(max(nCoV[1,],na.rm=T), format="d", big.mark=',')),col="darkgreen",xpd=T,pos=4)
title("回復された方、亡くなった方、療養中の方の推移(新型コロナウイルス）",cex.main=1.5)
#dev.off()
```

#### 世界：致死率(%):Deaths/Confirmed の推移(新型コロナウイルス）

```R
# nCoVの2行目 / nCoVの1行目
MR<- round(nCoV[2,]/nCoV[1,] *100,3)
#png("Coronavirus01_1.png",width=800,height=600)
par(mar=c(5,6,3,4),family="serif")
plot(MR,type="l",lwd=2.5,las=1,xaxt="n",ylab="Reported deaths / Reported cases",bty="l",xlab="")
box(bty="l",lwd=2)
labels<-sub("/20","",colnames(nCoV))
labels<-gsub("^.*/","",labels)
pos<-gsub("/.*$","",sub("/20","",colnames(nCoV)))
pos<- factor(pos,levels=min(as.numeric(pos)):max(as.numeric(pos)))
axis(1,at=1:ncol(nCoV),labels =NA)
#月の区切り
#axis(1,at=cumsum(as.vector(table(pos)))+0.5, labels =NA,tck=-0.1,lty=2 ,lwd=1)
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
text(x=par("usr")[2],y=MR[length(MR)],labels=paste(MR[length(MR)],"%"),xpd=T)
title("Covid-19 : Death rates(致死率)")
#dev.off()
```

#### 世界 : 週単位の陽性者増加比

```R
library(TTR)
diffC<- diff(t(nCoV["Confirmed",,drop=F]))
rownames(diffC)<- sub("/20","",rownames(diffC))
fun<- function(x){round(runSum(x,n=7)/(runSum(x,n=14) -runSum(x,n=7)),2)}
diffC2<- data.frame(fun(diffC))
rownames(diffC2)<- rownames(diffC)
colnames(diffC2)<- "Confirmed"
diffC2<- diffC2[!is.na(diffC2),,drop=F]
#png("zoukaworld01.png",width=800,height=600)
par(mar=c(5,6,4,7),family="serif")
plot(diffC2$Confirmed,type="l",lwd=2,las=1,xlab="",ylab="",bty="n",xaxt="n",ylim=c(0,4))
box(bty="l",lwd=2.5)
abline(h=1,lwd=1.5,col="red",lty=2)
labels<-gsub("^.*/","",rownames(diffC2))
pos<-gsub("/.*$","",rownames(diffC2))
pos<- factor(pos,levels=min(as.numeric(pos)):max(as.numeric(pos)))
axis(1,at=1:nrow(diffC2),labels =NA)
#月の区切り
#axis(1,at=cumsum(as.vector(table(pos)))+0.5, labels =NA,tck=-0.1,lty=2 ,lwd=1)
for (i in c("1","10","20")){
	at<- grep("TRUE",is.element(labels,i))
	axis(1,at=at,labels = rep(i,length(at)))
	}
Month<-c("Jan.","Feb.","Mar.","Apr.","May","Jun.","Jul.","Aug.","Sep.","Oct.","Nov.","Dec.")
mon<-cut(as.numeric(names(table(pos))),breaks = seq(0,12),right=T, labels =Month)
# 月の中央
#mtext(text=mon,at=cumsum(as.vector(table(pos)))-as.vector(table(pos)/2),side=1,line=2) 
# 月のはじめ
mtext(text=mon,at=1+cumsum(as.vector(table(pos)))-as.vector(table(pos)),side=1,line=2) 
text(x=par("usr")[2],y=diffC2[nrow(diffC2),],labels=diffC2[nrow(diffC2),],xpd=T)
arrows(par("usr")[2]*1.08, 1.1,par("usr")[2]*1.08,1.68,length = 0.2,lwd=2.5,xpd=T)
text(x=par("usr")[2]*1.08,y=1.9,labels="増加\n傾向",xpd=T)
arrows(par("usr")[2]*1.08, 0.9,par("usr")[2]*1.08,0.32,length = 0.2,lwd=2.5,xpd=T)
text(x=par("usr")[2]*1.08,y=0.1,labels="減少\n傾向",xpd=T)
title("週単位の陽性者増加比(世界)",cex.main=1.5)
title(sub="Data : CSSE at Johns Hopkins University(Confirmed)",line=3.5)
#dev.off()
```

#### 感染者の状況を国ごとにまとめる

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
#Recovered
Rtl<- aggregate(Recovered[,5:ncol(Deaths)], sum, by=list(Recovered$"Country/Region"))
rownames(Rtl)<-Rtl[,1]
Rtl<- Rtl[,-1]
```

#### CountryData$countryとジョンズ・ホプキンス大学のデータの国名を一致させる
台湾はCountryData$countryにあわせる。(Taiwan)

```R
library(DataComputing)
data("CountryData")
#CountryData$countryとジョンズ・ホプキンス大学のデータの国名を一致させる
cdata<- CountryData[is.element(CountryData$country,rownames(Ctl)),1:3]
rownames(Ctl)[!is.element(rownames(Ctl),cdata$country)]
# [1] "Bahamas"             "Congo (Brazzaville)" "Congo (Kinshasa)"   
# [4] "Czechia"             "Diamond Princess"    "Eswatini"           
# [7] "Gambia"              "Holy See"            "MS Zaandam" (MSザーンダム)        
#[10] "North Macedonia"     "Taiwan*"             "US"                 
#[13] "West Bank and Gaza" (Palestinian West Bank and the Gaza Strip)
#
# 国以外のデータ Diamond Princess、MS Zaandam を除く
Ctl<- Ctl[grep("Diamond Princess|MS Zaandam",rownames(Ctl),invert =T),]
Dtl<- Dtl[grep("Diamond Princess|MS Zaandam",rownames(Dtl),invert =T),]
Rtl<- Rtl[grep("Diamond Princess|MS Zaandam",rownames(Rtl),invert =T),]
#
rownames(Ctl)<- gsub("\\*","",rownames(Ctl))
rownames(Dtl)<- gsub("\\*","",rownames(Dtl))
rownames(Rtl)<- gsub("\\*","",rownames(Rtl))
#
#"West Bank"+"Gaza Strip"
adddata<- data.frame(country="West Bank and Gaza",area=CountryData[CountryData$country=="West Bank",2]+CountryData[CountryData$country=="Gaza Strip",2],
		pop=CountryData[CountryData$country=="West Bank",3]+CountryData[CountryData$country=="Gaza Strip",3])
# CountryDataのUnited StatesをUSに変更(ジョンズ・ホプキンス大学のデータに合わせる)
CountryData$country<- sub("Bahamas, The","Bahamas",CountryData$country)
CountryData$country<- sub("Congo, Democratic Republic of the","Congo (Kinshasa)",CountryData$country)
CountryData$country<- sub("Congo, Republic of the","Congo (Brazzaville)",CountryData$country)
CountryData$country<- sub("Czech Republic","Czechia",CountryData$country)
CountryData$country<- sub("Gambia, The","Gambia",CountryData$country)
CountryData$country<- sub("Holy See \\(Vatican City\\)","Holy See",CountryData$country)
CountryData$country<- sub("Macedonia","North Macedonia",CountryData$country)
CountryData$country<- sub("Swaziland","Eswatini",CountryData$country)
#CountryData$country<- sub("Taiwan","Taiwan*",CountryData$country)
CountryData$country<- sub("United States","US",CountryData$country)
cdata<- CountryData[,1:3]
cdata<- rbind(cdata,adddata)
cdata<- cdata[is.element(CountryData$country,rownames(Ctl)),]
#確認
rownames(Ctl)[!is.element(rownames(Ctl),cdata$country)]
#character(0)
```

#### 検査数：Our World in Dataのデータを読み込み、国名をジョンズ・ホプキンス大学のデータに合わせる。

```R
test<- read.csv("https://covid.ourworldindata.org/data/owid-covid-data.csv")
save(test,file="test.Rdata")
#load("test.Rdata")
Tdat<- test[,c("date","location","total_tests")]
# total_testsがNAではないものを抽出
Tdat<- Tdat[!is.na(Tdat[,3]),]
# 国ごとの最新のトータル検査者数(maxデータ)
Tdat<- aggregate(Tdat$total_tests,max,na.rm=T, by=list(Tdat$location))
# ネーム変更
colnames(Tdat)<- c("country","total_tests")
rownames(Ctl)[!is.element(rownames(Ctl),Tdat$country)]
Tdat$country[!is.element(Tdat$country,rownames(Ctl))]
# [1] Czech Republic Hong Kong      Myanmar        South Korea    United States
Tdat$country<- sub("United States","US",Tdat$country)
Tdat$country<- sub("Czech Republic","Czechia",Tdat$country)
Tdat$country<- sub("South Korea","Korea, South",Tdat$country)
Tdat$country[!is.element(Tdat$country,rownames(Ctl))]
#[1] "Hong Kong" "Myanmar"
```

#### データのある国一覧
香港は"Province/State"。グラフにするときのコードが少し違う。

```R
rownames(Ctl)
```

#### 一つの国のデータををグラフにする。例として、日本

```R
# 指数表示を抑制
options(scipen=2) 
#
country<- "Japan"
population<- cdata[cdata$country==country,"pop"]
TestpM<- round(ifelse(all(Tdat$country!=country),NA,Tdat[Tdat$country==country,"total_tests"])/population*1000000,0)
XY <- data.frame(t(Ctl[country==rownames(Ctl),]-(Dtl[country==rownames(Dtl),] + Rtl[country==rownames(Rtl),])), 
	t(Dtl[country==rownames(Dtl),]), 
	t(Rtl[country==rownames(Rtl),]))
colnames(XY)<- c("Under_Isolation","Deaths","Recovered")
rownames(XY)<- sub("/20","",colnames(nCoV))
CpMP<- round(max(t(Ctl[country==rownames(Ctl),]),na.rm=T)/population*1000000,2)
Irate<- round(CpMP/TestpM*100,2)
DpMP<- round(max(XY$Deaths,na.rm=T)/population*1000000,2)
Drate<- round(max(XY$Deaths,na.rm=T)/max(t(Ctl[country==rownames(Ctl),]),na.rm=T)*100,2)
fname<- paste0(gsub(",","",gsub(" ","",country)),".png")
#png(fname,width=800,height=600)
par(mar=c(5,6,4,7),family="serif")
b<- barplot(t(XY),col=c(rgb(1,1,0,0.8),rgb(1,0,0,0.8),rgb(0,1,0,0.8)),yaxt="n",
	legend=T,args.legend=list(x="topleft",inset=0.03),ylim=c(0,max(t(Ctl[country==rownames(Ctl),]),na.rm=T)*1.1))
lines(x=b,y=t(Ctl[country==rownames(Ctl),]),lwd=3)
# Add comma separator to axis labels
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
text(x=par("usr")[2],y=c(XY[nrow(XY),1]/2,XY[nrow(XY),1]+max(XY[,2],na.rm=T)/2,XY[nrow(XY),1]+max(XY[,2],na.rm=T)+max(XY[,3],na.rm=T)/2),
	labels=formatC(c(XY[nrow(XY),1],max(XY[,2],na.rm=T),max(XY[,3],na.rm=T)),format="d", big.mark=','),xpd=T)
text(x=par("usr")[2],y=max(t(Ctl[country==rownames(Ctl),]),na.rm=T),pos=3,
	labels= paste0("Confirmed\n",formatC(max(t(Ctl[country==rownames(Ctl),]),na.rm=T), format="d", big.mark=',')),col="darkgreen",xpd=T)
legend("topleft",inset=c(0,0.2),legend=paste0("population\n",formatC(population,format="d",big.mark=',')),bty="n",cex=1.2)
legend("topleft",inset=c(0,0.3),legend=paste0("Tested(per million people)\n",formatC(TestpM,format="d",big.mark=',')),bty="n",cex=1.2)
legend("topleft",inset=c(0,0.4),legend=paste0("Confirmed(per million people)\n",CpMP),bty="n",cex=1.2,text.col="darkgreen")
legend("topleft",inset=c(0,0.5),legend=paste0("Infection rates(感染率)\n",Irate," %"),bty="n",cex=1.2,text.col="darkgreen")
legend("topleft",inset=c(0,0.6),legend=paste0("Deaths(per million people)\n",DpMP),bty="n",cex=1.2,text.col="red")
legend("topleft",inset=c(0,0.7),legend=paste0("Death rates(致死率)\n",Drate," %"),bty="n",cex=1.2,text.col="red")
title(paste0("回復された方、亡くなった方、療養中の方の推移(新型コロナウイルス）(",country,")"),cex.main=1.5)
title(sub="Data : DataComputing package(population),Our World in Data(Tested),CSSE at Johns Hopkins University(Confirmed,Deaths,Recovered)",line=3)
#dev.off()
```

#### 香港のデータをグラフにする。（国ではないのでコードがちょっと違う）

```R
# 指数表示を抑制
options(scipen=2) 
#
#Hong Kong
#香港の人口もCountryData package内にある
province<- "Hong Kong"
population<- CountryData[province==CountryData$country,3]
TestpM<- round(ifelse(all(Tdat$country!=country),NA,Tdat[Tdat$country==country,"total_tests"])/population*1000000,0)
confdata<- Confirmed[Confirmed$"Province/State"==province,5:ncol(Confirmed)]
deathdata<- Deaths[Deaths$"Province/State"==province,5:ncol(Deaths)]
recdata<- Recovered[Recovered$"Province/State"==province,5:ncol(Recovered)]
XY <- data.frame(t(confdata-(deathdata + recdata)),t(deathdata),t(recdata))
colnames(XY)<- c("Under_Isolation","Deaths","Recovered")
rownames(XY)<- sub("/20","",colnames(nCoV))
CpMP<- round(max(t(confdata),na.rm=T)/population*1000000,2)
Irate<- round(CpMP/TestpM*100,2)
DpMP<- round(max(XY$Deaths,na.rm=T)/population*1000000,2)
Drate<- round(max(XY$Deaths,na.rm=T)/max(t(confdata),na.rm=T)*100,2)
fname<- paste0(gsub(",","",gsub(" ","",province)),".png")
#png(fname,width=800,height=600)
par(mar=c(5,6,4,7),family="serif")
b<- barplot(t(XY),col=c(rgb(1,1,0,0.8),rgb(1,0,0,0.8),rgb(0,1,0,0.8)),yaxt="n",
	legend=T,args.legend=list(x="topleft",inset=0.03),ylim=c(0,max(t(confdata),na.rm=T)*1.1))
lines(x=b,y=t(confdata),lwd=3)
# Add comma separator to axis labels
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
text(x=par("usr")[2],y=c(XY[nrow(XY),1]/2,XY[nrow(XY),1]+max(XY[,2],na.rm=T)/2,XY[nrow(XY),1]+max(XY[,2],na.rm=T)+max(XY[,3],na.rm=T)/2),
	labels=formatC(c(XY[nrow(XY),1],max(XY[,2],na.rm=T),max(XY[,3],na.rm=T)),format="d", big.mark=','),xpd=T)
text(x=par("usr")[2],y=max(t(confdata),na.rm=T),pos=3,
	labels= paste0("Confirmed\n",formatC(max(t(confdata),na.rm=T), format="d", big.mark=',')),col="darkgreen",xpd=T)
legend("topleft",inset=c(0,0.2),legend=paste0("population\n",formatC(population,format="d",big.mark=',')),bty="n",cex=1.2)
legend("topleft",inset=c(0,0.3),legend=paste0("Tested(per million people)\n",formatC(TestpM,format="d",big.mark=',')),bty="n",cex=1.2)
legend("topleft",inset=c(0,0.4),legend=paste0("Confirmed(per million people)\n",CpMP),bty="n",cex=1.2,text.col="darkgreen")
legend("topleft",inset=c(0,0.5),legend=paste0("Infection rates(感染率)\n",Irate," %"),bty="n",cex=1.2,text.col="darkgreen")
legend("topleft",inset=c(0,0.6),legend=paste0("Deaths(per million people)\n",DpMP),bty="n",cex=1.2,text.col="red")
legend("topleft",inset=c(0,0.7),legend=paste0("Death rates(致死率)\n",Drate," %"),bty="n",cex=1.2,text.col="red")
title(paste0("回復された方、亡くなった方、療養中の方の推移(新型コロナウイルス）(",province,")"),cex.main=1.5)
title(sub="Data : DataComputing package(population),Our World in Data(Tested),CSSE at Johns Hopkins University(Confirmed,Deaths,Recovered)",line=3)
#dev.off()
```

#### 複数の国のデータを作成、保存。
for文で回すだけ。

```R
# 中国、台湾、韓国、モンゴル、シンガポール、フィリピン、インドネシア
Pcountry<- c("China","Taiwan","Korea, South","Mongolia","Singapore","Philippines","Indonesia")
for (country in Pcountry){
	XY <- data.frame(t(Ctl[country==rownames(Ctl),]-(Dtl[country==rownames(Dtl),] + Rtl[country==rownames(Rtl),])), 
	t(Dtl[country==rownames(Dtl),]), 
	t(Rtl[country==rownames(Rtl),]))
colnames(XY)<- c("Under_Isolation","Deaths","Recovered")
rownames(XY)<- sub("/20","",colnames(nCoV))
population<- cdata[cdata$country==country,"pop"]
TestpM<- round(ifelse(all(Tdat$country!=country),NA,Tdat[Tdat$country==country,"total_tests"])/population*1000000,0)
CpMP<- round(max(t(Ctl[country==rownames(Ctl),]),na.rm=T)/population*1000000,2)
Irate<- round(CpMP/TestpM*100,2)
DpMP<- round(max(XY$Deaths,na.rm=T)/population*1000000,2)
Drate<- round(max(XY$Deaths,na.rm=T)/max(t(Ctl[country==rownames(Ctl),]),na.rm=T)*100,2)
fname<- paste0(gsub(",","",gsub(" ","",country)),".png")
png(fname,width=800,height=600)
par(mar=c(5,6,4,7),family="serif")
b<- barplot(t(XY),col=c(rgb(1,1,0,0.8),rgb(1,0,0,0.8),rgb(0,1,0,0.8)),yaxt="n",
	legend=T,args.legend=list(x="topleft",inset=0.03),ylim=c(0,max(t(Ctl[country==rownames(Ctl),]),na.rm=T)*1.1))
lines(x=b,y=t(Ctl[country==rownames(Ctl),]),lwd=3)
# Add comma separator to axis labels
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
text(x=par("usr")[2],y=c(XY[nrow(XY),1]/2,XY[nrow(XY),1]+max(XY[,2],na.rm=T)/2,XY[nrow(XY),1]+max(XY[,2],na.rm=T)+max(XY[,3],na.rm=T)/2),
	labels=formatC(c(XY[nrow(XY),1],max(XY[,2],na.rm=T),max(XY[,3],na.rm=T)),format="d", big.mark=','),xpd=T)
text(x=par("usr")[2],y=max(t(Ctl[country==rownames(Ctl),]),na.rm=T),pos=3,
	labels= paste0("Confirmed\n",formatC(max(t(Ctl[country==rownames(Ctl),]),na.rm=T), format="d", big.mark=',')),col="darkgreen",xpd=T)
legend("topleft",inset=c(0,0.2),legend=paste0("population\n",formatC(population,format="d",big.mark=',')),bty="n",cex=1.2)
legend("topleft",inset=c(0,0.3),legend=paste0("Tested(per million people)\n",formatC(TestpM,format="d",big.mark=',')),bty="n",cex=1.2)
legend("topleft",inset=c(0,0.4),legend=paste0("Confirmed(per million people)\n",CpMP),bty="n",cex=1.2,text.col="darkgreen")
legend("topleft",inset=c(0,0.5),legend=paste0("Infection rates(感染率)\n",Irate," %"),bty="n",cex=1.2,text.col="darkgreen")
legend("topleft",inset=c(0,0.6),legend=paste0("Deaths(per million people)\n",DpMP),bty="n",cex=1.2,text.col="red")
legend("topleft",inset=c(0,0.7),legend=paste0("Death rates(致死率)\n",Drate," %"),bty="n",cex=1.2,text.col="red")
title(paste0("回復された方、亡くなった方、療養中の方の推移(新型コロナウイルス）(",country,")"),cex.main=1.5)
title(sub="Data : DataComputing package(population),Our World in Data(Tested),CSSE at Johns Hopkins University(Confirmed,Deaths,Recovered)",line=3)
dev.off()
}
```

#### 週単位の陽性者増加比(日本、韓国、中国、台湾、香港、シンガポール)

```R
library(TTR)
#datC<- t(Ctl[rownames(Ctl)== "Japan"|rownames(Ctl)=="Korea, South",])
datC<- t(Ctl[grep("(Japan|China|Korea, South|Taiwan|Singapore)",rownames(Ctl)),] )
#Hong Kong
HK<- Confirmed[Confirmed$"Province/State"=="Hong Kong",5:ncol(Confirmed)]
rownames(HK)<- "Hong Kong"
datC<- cbind(datC,t(HK))
rownames(datC)<- sub("/20","",rownames(datC))
x<- apply(datC,2,diff)
fun<- function(x){round(runSum(x,n=7)/(runSum(x,n=14) -runSum(x,n=7)),2)}
df<- apply(x,2,fun)
# InfにNAを入れる
df[df==Inf]<- NA
df<- data.frame(df)
rownames(df)<- rownames(datC)[-1]
#
pdat<- df[14:nrow(df),]
#並べ替え
pdat<- pdat[,order(pdat[nrow(pdat),],decreasing=T)]
num<- as.numeric(pdat[nrow(pdat),])
#
#png("zouka01.png",width=800,height=600)
par(mar=c(5,6,4,7),family="serif")
matplot(pdat,type="l",lwd=2,las=1,lty=1,col=1:6,xlab="",ylab="",xaxt="n",bty="n",log="y",ylim=c(0.01,100))
#matplot(pdat,type="l",lwd=2,las=1,lty=1,col=1:6,xlab="",ylab="",xaxt="n",bty="n",ylim=c(0,10))
box(bty="l",lwd=2.5)
abline(h=1,lty=2,col="darkgreen",lwd=1.5)
labels<-gsub("^.*/","",rownames(pdat))
pos<-gsub("/.*$","",rownames(pdat))
pos<- factor(pos,levels=min(as.numeric(pos)):max(as.numeric(pos)))
axis(1,at=1:nrow(pdat),labels =NA)
#月の区切り
#axis(1,at=cumsum(as.vector(table(pos)))+0.5, labels =NA,tck=-0.1,lty=2 ,lwd=1)
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
#text(x=par("usr")[2],y=pdat[nrow(pdat),],labels=colnames(pdat),xpd=T)
legend("topright",inset=c(-0.03,0.03),lty=1,lwd=2,col=1:6,legend=colnames(pdat),xpd=T)
legend("bottomright",inset=c(-0.03,0.1),xpd=T,bty="n",
	legend= paste(rownames(pdat)[nrow(pdat)],"現在\n",colnames(pdat)[1],num[1],"\n",colnames(pdat)[2],num[2],"\n",colnames(pdat)[3],num[3],"\n",
	colnames(pdat)[4],num[4],"\n",colnames(pdat)[5],num[5],"\n",colnames(pdat)[6],num[6],"\n"))
title("週単位の陽性者増加比(日本、韓国、中国、台湾、香港、シンガポール)\nｙ軸は対数表示",cex.main=1.5)
title(sub="Data : CSSE at Johns Hopkins University(Confirmed)",line=3.5)
#dev.off()
```

