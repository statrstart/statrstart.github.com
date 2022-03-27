---
title: （99%自分用メモ）RcmdrPlugin.KMggplot2にメニュー追加
date: 2022-03-28
tags: ["R","Rcmdr","RcmdrPlugin.KMggplot2","ggplot2","ggmosaic"]
excerpt: 「コンパイル」できる人だけ
---

#（99%自分用メモ）RcmdrPlugin.KMggplot2にメニュー追加

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FKMggplot2menu&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

（注意）OSはLinux。`/home/(ユーザー名)/R/x86_64-pc-linux-gnu-library/(Rバージョン)`にインストール。  

(windowsならRtoolsが必要。)  

- Rcmdr : 2.7.2  
- RcmdrPlugin.KMggplot2 : 0.2.6  
- ggplot2 : 3.3.5  
- ggmosaic : 0.3.3  

[RcmdrPlugin.KMggplot2(Package source:https://cran.r-project.org/src/contrib/RcmdrPlugin.KMggplot2_0.2-6.tar.gz)](https://cran.r-project.org/src/contrib/RcmdrPlugin.KMggplot2_0.2-6.tar.gz)  

### RcmdrPlugin.KMggplot2 : 0.2.6 の（多分）バグ

#### plot-aaa.r  

471:  (誤)  facet <- "facet_wrap( ~ s) + \n  "　  
      (正)  facet <- "facet_grid(s ~ .) + \n  "  

### 以下は追加、変更する箇所

#### menus.txt  

(追加)  

item	kmg2Menu	command "Bar chart"	windowBar	"nonFactorsP()"	""  
item	kmg2Menu	command "Mosaic Plot"	windowMosaic	"factorsP()"	""  

#### DESCRIPTION

Depends: に  ggmosaic (>= 0.3.3) を追加  

Collate: に　'plot-gbar.r'   'plot-gmosaic.r'　'ChangeColor.R' を追加  

#### NAMESPACE

(追加)  

export(gmosaic)  
export(windowMosaic)  
export(gbar)  
export(windowBar)  
export(changecolor)  
import(ggmosaic)  

### 追加する関数(.r ファイルは３つ)

#### ChangeColor.R

棒グラフやヒストグラムを単色で塗りつぶす色を変更したい場合。コマンドとして使う。メニューにはない。  

`changecolor()`とか`changecolor("brown3","royalblue3",1)`のように使う。  

（注意）colourとsizeは複数の色で塗る際にも影響あり。  


```R
changecolor <- function(fill= "gray55",colour="black",size=0.25) {
# default : fill="grey35" , colour="NA" ,size=0.5
	barcolor = paste0("update_geom_defaults('bar',list(fill = '",fill,"',colour='",colour,"',size=",size,"))")
	colcolor = paste0("update_geom_defaults('col',list(fill = '",fill,"',colour='",colour,"',size=",size,"))")
	eval(parse(text = barcolor))
	eval(parse(text = colcolor))
}
```

これを
![barchart001.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/barchart001.png)

こうしたり、ああしたり、
![barchart003.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/barchart003.png)

![barchart004.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/barchart004.png)


#### plot-gbar.r

`plot-gbox.r`を参考に作成。box一個なくして（その箇所削って）、if文削って、`geom_boxplot`を`geom_col`に変えた程度。

```R
gbar <- setRefClass(
  Class = "gbar",

  fields = c("vbbox1",  "vbbox2", "lbbox1", "rbbox1","cbbox1", "tbbox1"),
  contains = c("plot_base"),
  methods = list(

    setFront = function() {

      vbbox1 <<- variableboxes$new()
      vbbox1$front(
        top       = top, 
        types     = list(Factors(), nonFactors(), Factors()),
        titles    = list(
          gettextKmg2("X variable"),
          gettextKmg2("Y variable (pick one)"),
          gettextKmg2("Stratum variable")
        ),
        initialSelection = list(FALSE, 0, FALSE)
      )
  # 
      vbbox2 <<- variableboxes$new()
      vbbox2$front(
        top       = top, 
        types     = list(Factors(), Factors()),
        titles    = list(
          gettextKmg2("Facet variable in rows"),
          gettextKmg2("Facet variable in cols")
        )
      )

      lbbox1 <<- textfields$new()
      lbbox1$front(
        top        = top,
        initValues = list("<auto>", "<auto>", "<auto>", ""),
        titles     = list(
          gettextKmg2("Horizontal axis label"),
          gettextKmg2("Vertical axis label"),
          gettextKmg2("Legend label"),
          gettextKmg2("Title")
        )
      )

      rbbox1 <<- radioboxes$new()
      rbbox1$front(
        top    = alternateFrame,
        labels = list(
          gettextKmg2("Bar chart(stack,Sum)"),
          gettextKmg2("Bar chart(dodge)"),
          gettextKmg2("Bar chart(fill)")	,
          gettextKmg2("Bar chart(mean)") ,
          gettextKmg2("Bar chart(mean+95% C.I.)")
        ),
        title  = gettextKmg2("Plot type")
      )

      cbbox1 <<- checkboxes$new()
      cbbox1$front(
        top        = alternateFrame,
        initValues = list("0"),
        labels     = list(
          gettextKmg2("Flipped coordinates")
        ),
        title      = gettextKmg2("Options")
      )
      
      tbbox1 <<- toolbox$new()
      tbbox1$front(top)

    },

    setBack = function() {
      vbbox1$back()
      vbbox2$back()
      lbbox1$back()
      tkgrid(
        rbbox1$frame,
        labelRcmdr(alternateFrame, text="    "),
        cbbox1$frame,
        labelRcmdr(alternateFrame, text="    "),
        stick="nw")
      tkgrid(alternateFrame, stick="nw")
      tkgrid(labelRcmdr(alternateFrame, text="    "), stick="nw")
      tbbox1$back()
    },

    getWindowTitle = function() {
      gettextKmg2("Bar chart")
    },
    
    getHelp = function() {
      "geom_boxplot"
    },

    getParms = function() {
      x      <- getSelection(vbbox1$variable[[1]])
      y      <- getSelection(vbbox1$variable[[2]])
      z      <- getSelection(vbbox1$variable[[3]])

      s      <- getSelection(vbbox2$variable[[1]])
      t      <- getSelection(vbbox2$variable[[2]])

      x      <- checkVariable(x)
      y      <- checkVariable(y)
      z      <- checkVariable(z)
      s      <- checkVariable(s)
      t      <- checkVariable(t)

      xlab   <- tclvalue(lbbox1$fields[[1]]$value)
      xauto  <- x
      ylab   <- tclvalue(lbbox1$fields[[2]]$value)
      yauto  <- y
      zlab   <- tclvalue(lbbox1$fields[[3]]$value)
      zauto  <- z
      main   <- tclvalue(lbbox1$fields[[4]]$value)
      
      if (length(x) == 0 && length(z) != 0) {
        xlab <- zlab
        xauto <- zauto
      }
      
      size   <- tclvalue(tbbox1$size$value)
      family <- getSelection(tbbox1$family)
      colour <- getSelection(tbbox1$colour)
      save   <- tclvalue(tbbox1$goption$value[[1]])
      theme  <- checkTheme(getSelection(tbbox1$theme))
      
      options(
        kmg2FontSize   = tclvalue(tbbox1$size$value),
        kmg2FontFamily = seq_along(tbbox1$family$varlist)[tbbox1$family$varlist == getSelection(tbbox1$family)] - 1,
        kmg2ColourSet  = seq_along(tbbox1$colour$varlist)[tbbox1$colour$varlist == getSelection(tbbox1$colour)] - 1,
        kmg2SaveGraph  = tclvalue(tbbox1$goption$value[[1]]),
        kmg2Theme      = seq_along(tbbox1$theme$varlist)[tbbox1$theme$varlist == getSelection(tbbox1$theme)] - 1
      )

      plotType          <- tclvalue(rbbox1$value)
      flipedCoordinates <- tclvalue(cbbox1$value[[1]])

      list(
        x = x, y = y, z = z, s = s, t = t,
        xlab = xlab, xauto = xauto, ylab = ylab, yauto = yauto, zlab = zlab, main = main,
        size = size, family = family, colour = colour, save = save, theme = theme,
        plotType = plotType, flipedCoordinates = flipedCoordinates
      )

    },

    checkError = function(parms) {

      if (length(parms$y) == 0) {
        errorCondition(
          recall  = windowBar,
          message = gettextKmg2("Y variable is not selected")
        )
        errorCode <- TRUE
      } else {
        errorCode <- FALSE
      }
      errorCode

    },

    getGgplot = function(parms) {

        ztype <- "fill"

      if (length(parms$x) == 0 && length(parms$z) == 0) {
        ggplot <- "ggplot(data = .df, aes(x = factor(1), y = y)) + \n  "	# 1
      } else if (length(parms$x) == 0) {
        ggplot <- paste0("ggplot(data = .df, aes(x = z, y = y, ", ztype, " = z)) + \n  ")
      } else if (length(parms$z) == 0) {
        ggplot <- "ggplot(data = .df, aes(x = factor(x), y = y)) + \n  "
      } else {
          ggplot <- paste0("ggplot(data = .df, aes(x = factor(x), y = y, ", ztype, " = z)) + \n  ")
      }
      ggplot
    },


    getGeom = function(parms) {
      if (length(parms$x) != 0 && length(parms$z) != 0) {
        dodge1 <- "position = position_dodge(width = 0.9), "
        dodge2 <- "position = position_dodge(width = 0.9)"
      } else {
        dodge1 <- dodge2 <- ""
      }

       if (parms$plotType == "1") {
          geom <- paste0(
            "geom_col() + \n    ",
            "scale_y_continuous(expand = c(0.01,0),labels = scales::comma)  + \n "
          )
      } else if (parms$plotType == "2") {
          geom <- paste0(
            "geom_col(position='dodge') + \n    ",
            "scale_y_continuous(expand = c(0.01,0), limits = c(0,max(.df$y,na.rm=1)*1.02),labels = scales::comma)  + \n "
          )
      } else if (parms$plotType == "3") {
          geom <- paste0(
            "geom_col(position='fill') + \n    ",
            "scale_y_continuous(expand = c(0.01,0),labels = scales::percent)  + \n "
          )
      }else if (parms$plotType == "4") {
        geom <- paste(
	"stat_summary(fun = \"mean\", geom = \"bar\", ", dodge2, ") + \n  " ,
	 "scale_y_continuous(expand = c(0.01,0),labels = scales::comma) + \n "
        )
      }else if (parms$plotType == "5") {
        geom <- paste(
	"stat_summary(fun = \"mean\", geom = \"bar\", ", dodge2, ") + \n  ", 
	"stat_summary(fun.data = \"mean_cl_normal\", geom = \"errorbar\", ",
            dodge1, "width = 0.1, fun.args = list(conf.int = 0.95)) + \n  ",
	 "scale_y_continuous(expand = c(0.01,0),labels = scales::comma) + \n "
        )
      }
      geom
    },

     getScale = function(parms) {     
      if (length(parms$x) == 0 && length(parms$z) == 0) {
        scale <- "scale_x_discrete(breaks = NULL) + \n  "
      } else if (length(parms$z) != 0) {
 
          if (parms$colour == "Default") {
            scale <- ""
          } else if (parms$colour == "Hue") {
            scale <- paste0("scale_fill_hue() + \n  ")
          } else if (parms$colour == "Grey") {
            scale <- paste0("scale_fill_grey() + \n  ")
          } else {
            scale <- paste0("scale_fill_brewer(palette = \"", parms$colour, "\") + \n  ")
          }

      } else {
        scale <- ""
      }
      scale
    },

    getCoord = function(parms) {
      
      if (parms$flipedCoordinates == "1") {
        coord <- "coord_flip() + \n  "
      } else {
        coord <- ""
      }
      coord     
    },

    getZlab = function(parms) {    
      if (length(parms$z) == 0) {
        zlab <- ""
      } else if (parms$zlab == "<auto>") { 
         zlab <- paste0("labs(fill = \"", parms$z, "\") + \n  ")
       }     
            zlab  
    },

    getOpts = function(parms) {
      opts <- list()
      if (length(parms$s) != 0 || length(parms$t) != 0) {
        opts <- c(opts, "panel.spacing = unit(0.3, \"lines\")")
      }

      if (length(parms$x) == 0 && length(parms$z) == 0) {
        if (parms$flipedCoordinates == "0") {
          opts <- c(opts, "axis.title.x = element_blank()", "axis.text.x = element_blank()")
        } else {
          opts <- c(opts, "axis.title.y = element_blank()", "axis.text.y = element_blank()")
        }
      }

      if (length(opts) != 0) {
        opts <- do.call(paste, c(opts, list(sep = ", ")))
        opts <- paste0(" + \n  theme(", opts, ")")
      } else {
        opts <- ""
      }
      opts
    }

  )
)

windowBar <- function() {
  Bar <- RcmdrPlugin.KMggplot2::gbar$new()
  Bar$plotWindow()
}
```

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/barchart002.png)

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/barchart005.png)

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/barplot006.png)

