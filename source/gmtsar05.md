---
title: GMTSARで2.5次元解析（計算式について）
date: 2024-03-26
tags: ["GMTSAR","GMT","pixel offset", "ALOS-2","PALSAR-2"]
excerpt: 2024能登半島地震のALOS-2/PALSAR-2の無償公開データ
---

# GMTSARで2.5次元解析（計算式について）

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2Fgmtsar05&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

** 「この記事に使用したデータは、JAXAの無償公開データを利用しました。」 **

(参考)  

1. [オプション２：斜面変状の移動量の更なる定量化を行う](https://www.gsi.go.jp/chirijoho/chirijoho40099.html)
2. [準上下・準東西方向とは](https://maps.gsi.go.jp/sar/mechanism/whats_2.5d_analysis.html)
3. [極座標への変換についてもう少し詳しく教えてほしい](https://science.shinshu-u.ac.jp/~tiiyama/?page_id=4311)
4. [三角関数の基本的性質](https://risalc.info/src/trigonometric-function.html#sup)

[「だいち2号」による令和6年能登半島地震の観測結果について](https://www.eorc.jaxa.jp/ALOS/jp/library/disaster/dis_pal2_noto_earthquake_20240110_j.htm)と
[「だいち２号」観測データの解析による令和６年能登半島地震に伴う地殻変動（2024年1月19日更新）](https://www.gsi.go.jp/uchusokuchi/20240101noto_insar.html)には
「 2.5次元解析」の図がでてきます。

ここ[オプション２：斜面変状の移動量の更なる定量化を行う](https://www.gsi.go.jp/chirijoho/chirijoho40099.html)によると、

衛星に近づく／遠ざかる距離Dは、地表の移動量を東方向をｄE、北方向をｄN、上方向をｄUとすると、ALOS/PALSARの場合、最も観測が行われているオフナディア角34.3度の場合に
- 南行観測の場合：D＝－0.62ｄE＋0.1ｄN－0.78ｄU
- 北行観測の場合：D＝0.62ｄE＋0.1ｄN－0.78ｄU
- ２つの式の差分をとると、D(北行)－D(南行)＝1.24ｄE
- 和をとると、D(北行)＋D(南行)＝0.2ｄN－1.56ｄU

＊　実際には、オフナディア角が南行と北行で一致するとは限らないし、衛星もこんなに都合のいい進行方向はとりません。

とあるけど、dEの係数、dNの係数、dUの係数の求め方については書いてありません。で、求めてみました。

### 計算式について

[極座標への変換についてもう少し詳しく教えてほしい](https://science.shinshu-u.ac.jp/~tiiyama/?page_id=4311)の極座標⇔直角座標の変換によると、

- x = r sin θ ・cos φ
- y = r sin θ ・sin φ
- z = r cos θ

- ここでの極角(天頂角)は以下で言う入射角のことだと考えることができる。
- ここでの方位角(φ)の定義は、x軸（東）から反時計回りにはかっているが、alosでのシーン中心におけるビーム中心方向(a)はy軸（北）から時計回りにはかっている。（a=π/2-φ が成り立つ）

（参考）[三角関数の基本的性質](https://risalc.info/src/trigonometric-function.html#sup)

- cos a=cos(π/2-φ)=sin φ
- sin a=sin(π/2-φ)=cos φ

上下については、衛星に近づく方向がマイナスなので、-cos θ　となる。

よって、θを入射角、aをシーン中心におけるビーム中心方向とすると、

- dEの係数: sin θ ・sin a
- dNの係数: sin θ ・cos a
- dUの係数: -cos θ

### 計算する

- ALOS/PALSARの場合、視線方向は進行方向の右90度
- ALOS/PALSARの場合、オフナディア角34.3度で入射角は約38.7度になる。
- 衛星の進行方向は、(計算した上で係数がほぼ一致した)北行の場合は進行方向の方位角を-10度、南行の場合は進行方向の方位角を190度とした。

#### 南行の場合

進行方向の方位角を190度とすると、視線方向は、190+90=280度。オフナディア角34.3度の場合、入射角は38.7度。

```R
sin(38.7*pi/180)*sin(280*pi/180)
sin(38.7*pi/180)*cos(280*pi/180)
-cos(38.7*pi/180)
#[1] -0.6157438
#[1] 0.1085722
#[1] -0.7804304
```

D＝－0.62ｄE＋0.11ｄN－0.78ｄU

#### 北行の場合

進行方向の方位角を-10度とすると、視線方向は、-10+90=80度。オフナディア角34.3度の場合、入射角は38.7度。

```R
sin(38.7*pi/180)*sin(80*pi/180)
sin(38.7*pi/180)*cos(80*pi/180)
-cos(38.7*pi/180)
#[1] 0.6157438
#[1] 0.1085722
#[1] -0.7804304
```

D＝0.62ｄE＋0.11ｄN－0.78ｄU

南行、北行とも、国土地理院の記事とほぼ一致した。

## ALOS2/PALSAR2 の実データで計算してみる

[陸域観測技術衛星 2 号（ALOS-2）PALSAR-2 レベル 1.1/1.5/2.1/3.1　プロダクトフォーマット説明書（CEOS SAR フォーマット）](https://www.eorc.jaxa.jp/ALOS-2/doc/fdata/PALSAR-2_xx_Format_CEOS_J_e.pdf)

SAR リーダ(LEDから始まるファイル)

(プロダクトフォーマット説明書のP.31) ファイルディスクリプタ : レコード長(byte) 720 <--- ここは読み飛ばす

SAR リーダファイルから計算に必要な数値をとりだして、計算すると、(Rを使わなくても取り出せる)

（参考）[シェルスクリプトでバイナリを扱う方法の完全版](https://qiita.com/ko1nksm/items/2c22e700b547ff99ecc3)

### 2024/01/02 2830

ALOS2/PALSAR2は、進行方向の左90度を観測できる。(ALOS/PALSARは右90度のみ)

```sh
# センサプラットフォームの飛行方向に対するセンサアングル
dd if=LED-ALOS2518982830-240102-UBSL1.1__D ibs=1 skip=1197 count=8 2>/dev/null
# -90.000 
# (注意) awkの場合、 piは、atan2(0,-0)
# 入射角
incidence_angle=$(dd if=LED-ALOS2518982830-240102-UBSL1.1__D ibs=1 skip=1205 count=8 2>/dev/null)
# シーン中心におけるビーム中心方向
look=$(dd if=LED-ALOS2518982830-240102-UBSL1.1__D ibs=1 skip=2534 count=16 2>/dev/null)
# pi=atan2(0,-0)
EW=$(echo| awk -v "ia=$incidence_angle" -v "look=$look"  '{print sin(ia*atan2(0,-0)/180)*sin(look*atan2(0,-0)/180)}' )
NS=$(echo| awk -v "ia=$incidence_angle" -v "look=$look"  '{print sin(ia*atan2(0,-0)/180)*cos(look*atan2(0,-0)/180)}' )
UD=$(echo| awk -v "ia=$incidence_angle" '{print -cos(ia*atan2(0,-0)/180)}' )
#
echo $incidence_angle $look $EW $NS $UD
# 39.678 106.1804862 0.613182 -0.177919 -0.769645
```

入射角: 39.678度、シーン中心におけるビーム中心方向：106.1804862度

D1 = 0.613182 dE -0.177919 dN -0.769645 dU

### 2024/01/01 0770

```sh
# センサプラットフォームの飛行方向に対するセンサアングル
dd if=LED-ALOS2518900770-240101-UBSL1.1__A ibs=1 skip=1197 count=8 2>/dev/null
# -90.000 
# 入射角
incidence_angle=$(dd if=LED-ALOS2518900770-240101-UBSL1.1__A ibs=1 skip=1205 count=8 2>/dev/null)
# シーン中心におけるビーム中心方向
look=$(dd if=LED-ALOS2518900770-240101-UBSL1.1__A ibs=1 skip=2534 count=16 2>/dev/null)
# pi=atan2(0,-0)
EW=$(echo| awk -v "ia=$incidence_angle" -v "look=$look"  '{print sin(ia*atan2(0,-0)/180)*sin(look*atan2(0,-0)/180)}' )
NS=$(echo| awk -v "ia=$incidence_angle" -v "look=$look"  '{print sin(ia*atan2(0,-0)/180)*cos(look*atan2(0,-0)/180)}' )
UD=$(echo| awk -v "ia=$incidence_angle" '{print -cos(ia*atan2(0,-0)/180)}' )
#
echo $incidence_angle $look $EW $NS $UD
# 32.411 -105.4931072 -0.516512 -0.143175 -0.844225
```

入射角: 32.411度、シーン中心におけるビーム中心方向：-105.4931072度

D2 = -0.516512 dE -0.143175 dN -0.844225 dU

＊ 単純に足したり、引いたりしただけではダメ。

### 準上下方向

D1/0.613182 + D2/0.516512     
= (0.613182 dE -0.177919 dN -0.769645 dU)/0.613182 + (-0.516512 dE -0.143175 dN -0.844225 dU)/0.516512  
= (-0.177919/0.613182 - 0.143175/0.516512 ) dN + (-0.769645/0.613182 -0.844225/0.516512) dU  
= -0.5673528 dN -2.889639 dU  

dU + 0.1963404 dN = -(D1/0.613182 + D2/0.516512)/2.889639

### 準東西方向

D1/0.769645 - D2/0.844225     
= (0.613182 dE -0.177919 dN -0.769645 dU)/0.769645 + (0.516512 dE +0.143175 dN +0.844225 dU)/0.844225  
= (0.613182/0.769645 + 0.516512/0.844225) dE + (-0.177919/0.769645 + 0.143175/0.844225 ) dN   
= 1.408526 dE - 0.0615768 dN  

dE - 0.04371719 dN = (D1/0.769645 - D2/0.844225)/1.408526

