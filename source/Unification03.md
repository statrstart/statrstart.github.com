---
title: 家庭連合（旧 統一教会）の所在地(地図を作成その２)
date: 2022-08-08
tags: ["R","jpndistrict","sf","ggplot2","rmapshaper"]
excerpt: 最寄りの家庭教会のデータ
---

# 家庭連合（旧 統一教会）の所在地(地図を作成その２)

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FUnification03&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

(元データ)  
[最寄りの家庭教会：https://ffwpu.jp/admission/church/nearest](https://ffwpu.jp/admission/church/nearest)  

[使用するデータセット:Unification.csv](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/Unification.csv)  
(注意)  
- 文字コードはUTF-8です。
- データ項目は、所在地の県番号、都道府県名、郵便番号、住所、緯度、経度です。
- 電話番号は地図上にプロットにするのに必要ないので取り除きました。
- サイトに載っている家庭教会（2022/8/7現在：２９０件）のみで関連団体の所在地はわかりません。
- データセット上の緯度、経度と施設の位置とは若干のずれがあるようです。

(重要ポイント)    
「jpndistrict パッケージのjpn_pref()でdistrict = FALSEとするとErrorが出てしまう。」問題は

```R
library(jpndistrict)
sf::sf_use_s2(FALSE) # <- ここがポイント
```

とすることで解決する。

### 日本地図では家庭教会数の多い都道府県の様子がわからないので大阪府、愛知県、東京都の地図を作成。  

#### 大阪府（district = TRUE ,ggplot2は使わない場合）

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Tkmap02.png)

#### 愛知県（district = FALSE ,ggplot2は使わない場合）

`sf_use_s2(FALSE)` が必要

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Tkmap03.png)

#### 東京都（district = FALSE ,ggplot2を使う。）

`sf_use_s2(FALSE)` が必要。`coord_sf(xlim = c(138.9, 139.95), ylim = c(35.35, 36), expand = FALSE)`で地図範囲を指定。

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Tkmap04.png)

### 複数の県を一つの地図に描く

#### 関東地方（district = FALSE ,ggplot2を使う。)  
`sf_use_s2(FALSE)` が必要

- rmapshaperパッケージのms_simplify関数とms_filter_islands関数を使う。

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Tkmap06.png)

#### 東北地方（district = FALSE ,ggplot2を使う。)  
`sf_use_s2(FALSE)` が必要

- 県境を描かない。

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/Tkmap05.png)

### Rコード

#### 大阪府（district = TRUE ,ggplot2は使わない場合）

```R
p<- read.csv("https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/Unification.csv")
#
#install.packages("remotes")
#remotes::install_github("uribo/jpndistrict")
require(jpndistrict)
library(sf)
#
#png("Tkmap02.png",width=800,height=600)
par(mar=c(0,0,2,0))
osaka <- jpn_pref(admin_name="大阪府")
plot(st_geometry(osaka))
points(x=p$経度[p$都道府県=="大阪府"],p$緯度[p$都道府県=="大阪府"],pch=21,cex=1.5,col="royalblue4",bg=rgb(1,0,0,0.8))
title("大阪府の世界平和統一家庭連合（旧 世界基督教統一神霊協会）の所在地")
#text(x=par("usr")[1],y=par("usr")[4],"大阪府の世界平和統一家庭連合（旧 世界基督教統一神霊協会）の所在地",cex=1.2,pos=4,xpd=T)
text(x=mean(par("usr")[1:2]),y=par("usr")[4],"家庭連合（旧 統一教会）の公式サイト「最寄りの家庭教会」から作成(2022年8月7日)",pos=1,xpd=T)
#dev.off()
```

#### 愛知県（district = FALSE ,ggplot2は使わない場合）

```R
p<- read.csv("https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/Unification.csv")
#
#install.packages("remotes")
#remotes::install_github("uribo/jpndistrict")
require(jpndistrict)
library(sf)
sf_use_s2(FALSE) # <- これが必要
#png("Tkmap03.png",width=800,height=600)
par(mar=c(0,0,2,0))
aichi <- jpn_pref(23, district = FALSE)
plot(st_geometry(aichi))
points(x=p$経度[p$県番号==23],p$緯度[p$県番号==23],pch=21,cex=1.5,col="royalblue4",bg=rgb(1,0,0,0.8))
title("愛知県の世界平和統一家庭連合（旧 世界基督教統一神霊協会）の所在地")
text(x=mean(par("usr")[1:2]),y=par("usr")[4],"家庭連合（旧 統一教会）の公式サイト「最寄りの家庭教会」から作成(2022年8月7日)",pos=1,xpd=T)
#dev.off()
```

