---
title: 夏季五輪・世界各国のメダル獲得数ランキング（上位12カ国）と新型コロナウイルス(Coronavirus)
date: 2021-07-21
tags: ["R","新型コロナウイルス"]
excerpt: メダルとコロナ
---

# 夏季五輪・世界各国のメダル獲得数ランキング（上位12カ国）と新型コロナウイルス

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus20&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

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

### 夏季五輪・世界各国のメダル獲得数ランキング（上位12カ国）

#### 1位.アメリカ合衆国(US)

![US](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/US.png)

#### 2位.ソビエト連邦

#### 3位.イギリス(United Kingdom)

![UnitedKingdom](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/UnitedKingdom.png)

#### 4位.フランス(France)

![France](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/France.png)

#### 5位.ドイツ(Germany)

![Germany](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Germany.png)

#### 6位.イタリア(Italy)

![Italy](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Italy.png)

#### 7位.中国(China)

![China](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/China.png)

#### 8位.オーストラリア(Australia)

![Australia](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Australia.png)

#### 9位.スウェーデン(Sweden)

![Sweden](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Sweden.png)

#### 10位.ハンガリー(Hungary)

![Hungary](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Hungary.png)

#### 11位.日本

![Japan](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Japan.png)

#### 12位.ロシア(Russia)

![Russia](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Russia.png)

### Rコード

前半部は、[世界と東アジアの感染者の状況(新型コロナウイルス：Coronavirus)](https://gitpress.io/@statrstart/Coronavirus15)と同じなので省略。


#### 複数の国のデータを作成、保存。
for文で回すだけ。

```R
# メダル獲得数ランキング（上位12カ国(ソビエト連邦は除く)）
Pcountry<- c("US","United Kingdom","France","Germany","Italy","China","Australia","Sweden","Hungary","Japan","Russia")
for (country in Pcountry){
	XY <- data.frame(t(Ctl[country==rownames(Ctl),]-(Dtl[country==rownames(Dtl),] + Rtl[country==rownames(Rtl),])), 
	t(Dtl[country==rownames(Dtl),]), 
	t(Rtl[country==rownames(Rtl),]))
colnames(XY)<- c("Under_Isolation","Deaths","Recovered")
rownames(XY)<- colnames(nCoV) #sub("/20","",colnames(nCoV))
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
