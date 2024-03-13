---
title: GMTSARでピクセルオフセット法（準備編）
date: 2024-03-13
tags: ["GMTSAR","GMT","pixel offset", "ALOS-2","PALSAR-2"]
excerpt: 2024能登半島地震のALOS-2/PALSAR-2の無償公開データ
---

# GMTSARでピクセルオフセット法（準備編）

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2Fgmtsar02&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

** 「この記事に使用したデータは、JAXAの無償公開データを利用しました。」 **

使用したパソコン、OS等

- PC : CHUWI HeroBox 2023 (Intel N100  8GB+256GB )
- OS : debian12（512GBのSSDを増設して、インストールした）
- gmt: Version 6.4.0
- gmtsarは記事時点で最新のもの。

ピクセルオフセット法を行うにはxcorrというプログラムを使うのですが、Intel N100のPCだと果てしなく時間（数日！！！）がかかります。ので、お金に余裕のある方は、超高速なPCを使いましょう。

でもなんとかしたいので、githubで見つけた[gmtsar_optimize:https://github.com/cuihaoleo/gmtsar_optimize ](https://github.com/cuihaoleo/gmtsar_optimize)の「xcorr2_cl」を使わせてもらいました。
（xcorr2だと数分で済む操作なら問題ないのですが、数時間の操作だとエラーになりました）

### 「xcorr2_cl」のインストールについて

[gmtsar_optimize:https://github.com/cuihaoleo/gmtsar_optimize ](https://github.com/cuihaoleo/gmtsar_optimize)には、Ubuntu 16.04 LTSへのインストールしか載っていません。
僕自身、ネットで検索し、試行錯誤しながらインストールしたので効率的な方法を示すことができません。以下は参考として。

#### OpenCLのインストール

[Linux 用の最新のインテル グラフィックス ドライバーを入手する方法](https://thewindowsclub.blog/how-to-get-the-latest-intel-graphics-drivers-for-linux/)

```
# Intel CPU内蔵GPUラインタイムのインストール
sudo apt-get install intel-opencl-icd
# OpenCLのインストール
sudo apt install ocl-icd-opencl-dev
# バージョン確認
sudo apt-cache show ocl-icd-dev
```

#### ArrayFireについては、[Install ArrayFire From Linux Package Managers](https://github.com/arrayfire/arrayfire/wiki/Install-ArrayFire-From-Linux-Package-Managers)を参考にする。

```
sudo su
apt-key adv --fetch-key https://repo.arrayfire.com/GPG-PUB-KEY-ARRAYFIRE-2020.PUB
echo "deb [arch=amd64] https://repo.arrayfire.com/debian all main" | tee /etc/apt/sources.list.d/arrayfire.list
```

メモを見ると、aptitude （インストールについて助言がもらえる）をインストールして、以下のようなことをしていました。

```
sudo aptitude install libarrayfire-unified-dev
sudo apt install arrayfire-opencl3-openblas
```

xcorr2_cl , xcorr2_helper , xcorr2 はgmtsarのbinフォルダに移動もしくはコピーする。

### 処理時間を計測してみました。

なお、xcorrを使う処理では極軽いものです。

```
TIME1=$(cat /proc/uptime | awk '{print $1}')
echo time1: $TIME1
# 計測したい処理ここから
#xcorr IMG-HH-ALOS2487932830-230606-UBSL1.1__D.PRM IMG-HH-ALOS2518982830-240102-UBSL1.1__D.PRM -xsearch 32 -ysearch 256 -nx 32 -ny 128
#diff: 1073.22
#xcorr2 IMG-HH-ALOS2487932830-230606-UBSL1.1__D.PRM IMG-HH-ALOS2518982830-240102-UBSL1.1__D.PRM -xsearch 32 -ysearch 256 -nx 32 -ny 128
#diff: 83.94
xcorr2_cl IMG-HH-ALOS2487932830-230606-UBSL1.1__D.PRM IMG-HH-ALOS2518982830-240102-UBSL1.1__D.PRM -xsearch 32 -ysearch 256 -nx 32 -ny 128
#diff: 65.59
# ここまで
TIME2=$(cat /proc/uptime | awk '{print $1}')
echo time2: $TIME2
DIFF=$(echo "$TIME2 - $TIME1" | bc)
echo diff: $DIFF
```

xcorr: 1073.22 秒、xcorr2：83.94秒、xcorr2_cl: 65.59秒

xcorr2_clは、xcorrの１６倍も高速。（１６日かかっていたのが１日で済む！！）

論文もありました。[Parallel Image Registration Implementations for GMTSAR Package](https://www.researchgate.net/publication/323324155_Parallel_Image_Registration_Implementations_for_GMTSAR_Package)

