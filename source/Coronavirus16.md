---
title: 検査陽性者数(チャーター便を除く国内事例)と政府の対応(新型コロナウイルス：Coronavirus)
date: 2020-11-15
tags: ["R","jsonlite","xts","Coronavirus","新型コロナウイルス"]
excerpt: 東洋経済オンラインのデータ
---

# 検査陽性者数(チャーター便を除く国内事例)と政府の対応(新型コロナウイルス：Coronavirus)

![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus16)  

(使用するデータ)  
[東洋経済オンライン:https://raw.githubusercontent.com/kaz-ogiwara/covid19/master/data/data.json](https://raw.githubusercontent.com/kaz-ogiwara/covid19/master/data/data.json)  

#### 新型コロナウイルス 検査陽性者数(チャーター便を除く国内事例)と政府の対応

![Jcovid01.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Jcovid01.png)

#### 入院治療等を要する者の数(チャーター便を除く国内事例)と政府の対応

![Jcovid02.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Jcovid02.png)

#### 死亡者数と重症者数(チャーター便を除く国内事例)と政府の対応

![Jcovid03.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Jcovid03.png)

#### 沖縄県 : 新型コロナウイルス 検査陽性者数(チャーター便を除く国内事例)と政府の対応

![Jcovid04.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Jcovid04.png)

#### 47都道府県の検査陽性者の推移のグラフの作成、保存の例として
##### 北海道

![HokkaidoC01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/HokkaidoC01.png)

### Rコード

#### データ読み込み

```R
library(jsonlite)
library(xts)
#「東洋経済オンライン」新型コロナウイルス 国内感染の状況
# https://toyokeizai.net/sp/visual/tko/covid19/
#著作権「東洋経済オンライン」
covid19 = fromJSON("https://raw.githubusercontent.com/kaz-ogiwara/covid19/master/data/data.json")
save(covid19,file="toyokeizai.Rdata")
#load("toyokeizai.Rdata")```
```

#### 新型コロナウイルス 検査陽性者数(チャーター便を除く国内事例)と政府の対応

```R
data<- covid19[[2]]$carriers
from<- as.Date(paste0(data$from[1],"-",data$from[2],"-",data$from[3]))
data.xts<- xts(x=as.numeric(data$values),seq(as.Date(from),length=nrow(data$values),by="days"))
#plot(data.xts)
#barplot
#png("Jcovid01.png",width=800,height=600)
par(mar=c(5,4,5,1),family="serif")
b<- barplot(t(coredata(data.xts)),las=1,yaxt="n",ylim=c(0,max(data.xts)*1.1),col="red")
box(bty="l",lwd=2)
# Add comma separator to axis labels
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
#表示するx軸ラベルを指定
#データのある箇所すべてにtick
#axis(1,at=b[1]:b[nrow(coredata(data.xts))], labels =NA,tck= -0.01)
# 2020- を削除。01-01 -> 1/1 
labels<- sub("-","/",sub("-0","-",sub("^0","",sub("2020-","",index(data.xts)))))
# 毎月1日
labelpos<- paste0(rep(1:12),"/",1)
for (i in labelpos){
	at<- b[match(i,labels)]
	if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.02)}
	}
labelpos<- paste0(rep(1:12,each=2),"/",c(10,20))
for (i in labelpos){
	at<- b[match(i,labels)]
	if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.01)}
	}
events<- data.frame(
	date=c("3/2","4/7","4/16","5/4","5/14","5/21","5/25","7/22"),
	events=c("3月2日\n全国の小中高 臨時休校\n4月下旬 : 臨時休校の割合は9割超。\n6月頭 : ほとんどの学校が再開",
		"4月7日\n当初緊急事態宣言","4月16日\n区域変更\n(対象地域を全国に拡大)",
		"5月4日(適用日：5月7日)\n期間延長(5月31日まで)","5月14日\n区域変更\n(特定警戒都道府県5県を含む39県を解除)",
		"5月21日\n区域変更\n(特定警戒都道府県の関西3府県を解除)","5月25日\n緊急事態解除宣言","7月22日\nGoToトラベル\n開始"),
	ypos=c(100,700,1100,850,600,350,100,1000))