#### plot-gmosaic.r

ggmosaicパッケージはもっと多機能だが、モザイクプロットの表示に絞った。  
関数に入れる変数の順序と表示位置（x,y軸方向）にくせがあるので関数に渡す際の順番を変えたりした。  
モザイクプロットは、vcd パッケージのmosaic関数が一押しだけど、表示はカラー色を使えるので抜群にきれい。  
(注意)mosaicという命令はvcdとggmosaicどちらにもあるので衝突をおこす。 
 

```R
gmosaic <- setRefClass(

  Class = "gmosaic",
 
  fields = c("vbbox1", "rbbox1","vbbox2",  "lbbox1","tbbox1"),

  contains = c("plot_base"),

  methods = list(

    setFront = function() {

      vbbox1 <<- variableboxes$new()
      vbbox1$front(
        top       = top, 
        types     = list(Factors(),Factors(),Factors()),
        titles    = list(
          gettextKmg2("variable (pick one)") ,
          gettextKmg2("variable (pick 0 or 1)") ,
          gettextKmg2("Stratum variable")
        ),
        initialSelection = list( 0,FALSE,FALSE)

      )

      lbbox1 <<- textfields$new()
      lbbox1$front(
        top        = top,
        initValues = list("<auto>", "<auto>","<auto>", ""),
        titles     = list(
          gettextKmg2("Horizontal axis label"),
          gettextKmg2("Vertical axis label"),
          gettextKmg2("Legend label"),
          gettextKmg2("Title")
        ),
      )

      vbbox2 <<- variableboxes$new()
      vbbox2$front(
        top       = top, 
        types     = list(Factors()),
        titles    = list(
          gettextKmg2("Facet variable in cols")
        )
      )

      rbbox1 <<- radioboxes$new()
      rbbox1$front(
        top    = alternateFrame,
        labels = list(
          gettextKmg2("angle=0"),
          gettextKmg2("angle=45"),
          gettextKmg2("angle=90")
        ),
        title  = gettextKmg2("axis.text.x")
      )

      tbbox1 <<- toolbox$new()
      tbbox1$front(top)
	},

    setBack = function() {

      vbbox1$back()
      vbbox2$back()
      lbbox1$back()

      tkgrid(
        rbbox1$frame,
        labelRcmdr(alternateFrame, text="    "),
        stick="nw")
      tkgrid(alternateFrame, stick="nw")
      tkgrid(labelRcmdr(alternateFrame, text="    "), stick="nw")

      tbbox1$back()

    },

    getWindowTitle = function() {
      
      gettextKmg2("Mosaicplot")
      
    },
    
    getHelp = function() {
      
      "geom_mosaic"
      
    },

    getParms = function() {

      x      <- getSelection(vbbox1$variable[[1]])
      y      <- getSelection(vbbox1$variable[[2]])
      z      <- getSelection(vbbox1$variable[[3]])
      
      x      <- checkVariable(x)
      s      <- NULL
      t      <- NULL
      tt      <- getSelection(vbbox2$variable[[1]])
      tt      <- checkVariable(tt)
      xlab   <- tclvalue(lbbox1$fields[[1]]$value)
      xauto  <- x
      ylab   <- tclvalue(lbbox1$fields[[2]]$value)
      yauto  <- y
      zlab   <- tclvalue(lbbox1$fields[[3]]$value)
      zauto  <- z
#######################################################################

if (length(y) != 0 && length(z) != 0) {
        xauto<- paste(z,":",x) 
        yauto<- y
      }
if (length(y) == 0 && length(z) != 0) {
        yauto<- z
	xauto<- x
      }

#######################################################################
      main   <- tclvalue(lbbox1$fields[[4]]$value)

      size   <- tclvalue(tbbox1$size$value)
      family <- getSelection(tbbox1$family)
      colour <- getSelection(tbbox1$colour)
      save   <- tclvalue(tbbox1$goption$value[[1]])
      theme  <- checkTheme(getSelection(tbbox1$theme))
      
      options(
        kmg2FontSize   = tclvalue(tbbox1$size$value),
        kmg2FontFamily = seq_along(tbbox1$family$varlist)[tbbox1$family$varlist == getSelection(tbbox1$family)] - 1,
        kmg2ColourSet  = seq_along(tbbox1$colour$varlist)[tbbox1$colour$varlist == getSelection(tbbox1$colour)] - 1,
        kmg2SaveGraph  = tclvalue(tbbox1$goption$value[[1]]),
        kmg2Theme      = seq_along(tbbox1$theme$varlist)[tbbox1$theme$varlist == getSelection(tbbox1$theme)] - 1
      )

      xangle <- tclvalue(rbbox1$value)

      list(
        x = x, y = y, z = z, s = s , t = t , tt = tt ,
        xlab = xlab, xauto = xauto, ylab = ylab, yauto = yauto, zlab = zlab,zauto=zauto, main = main,
        size = size, family = family, colour = colour, save = save, theme = theme,
        xangle = xangle
      )

    },

    checkError = function(parms) {

      if (length(parms$x) == 0) {
        errorCondition(
          recall  = windowMosaic,
          message = gettextKmg2("Variable is not selected")
        )
        errorCode <- TRUE
      } else {
        errorCode <- FALSE
      }
      errorCode

    },

    setDataframe = function(parms) {

      var <- list()
      if (length(parms$x) != 0) {
        var <- c(var, paste0(parms$x," = ", ActiveDataSet(), "$", parms$x))
      }
      if (length(parms$y) != 0) {
        var <- c(var, paste0(parms$y," = ", ActiveDataSet(), "$", parms$y))
      }
      if (length(parms$z) != 0) {
        var <- c(var, paste0(parms$z," = ", ActiveDataSet(), "$", parms$z))
      }

      if (length(parms$tt) != 0) {
        var <- c(var, paste0(parms$tt," = ", ActiveDataSet(), "$", parms$tt))
      }
#      if (length(parms$tt) != 0) {
#        var <- c(var, paste0("tt = ", ActiveDataSet(), "$", parms$tt))
#      }
      command <- do.call(paste, c(var, list(sep = ", ")))
      command <- paste0(".df <- na.omit(data.frame(", command, "))")
      commandDoIt("require(\"ggmosaic\")", log = TRUE)
     # doItAndPrint("require(\"ggmosaic\")")
      commandDoIt(command)
      registRmlist(.df)

    },

    getGgplot = function(parms) {

      ggplot<- "ggplot(data = .df) + \n  " 
      ggplot
    },

    getGeom = function(parms) {

      if (length(parms$y) == 0 && length(parms$z) == 0) {
        geom <- paste0("geom_mosaic(aes(x=product(",parms$x,")) ) + \n ") 	
      } else if (length(parms$z) == 0) {
        geom <- paste0("geom_mosaic(aes(x=product(",parms$y,",",parms$x,"))) + \n  ")
      } else if (length(parms$y) == 0) {
        geom <- paste0("geom_mosaic(aes(x=product(",parms$x,"),fill=",parms$z,")) + \n  ")
      } else {
          geom <- paste0("geom_mosaic(aes(x=product(",parms$y,",",parms$x,"),fill=",parms$z,")) + \n ")
      }
      if (length(parms$tt) != 0 ) {
	  geom <- paste0(geom , "facet_wrap( ~ ",parms$tt," , ncol = 2, scale = \"free\") + \n ") 
      }else{
	  geom<- geom
	}

      geom

    },

     getScale = function(parms) {     
      if (length(parms$x) == 0 && length(parms$z) == 0) {
        scale <- "scale_x_discrete(breaks = NULL) + \n  "
      } else if (length(parms$z) != 0) {
 
          if (parms$colour == "Default") {
            scale <- ""
          } else if (parms$colour == "Hue") {
            scale <- paste0("scale_fill_hue() + \n  ")
          } else if (parms$colour == "Grey") {
            scale <- paste0("scale_fill_grey() + \n  ")
          } else {
            scale <- paste0("scale_fill_brewer(palette = \"", parms$colour, "\") + \n  ")
          }

      } else {
        scale <- ""
      }
      scale
    },

    getOpts = function(parms) {
      opts <- list()
      if (parms$xangle == 1) {
        opts <- c("axis.text.x = element_text(angle = 0)")
      } else if (parms$xangle == "2") {
        opts <- c("axis.text.x = element_text(angle = 45, hjust =0.5, vjust = 1.1)")
      } else if (parms$xangle == "3") {
        opts <- c("axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)")
      } else {
        opts <- c("axis.text.x = element_text(angle = 0)")
      }
        opts <- c(opts, "axis.ticks=element_blank(),panel.border = element_blank(), axis.text=element_text(colour = \"black\"),panel.grid.major = element_blank(), panel.grid.minor = element_blank()")

      if (length(opts) != 0) {
        opts <- do.call(paste, c(opts, list(sep = ", ")))
        opts <- paste0(" + \n  theme(", opts, ")")
      } else {
        opts <- ""
      }
      opts
    }
  )
)

windowMosaic <- function() {
  Mosaic <- RcmdrPlugin.KMggplot2::gmosaic$new()
  Mosaic$plotWindow()

}
```

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/mosaic001.png)

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/mosaic002.png)

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/mosaic003.png)

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/mosaic004.png)

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/mosaic005.png)


