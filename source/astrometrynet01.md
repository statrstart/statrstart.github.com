---
title: astrometry.netとR その１（準備編）
date: 2023-01-27
tags: ["astrometry.net"]
excerpt: astrometry.netのインストールと使い方
---

# astrometry.netとR その１（準備編）

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2Fastrometrynet01&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

astrometry.netを使って得たwcsファイルとRを使って星野写真に星の名前や天体名を記入する方法の自分のための備忘録です。 

## 2023-01-27 : 例４追加 

OS : ubuntu20.04

(参考)  

1. astrometry.netのインストール  
[Building/installing the Astrometry.net code](http://astrometry.net/doc/build.html#build)    
[astrometry.netを入れ直す](https://nekomeshi312.livedoor.blog/archives/7704100.html)  

#### インストールしたときのbinフォルダの中身

```
ls /usr/local/astrometry/bin

an-fitstopnm            fitsverify     modhead              tabmerge
an-pnmtofits            get-healpix    new-wcs              tabsort
astrometry-engine       get-wcs        pad-file             text2fits
augment-xylist          hmstodeg       plot-constellations  uniformize
build-astrometry-index  hpsplit        plotann.py           votabletofits
degtohms                image2pnm      plotquad             wcs-grab
downsample-fits         image2xy       plotxy               wcs-match
fit-wcs                 imarith        query-starkd         wcs-pv2sip
fits-column-merge       imcopy         removelines          wcs-rd2xy
fits-flip-endian        imstat         solve-field          wcs-resample
fits-guess-scale        listhead       startree             wcs-to-tan
fitscopy                liststruc      subtable             wcs-xy2rd
fitsgetext              merge-columns  tablist              wcsinfo
```

2. 必要なデータ（インストールしただけでは動かない）のある場所  

[Astrometry.net index files and other data](http://data.astrometry.net/)  

#### ダウンロードしたファイル（一例：カメラレンズを使用。望遠鏡は使わない。）

```
ls /usr/local/astrometry/data

abell-all.fits    index-4109.fits  index-4115.fits  openngc-ngc.fits
brightstars.fits  index-4110.fits  index-4116.fits  tycho2.kd
hd.fits           index-4111.fits  index-4117.fits  ugc.fits
hip.fits          index-4112.fits  index-4118.fits  uzc2000.fits
index-4107.fits   index-4113.fits  index-4119.fits
index-4108.fits   index-4114.fits  openngc-ic.fits
```

#### `/usr/local/astrometry/data`以外にデータを置く場合、astrometry.cfgの書き換えが必要

```
ls /usr/local/astrometry/etc

astrometry.cfg
```

#### pathは通しておく

`.bashrc`に`export PATH=$PATH:/usr/local/astrometry/bin`を追加

3. plotann.py以外で写真上の銀河のアノテーションを行うツールもありました。

[Galaxy Annotator v0.9](https://github.com/rnanba/GalaxyAnnotator#readme)  

## astrometry.netインストール版の使い方

### プレートソルブ(solve-field コマンド)

プレートソルブしたい画像（例えば、image001.jpg）の置き場所に移動

```
solve-field  -z 2 -O  image001.jpg
```

使用したオプション  

` -z / --downsample <int>: downsample the image by factor <int> before running source extraction `  
` -O / --overwrite: overwrite output files if they already exist `  

### アノテーションを行い画像に星の名前、天体名等を記入(plotann.py)

```
plotann.py --no-grid image001.wcs image001.jpg imageann001.jpg
```

オプションをつけると「星の名前を記入しない」とか「ngcの名前を記入しない」等もできる。

```
plotann.py --no-grid --no-ngc -t "M 31" image001.wcs image001.jpg imageann001.jpg
plotann.py --no-grid --no-bright image001.wcs image001.jpg imageann001.jpg
plotann.py --no-grid --no-ngc --no-bright -t "M 31" image001.wcs image001.jpg imageann001.jpg
```

### 例１: 

![image001.jpg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/image001.jpg)

![imageann001.jpg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/imageann001.jpg)


### 例２: 

![image002.jpg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/image002.jpg)

![imageann002.jpg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/imageann002.jpg)


### 例３: 

![image003.jpg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/image003.jpg)

![imageann003.jpg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/imageann003.jpg)

### 例４: Nex-5 + 銘匠光学(TTArtisan) 17mm F1.4

銘匠光学(TTArtisan) 17mm F1.4 のレンズプロファイルが公開されています。補正は「Raw Therapee」を使って行いました。

[TTArtisan:DownloadCenter](https://ttartisan.com/?DownloadCenter/)

[銘匠光学 TTArtisan 17mm F1.4 APS-C Correction File:https://ttartisan.com/static/upload/file/20220601/1654070780198089.rar](https://ttartisan.com/static/upload/file/20220601/1654070780198089.rar)

#### 補正前

![before001.jpg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/before001.jpg)

- アンドロメダ大銀河あたりは完全にずれています。アンドロメダ大銀河と位置を示す円は全く一致していません。

#### 補正後

![after001.jpg](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/after001.jpg)

- アンドロメダ大銀河が位置を示す円の中にきちんと収まっています。星座線のずれもさほど気になりません。

#### おまけ(補正後のデータを使ってRの自作プログラムで作成した画像)

星座の名前はめんどくさいので書いていません。

![astro06.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/astro06.png)


