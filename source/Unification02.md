---
title: 家庭連合（旧 統一教会）の所在地(地図を作成その１)
date: 2022-08-08
tags: ["R","NipponMap","ggplot2"]
excerpt: 最寄りの家庭教会のデータ
---

# 家庭連合（旧 統一教会）の所在地(地図を作成その１)

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FUnification02&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

(元データ)  
[最寄りの家庭教会：https://ffwpu.jp/admission/church/nearest](https://ffwpu.jp/admission/church/nearest)  

[使用するデータセット:Unification.csv](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/Unification.csv)  
(注意)  
- 文字コードはUTF-8です。
- データ項目は、所在地の県番号、都道府県名、郵便番号、住所、緯度、経度です。
- 電話番号は地図上にプロットにするのに必要ないので取り除きました。
- サイトに載っている家庭教会（2022/8/7現在：２９０件）のみで関連団体の所在地はわかりません。
- データセット上の緯度、経度と施設の位置とは若干のずれがあるようです。

#### 日本の世界平和統一家庭連合（旧 世界基督教統一神霊協会）の所在地

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Tkmap01.png)

#### 都道府県別家庭教会数

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Tkmap11.png)

#### 都道府県別家庭教会数 その２

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Tkmap12.png)

### Rコード

#### 日本の世界平和統一家庭連合（旧 世界基督教統一神霊協会）の所在地

```R
require(NipponMap)
p<- read.csv("https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/Unification.csv")
#
#par(mar=rep(0,4))
#JapanPrefMap(inset=FALSE)
#points(x=p$経度,p$緯度,pch=16,cex=0.8,col="brown3")
#
#png("Tkmap01.png",width=800,height=600)
par(mar=rep(0,4))
JapanPrefMap()
points(x=p$経度,p$緯度,pch=21,cex=1,col="royalblue4",bg=rgb(1,0,0,0.8))
#沖縄のデータだけずらしてプロット
points(x=p$経度[290]+7,p$緯度[290]+14,pch=21,cex=1,col="royalblue4",bg=rgb(1,0,0,0.8))
text(x=par("usr")[1],y=par("usr")[4]*0.99,"日本の世界平和統一家庭連合（旧 世界基督教統一神霊協会）の所在地",cex=1.2,pos=4)
text(x=par("usr")[1],y=par("usr")[4]*0.975,"    家庭連合（旧 統一教会）の公式サイト「最寄りの家庭教会」から作成(2022年8月)",pos=4)
#dev.off()
```

#### 都道府県別家庭教会数

```R
require(ggplot2)
kenmei = c("北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県", "茨城県",
           "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県", "新潟県", "富山県",
           "石川県", "福井県", "山梨県", "長野県", "岐阜県", "静岡県", "愛知県", "三重県",
           "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県", "鳥取県", "島根県",
           "岡山県", "広島県", "山口県", "徳島県", "香川県", "愛媛県", "高知県", "福岡県",
           "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県")
#
tab<- table(factor(p$都道府県, levels = kenmei))
bpdata<- data.frame(tab)
colnames(bpdata)<- c("都道府県","家庭教会数")
bpdata$tate<- NULL
# 都道府県名縦書き
for (i in 1:47){
	bpdata$tate[i]<- sapply(strsplit(split="",as.character(bpdata$都道府県)[i]), paste, collapse="\n")
}
# tateのlevels
bpdata$tate<- factor(bpdata$tate,levels=unique(bpdata$tate))
#
# 棒グラフ作成
g <- ggplot(bpdata, aes(x = tate, y = 家庭教会数)) 
g <- g + geom_bar(stat = "identity",fill="brown3",colour="brown3")
g <- g + theme_bw()
g <- g + labs(title="都道府県別家庭教会数",x="",y="")
g <- g + scale_y_continuous(expand = c(0,0), limits = c(0,max(bpdata$家庭教会数)*1.1))
g <- g + theme(axis.text=element_text(colour = "black"),panel.grid.major.x = element_blank())
g
# ggsave("Tkmap11.png",g,width=8,height=6,dpi=150)
```

#### 都道府県別家庭教会数 その２

```R
png("Tkmap12.png",width=800,height=600)
par(mar=c(6,3,3,1))
tate<- NULL
for (i in 1:47){
	tate[i]<- sapply(strsplit(split="",names(tab)[i]), paste, collapse="\n")
}
plot(NA,xlim=c(1,47),ylim=c(0,max(tab)*1.1),type="n",xaxt="n",yaxt="n",xlab="",ylab="",bty="n",yaxs="i")
box(bty="l",lwd=2.5)
for (i in 1:47){
	points(x=rep(i,tab[i]),y=1:tab[i],pch="\u26B1",col="red")
}
axis(2,at=c(0,seq(5.5,35.5,5)),labels=c(0,seq(5,35,5)),las=1)
abline(h=seq(10.5,30.5,10),lwd=0.8,col="gray50")
abline(h=seq(5.5,35.5,10),lwd=0.5,col="gray80")
axis(1,at=1:47,labels=F)
text(x=1:47,y=0,labels=tate,pos=1,offset=1.5,xpd=T)
title("都道府県別家庭教会数",cex.main=1.5)
#dev.off()
```