#### （おまけ:もとからある関数に付け加え）plot-gbox.r

欠損値があるデータに対応するために、plot-gbox.r に cbbox2 を追加して、`scale_x_discrete(na.translate = FALSE)` を書き加えることができるようにした。

```R
gbox <- setRefClass(

  Class = "gbox",

#  fields = c("vbbox1", "vbbox2", "lbbox1", "rbbox1", "rbbox2", "cbbox1", "tbbox1"),
fields = c("vbbox1", "vbbox2", "lbbox1", "rbbox1", "rbbox2", "cbbox1", "cbbox2", "tbbox1"),

  contains = c("plot_base"),

  methods = list(

    setFront = function() {

      vbbox1 <<- variableboxes$new()
      vbbox1$front(
        top       = top, 
        types     = list(Variables(), nonFactors(), Factors()),
        titles    = list(
          gettextKmg2("X variable"),
          gettextKmg2("Y variable (pick one)"),
          gettextKmg2("Stratum variable")
        ),
        initialSelection = list(FALSE, 0, FALSE)
      )

      vbbox2 <<- variableboxes$new()
      vbbox2$front(
        top       = top, 
        types     = list(Factors(), Factors()),
        titles    = list(
          gettextKmg2("Facet variable in rows"),
          gettextKmg2("Facet variable in cols")
        )
      )

      lbbox1 <<- textfields$new()
      lbbox1$front(
        top        = top,
        initValues = list("<auto>", "<auto>", "<auto>", ""),
        titles     = list(
          gettextKmg2("Horizontal axis label"),
          gettextKmg2("Vertical axis label"),
          gettextKmg2("Legend label"),
          gettextKmg2("Title")
        )
      )

      rbbox1 <<- radioboxes$new()
      rbbox1$front(
        top    = alternateFrame,
        labels = list(
          gettextKmg2("Box plot"),
          gettextKmg2("Notched box plot"),
          gettextKmg2("Violin plot"),
          gettextKmg2("95% C.I. (t distribution)"),
          gettextKmg2("95% C.I. (bootstrap)")
        ),
        title  = gettextKmg2("Plot type")
      )

      cbbox1 <<- checkboxes$new()
      cbbox1$front(
        top        = alternateFrame,
        initValues = list("0"),
        labels     = list(
          gettextKmg2("Flipped coordinates")
        ),
        title      = gettextKmg2("Options")
      )

##############################################################

      cbbox2 <<- checkboxes$new()
      cbbox2$front(
        top        = alternateFrame,
        initValues = list("0"),
        labels     = list(
          gettextKmg2("FALSE")
        ),
        title      = gettextKmg2("na.translate")
      )

##############################################################
      
      rbbox2 <<- radioboxes$new()
      rbbox2$front(
        top    = alternateFrame,
        labels = list(
          gettextKmg2("None"),
          gettextKmg2("Jitter"),
          gettextKmg2("Beeswarm")
        ),
        title  = gettextKmg2("Add data point")
      )
      
      tbbox1 <<- toolbox$new()
      tbbox1$front(top)

    },

    setBack = function() {

      vbbox1$back()
      vbbox2$back()
      lbbox1$back()

      tkgrid(
        rbbox1$frame,
        labelRcmdr(alternateFrame, text="    "),
        cbbox1$frame,
#
        cbbox2$frame,
#
        labelRcmdr(alternateFrame, text="    "),
        rbbox2$frame,
        stick="nw")
      tkgrid(alternateFrame, stick="nw")
      tkgrid(labelRcmdr(alternateFrame, text="    "), stick="nw")

      tbbox1$back()

    },

    getWindowTitle = function() {
      
      gettextKmg2("Box plot / Violin plot / Confidence interval")
      
    },
    
    getHelp = function() {
      
      "geom_boxplot"
      
    },

    getParms = function() {

      x      <- getSelection(vbbox1$variable[[1]])
      y      <- getSelection(vbbox1$variable[[2]])
      z      <- getSelection(vbbox1$variable[[3]])

      s      <- getSelection(vbbox2$variable[[1]])
      t      <- getSelection(vbbox2$variable[[2]])

      x      <- checkVariable(x)
      y      <- checkVariable(y)
      z      <- checkVariable(z)
      s      <- checkVariable(s)
      t      <- checkVariable(t)

      xlab   <- tclvalue(lbbox1$fields[[1]]$value)
      xauto  <- x
      ylab   <- tclvalue(lbbox1$fields[[2]]$value)
      yauto  <- y
      zlab   <- tclvalue(lbbox1$fields[[3]]$value)
      zauto  <- z
      main   <- tclvalue(lbbox1$fields[[4]]$value)
      
      if (length(x) == 0 && length(z) != 0) {
        xlab <- zlab
        xauto <- zauto
      }
      
      size   <- tclvalue(tbbox1$size$value)
      family <- getSelection(tbbox1$family)
      colour <- getSelection(tbbox1$colour)
      save   <- tclvalue(tbbox1$goption$value[[1]])
      theme  <- checkTheme(getSelection(tbbox1$theme))
      
      options(
        kmg2FontSize   = tclvalue(tbbox1$size$value),
        kmg2FontFamily = seq_along(tbbox1$family$varlist)[tbbox1$family$varlist == getSelection(tbbox1$family)] - 1,
        kmg2ColourSet  = seq_along(tbbox1$colour$varlist)[tbbox1$colour$varlist == getSelection(tbbox1$colour)] - 1,
        kmg2SaveGraph  = tclvalue(tbbox1$goption$value[[1]]),
        kmg2Theme      = seq_along(tbbox1$theme$varlist)[tbbox1$theme$varlist == getSelection(tbbox1$theme)] - 1
      )

      plotType          <- tclvalue(rbbox1$value)
      flipedCoordinates <- tclvalue(cbbox1$value[[1]])
#
    naomit <- tclvalue(cbbox2$value[[1]])
#
      dataPoint         <- tclvalue(rbbox2$value)

      list(
        x = x, y = y, z = z, s = s, t = t,
        xlab = xlab, xauto = xauto, ylab = ylab, yauto = yauto, zlab = zlab, main = main,
        size = size, family = family, colour = colour, save = save, theme = theme,
        plotType = plotType, flipedCoordinates = flipedCoordinates,naomit=naomit ,dataPoint = dataPoint
      )

    },

    checkError = function(parms) {

      if (length(parms$y) == 0) {
        errorCondition(
          recall  = windowBox,
          message = gettextKmg2("Y variable is not selected")
        )
        errorCode <- TRUE
      } else {
        errorCode <- FALSE
      }
      errorCode

    },

    getGgplot = function(parms) {
      
      if (parms$plotType == "1" || parms$plotType == "2" || parms$plotType == "3") {
        ztype <- "fill"
      } else {
        ztype <- "colour"
      }

      if (length(parms$x) == 0 && length(parms$z) == 0) {
        ggplot <- "ggplot(data = .df, aes(x = factor(1), y = y)) + \n  "
      } else if (length(parms$x) == 0) {
        ggplot <- paste0("ggplot(data = .df, aes(x = z, y = y, ", ztype, " = z)) + \n  ")
      } else if (length(parms$z) == 0) {
        ggplot <- "ggplot(data = .df, aes(x = factor(x), y = y)) + \n  "
      } else {
        if (parms$plotType == "1" || parms$plotType == "2" || parms$plotType == "3") {
          ggplot <- paste0("ggplot(data = .df, aes(x = factor(x), y = y, ", ztype, " = z)) + \n  ")
        } else if (parms$dataPoint != "1") {
          ggplot <- paste0("ggplot(data = .df, aes(x = factor(x), y = y, ", ztype, " = z, fill = z)) + \n  ")
        } else {
          ggplot <- paste0("ggplot(data = .df, aes(x = factor(x), y = y, ", ztype, " = z)) + \n  ")
        }
      }
      ggplot

    },

    getGeom = function(parms) {
      
      if (length(parms$x) != 0 && length(parms$z) != 0) {
        dodge1 <- "position = position_dodge(width = 0.9), "
        dodge2 <- "position = position_dodge(width = 0.9)"
      } else {
        dodge1 <- dodge2 <- ""
      }

      if (parms$plotType == "1") {
        if (parms$dataPoint == "1") {
          geom <- paste0(
            "stat_boxplot(geom = \"errorbar\", ", dodge1, "width = 0.5) + \n  ",
            "geom_boxplot(", dodge2, ") + \n  "
          )
        } else {
          geom <- paste0(
            "stat_boxplot(geom = \"errorbar\", ", dodge1, "width = 0.5) + \n  ",
            "geom_boxplot(", dodge1, "outlier.colour = \"transparent\") + \n  "
          )
        }
      } else if (parms$plotType == "2") {
        if (parms$dataPoint == "1") {
          geom <- paste0(
            "stat_boxplot(geom = \"errorbar\", ", dodge1, "width = 0.5) + \n  ",
            "geom_boxplot(", dodge1, "notch = TRUE) + \n  "
          )
        } else {
          geom <- paste0(
            "stat_boxplot(geom = \"errorbar\", ", dodge1, "width = 0.5) + \n  ",
            "geom_boxplot(", dodge1, "outlier.colour = \"transparent\", notch = TRUE) + \n  "
          )
        }
      } else if (parms$plotType == "3") {
        geom <- paste0(
          "geom_violin(", dodge2, ") + \n  ",
          "stat_summary(fun = \"median\", geom = \"point\", ", dodge1, "pch = 10, size = 4) + \n  "
        )
      } else if (parms$plotType == "4") {
        geom <- paste0(
          "stat_summary(fun = \"mean\", geom = \"point\", ", dodge2, ") + \n  ",  
          "stat_summary(fun.data = \"mean_cl_normal\", geom = \"errorbar\", ",
            dodge1, "width = 0.1, fun.args = list(conf.int = 0.95)) + \n  "
        )
      } else if (parms$plotType == "5") {
        geom <- paste(
          "stat_summary(fun = \"mean\", geom = \"point\", ", dodge2, ") + \n  ",  
          "stat_summary(fun.data = \"mean_cl_boot\", geom = \"errorbar\", ",
            dodge1, "width = 0.1, fun.args = list(conf.int = 0.95)) + \n  "
        )
      }

      if (parms$dataPoint == "1") {
      } else if (parms$dataPoint == "2") {
        if (length(parms$x) != 0 && length(parms$z) != 0) {
          geom <- paste0(
            geom,
            "geom_jitter(colour = \"black\", position = position_jitterdodge(jitter.width = 0.25, jitter.height = 0, dodge.width = 0.9)) + \n  "
          )
        } else {
          geom <- paste0(
            geom,
            "geom_jitter(colour = \"black\", width = 0.1, height = 0) + \n  "
          )
        }
      } else if (parms$dataPoint == "3") {
        geom <- paste0(
          geom,
          "geom_dotplot(binaxis = \"y\", stackdir = \"center\", position = position_dodge(width = 0.9)) + \n  "
        )
      }

      if (parms$naomit == "1") {
        geom <- paste0(
	geom ,
        "scale_x_discrete(na.translate = FALSE) + \n  "
	)
      } else {
      }
	geom
    },


    getScale = function(parms) {
      
      if (length(parms$x) == 0 && length(parms$z) == 0) {
        scale <- "scale_x_discrete(breaks = NULL) + \n  "
      } else if (length(parms$z) != 0) {
        if (parms$plotType == "1" || parms$plotType == "2" || parms$plotType == "3") {
          if (parms$colour == "Default") {
            scale <- ""
          } else if (parms$colour == "Hue") {
            scale <- paste0("scale_fill_hue() + \n  ")
          } else if (parms$colour == "Grey") {
            scale <- paste0("scale_fill_grey() + \n  ")
          } else {
            scale <- paste0("scale_fill_brewer(palette = \"", parms$colour, "\") + \n  ")
          }
        } else {
          if (parms$colour == "Default") {
            scale <- ""
          } else if (parms$colour == "Hue") {
            scale <- paste0("scale_colour_hue() + \n  ")
          } else if (parms$colour == "Grey") {
            scale <- paste0("scale_colour_grey() + \n  ")
          } else {
            scale <- paste0("scale_colour_brewer(palette = \"", parms$colour, "\") + \n  ")
          }
        }
      } else {
        scale <- ""
      }
      scale

    },

    getCoord = function(parms) {
      
      if (parms$flipedCoordinates == "1") {
        coord <- "coord_flip() + \n  "
      } else {
        coord <- ""
      }
      coord
      
    },
    
    getZlab = function(parms) {
      
      if (length(parms$z) == 0) {
        zlab <- ""
      } else if (parms$zlab == "<auto>") {
        if (parms$plotType == "1" || parms$plotType == "2" || parms$plotType == "3") {
          zlab <- paste0("labs(fill = \"", parms$z, "\") + \n  ")
        } else if (parms$dataPoint != "1") {
          zlab <- paste0("labs(fill = \"", parms$z, "\", colour = \"", parms$z, "\") + \n  ")
        } else {
          zlab <- paste0("labs(colour = \"", parms$z, "\") + \n  ")
        }
      } else {
        if (parms$plotType == "1" || parms$plotType == "2" || parms$plotType == "3") {
          zlab <- paste0("labs(fill = \"", parms$zlab, "\") + \n  ")
        } else if (parms$dataPoint != "1") {
          zlab <- paste0("labs(fill = \"", parms$zlab, "\", colour = \"", parms$zlab, "\") + \n  ")
        } else {
          zlab <- paste0("labs(colour = \"", parms$zlab, "\") + \n  ")
        }
      }
      zlab
      
    },

    getOpts = function(parms) {

      opts <- list()
      if (length(parms$s) != 0 || length(parms$t) != 0) {
        opts <- c(opts, "panel.spacing = unit(0.3, \"lines\")")
      }

      if (length(parms$x) == 0 && length(parms$z) == 0) {
        if (parms$flipedCoordinates == "0") {
          opts <- c(opts, "axis.title.x = element_blank()", "axis.text.x = element_blank()")
        } else {
          opts <- c(opts, "axis.title.y = element_blank()", "axis.text.y = element_blank()")
        }
      }

      if (length(opts) != 0) {
        opts <- do.call(paste, c(opts, list(sep = ", ")))
        opts <- paste0(" + \n  theme(", opts, ")")
      } else {
        opts <- ""
      }
      opts

    }

  )
)

windowBox <- function() {

  Box <- RcmdrPlugin.KMggplot2::gbox$new()
  Box$plotWindow()

}
```

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/boxplotNA001.png)

![](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/boxplotNA002.png)

