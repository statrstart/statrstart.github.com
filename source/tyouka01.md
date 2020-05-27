---
title: 超過死亡(インフルエンザ関連死亡迅速把握システムのデータ)
date: 2020-05-27
tags: ["R","超過死亡"]
excerpt: インフルエンザ関連死亡迅速把握システムのデータ
---

# 超過死亡(インフルエンザ関連死亡迅速把握システムのデータ)

![Hits](https://hitcounter.pythonanywhere.com/count/tag.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2Ftyouka01)  

(参考)  
[コロナ感染死、把握漏れも「超過死亡」200人以上か 東京23区2～3月　必要な統計公表遅く、対策左右も 2020/5/24](https://www.nikkei.com/article/DGXMZO59508030U0A520C2NN1000/)   
＊ では、他の都市の「超過死亡」はどうなっているのか比較してみます。 

[反PCR検査拡充派の間で広まる医師ブログの不自然なデータ引用。「日本に超過死亡はない」の嘘 2020.05.16](https://hbol.jp/219193?cx_clicks_art_mdl=3_title)  
[「超過死亡グラフ改竄」疑惑に、国立感染研は誠実に答えよ！](https://webronza.asahi.com/politics/articles/2020052600001.html)  

[インフルエンザ関連死亡迅速把握システムについてのQ＆A](https://www.niid.go.jp/niid/ja/from-idsc/9627-jinsoku-qa.html)  

(使用したデータ)  
[インフルエンザ関連死亡迅速把握システム ](https://www.niid.go.jp/niid/ja/flu-m/2112-idsc/jinsoku/)  
各都市のグラフ上部のコメント欄より作成した。

(注意)  
- 2020/5/26のデータ（グラフ）で作成。 
- 手入力しているので間違いがある可能性があります。

#### グラフ

![cdeath01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/cdeath01.png)

### Rコード

#### 超過死亡あり-> 1 ,超過死亡なし-> 0 ,報告なし-> NA

```R
# 超過死亡あり-> 1 ,超過死亡なし-> 0 ,報告なし-> NA
川崎<- c(NA,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
京都<- c(NA,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NA)
大坂<- c(NA,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
広島<- c(NA,0,0,0,0,0,0,0,0,0,0,0,0,0,NA,NA,NA,NA,NA)
北九州<- c(NA,0,0,0,0,0,0,0,0,0,0,NA,NA,NA,NA,NA,NA,NA,NA)
福岡<- c(NA,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
静岡<- c(NA,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
堺<- c(NA,0,0,0,0,0,0,0,0,0,0,0,0,0,NA,NA,NA,NA,NA)
浜松<- c(NA,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,NA)
岡山<- c(NA,0,0,0,0,0,0,0,0,0,0,0,0,0,NA,NA,NA,NA,NA)
千葉<- c(NA,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
さいたま<- c(NA,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
仙台<- c(NA,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0)
名古屋<- c(NA,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0)
熊本<- c(NA,0,0,1,0,0,0,0,0,0,0,1,0,1,1,0,0,1,0)
東京<- c(NA,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0)
大都市の合計<- c(NA,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)
# 報告なし
 札幌<- c(NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA)
 神戸<- c(NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA)
 新潟<- c(NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA)
 相模原<- c(NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA,NA)
week<- c("48","49","50","51","52","1","2","3","4","5","6","7","8","9","10","11","12","13","14")
z<- data.frame(札幌,神戸,新潟,相模原,川崎,京都,大坂,広島,北九州,福岡,静岡,堺,浜松,岡山,千葉,さいたま,仙台,名古屋,熊本,東京,大都市の合計,
	check.names=F)
rownames(z)<- week
#
z<- t(z)
nr <- nrow(z)
nc <- ncol(z)
#image(t(z))
#png("cdeath01.png",width=800,height=600)
par(mar=c(4,8,6,10),family="serif")
plot(x=c(0,nc),y=c(0,nr), type="n",axes = F, xaxs = "i",yaxs="i",xlab="",ylab="")
abline(h=seq(1,nr))
abline(v=seq(1,nc))
box()
for (i in 1:nc){
	for (j in 1:nr){
		if (!is.na(z[j,i])){
			if (z[j,i]==1){
				rect(xleft=i-1, ybottom=j-1, xright=i, ytop=j,col ="red")
			}
			if (z[j,i]==0){
				rect(xleft=i-1, ybottom=j-1, xright=i, ytop=j,col ="lightblue")
			}
		}
		if (is.na(z[j,i])){
			rect(xleft=i-1, ybottom=j-1, xright=i, ytop=j,col ="lightgray")
		}			
	}
}
axis(3,at=seq(0.5,nc-0.5,1),labels=colnames(z),tck= -0.005,padj=1)
axis(3,at=c(0.5,5.5),labels=c("2019","2020"),tick=F,padj= -0.5,hadj= 0.8)
axis(3,at=nc,labels="(週)",tick=F,padj= -0.5,hadj= 0.8)
axis(2,at=seq(0.5,nr-0.5,1),labels=rownames(z),las=1,tck= -0.01)
legend("topright",inset=c(-0.22,0.03),pch=15,col=c("red","lightblue","lightgray"),
	legend=c("超過死亡あり","超過死亡なし","報告なし"),xpd=T,bty="n",cex=1.2)
title("超過死亡の状況(2019年48週から2020年14週)")
mtext("Data:[インフルエンザ関連死亡迅速把握システム ](https://www.niid.go.jp/niid/ja/flu-m/2112-idsc/jinsoku/) ",
	side=1,adj=1,padj= 1)
#dev.off()
```

