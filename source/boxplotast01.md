---
title: Rでアスタリスク付きの箱ひげ図
date: 2023-05-20
tags: ["R","coin" ,"effsize"]
excerpt: baseRのboxplot
---

# Rでアスタリスク付きの箱ひげ図 その1

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2Fboxplotast01&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

(参考)  

[effectsize.xls: http://www.mizumot.com/stats/effectsize.xls](http://www.mizumot.com/stats/effectsize.xls)  

ggplotを使うなら、[github: rstatix](https://github.com/kassambara/rstatix)

t検定を行い、有意差を示すアスタリスク付きの箱ひげ図を作成します。これだけじゃ、あまりおもしろくないので、effsizeパッケージで
Cohen's d を求め、参考にしたエクセルファイルの式を使って効果量rも求めます。

あと、ノンパラメトリック検定を行い、有意差を示すアスタリスク付きの箱ひげ図を作成。
参考にしたエクセルファイルの式を使って効果量rも求めてみました。


#### p値に応じたアスタリスクを選ぶ関数(共通)

```R
# ns: p > 0.05, ＊: p <= 0.05, ＊＊:p <= 0.01, ＊＊＊:p <= 0.001
asterisk <- function(p){
  return(
    ifelse( p > 0.05,  "ns",
    ifelse( p > 0.01,  "＊",
    ifelse( p > 0.001, "＊＊", "＊＊＊")))
  )
}
# mtext("ns: p > 0.05, ＊: p <= 0.05, ＊＊:p <= 0.01, ＊＊＊:p <= 0.001",side=1,outer=TRUE)
```

### t検定を行い、有意差を示すアスタリスク付きの箱ひげ図を作成

`effsize` パッケージが必要です.

```R
# install.packages("effsize")
tbox<- function(data,x,y,notch=FALSE,col = "lightgray",
		alternative = c("two.sided", "less", "greater"),
		paired = FALSE, var.equal = FALSE){
	require(effsize)
	res<-NULL
	c.d<-NULL
	stat<- NULL
	apa <- apa1 <- apa2 <- apa3 <- NULL
	attach(data)
	if (length(unique(x))==2){
		res<-t.test(y ~ x ,alternative = alternative, paired = paired, var.equal = var.equal)
		c.d<-cohen.d(y, x ,paired = paired)
		print(res) ; print(c.d)
		stat <- data.frame(t = as.numeric(res$statistic),df=as.numeric(res$parameter),p=res$p.value ,
	   		t.conf.level=attr(res$conf.int,"conf.level") ,t.ci_min=res$conf.int[1] ,t.ci_max=res$conf.int[2],
	   		d=c.d$estimate ,mag=as.vector(c.d$magnitude),c.conf.level=c.d$conf.level ,
	   		c.ci_min=as.numeric(c.d$conf.int[1]) ,c.ci_max=as.numeric(c.d$conf.int[2]))
		apa1<- paste0("t(",stat$df,") = ",format(round(stat$t,2),nsmall = 2 ) ,", p = ",format(round(stat$p,3),nsmall = 3 ) )
		apa2<- paste0(", d = ",format(abs(round(stat$d,2)),nsmall = 2 ))
# http://www.mizumot.com/stats/effectsize.xls
# r: 対応のあるt検定の場合の例	(Field, 2005, p. 295)
#    対応のないt検定の場合の例 (Field, 2005, p. 303)
# r = sqrt(t^2/(t^2 + df)
		apa3<- paste0(", r = ",format(round(sqrt(stat$t^2/(stat$t^2 + stat$df)),2),nsmall = 2 ))
		apa<- paste0(apa1,apa2,apa3)
	}
 	sa= max(y,na.rm = TRUE)-min(y,na.rm=TRUE)
	ylim=c(min(y,na.rm=TRUE),max(y,na.rm=TRUE)+(sa/5))
	pos<- boxplot(y ~ x, notch=notch,ann=F,las=1,ylim=ylim,col=col,xaxt="n",yaxt="n",
		pars = list(boxwex = 0.5, staplewex = 0.2, outwex = 0.5),outline=TRUE)
	axis(1,at= seq(1,length(pos$names)) ,labels = pos$names,las=1,tcl= -0.25,padj=-1)
	axis(2,at=axTicks(2) ,labels = axTicks(2),las=1,tcl= -0.25,hadj=0.8)
	if (length(unique(x))==2){
		lines(x=c(1,1,2,2),y=c(tapply(y,x,max,na.rm=TRUE)[1]+(sa/20),max(y,na.rm=TRUE)+(sa/10),
			max(y,na.rm=TRUE)+(sa/10), tapply(y,x,max,na.rm=TRUE)[2]+(sa/20) )   )
		mark <- asterisk(res$p.value)
		text(x=1.5,y=max(y,na.rm=TRUE)+(sa/10) ,labels=mark,pos=3,cex=1)
	}
	detach(data)
	return(list(res,c.d,stat,apa))
}
```

データセット`sleep` : 10人の患者に対して、2種類の睡眠薬の効果を示したデータ を使います。対応のあるデータ

```R
# oma: 作図領域の外側の余白． 下，左，上，右の余白の「行数」
# グラフ下にテキスト、上にタイトルを書き込むため、下と上は1.2
par(oma=c(1.2,0,1.5,0))
# mar プロットの四隅に置かれる余白のサイズ
# 左側は数値の桁数によって変えた方が見栄えが良い。
par(mar=c(2,2.5,1,1))
# boxの形（L型）
par(bty="l")
# 対応があるデータなので、paired=TRUEとする。（デフォルトは、paired=FALSE）
# 戻り値をresに入れる
res <- tbox(data=sleep,x=group,y=extra,col=rgb(0,1,0,0.1), paired=TRUE)
# omaで指定した部分に書き込むために, mtext, titleとも、outer=TRUE とする。
mtext("ns: p > 0.05, ＊: p <= 0.05, ＊＊:p <= 0.01, ＊＊＊:p <= 0.001",side=1,outer=TRUE)
title(main = "the effect of two soporific drugs (＊: Paired t-test)",outer = TRUE)
# 戻り値（リスト）をみる
res
#
#[[1]]
#	Paired t-test
#data:  y by x
#t = -4.0621, df = 9, p-value = 0.002833
#alternative hypothesis: true mean difference is not equal to 0
#95 percent confidence interval:
# -2.4598858 -0.7001142
#sample estimates:
#mean difference 
#          -1.58 
#[[2]]
#Cohen's d
#d estimate: -0.8221766 (large)
#95 percent confidence interval:
#     lower      upper 
#-1.3140434 -0.3303099 
#[[3]]
#          t df          p t.conf.level  t.ci_min   t.ci_max          d   mag
# -4.062128  9 0.00283289         0.95 -2.459886 -0.7001142 -0.8221766 large
#  c.conf.level  c.ci_min   c.ci_max
#         0.95 -1.314043 -0.3303099
#[[4]]
#[1] "t(9) = -4.06, p = 0.003, d = 0.82, r = 0.80"
```

この例の場合、戻り値をresに入れています。res[[4]]のdとrが効果量です。

r値は参考にしたエクセルファイルと一致しているか確認してください。

- r: 対応のあるt検定の場合の例	(Field, 2005, p. 295)

- r: 対応のないt検定の場合の例 (Field, 2005, p. 303)

![boxast01.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/boxast01.png)


### ノンパラメトリック検定を行い、有意差を示すアスタリスク付きの箱ひげ図を作成

`coin` パッケージが必要です。

- ウィルコクソンの順位和検定 (およびマン-ホイットニーのU検定) は，パラメトリック検定における対応のないt検定 

	- `coin::wilcox_test`

- ウィルコクソンの符号順位検定はパラメトリック検定における対応のあるt検定に相当するものである．

	- `coin::wilcoxsign_test(x ~ y, distribution="exact")`

```R
# install.packages("coin")
wbox<- function(data,x,y,id=NULL,notch=FALSE,col = "lightgray", paired = FALSE){
	require(coin)
	res<- NULL
	N <- NULL
	attach(data)
	if (length(unique(x))==2){
		if (!paired){
# 対応なし: coin::wilcox_test
			res<- wilcox_test(y ~ x ,distribution="exact")
			N=length(x)
			print(res)
			}
		if (paired & !is.null(id) ) {
# 対応あり: coin::wilcoxsign_test
			wide<-tapply(y,list(id ,x),function(x){x})
			res<- wilcoxsign_test(as.numeric(wide[,1]) ~ as.numeric(wide[,2]), distribution = 'exact')
			print(res)
			N=length(as.numeric(wide[,1]))
		}
	}
 	sa= max(y,na.rm = TRUE)-min(y,na.rm=TRUE)
	ylim=c(min(y,na.rm=TRUE),max(y,na.rm=TRUE)+(sa/5))
	pos<- boxplot(y ~ x, notch=notch,ann=F,las=1,ylim=ylim,col=col,xaxt="n",yaxt="n",
		pars = list(boxwex = 0.5, staplewex = 0.2, outwex = 0.5),outline=TRUE)
	axis(1,at= seq(1,length(pos$names)) ,labels = pos$names,las=1,tcl= -0.25,padj=-1)
	axis(2,at=axTicks(2) ,labels = axTicks(2),las=1,tcl= -0.25,hadj=0.8)
	if (!is.null(res)){
		lines(x=c(1,1,2,2),y=c(tapply(y,x,max,na.rm=TRUE)[1]+(sa/20),max(y,na.rm=TRUE)+(sa/10),
			max(y,na.rm=TRUE)+(sa/10), tapply(y,x,max,na.rm=TRUE)[2]+(sa/20) )   )
		mark <- asterisk( pvalue(res) )
		text(x=1.5,y=max(y,na.rm=TRUE)+(sa/10) ,labels=mark,pos=3,cex=1)
	}
	detach(data)
	return(list(res,N))
}
```

こちらもデータセット`sleep`を使う

```R
par(oma=c(1.2,0,1.5,0))
par(mar=c(2,2.5,1,1))
par(bty="l")
# 対応があるデータなので、paired=TRUEとする。（デフォルトは、paired=FALSE）
# 対応付けの列は ID 列なので、id=ID とする。<- これがないと、ウィルコクソンの符号順位検定は行われない。
res <- wbox(data=sleep,x=group,y=extra,col=rgb(0,1,0,0.1), paired=TRUE,id=ID)
mtext("ns: p > 0.05, ＊: p <= 0.05, ＊＊:p <= 0.01, ＊＊＊:p <= 0.001",side=1,outer=TRUE)
title(main = "２種類の睡眠薬の効果 (＊: ウィルコクソンの符号順位検定)",outer = TRUE)
```

対応があるので、Exact Wilcoxon-Pratt Signed-Rank Test（ウィルコクソンの符号順位検定）

![boxast02.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/boxast02.png)

こっちは、knitr パッケージを使って、

```R
require(knitr)
# http://www.mizumot.com/stats/effectsize.xls
# 効果量: r = Z/√N
object<-res[[1]]
data.frame(method = object@method ,
     alternative = object@statistic@alternative , 
     Z = round(statistic(object),4) , 
     p.value = round(pvalue(object),4) ,
     N = res[[2]] ,
     r = round(statistic(object)/sqrt(res[[2]]),4)) |>
kable()
```

この例では、対応があるので、N=10

|method                          |alternative |       Z| p.value|  N|      r|
|:-------------------------------|:-----------|-------:|-------:|--:|------:|
|Wilcoxon-Pratt Signed-Rank Test |two.sided   | -2.7575|  0.0039| 10| -0.872|

(比較)ノンパラメトリック:対応がないと仮定した場合(Exact Wilcoxon-Mann-Whitney Test)

```R
wbox(data=sleep,x=group,y=extra,col=rgb(0,1,0,0.1),paired=FALSE)
```

### おまけ（3群：グラフのみ 戻り値なし）

```R
tubox <- function(data,x,y, notch=FALSE,col="lightgray"){
	attach(data)
	aov <- aov(y~x)
	res<-TukeyHSD(aov)
	print(res)
	sa= max(y ,na.rm=TRUE)-min(y ,na.rm=TRUE)
	ylim=c(min(y ,na.rm=TRUE),max(y ,na.rm=TRUE)+(sa/3))
	pos<- boxplot(y~x, notch=notch ,ann=F,las=1,ylim=ylim,col=col ,xaxt="n",yaxt="n",
		pars = list(boxwex = 0.5, staplewex = 0.2, outwex = 0.5),outline=TRUE)
	axis(1,at= seq(1,length(pos$names)) ,labels = pos$names,las=1,tcl= -0.25,padj=-1,cex.axis=1.2)
	axis(2,at=axTicks(2) ,labels = axTicks(2),las=1,tcl= -0.25,hadj=0.8,cex.axis=1.2)
	df<-data.frame(res[[1]])
	names<- strsplit(rownames(df),"-")
	marks<- asterisk(df$p.adj)
	if (length(names)==3){
		for (i in 1:length(names) ){
			x1=grep(names[[i]][1],pos$names)
			x2=grep(names[[i]][2],pos$names)
			y0=max(y,na.rm=TRUE)
			j=which(c(1,3,2)==i)
			lines(x=c(x1,x1,x2,x2) ,y=c(y0+(sa*j/10)-(sa/30),y0+(sa*j/10),y0+(sa*j/10) ,y0+(sa*j/10)-(sa/30) ) )
			text(x=(x1+x2)/2,y=y0+(sa*j/10) ,labels=marks[i],pos=3,offset=0.3 ,cex=1)
			}
		}
	detach(data)
}
```

データセットは、`iris`

```R
par(oma=c(1.2,0,1.5,0))
par(mar=c(2,3,1,1))
par(bty="l")
tubox(data=iris,x=Species,y=Sepal.Width ,col=rgb(0,1,0,0.2) )
mtext("ns: p > 0.05, ＊: p <= 0.05, ＊＊:p <= 0.01, ＊＊＊:p <= 0.001",side=1,outer=TRUE)
title(main = "iris (＊: TukeyHSD)",outer = TRUE)
```

![boxast03.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/boxast03.png)

表示されるTukey HSD検定の結果と一致しているか確認。


### なお、分野によってはアスタリスク以外の記号を使うようです。その場合は、

#### 危険率の値（p値）の識別に、†（dagger）等を使う場合

```R
# 危険率の値（p値）の識別に、†（dagger）等を使う場合。
# ns: p > 0.05, ＊: p <= 0.05, †: p <= 0.01, ‡: p <= 0.005, §: p <= 0.001
asterisk <- function(p){
  return(
    ifelse( p > 0.05,  "ns",
    ifelse( p > 0.01,  "＊",
    ifelse( p > 0.005, "†",
    ifelse( p > 0.001, "‡", "§" ))))
  )
}
# mtext("ns: p > 0.05, ＊: p <= 0.05, †: p <= 0.01, ‡: p <= 0.005, §: p <= 0.001",side=1,outer=TRUE)
```

4群以上になると、それぞれを結ぶのは困難。multcomp パッケージを使うのがよいのでは。
