---
title: （99%自分用メモ）RcmdrPlugin.KMggplot2にクロステーブル作成メニュー追加
date: 2022-04-11
tags: ["R","Rcmdr","RcmdrPlugin.KMggplot2","descr","xtable","vcd"]
excerpt: 「コンパイル」できる人だけ
---

# （99%自分用メモ）RcmdrPlugin.KMggplot2にクロステーブル作成メニュー追加

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FKMggplot2crosstable&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

（注意）OSはLinux。`/home/(ユーザー名)/R/x86_64-pc-linux-gnu-library/(Rバージョン)`にインストール。  

(windowsならRtoolsが必要。)  

- Rcmdr : 2.7.2  
- RcmdrPlugin.KMggplot2 : 0.2.6  

[RcmdrPlugin.KMggplot2(Package source:https://cran.r-project.org/src/contrib/RcmdrPlugin.KMggplot2_0.2-6.tar.gz)](https://cran.r-project.org/src/contrib/RcmdrPlugin.KMggplot2_0.2-6.tar.gz)  

> ggplot2を使わないメニューの例です。descrパッケージのCrossTable関数でクロステーブルを作成するメニューです。

- digitsとformat以外のパラメータ選択にはcbboxを使いました。(rbboxの方がいいかも)
- パラメータの初期値はdescr::CrossTable関数のdefaultにあわせました。お好みの初期値にしてからコンパイルすると後の設定が楽。

なお、「３重クロス表」を作りたい場合（すでに１０年も前に関数を公開されている方がおられます。）は、  
[Rでちゃんとしたクロス集計表を出力する関数](https://m884.hateblo.jp/entry/2012/05/14/225259)    
この関数が入っているパッケージ（cranのArchiveにあります）[Rz package(archive)](https://cran.r-project.org/src/contrib/Archive/Rz/)    
を使ってメニューを作成したらいいかも。

### 以下は追加、変更する箇所

#### menus.txt  

(追加)  

item	kmg2Menu	command "* クロステーブル作成"	  windowMakecross 	"factorsP()"	""

#### DESCRIPTION

Depends: に   descr , xtable , vcd

Collate: に　'makecross.r'   を追加  

#### NAMESPACE

(追加)  

export(makecross)
export(windowMakecross)

### 追加する関数(.rファイル)

- 連続作成に便利（メニューが閉じない）なので「Preview」部分もコピペしています。
- vcdパッケージのmosaic関数を使ってモザイクプロットを作る部分もつけています。

#### makecross.r

```R
makecross <- setRefClass(

  Class = "makecross",
 
  fields = c("vbbox1" , "lbbox1", "rbbox1","cbbox1","cbbox2","cbbox3","cbbox4","cbbox5","cbbox6","cbbox7","cbbox8","cbbox9","cbbox10","cbbox11","cbbox12","cbbox13","cbbox14","cbbox15"),

  contains = c("plot_base"),

  methods = list(
    
##### Plot Windows
    plotWindow = function() {
      
      # note: The initializeDialog() generates "top"
      initializeDialog(window = topwindow, title = getWindowTitle())
      top            <<- topwindow
      alternateFrame <<- tkframe(top)
      
      setFront()
      
      parms <- getParms()

########## doItAndPrint mode ##########

      onOK <- function() {
        
        mode <<- 1
        parms <- getParms()
        
        closeDialog()
        
        errorCode <- checkError(parms)
        if (errorCode == TRUE) {
          removeRmlist()
          return()
        } else if (errorCode == FALSE) {
          
          setDataframe(parms)
          
          .plot <- getPlot(parms)
          commandDoIt("print(.plot)", log = TRUE)
          response <- tryCatch({
            print(.plot)
            ""
          }, error = function(ex) {
            tclvalue(RcmdrTkmessageBox(
              message = getMessage(),
              title   = gettextKmg2("Error"),
              icon    = "error",
              type    = "ok",
              default = "ok"
            ))
          }
          )
          if (response == "ok") {
            removeRmlist()
            return()
          }

        }
        
        removeRmlist()
        
        # tkinsert(LogWindow(), "end", codes)
        
        activateMenus()
        tkfocus(CommanderWindow())
        
      }
      
      setBack()
      
      # note: The OKCancelHelp() generates "buttonsFrame"
      OKCancelHelp(window = top, helpSubject = getHelp())

########## justDoIt mode ##########

      onPreview <- function() {

        mode <<- 0

        parms <- getParms()

        errorCode <- checkError(parms)
        if (errorCode == TRUE) {
          removeRmlist()
          return()
        } else if (errorCode == FALSE) {
          
          setDataframe(parms)
          
          .plot <- getPlot(parms)

          response <- tryCatch({
            print(.plot)

          }, error = function(ex) {
            tclvalue(RcmdrTkmessageBox(
              message = getMessage(),
              title   = gettextKmg2("Error"),
              icon    = "error",
              type    = "ok",
              default = "ok"
            ))
          }
          )
          if (response == "ok") {

            removeRmlist()
            return()
          }
        }
        removeRmlist()
      }
      previewButton <- buttonRcmdr(
        rightButtonsBox, text = gettextKmg2("Preview"), foreground = "yellow",
        width = nchar(gettextKmg2("Preview")), command = onPreview, 
        image = "::image::applyIcon", compound = "left"
      )
      tkgrid(previewButton, row = 0, column = 3, sticky = "nw")
      tkgrid.configure(previewButton, padx = c(5, 0))

##################################################################      
        
      tkgrid(buttonsFrame, sticky = "nw")
      dialogSuffix()
      
      return()
      
    },


    setFront = function() {

      vbbox1 <<- variableboxes$new()
      vbbox1$front(
        top       = top, 
        types     = list(Factors(),Factors()),
        titles    = list(
          gettextKmg2("variable (pick one)") ,
          gettextKmg2("variable (pick one)") 
        ),
        initialSelection = list( 0,0)

      )

      lbbox1 <<- textfields$new()
      lbbox1$front(
        top        = top,
        initValues = list("1", "3","1", "3","SPSS"),
        titles     = list(
          gettextKmg2("expected"),
          gettextKmg2("prop"),
          gettextKmg2("percent"),
          gettextKmg2("others"),
          gettextKmg2("format(SPSS or SAS)")
        ),
      )

      rbbox1 <<- radioboxes$new()
      rbbox1$front(
        top    = alternateFrame,,
        labels = list(
          gettextKmg2("Text"),
          gettextKmg2("Latex"),
          gettextKmg2("Html")
        ),
        title  = gettextKmg2("Output")
      )

      cbbox1 <<- checkboxes$new()
      cbbox1$front(
        top        = alternateFrame,
        initValues = list("0"),
        labels     = list(
          gettextKmg2("TRUE")
        ),
        title      = gettextKmg2("expected")
      )


      cbbox2 <<- checkboxes$new()
      cbbox2$front(
        top        = alternateFrame,
        initValues = list("1"),
        labels     = list(
          gettextKmg2("TRUE")
        ),
        title      = gettextKmg2("prop.r")
      )

      cbbox3 <<- checkboxes$new()
      cbbox3$front(
        top        = alternateFrame,
        initValues = list("1"),
        labels     = list(
          gettextKmg2("TRUE")
        ),
        title      = gettextKmg2("prop.c")
      )

      cbbox4 <<- checkboxes$new()
      cbbox4$front(
        top        = alternateFrame,
        initValues = list("1"),
        labels     = list(
          gettextKmg2("TRUE")
        ),
        title      = gettextKmg2("prop.t")
      )

      cbbox5 <<- checkboxes$new()
      cbbox5$front(
        top        = alternateFrame,
        initValues = list("1"),
        labels     = list(
          gettextKmg2("TRUE")
        ),
        title      = gettextKmg2("prop.chisq")
      )

      cbbox6 <<- checkboxes$new()
      cbbox6$front(
        top        = alternateFrame,
        initValues = list("0"),
        labels     = list(
          gettextKmg2("TRUE")
        ),
        title      = gettextKmg2("chisq")
      )

      cbbox7 <<- checkboxes$new()
      cbbox7$front(
        top        = alternateFrame,
        initValues = list("0"),
        labels     = list(
          gettextKmg2("TRUE")
        ),
        title      = gettextKmg2("fisher")
      )

      cbbox8 <<- checkboxes$new()
      cbbox8$front(
        top        = alternateFrame,
        initValues = list("0"),
        labels     = list(
          gettextKmg2("TRUE")
        ),
        title      = gettextKmg2("mcnemar")
      )

      cbbox9 <<- checkboxes$new()
      cbbox9$front(
        top        = alternateFrame,
        initValues = list("0"),
        labels     = list(
          gettextKmg2("TRUE")
        ),
        title      = gettextKmg2("resid")
      )

      cbbox10 <<- checkboxes$new()
      cbbox10$front(
        top        = alternateFrame,
        initValues = list("0"),
        labels     = list(
          gettextKmg2("TRUE")
        ),
        title      = gettextKmg2("sresid")
      )

      cbbox11 <<- checkboxes$new()
      cbbox11$front(
        top        = alternateFrame,
        initValues = list("0"),
        labels     = list(
          gettextKmg2("TRUE")
        ),
        title      = gettextKmg2("asresid")
      )

      cbbox12 <<- checkboxes$new()
      cbbox12$front(
        top        = alternateFrame,
        initValues = list("0"),
        labels     = list(
          gettextKmg2("TRUE")
        ),
        title      = gettextKmg2("missing.include")
      )

      cbbox13 <<- checkboxes$new()
      cbbox13$front(
        top        = alternateFrame,
        initValues = list("1"),
        labels     = list(
          gettextKmg2("TRUE")
        ),
        title      = gettextKmg2("drop.levels")
      )

      cbbox14 <<- checkboxes$new()
      cbbox14$front(
        top        = alternateFrame,
        initValues = list("1"),
        labels     = list(
          gettextKmg2("TRUE")
        ),
        title      = gettextKmg2("cell.layout")
      )

      cbbox15 <<- checkboxes$new()
      cbbox15$front(
        top        = alternateFrame,
        initValues = list("0"),
        labels     = list(
          gettextKmg2("YES")
        ),
        title      = gettextKmg2("vcd::mosaic")
      )
	},

    setBack = function() {

      vbbox1$back()

      tkgrid(
        rbbox1$frame,
        labelRcmdr(alternateFrame, text="    "),
        cbbox15$frame,
        stick="nw")
      tkgrid(alternateFrame, stick="nw")
      tkgrid(labelRcmdr(alternateFrame, text="    "), stick="nw")

      lbbox1$back()

      tkgrid(
        cbbox1$frame,
        labelRcmdr(alternateFrame, text="    "),
        cbbox2$frame,
        labelRcmdr(alternateFrame, text="    "),
        cbbox3$frame,
        labelRcmdr(alternateFrame, text="    "),
        cbbox4$frame,
        labelRcmdr(alternateFrame, text="    "),
        cbbox5$frame,
        labelRcmdr(alternateFrame, text="    "),
        cbbox6$frame,
        labelRcmdr(alternateFrame, text="    "),
        cbbox7$frame,
        stick="nw")
      tkgrid(alternateFrame, stick="nw")
      tkgrid(labelRcmdr(alternateFrame, text="    "), stick="nw")

      tkgrid(
        cbbox8$frame,
        labelRcmdr(alternateFrame, text="    "),
        cbbox9$frame,
        labelRcmdr(alternateFrame, text="    "),
        cbbox10$frame,
        labelRcmdr(alternateFrame, text="    "),
        cbbox11$frame,
        labelRcmdr(alternateFrame, text="    "),
        cbbox12$frame,
        labelRcmdr(alternateFrame, text="    "),
        cbbox13$frame,
        labelRcmdr(alternateFrame, text="    "),
        cbbox14$frame,
        stick="nw")
      tkgrid(alternateFrame, stick="nw")
      tkgrid(labelRcmdr(alternateFrame, text="    "), stick="nw")

    },

    getWindowTitle = function() {
      
      gettextKmg2("Cross Table")
      
    },
    
    getHelp = function() {
      
      ""
      
    },

    getParms = function() {
      
      x      <- getSelection(vbbox1$variable[[1]])
      y      <- getSelection(vbbox1$variable[[2]])
      z      <- character(0)
      
      s      <- character(0)
      t      <- character(0)
      
      xlab   <- character(0)
      xauto  <- character(0)
      ylab   <- character(0)
      yauto  <- character(0)
      zlab   <- character(0)
      main   <- character(0)
      
      size   <- character(0)
      family <- character(0)
      colour <- character(0)
      save   <- character(0)
      theme  <- character(0)
   
      d_expected   <- tclvalue(lbbox1$fields[[1]]$value)
      d_prop   <- tclvalue(lbbox1$fields[[2]]$value)
      d_percent   <- tclvalue(lbbox1$fields[[3]]$value)
      d_others   <- tclvalue(lbbox1$fields[[4]]$value)
      format <- tclvalue(lbbox1$fields[[5]]$value)
   
      Output <- tclvalue(rbbox1$value)

      expected <- tclvalue(cbbox1$value[[1]])
      prop.r <- tclvalue(cbbox2$value[[1]])
      prop.c <- tclvalue(cbbox3$value[[1]])
      prop.t <- tclvalue(cbbox4$value[[1]])

      prop.chisq <- tclvalue(cbbox5$value[[1]])
      chisq <- tclvalue(cbbox6$value[[1]])
      fisher <- tclvalue(cbbox7$value[[1]])
      mcnemar <- tclvalue(cbbox8$value[[1]])

      resid <- tclvalue(cbbox9$value[[1]])
      sresid <- tclvalue(cbbox10$value[[1]])
      asresid <- tclvalue(cbbox11$value[[1]])
      missing.include <- tclvalue(cbbox12$value[[1]])

      drop.levels <- tclvalue(cbbox13$value[[1]])
      cell.layout <- tclvalue(cbbox14$value[[1]])
      
      plot <- tclvalue(cbbox15$value[[1]])

      list(
        x = x, y = y, z = z, s = s, t = t,
        xlab = xlab, xauto = xauto, ylab = ylab, yauto = yauto, zlab = zlab, main = main,
        size = size, family = family, colour = colour, save = save, theme = theme,
        Output = Output , d_expected = d_expected , d_prop = d_prop , d_percent = d_percent ,
        d_others = d_others , format = format , expected = expected , prop.r = prop.r ,
        prop.c = prop.c ,prop.t = prop.t ,prop.chisq = prop.chisq , chisq = chisq ,
        fisher = fisher , mcnemar = mcnemar ,resid = resid ,sresid = sresid ,asresid = asresid ,
        missing.include = missing.include , drop.levels = drop.levels , cell.layout = cell.layout ,
	plot = plot
      )
      
    },
    
    checkError = function(parms) {
      
      if (length(parms$x) == 0) {
        errorCondition(
          recall  = windowScatter,
          message = gettextKmg2("Variables are not selected")
        )
        errorCode <- TRUE
      } else {
        setDataframe(parms)
        
        errorCode <- 2
      }
      errorCode
      
    },
    
    setDataframe = function(parms) {

     doItAndPrint("require(descr)")
     doItAndPrint("require(xtable)")

      doItAndPrint(paste0("digits<- list(expected =",parms$d_expected ,", prop = ",parms$d_prop ,", percent = ",parms$d_percent ,", others =",parms$d_others ,")") )
      
      if (parms$expected == "1") { doItAndPrint("expected <- TRUE") } else{ doItAndPrint("expected <- FALSE") }
      if (parms$prop.r == "1") { doItAndPrint("prop.r <- TRUE") } else{ doItAndPrint("prop.r <- FALSE") }
      if (parms$prop.c == "1") { doItAndPrint("prop.c <- TRUE") } else{ doItAndPrint("prop.c <- FALSE") }
      if (parms$prop.t == "1") { doItAndPrint("prop.t <- TRUE") } else{ doItAndPrint("prop.t <- FALSE") }
      if (parms$prop.chisq == "1") { doItAndPrint("prop.chisq <- TRUE") } else{ doItAndPrint("prop.chisq <- FALSE") }
      if (parms$chisq == "1") { doItAndPrint("chisq <- TRUE") } else{ doItAndPrint("chisq <- FALSE") }
      if (parms$fisher == "1") { doItAndPrint("fisher <- TRUE") } else{ doItAndPrint("fisher <- FALSE") }
      if (parms$mcnemar == "1") { doItAndPrint("mcnemar <- TRUE ")} else{ doItAndPrint("mcnemar <- FALSE") }
      if (parms$resid == "1") { doItAndPrint("resid <- TRUE") } else{ doItAndPrint("resid <- FALSE") }
      if (parms$sresid == "1") { doItAndPrint("sresid <- TRUE") } else{ doItAndPrint("sresid <- FALSE") }
      if (parms$asresid == "1") { doItAndPrint("asresid <- TRUE") } else{ doItAndPrint("asresid <- FALSE") }
      if (parms$missing.include == "1") { doItAndPrint("missing.include <- TRUE") } else{ doItAndPrint("missing.include <- FALSE") }
      if (parms$drop.levels == "1") { doItAndPrint("drop.levels <- TRUE") } else{ doItAndPrint("drop.levels <- FALSE") }
      if (parms$cell.layout == "1") { doItAndPrint("cell.layout <- TRUE") } else{ doItAndPrint("cell.layout <- FALSE") }

        command <- paste0(
		".crosstab <- with(", ActiveDataSet()," ,descr::CrossTable(",parms$x,",", parms$y,",
	        digits = digits ,  expected = expected ,prop.r = prop.r , prop.c = prop.c , prop.t = prop.t ,
           	prop.chisq = prop.chisq , chisq = chisq , fisher = fisher ,
           	mcnemar = mcnemar , resid = resid , sresid = sresid ,
           	asresid = asresid , missing.include =  missing.include ,
           	drop.levels = drop.levels, format = '",parms$format,"' ,
           	cell.layout = cell.layout)) \n"
			)

	doItAndPrint(command)
	doItAndPrint(".xtab<- xtable(.crosstab)")
	if (parms$Output == "1"){ doItAndPrint(" .crosstab") }
	if (parms$Output == "2"){ doItAndPrint(" print(.xtab)") }
	if (parms$Output == "3"){ doItAndPrint(" print(.xtab ,type = \"html\" )") }

        if (parms$plot == "1"){ doItAndPrint(paste0("vcd::mosaic(",parms$y,"~",parms$x,",data=",ActiveDataSet(),", highlighting_fill=scales::hue_pal()(length(with(",ActiveDataSet(),",levels(",parms$y,")))))")
) }
      
    }
    
  )
)


windowMakecross <- function() {
  Makecross <- RcmdrPlugin.KMggplot2::makecross$new()
  Makecross$plotWindow()
}
```