#### 東京都（district = FALSE ,ggplot2を使う。）

```R
p<- read.csv("https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/Unification.csv")
#
#install.packages("remotes")
#remotes::install_github("uribo/jpndistrict")
require(jpndistrict)
library(sf)
sf_use_s2(FALSE) # <- これが必要
require(ggplot2)
#
tokyo <- jpn_pref(pref_code=13, district = FALSE)
pos<- data.frame(longitude=p$経度[p$都道府県=="東京都"],latitude=p$緯度[p$都道府県=="東京都"])
#png("Tkmap04.png",width=800,height=600)
ggplot() +
   geom_sf(data = tokyo) +
	coord_sf(xlim = c(138.9, 139.95), ylim = c(35.35, 36), expand = FALSE) +
	geom_text(data = pos, aes(x = longitude, y = latitude), label= "\u26B1", color=rgb(1,0,0,0.8),size=8) +
	labs(title="東京都の世界平和統一家庭連合（旧 世界基督教統一神霊協会）の所在地",
		subtitle="家庭連合（旧 統一教会）の公式サイト「最寄りの家庭教会」から作成(2022年8月7日)") +
	theme(plot.title = element_text(hjust = 0.5),plot.subtitle = element_text(hjust = 1))
#dev.off()
```

#### 関東地方（district = FALSE ,ggplot2を使う。)  
- rmapshaperパッケージのms_simplify関数とms_filter_islands関数を使う。

```R
p<- read.csv("https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/Unification.csv")
#
#install.packages("remotes")
#remotes::install_github("uribo/jpndistrict")
require(jpndistrict)
library(sf)
sf_use_s2(FALSE) # <- これが必要
require(ggplot2)
library(rmapshaper)
#
# 関東地方
map <- jpn_pref(pref_code =8, district = FALSE)
for (i in 9:14){
	temp <- jpn_pref(pref_code =i, district = FALSE)
# 県境も取り去る場合は、st_union
#	map<- st_union(map,temp)
	map<- rbind(map,temp)
}
map<- ms_simplify(map,keep = 0.01, keep_shapes = TRUE)
map<- ms_filter_islands(map,min_area = 100000000)
#
nnn<-which(p$県番号>=8 & p$県番号<=14)
pos<- data.frame(longitude=p$経度[nnn],latitude=p$緯度[nnn])
#png("Tkmap06.png",width=800,height=600)
ggplot() +
   geom_sf(data = map) +
	geom_point(data = pos, aes(x = longitude, y = latitude), size = 4, shape = 21, fill = rgb(1,0,0,0.8),color="royalblue4") +
	labs(title="関東地方の世界平和統一家庭連合（旧 世界基督教統一神霊協会）の所在地",
		subtitle="家庭連合（旧 統一教会）の公式サイト「最寄りの家庭教会」から作成(2022年8月7日)") +
	theme(plot.title = element_text(hjust = 0.5),plot.subtitle = element_text(hjust = 0.5))
#dev.off()
```

#### 東北地方（district = FALSE ,ggplot2を使う。)  
`sf_use_s2(FALSE)` が必要

- 県境を描かない。

```R
p<- read.csv("https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/Unification.csv")
#
#install.packages("remotes")
#remotes::install_github("uribo/jpndistrict")
require(jpndistrict)
library(sf)
sf_use_s2(FALSE) # <- これが必要
require(ggplot2)
# 東北地方
map <- jpn_pref(pref_code =2, district = FALSE)
for (i in 3:7){
	temp <- jpn_pref(pref_code =i, district = FALSE)
# 県境も取り去る場合は、st_union
	map<- st_union(map,temp)
#	map<- rbind(map,temp)
}
nnn<-which(p$県番号>=2 & p$県番号<=7)
pos<- data.frame(longitude=p$経度[nnn],latitude=p$緯度[nnn])
#png("Tkmap05.png",width=600,height=800)
ggplot() +
   geom_sf(data = map) +
	geom_point(data = pos, aes(x = longitude, y = latitude), size = 4, shape = 21, fill = rgb(1,0,0,0.8),color="royalblue4") +
	labs(title="東北地方の世界平和統一家庭連合（旧 世界基督教統一神霊協会）の所在地",
		subtitle="家庭連合（旧 統一教会）の公式サイト「最寄りの家庭教会」から作成(2022年8月7日)") +
	theme(plot.title = element_text(hjust = 0.5),plot.subtitle = element_text(hjust = 0.5))
#dev.off()
```
