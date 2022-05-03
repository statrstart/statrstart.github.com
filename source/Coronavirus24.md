---
title: ggplotで散布図（コロナによる死亡者数等と高齢化率、人口密度）
date: 2022-05-03
tags: ["R","ggplot2","scales","ggrepel","ggpmisc","latex2exp"]
excerpt: 散布図作成はggplotを使うと楽
---

# ggplotで散布図（コロナによる死亡者数等と高齢化率、人口密度）

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FCoronavirus24&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

(使用するデータ)  
[NHK:新型コロナデータ](https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv)  
人口及び高齢化(７０歳以上)率(%)：[住民基本台帳に基づく人口、人口動態及び世帯数令和3年1月1日現在](https://www.soumu.go.jp/main_sosiki/jichi_gyousei/daityo/jinkou_jinkoudoutai-setaisuu.html)  
人口密度：[令和２年国勢調査](https://www.e-stat.go.jp/stat-search?page=1&query=%E4%BA%BA%E5%8F%A3%E5%AF%86%E5%BA%A6&layout=dataset)  

- グラフ上のラベル（都道府県名）付けには、ggrepelパッケージを利用した。
- 回帰直線を引いた散布図には、「回帰式」,「相関係数(R))」<- 予め計算 ,「調整済み決定係数(Radj^2)」を表示した。(ggpmiscパッケージを利用)

個人的には、「棒グラフ」「折れ線グラフ」「箱ひげ図」作成にはggplot2パッケージを使いたいとは思いませんが、「散布図」作成にはggplotを使うのが楽だと思います。

#### 散布図：高齢化(７０歳以上)率(%) & 人口１万人当たり死者数

![covid24_1](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid24_1.png)

- 正の相関ではなく「負の相関がある」のがわかります。
- 「大阪府」は回帰直線のかなり上にある。「北海道」「兵庫県」も大阪ほどではないけど上にあります。

#### 散布図：人口密度 & 人口１万人当たり死者数

![covid24_4](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid24_4.png)

- 人口密度（x軸）は対数にしています。
- こちらは予想通り「正の相関」があります。
- 回帰直線の目立って上にあるのは「北海道」「大阪府」、あとは「兵庫県」「沖縄県」といったところ。

#### 散布図：高齢化(７０歳以上)率(%) & 人口100人当たり感染者数

![covid24_2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid24_2.png)

#### 散布図：人口密度(人/km$^2$) & 人口100人当たり感染者数

![covid24_5](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid24_5.png)

#### 散布図：高齢化(７０歳以上)率(%) & 致死率(%)

![covid24_3](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid24_3.png)

#### 散布図：人口密度(人/km$^2$) & 致死率(%)

![covid24_6](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/covid24_6.png)

### Rコード

```R
library(ggplot2)
library(scales)
library(ggrepel)
library(ggpmisc)
#devtools::install_github('stefano-meschiari/latex2exp')
library(latex2exp)
# ネット上にあるNHKのコロナデータを読み込む
nhkC<- read.csv("https://www3.nhk.or.jp/n-data/opendata/coronavirus/nhk_news_covid19_prefectures_daily_data.csv")
#save(nhkC,file="nhkC.Rdata")
#load("nhkC.Rdata")
nhkC$date<- as.Date(nhkC$"日付")
nhkC$都道府県名<- factor(nhkC$都道府県名,levels=as.character(unique(nhkC$都道府県名)))
# 最も新しい日付
kansen<- nhkC[nhkC$date==max(nhkC$date),c(3,5)]
shisha<- nhkC[nhkC$date==max(nhkC$date),c(3,7)]
# 予め作成したデータの読み込み
#　人口密度：令和２年国勢調査　https://www.e-stat.go.jp/stat-search?page=1&query=%E4%BA%BA%E5%8F%A3%E5%AF%86%E5%BA%A6&layout=dataset
#  人口及び高齢化(７０歳以上)率(%)：住民基本台帳に基づく人口、人口動態及び世帯数令和3年1月1日現在 https://www.soumu.go.jp/main_sosiki/jichi_gyousei/daityo/jinkou_jinkoudoutai-setaisuu.html        
zinkou<- c(5228732,1260067,1221205,2282106,971604,1070017,1862777,2907678,1955402,1958185,7393849,6322897,13843525,9220245,2213353,1047713,
	1132656,774596,821094,2072219,2016868,3686335,7558872,1800756,1418886,2530609,8839532,5523627,1344952,944750,556959,672979,
	1893874,2812477,1356144,735070,973922,1356343,701531,5124259,818251,1336023,1758815,1141784,1087372,1617850,1485484)
pdata<- data.frame(
	都道府県名=c("北海道","青森県","岩手県","宮城県","秋田県","山形県","福島県","茨城県","栃木県","群馬県",
	"埼玉県","千葉県","東京都","神奈川県","新潟県","富山県","石川県","福井県","山梨県","長野県","岐阜県","静岡県","愛知県",
	"三重県","滋賀県","京都府","大阪府","兵庫県","奈良県","和歌山県","鳥取県","島根県","岡山県","広島県","山口県","徳島県",
	"香川県","愛媛県","高知県","福岡県","佐賀県","長崎県","熊本県","大分県","宮崎県","鹿児島県","沖縄県"),
	高齢化率=c(24.379,25.232,25.510,21.183,28.548,25.711,23.403,22.091,21.541,22.850,20.446,21.084,17.761,19.705,24.972,25.323,
	23.140,23.338,23.604,24.884,23.334,23.009,19.477,23.069,20.004,23.197,21.338,22.260,24.412,25.724,24.511,26.733,23.640,22.862,
	26.975,25.583,24.299,25.398,27.661,20.967,22.736,24.784,23.772,25.382,24.504,24.082,15.871),
	人口密度= c(66.6,128.3,79.2,316.1,82.4,114.6,133,470.2,301.7,304.8,1934,1218.5,6402.6,3823.2,174.9,243.6,270.5,183,181.4,
	151,186.3,467.2,1458,306.6,351.9,559,4638.4,650.5,358.8,195.3,157.8,100.1,265.4,330.2,219.6,173.5,506.3,235.2,97.3,1029.8,
	332.5,317.7,234.6,177.2,138.3,172.9,642.9))
pdata$人口当たり感染者数 <- kansen[,2]/zinkou*100
pdata$人口当たり死者数 <- shisha[,2]/zinkou*10000
pdata$致死率 <- shisha[,2]/kansen[,2]*100
#色
pdata$color<- rep("black",47)
#大阪府の色変更
pdata$color[27]<- "red" 
#東京都と愛知県の色変更
pdata$color[c(13,23)]<- "blue" 
# 散布図：高齢化(７０歳以上)率 & 人口１万人当たり死者数
# 相関係数の計算
corc <- round(cor(pdata$高齢化率,pdata$人口当たり死者数),2)
#
g <- ggplot(pdata, aes(x = 高齢化率, y = 人口当たり死者数, label = 都道府県名)) 
g <- g + geom_point(color=pdata$color) 
g <- g + geom_text_repel(color=pdata$color,max.overlaps = Inf)
g <- g + labs(title="散布図：高齢化(７０歳以上)率(%) & 人口１万人当たり死者数",x="高齢化(７０歳以上)率(%)",y="人口１万人当たり死者数")
g <- g + geom_smooth(method = "lm",formula='y~x')
g <- g + stat_poly_eq(formula = y~x,
	aes(label = paste("atop(",
			paste(stat(eq.label),
			sep = "~~~"),
		",",
			paste("R~`=`~",corc,"~~~",stat(adj.rr.label),
			sep = ""),
		")",
		sep = "")),
	label.x = "left",label.y = "top",
	parse = TRUE)
g
# ggsave("covid24_1.png",g,width=8,height=6,dpi=150)
#
# 散布図：高齢化(７０歳以上)率 & 人口100人当たり感染者数
# 相関係数の計算
corc <- round(cor(pdata$高齢化率,pdata$人口当たり感染者数),2)
#
g <- ggplot(pdata, aes(x = 高齢化率, y = 人口当たり感染者数, label = 都道府県名)) 
g <- g + geom_point(color=pdata$color) 
g <- g + geom_text_repel(color=pdata$color,max.overlaps = Inf)
g <- g + labs(title="散布図：高齢化(７０歳以上)率(%) & 人口100人当たり感染者数",x="高齢化(７０歳以上)率(%)",y="人口100人当たり感染者数")
g <- g + geom_smooth(method = "lm",formula='y~x')
g <- g + stat_poly_eq(formula = y~x,
	aes(label = paste("atop(",
			paste(stat(eq.label),
			sep = "~~~"),
		",",
			paste("R~`=`~",corc,"~~~",stat(adj.rr.label),
			sep = ""),
		")",
		sep = "")),
	label.x = "right",label.y = "top",
	parse = TRUE)
g
# ggsave("covid24_2.png",g,width=8,height=6,dpi=150)
#
# 散布図：高齢化(７０歳以上)率 & 致死率
g <- ggplot(pdata, aes(x = 高齢化率, y = 致死率, label = 都道府県名)) 
g <- g + geom_point(color=pdata$color) 
g <- g + geom_text_repel(color=pdata$color,max.overlaps = Inf)
g <- g + labs(title="散布図：高齢化(７０歳以上)率(%) & 致死率(%)",x="高齢化(７０歳以上)率(%)",y="致死率(%)")
g
# ggsave("covid24_3.png",g,width=8,height=6,dpi=150)
#
# 散布図：人口密度 & 人口１万人当たり死者数
# 相関係数の計算
corc <- round(cor(log10(pdata$人口密度),pdata$人口当たり死者数),2)
#
g <- ggplot(pdata, aes(x = 人口密度, y = 人口当たり死者数, label = 都道府県名)) 
g <- g + geom_point(color=pdata$color) 
g <- g + geom_text_repel(color=pdata$color,max.overlaps = Inf)
# titleはexpression関数を使い、x軸のラベルにはlatex2expパッケージのTeX関数を使いました。
g <- g + labs(title=expression(paste("散布図：人口密度(人/k",m^2,")[対数軸] & 人口１万人当たり死者数"),sep=""),
		x=TeX("人口密度(人/km$^2$)")  ,y="人口１万人当たり死者数")
g <- g + scale_x_log10(breaks=(10^(1:4))%x%c(1,5),minor_breaks=(10^(1:3))%x%c(2:4,6:9))
g <- g + geom_smooth(method = "lm",formula='y~x')
g <- g + stat_poly_eq(formula = y~x,
	aes(label = paste("atop(",
			paste(stat(eq.label),
			sep = "~~~"),
		",",
			paste("R~`=`~",corc,"~~~",stat(adj.rr.label),
			sep = ""),
		")",
		sep = "")),
	label.x = "left",label.y = "top",
	parse = TRUE)
g
# ggsave("covid24_4.png",g,width=8,height=6,dpi=150)
#
# 散布図：人口密度 & 人口100人当たり感染者数
lm(人口当たり感染者数~log10(人口密度),data=pdata)
# 相関係数の計算
corc <- round(cor(log10(pdata$人口密度),pdata$人口当たり感染者数),2)
#
g <- ggplot(pdata, aes(x = 人口密度, y = 人口当たり感染者数, label = 都道府県名)) 
g <- g + geom_point(color=pdata$color) 
g <- g + geom_text_repel(color=pdata$color,max.overlaps = Inf)
g <- g + labs(title=TeX("散布図：人口密度(人/km$^2$) & 人口100人当たり感染者数"),x=TeX("人口密度(人/km$^2$)"),y="人口100人当たり感染者数")
g <- g + scale_x_log10(breaks=(10^(1:4))%x%c(1,5),minor_breaks=(10^(1:3))%x%c(2:4,6:9))
g <- g + geom_smooth(method = "lm",formula='y~x')
g <- g + stat_poly_eq(formula = y~x,
	aes(label = paste("atop(",
			paste(stat(eq.label),
			sep = "~~~"),
		",",
			paste("R~`=`~",corc,"~~~",stat(adj.rr.label),
			sep = ""),
		")",
		sep = "")),
	label.x = "left",label.y = "top",
	parse = TRUE)
#g <- g + annotate("text",x=xmin,y=ymax,label = txt,hjust=-.2,vjust=2)
g
# ggsave("covid24_5.png",g,width=8,height=6,dpi=150)
#
# 散布図：人口密度 & 致死率
g <- ggplot(pdata, aes(x = 人口密度, y = 致死率, label = 都道府県名)) 
g <- g + geom_point(color=pdata$color) 
g <- g + geom_text_repel(color=pdata$color,max.overlaps = Inf)
g <- g + labs(title=TeX("散布図：人口密度(人/km$^2$) & 致死率(%)"),x=TeX("人口密度(人/km$^2$)"),y="致死率(%)")
g <- g + scale_x_log10(breaks=(10^(1:4))%x%c(1,5),minor_breaks=(10^(1:3))%x%c(2:4,6:9))
g
# ggsave("covid24_6.png",g,width=8,height=6,dpi=150)
```