#
for (i in 1:nrow(events)){
	labelpos<- events$date[i]
	xpos<- b[match(labelpos,labels)]
	ypos<- events$ypos[i]
	points(x=xpos,y=ypos,pch=25,bg="red",cex=1.2,xpd=T)
	text(x=xpos,y=ypos,labels=events$events[i],xpd=T,pos=3)
}
title("日本の新型コロナウイルス 検査陽性者数(チャーター便を除く国内事例)と政府の対応","データ：[東洋経済オンライン](https://raw.githubusercontent.com/kaz-ogiwara/covid19/master/data/data.json)",line=3)
#dev.off()　
```

#### 入院治療等を要する者の数(チャーター便を除く国内事例)と政府の対応

```R
#入院治療等を要する者
data<- covid19[[2]]$cases
from<- as.Date(paste0(data$from[1],"-",data$from[2],"-",data$from[3]))
#cumsum
data.xts<- xts(x=cumsum(data$values),seq(as.Date(from),length=nrow(data$values),by="days"))
#plot(data.xts)
#barplot
#png("Jcovid02.png",width=800,height=600)
par(mar=c(5,4,5,1),family="serif")
b<- barplot(t(coredata(data.xts)),las=1,yaxt="n",ylim=c(0,max(data.xts)*1.1),col="lightblue")
box(bty="l",lwd=2)
# Add comma separator to axis labels
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
#表示するx軸ラベルを指定
#データのある箇所すべてにtick
#axis(1,at=b[1]:b[nrow(coredata(data.xts))], labels =NA,tck= -0.01)
# 2020- を削除。01-01 -> 1/1 
labels<- sub("-","/",sub("-0","-",sub("^0","",sub("2020-","",index(data.xts)))))
# 毎月1日
labelpos<- paste0(rep(1:12),"/",1)
for (i in labelpos){
	at<- b[match(i,labels)]
	if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.02)}
	}
labelpos<- paste0(rep(1:12,each=2),"/",c(10,20))
for (i in labelpos){
	at<- b[match(i,labels)]
	if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.01)}
	}
events<- data.frame(
	date=c("3/2","4/7","4/16","5/4","5/14","5/21","5/25","7/22"),
	events=c("3月2日\n全国の小中高 臨時休校\n4月下旬 : 臨時休校の割合は9割超。\n6月頭 : ほとんどの学校が再開",
		"4月7日\n当初緊急事態宣言","4月16日\n区域変更\n(対象地域を全国に拡大)",
		"5月4日(適用日：5月7日)\n期間延長(5月31日まで)","5月14日\n区域変更\n(特定警戒都道府県5県を含む39県を解除)",
		"5月21日\n区域変更\n(特定警戒都道府県の関西3府県を解除)","5月25日\n緊急事態解除宣言","7月22日\nGoToトラベル\n開始"),
	ypos=c(500,4000,8500,12500,6000,4000,2500,5500))
#
for (i in 1:nrow(events)){
	labelpos<- events$date[i]
	xpos<- b[match(labelpos,labels)]
	ypos<- events$ypos[i]
	points(x=xpos,y=ypos,pch=25,bg="red",cex=1.2,xpd=T)
	text(x=xpos,y=ypos,labels=events$events[i],xpd=T,pos=3,col="red")
}
title("日本の新型コロナウイルス 入院治療等を要する者の数(チャーター便を除く国内事例)と政府の対応","データ：[東洋経済オンライン](https://raw.githubusercontent.com/kaz-ogiwara/covid19/master/data/data.json)",line=3)
#dev.off()
```

#### 死亡者数と重症者数(チャーター便を除く国内事例)と政府の対応

```R
#死亡者数
data<- covid19[[2]]$deaths
from<- as.Date(paste0(data$from[1],"-",data$from[2],"-",data$from[3]))
dataD.xts<- xts(x=data$values,seq(as.Date(from),length=nrow(data$values),by="days"))
#重症者
data<- covid19[[2]]$serious
from<- as.Date(paste0(data$from[1],"-",data$from[2],"-",data$from[3]))
dataS.xts<- xts(x=cumsum(data$values),seq(as.Date(from),length=nrow(data$values),by="days"))
data.xts<- merge(dataD.xts,dataS.xts,all=T)
colnames(data.xts)<- c("死亡者","重症者")
#barplot
#png("Jcovid03.png",width=800,height=600)
par(mar=c(5,4,5,1),family="serif")
b<- barplot(t(coredata(data.xts)),las=1,yaxt="n",ylim=c(0,max(rowSums(data.xts),na.rm=T)*1.1),col=c("red","yellow"),legend=T,
	args.legend=list(x="topleft",inset=0.03,cex=1.2))
