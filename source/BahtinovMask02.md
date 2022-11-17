---
title: Rでカメラレンズのバーティノフ・マスク（easySVG パッケージ）
date: 2022-11-17
tags: ["R","BahtinovMask","easySVG","eval"]
excerpt: 透明なシートに印刷。
---

# Rでカメラレンズのバーティノフ・マスク（easySVG パッケージ）

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FBahtinovMask02&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

###（参考）  
「カメラレンズ バーティノフ・マスク 自作」で検索したサイト。

### 「透明なシートに印刷」して使うバーティノフ・マスクを作るための簡単なプログラムです。今回は、「easySVG パッケージ」を使いました。

### （注意）このプログラムでは、できたSVGファイルをGimpで必要とするサイズで読み込み。ファイル->名前を付けてエクスポート する必要あり。

### BahtinovMaskのsvgファイル

[SVGBahtinov01.svg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/SVGBahtinov01.svg)

#### 縦横80mmにリサイズしたpngファイル

![SVGBahtinov80mm_1.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/SVGBahtinov80mm_1.png)

### BahtinovMaskのsvgファイル（線の間隔を狭くした）

[SVGBahtinov02.svg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/SVGBahtinov02.svg)

#### 縦横80mmにリサイズしたpngファイル

![SVGBahtinov80mm_2.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/SVGBahtinov80mm_2.png)

### Rコード

SVGの標準の座標系は左上隅が(0,0)なんですね。基本的なことも知らずにプログラムしたので混乱しました。  

```R
# easySVGパッケージのインストール
# devtools::install_github("ytdai/easySVG")
#
library(easySVG)
# 円の半径
r=180
# 間隔
space=18
# space=3.375
#横線と斜線の仕切り線の太さ
wide0=space/2
#マスク線の太さ
wide=space/3
# 角度
theta=pi/6 # 30°
a=tan(theta)
# 円
circle.1 <- circle.svg(cx = r, cy = r, r = r,fill="none",stroke="black", stroke.width = 1)
# message(circle.1)
#横線と斜線の仕切り線
line.01 <- line.svg(x1 = r, y1 = 0, x2 = r, y2 = r*2, stroke = "black", stroke.width = wide0)
# message(line.01)
#斜線と斜線の仕切り線
line.02 <- line.svg(x1 = r, y1 = r, x2 = r*2, y2 = r, stroke = "black", stroke.width = wide)
# message(line.02)
# 四角で囲む(切り取り線のつもり)
rect.1 <- rect.svg(x = 0, y = 0, width = 2*r, height = 2*r, fill = "none",stroke="black",stroke.width=1)
# message(rect.1)
#
# この変数（list）に線名をつなげていく。囲み線が必要でないならrect.1はいらない。
list<- "list(circle.1,line.01,line.02,rect.1"
# 囲み線が必要でない場合はこっちを使う。
# list<- "list(circle.1,line.01,line.02
# 横線
LL1<- seq(r+space/2,r*2,space)
LL2<- seq(r-space/2,0,-space)
L1<- c(LL1,LL2)
x1 = - sqrt(r^2-(L1-r)^2)+r
# line.svg命令をeval関数を使って実行する。
for (i in 1:length(L1)){
	eval(parse(text = paste0("line.1", i, "=line.svg(x1 = r, y1 =" , L1[i] , ", x2 = " , x1[i], " , y2 =" , L1[i] ,",stroke = 'black', stroke.width = wide)" )))
#	eval(parse(text = paste0("message(line.1", i, ")")))
}
# 変数(list)の線の名を加える
for (i in 1:length(L1)){
	list<- paste0(list,",line.1",i)
}
#
# 斜線
# 横線と斜線の仕切り線上の点を始点とする線
LL1<- seq(r,r*2,space)
LL2<- seq(r,0,-space)
# 連立方程式の解
x21<- (-2*a*(LL1-r)+sqrt(4*a^2*(LL1-r)^2-4*(1+a^2)*((LL1-r)^2-r^2)))/(2*(1+a^2)) +r
y21<- a*(-2*a*(LL1-r)+sqrt(4*a^2*(LL1-r)^2-4*(1+a^2)*((LL1-r)^2-r^2)))/(2*(1+a^2)) +(LL1-r) + r
# 確認
# (x21-r)^2+(y21-r)^2
for (i in 1:length(LL1)){
	eval(parse(text = paste0("line.2", i, "=line.svg(x1 = r, y1 =" , LL1[i] , ", x2 = " , x21[i], " , y2 =" , y21[i] ,",stroke = 'black', stroke.width = wide)" )))
#	eval(parse(text = paste0("message(line.2", i, ")")))
}
for (i in 1:length(LL1)){
	list<- paste0(list,",line.2",i)
}
x22<- x21
y22<- a*(-2*a*(LL2-r)-sqrt(4*a^2*(LL2-r)^2-4*(1+a^2)*((LL2-r)^2-r^2)))/(2*(1+a^2)) +(LL2-r) +r
# 確認
# (x22-r)^2+(y22-r)^2
for (i in 1:length(LL2)){
	eval(parse(text = paste0("line.3", i, "=line.svg(x1 = r, y1 =" , LL2[i] , ", x2 = " , x22[i], " , y2 =" , y22[i] ,",stroke = 'black', stroke.width = wide)" )))
#	eval(parse(text = paste0("message(line.3", i, ")")))
}
for (i in 1:length(LL1)){
	list<- paste0(list,",line.3",i)
}
# 斜線と斜線の仕切り線上の点を始点とする線
x31<- (-2*a*(LL2-r)+sqrt(4*a^2*(LL2-r)^2-4*(1+a^2)*((LL2-r)^2-r^2)))/(2*(1+a^2)) +r
y31<- a*(-2*a*(LL2-r)+sqrt(4*a^2*(LL2-r)^2-4*(1+a^2)*((LL2-r)^2-r^2)))/(2*(1+a^2)) +(LL2-r) + r
# 確認
# (x31-r)^2+(y31-r)^2

for (i in 1:length(LL2)){
	if (LL2[i] != r & y31[i] > r){
		eval(parse(text = paste0("line.4", i, "=line.svg(x1 =",r+(r-LL2[i])/a , ", y1 =r , x2 = " , x31[i], " , y2 =" , y31[i] ,",stroke = 'black', stroke.width = wide)" )))
#		eval(parse(text = paste0("message(line.4", i, ")")))
	}
}

for (i in 1:length(LL2)){
	if (LL2[i] != r & y31[i] > r){
		list<- paste0(list,",line.4",i)
	}
}
x32<- x31
y32<- a*(-2*a*(LL1-r)-sqrt(4*a^2*(LL1-r)^2-4*(1+a^2)*((LL1-r)^2-r^2)))/(2*(1+a^2)) +(LL1-r) + r
# 確認
# (x32-r)^2+(y32-r)^2
for (i in 1:length(LL1)){
	if (LL1[i] != r & y32[i] < r){
		eval(parse(text = paste0("line.5", i, "=line.svg(x1 =",r+(LL1[i]-r)/a , ", y1 =r , x2 = " , x32[i], " , y2 =" , y32[i] ,",stroke = 'black', stroke.width = wide)" )))
#		eval(parse(text = paste0("message(line.5", i, ")")))
	}
}
for (i in 1:length(LL1)){
	if (LL1[i] != r & y32[i] < r){
		list<- paste0(list,",line.5",i)
	}
}
eval(parse(text = paste0("content <- ",list,")")))
pack.svg(width = 2*r, height = 2*r, pack.content = content, output.svg.name = "SVGBahtinov.svg")
```
