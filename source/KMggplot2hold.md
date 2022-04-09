---
title: （99%自分用メモ）RcmdrPlugin.KMggplot2にggplotオブジェクト保持機能追加
date: 2022-04-09
tags: ["R","Rcmdr","RcmdrPlugin.KMggplot2","ggplot2"]
excerpt: 「コンパイル」できる人だけ
---

# （99%自分用メモ）RcmdrPlugin.KMggplot2にhhplotオブジェクト保持機能追加

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FKMggplot2hold&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

（注意）OSはLinux。`/home/(ユーザー名)/R/x86_64-pc-linux-gnu-library/(Rバージョン)`にインストール。  

(windowsならRtoolsが必要。)  

- Rcmdr : 2.7.2  
- RcmdrPlugin.KMggplot2 : 0.2.6  
- ggplot2 : 3.3.5  
- ggmosaic : 0.3.3  

[RcmdrPlugin.KMggplot2(Package source:https://cran.r-project.org/src/contrib/RcmdrPlugin.KMggplot2_0.2-6.tar.gz)](https://cran.r-project.org/src/contrib/RcmdrPlugin.KMggplot2_0.2-6.tar.gz)  

RcmdrPlugin.KMggplot2ではグラフが作成されると、`rm(.df, .plot)`と作成されたggplotオブジェクト(.plot)が削除されてしまいます。  

`print(.plot)`と`rm(.df, .plot)`の間に例えば、`g <- .plot`を実行するようにすれば、ggplotオブジェクトが保持できるようになります。

手っ取り早い方法は、plot****.rに４箇所書き加えて、plot-aaa.rに１箇所（４行）書き加える。

### plot****.r

例として、plot-gpie.rの場合。３箇所目の`tclvalue(lbbox1$fields[[3]]$value)`の`[[3]]`はplot****.rで異なります。


#### １，２箇所目 : lbbox

- ggplotオブジェクト名の箇所は空でもかまいません。以下ではpieとしています。  
- list記入の際「,」を入れる箇所注意

```R
      lbbox1 <<- textfields$new()
      lbbox1$front(
        top        = top,
# initValuesにggplotオブジェクト名の入力箇所追加（１）
        initValues = list("<auto>", "","pie"), 	
        titles     = list(
          gettextKmg2("Legend label"),
          gettextKmg2("Title"),
# ggplotオブジェクト保持 listに追加（２）
          gettextKmg2("ggplot object name")
        )
      )
```

#### ３箇所目 : getParms

```R
      main   <- tclvalue(lbbox1$fields[[2]]$value)
# パラメータhold（名前はなんでもいい）追加。mainが２番めでその次だから`[[3]]` （３）
      hold   <- tclvalue(lbbox1$fields[[3]]$value)
```

#### ４箇所目 : getParmsのlist

```R
# 「,」も忘れないように　（４）
hold = hold
```

### plot-aaa.r

`.plot`が作られるタイミングはOKがクリックされたときとプレビュはクリックされたときです。  
ここでは「OKがクリックされたとき」に保持することとします。

```R
      onOK <- function() {

########## 略 ##########
 
          if (parms$save == "1") .self$savePlot(.plot)
          
          pos <- 1
          assign(".lastcom", paste0(codes, "\n"), envir = as.environment(pos))
          
        }
########## この部分を追加 ################
      if (nchar(parms$hold)==0 || is.null(parms$hold)) {
      } else {
        commandDoIt(paste0(parms$hold,"<- .plot"))
      }
#############################################        
        removeRmlist()
        
        activateMenus()
        tkfocus(CommanderWindow())
        
      }
      
      setBack()
```

### 最後に

公開はしませんが、他にもRcmdrPlugin.KMggplot2にメニューを追加しました。
(グラフを並べる、保存する、対数軸の散布図、時系列グラフなど、標準作図関数(hist,barplot)を使ったりもした) 
ggmosaic , cowplot , ggrepel , ggpmisc ,xts , ggfortify などggplotを拡張したり、
使いやすくするパッケージも数多くあるのでそれらを使い、
なによりRcmdrPlugin.KMggplot2のメニュー作成がやりやすかったのでなんとか作ることができました。


