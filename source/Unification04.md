---
title: 家庭連合（旧 統一教会）の所在地(地図を作成その３:絵文字)
date: 2022-08-24
tags: ["R","NipponMap","sf","ggplot2","emoGG"]
excerpt: 最寄りの家庭教会のデータ
---

# 家庭連合（旧 統一教会）の所在地(地図を作成その２)

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FUnification04&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

(元データ)  
[最寄りの家庭教会：https://ffwpu.jp/admission/church/nearest](https://ffwpu.jp/admission/church/nearest)  

[使用するデータセット:Unification.csv](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/Unification.csv)  
(注意)  
- 文字コードはUTF-8です。
- データ項目は、所在地の県番号、都道府県名、郵便番号、住所、緯度、経度です。
- 電話番号は地図上にプロットにするのに必要ないので取り除きました。
- サイトに載っている家庭教会（2022/8/7現在：２９０件）のみで関連団体の所在地はわかりません。
- データセット上の緯度、経度と施設の位置とは若干のずれがあるようです。

## 家庭連合（旧 統一教会）といえば、「壺」のイメージが強いので、pointやbarの代わりに絵文字の壺を使ってみます。

#### 日本の世界平和統一家庭連合（旧 世界基督教統一神霊協会）の所在地

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/mapemoG01.png)

#### 都道府県別家庭教会数（つ棒グラフ２種類）

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/emoGbar01.png)

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/emoGbar02.png)

### Rコード

#### 日本の世界平和統一家庭連合（旧 世界基督教統一神霊協会）の所在地

```R
require(NipponMap)
require(ggplot2)
require(sf)
#devtools::install_github("dill/emoGG")
library(emoGG)
p<- read.csv("https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/Unification.csv")
# JapanPrefMap関数を参考にした。
shp <- system.file("shapes/jpn.shp", package = "NipponMap")[1]
    m <- read_sf(shp)
    st_crs(m) <- "+proj=longlat +datum=WGS84"
    m$geometry[[47]] <- m$geometry[[47]] + c(7, 14)
pp<- p
# 沖縄の家庭教会の位置を移動
pp[290,"経度"]<- pp[290,"経度"]+7
pp[290,"緯度"]<- pp[290,"緯度"]+14
#
#png("mapemoG01.png",width=800,height=600)
ggplot(m) + 
	geom_sf() +
	theme_void() +
        annotate("segment", x = 132, xend = 135, y = 38, yend = 38, colour = "black", size=0.5) +
	annotate("segment", x = 135, xend = 137, y = 38, yend = 40, colour = "black", size=0.5) +
	annotate("segment", x = 137, xend = 137, y = 40, yend = 43, colour = "black", size=0.5) +
	geom_emoji(data = pp, aes(x = 経度, y = 緯度), emoji="26b1", size = 0.02) +	
	labs(title="日本の世界平和統一家庭連合（旧 世界基督教統一神霊協会）の所在地",
		subtitle="家庭連合（旧 統一教会）の公式サイト「最寄りの家庭教会」から作成(2022年8月7日)")
#dev.off()
```

#### 都道府県別家庭教会数

```R
#devtools::install_github("dill/emoGG")
library(ggplot2)
library(emoGG)
p<- read.csv("https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/Unification.csv")
kenmei = c("北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県", "茨城県",
           "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県", "新潟県", "富山県",
           "石川県", "福井県", "山梨県", "長野県", "岐阜県", "静岡県", "愛知県", "三重県",
           "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県", "鳥取県", "島根県",
           "岡山県", "広島県", "山口県", "徳島県", "香川県", "愛媛県", "高知県", "福岡県",
           "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県")
#
tab<- table(factor(p$都道府県, levels = kenmei))
#
bpdata<- data.frame(tab)
colnames(bpdata)<- c("都道府県","家庭教会数")
bpdata$tate<- NULL
# 都道府県名縦書き
for (i in 1:47){
	bpdata$tate[i]<- sapply(strsplit(split="",as.character(bpdata$都道府県)[i]), paste, collapse="\n")
}
# tateのlevels
bpdata$tate<- factor(bpdata$tate,levels=unique(bpdata$tate))
x<- NULL
y<- NULL
for (i in 1:47){
	x=c(x,rep(i,tab[i]))
	y=c(y,1:tab[i])
}
# y座標は 0.5を引く
point<- data.frame(x=x,y=y-0.5)
#
g<- ggplot(point, aes(x,y)) +
  theme_linedraw() +
  theme(panel.border = element_blank(), axis.line = element_line(),
		axis.text=element_text(colour = "black"),panel.grid.major.x = element_blank(),panel.grid.minor.x = element_blank()) +
  scale_y_continuous(expand = c(0,0), limits = c(0,37),breaks=c(0,10,20,30),labels=c(0,10,20,30)) + 
  scale_x_continuous(expand = c(0,0), limits = c(0,48),breaks= 1:47 ,labels = bpdata$tate) +
  labs(title="都道府県別家庭教会数 ",x="",y="") +
  geom_emoji(emoji="26b1",size=0.03)
g
# ggsave("emoGbar01.png",g,width=8,height=6,dpi=150)
```

#### amphora(2つの持ち手あり)

```R
emoji_search("amphora")
#           emoji             code     keyword
#3477     amphora            1f3fa        vase
#3478     amphora            1f3fa         jar
#4092           a            1f170  red-square
#4093           a            1f170    alphabet
#4094           a            1f170      letter
#4130           o             2b55      circle
#4131           o             2b55       round
#4278           m             24c2    alphabet
#4279           m             24c2 blue-circle
#4280           m             24c2      letter
#4924     armenia 1f1e6\\U0001f1f2          am
#5791 philippines 1f1f5\\U0001f1ed          ph
#
g<- ggplot(point, aes(x,y)) +
  theme_linedraw() +
  theme(panel.border = element_blank(), axis.line = element_line(),
		axis.text=element_text(colour = "black"),panel.grid.major.x = element_blank(),panel.grid.minor.x = element_blank()) +
  scale_y_continuous(expand = c(0,0), limits = c(0,37),breaks=c(0,10,20,30),labels=c(0,10,20,30)) + 
  scale_x_continuous(expand = c(0,0), limits = c(0,48),breaks= 1:47 ,labels = bpdata$tate) +
  labs(title="都道府県別家庭教会数 ",x="",y="") +
  geom_emoji(emoji="1f3fa",size=0.03)
g
# ggsave("emoGbar02.png",g,width=8,height=6,dpi=150)
```