box(bty="l",lwd=2)
# Add comma separator to axis labels
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
#表示するx軸ラベルを指定
#データのある箇所すべてにtick
#axis(1,at=b[1]:b[nrow(coredata(data.xts))], labels =NA,tck= -0.01)
# 2020- を削除。01-01 -> 1/1 
labels<- sub("-","/",sub("-0","-",sub("^0","",sub("2020-","",index(data.xts)))))
# 毎月1日
labelpos<- paste0(rep(1:12),"/",1)
for (i in labelpos){
	at<- b[match(i,labels)]
	if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.02)}
	}
labelpos<- paste0(rep(1:12,each=2),"/",c(10,20))
for (i in labelpos){
	at<- b[match(i,labels)]
	if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.01)}
	}
events<- data.frame(
	date=c("3/2","4/7","4/16","5/4","5/14","5/21","5/25","7/22"),
	events=c("3月2日\n全国の小中高 臨時休校\n4月下旬 : 臨時休校の割合は9割超。\n6月頭 : ほとんどの学校が再開",
		"4月7日\n当初緊急事態宣言","4月16日\n区域変更\n(対象地域を全国に拡大)",
		"5月4日(適用日：5月7日)\n期間延長(5月31日まで)","5月14日\n区域変更\n(特定警戒都道府県5県を含む39県を解除)",
		"5月21日\n区域変更\n(特定警戒都道府県の関西3府県を解除)","5月25日\n緊急事態解除宣言","7月22日\nGoToトラベル\n開始"),
	ypos=c(40,120,240,350,280,220,180,80))
#
for (i in 1:nrow(events)){
	labelpos<- events$date[i]
	xpos<- b[match(labelpos,labels)]
	ypos<- events$ypos[i]
	points(x=xpos,y=ypos,pch=25,bg="red",cex=1.2,xpd=T)
	text(x=xpos,y=ypos,labels=events$events[i],xpd=T,pos=3,col="red")
}
title("日本の新型コロナウイルス 死亡者数と重症者数(チャーター便を除く国内事例)と政府の対応","データ：[東洋経済オンライン](https://raw.githubusercontent.com/kaz-ogiwara/covid19/master/data/data.json)",line=3)
#dev.off()
```

#### 沖縄県 : 新型コロナウイルス 検査陽性者数(チャーター便を除く国内事例)と政府の対応

```R
# 沖縄
data<- covid19[[4]]$carriers[47,]
from<- as.Date(paste0(data$from[[1]][1],"-",data$from[[1]][2],"-",data$from[[1]][3]))
data.xts<- xts(x=as.numeric(data$values[[1]]),seq(as.Date(from),length=nrow(data$values[[1]]),by="days"))
#
#barplot
#png("Jcovid04.png",width=800,height=600)
par(mar=c(5,4,5,1),family="serif")
b<- barplot(t(coredata(data.xts)),las=1,yaxt="n",ylim=c(0,max(data.xts)*1.1),col="red")
box(bty="l",lwd=2)
# Add comma separator to axis labels
axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
#表示するx軸ラベルを指定
#データのある箇所すべてにtick
#axis(1,at=b[1]:b[nrow(coredata(data.xts))], labels =NA,tck= -0.01)
# 2020- を削除。01-01 -> 1/1 
labels<- sub("-","/",sub("-0","-",sub("^0","",sub("2020-","",index(data.xts)))))
# 毎月1日
labelpos<- paste0(rep(1:12),"/",1)
for (i in labelpos){
	at<- b[match(i,labels)]
	if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.02)}
	}
