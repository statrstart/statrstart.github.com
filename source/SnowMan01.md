---
title: （小ネタ）Ｒで雪だるま
date: 2021-12-22
tags: ["R","unicode","snowman"]
excerpt: unicode キャラクターをプロット
---

# （小ネタ）Ｒで雪だるま

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FSnowMan01&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

（注意）OSはLinuxを使っています。font familyの変更の仕方がwindows版のRとは異なるかもしれません。

### Noto Sans CJK JP

![snowman_noto](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/snowman_noto.png)

### IPAGothic

![snowman_IPAGothic](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/snowman_IPAGothic.png)

### DejaVuSans

![snowman_DejaVu](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/snowman_DejaVu.png)

### DejaVu Sans Mono

![snowman_DejaVum](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/snowman_DejaVum.png)

### iris：雪だるまで散布図1

![snowman_iris01](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/snowman_iris01.png)

### iris：雪だるまで散布図2

![snowman_iris02](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/snowman_iris02.png)

### Rコード

#### linuxの場合　システムに入っているフォントをR上で調べる

```R
system("fc-list")
# grepで絞り込む
system("fc-list|grep DejaVu")
system("fc-list|grep noto")
system("fc-list|grep JP")
system("fc-list|grep gothic")
```

#### pchに雪だるまを指定

```R
#png("snowman_noto.png")
par(mar=c(0,0,0,0),family="Noto Sans CJK JP")
plot(1,1,pch=-as.hexmode("2603"),cex=40,ann=F,axes=F,xpd=T)
#dev.off()
```

#### text関数で雪だるまを描く（定番）

```R
#png("snowman_noto.png")
par(mar=c(0,0,0,0))
plot(1,1,type="n",ann=F,axes=F)
text(1,1,labels="\u2603",cex=40,family="Noto Sans CJK JP",xpd=T)
#dev.off()
#
#png("snowman_IPAGothic.png")
par(mar=c(0,0,0,0))
plot(1,1,type="n",ann=F,axes=F)
text(1,1,labels="\u2603",cex=40,family="IPAGothic",xpd=T)
#dev.off()
#
#png("snowman_DejaVu.png")
par(mar=c(0,0,0,0))
plot(1,1,type="n",ann=F,axes=F)
text(1,1,labels="\u2603",cex=40,family="DejaVuSans",xpd=T)
#dev.off()
#
#png("snowman_DejaVum.png")
par(mar=c(0,0,0,0))
plot(1,1,type="n",ann=F,axes=F)
text(1,1,labels="\u2603",cex=40,family="DejaVu Sans Mono",xpd=T)
#dev.off()
```

#### iris：雪だるまで散布図（Speciesによって色を変えるのは簡単）

```R
data(iris)
#png("snowman_iris01.png",width=800,height=800)
par(mar=c(4,4,4,2))
plot(Petal.Length~Sepal.Length,type="n",bty="n",las=1,data=iris)
box(bty="l",lwd=2)
text(iris$Sepal.Length,iris$Petal.Length,labels="\u2603",col=c(2,3,4)[iris$Species],family="Noto Sans CJK JP",cex=2)
title("iris：雪だるまで散布図")
#dev.off()
```

####  iris：雪だるまで散布図（Speciesによってfont familyを変えるのはちょっとやっかい（一例です））

```R
data(iris)
png("snowman_iris02.png",width=800,height=800)
par(mar=c(4,4,4,2))
plot(Petal.Length~Sepal.Length,type="n",bty="n",las=1,data=iris)
box(bty="l",lwd=2)
for (i in 1:length(iris$Species) ){
	if (iris$Species[i]==as.character(unique(iris$Species)[1])){
		 text(iris$Sepal.Length[i],iris$Petal.Length[i],labels="\u2603",col=2,family="Noto Sans CJK JP",cex=2)
		}
	if (iris$Species[i]==as.character(unique(iris$Species)[2])){
		text(iris$Sepal.Length[i],iris$Petal.Length[i],labels="\u2603",col=3,family="IPAGothic",cex=2)
		}
	if (iris$Species[i]==as.character(unique(iris$Species)[3])){
		text(iris$Sepal.Length[i],iris$Petal.Length[i],labels="\u2603",col=4,family="DejaVuSans",cex=2)
		}
}
title("iris：雪だるまで散布図")
dev.off()
```