labelpos<- paste0(rep(1:12,each=2),"/",c(10,20))
for (i in labelpos){
	at<- b[match(i,labels)]
	if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.01)}
	}
events<- data.frame(
	date=c("3/2","4/7","4/16","5/4","5/14","5/21","5/25","7/22"),
	events=c("3月2日\n全国の小中高 臨時休校\n4月下旬 : 臨時休校の割合は9割超。\n6月頭 : ほとんどの学校が再開",
		"4月7日\n当初緊急事態宣言","4月16日\n区域変更\n(対象地域を全国に拡大)",
		"5月4日(適用日：5月7日)\n期間延長(5月31日まで)","5月14日\n区域変更\n(特定警戒都道府県5県を含む39県を解除)",
		"5月21日\n区域変更\n(特定警戒都道府県の関西3府県を解除)","5月25日\n緊急事態解除宣言","7月22日\nGoToトラベル\n開始"),
	ypos=c(5,15,35,75,55,25,5,10))
#
for (i in 1:nrow(events)){
	labelpos<- events$date[i]
	xpos<- b[match(labelpos,labels)]
	ypos<- events$ypos[i]
	points(x=xpos,y=ypos,pch=25,bg="red",cex=1.2,xpd=T)
	text(x=xpos,y=ypos,labels=events$events[i],xpd=T,pos=3)
}
title("沖縄県 : 新型コロナウイルス 検査陽性者数(チャーター便を除く国内事例)と政府の対応","データ：[東洋経済オンライン](https://raw.githubusercontent.com/kaz-ogiwara/covid19/master/data/data.json)",line=3)
#dev.off()
```

#### 47都道府県の検査陽性者の推移のグラフを作成、保存

```R
for (pref in 1:47){
	data<- covid19[[4]]$carriers[pref,]
	from<- as.Date(paste0(data$from[[1]][1],"-",data$from[[1]][2],"-",data$from[[1]][3]))
	data.xts<- xts(x=as.numeric(data$values[[1]]),seq(as.Date(from),length=nrow(data$values[[1]]),by="days"))
	#
	#barplot
	png(paste0(covid19[[5]]$en[pref],"C01.png"),width=800,height=600)
	par(mar=c(5,4,5,1),family="serif")
	b<- barplot(t(coredata(data.xts)),las=1,yaxt="n",ylim=c(0,max(data.xts)*1.1),col="red")
	box(bty="l",lwd=2)
	# Add comma separator to axis labels
	axis(side=2, at=axTicks(2), labels=formatC(axTicks(2), format="d", big.mark=','),las=1) 
	#表示するx軸ラベルを指定
	# 2020- を削除。01-01 -> 1/1 
	labels<- sub("-","/",sub("-0","-",sub("^0","",sub("2020-","",index(data.xts)))))
	# 毎月1日
	labelpos<- paste0(rep(1:12),"/",1)
	for (i in labelpos){
		at<- b[match(i,labels)]
		if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.02)}
	}
	labelpos<- paste0(rep(1:12,each=2),"/",c(10,20))
	for (i in labelpos){
		at<- b[match(i,labels)]
		if (!is.na(at)){ axis(1,at=at,labels = i,tck= -0.01)}
	}
	events<- data.frame(
		date=c("5/25","7/22"),
		events=c("5月25日\n緊急事態解除宣言","7月22日\nGoToトラベル開始"),
		ypos=rep(par("usr")[4],2))
#
	for (i in 1:nrow(events)){
		labelpos<- events$date[i]
		xpos<- b[match(labelpos,labels)]
		ypos<- events$ypos[i]
		points(x=xpos,y=ypos,pch=25,bg="red",cex=1.2,xpd=T)
		text(x=xpos,y=ypos,labels=events$events[i],xpd=T,pos=3)
	}
	title(paste0(covid19[[5]]$ja[pref]," : 新型コロナウイルス 検査陽性者数(チャーター便を除く国内事例)"),"データ：[東洋経済オンライン](https://raw.githubusercontent.com/kaz-ogiwara/covid19/master/data/data.json)",line=3)
	dev.off()
}
```