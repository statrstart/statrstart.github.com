---
title: Quartoで日本語PDFファイルを作成する（その３）
date: 2023-12-16
tags: ["quarto", "xelatex","bxjsarticle","xelatexja"]
excerpt: Quarto、xelatex、bxjsarticle、xelatexjaでmojiparline
---

# Quarto、xelatex、bxjsarticle、xelatexjaでmojiparline

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2Fquarto03&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

- Quarto 1.3.450

- pdf-engine: xelatex

- documentclass: bxjsarticle

- xelatexjaは、[XeLaTeX で和文する実験 ](https://github.com/h20y6m/xelatexja)で入手

(参考) 

[TeX設定（LualaTeXへの引っ越し編）](http://www.sip-ac.jp/sip/tex04.html)

[文字数と行数指定で余白も指定したい](https://okumuralab.org/tex/mod/forum/discuss.php?d=1206)

[BXjscls パッケージ（BXJS 文書クラス集）ソースコード説明書v2.9](http://mirrors.ctan.org/language/japanese/BX/bxjscls/bxjscls.pdf)

p.57

本文 10 ポイントのときの行送りは，（中略）ここでは 16 ポイントにしました。

公称 10 ポイントの和文フォントが約 9.25 ポイント（中略）16/9.25 ≈ 1.73 であり，和文の推奨値の一つ「二分四分」（1.75）に近づきました。

p.171 和文・和欧文間空白の初期値

```
4952 \setkanjiskip{0pt plus.1\jsZw minus.01\jsZw}
4953 \ifx\jsDocClass\jsSlide \setxkanjiskip{0.1em}
4954 \else \setxkanjiskip{0.25em plus 0.15em minus 0.06em}
4955 \fi
```

## `xelatex`、`bxjsarticle`用の`mojiparline`マクロ

### その１

```
\makeatletter
\def\mojiparline#1{
    \newcounter{mpl}
    \setcounter{mpl}{#1}
    \@tempdima=\textwidth
    \advance\@tempdima by-\value{mpl}\zw     % \zwに変更
    \addtocounter{mpl}{-1}
    \divide\@tempdima by \value{mpl}
    \@tempskipa=\getkanjiskip  % レジスタにkanjiskipを代入(\getkanjiskip)
    \advance\@tempskipa by \@tempdima        % レジスタに調整分を加算
    \setkanjiskip{\@tempskipa}  % レジスタをkanjiskipにセット(\setkanjiskip)
    \@tempskipa=\getxkanjiskip  % レジスタにxkanjiskipを代入(\getxkanjiskip)
    \advance\@tempskipa by \@tempdima        % レジスタに調整分を加算
    \setxkanjiskip{\@tempskipa}  % レジスタをxkanjiskipにセット(\setxkanjiskip)
    \advance\parindent by \@tempdima % インデントに調整分を加算
}
\makeatother
\def\linesparpage#1{
    \baselineskip=\textheight
    \divide\baselineskip by #1
}

%document環境の中で
% 一行あたり文字数の指定
%\mojiparline{35}
% 1ページあたり行数の指定
%\linesparpage{35}
```

### マクロ２: Quartoはcalcパッケージが読み込まれる。ちょっとだけこっちに方がコードが短い。

```
usepackage{calc}
%
\makeatletter
\def\mojiparline#1{
    \newcounter{mpl}
    \setcounter{mpl}{#1}
    \@tempdima=\textwidth
    \advance\@tempdima by -\value{mpl}\zw
    \setcounter{mpl}{#1-1}
    \divide\@tempdima by \value{mpl}
    \@tempskipa=\getkanjiskip
    \setkanjiskip{\@tempdima + \@tempskipa} 
    \@tempskipa=\getxkanjiskip
    \setxkanjiskip{\@tempdima + \@tempskipa } 
    \advance\parindent by \@tempdima 
}
\makeatother
\def\linesparpage#1{
    \setlength{\baselineskip}{\textheight / #1 }
}
%
%document環境の中で
% 一行あたり文字数の指定
%\mojiparline{35}
% 1ページあたり行数の指定
%\linesparpage{35}
```

### baselinestretch,kanjiskip,xkanjiskip,parindentをRで計算する

コンパイルするたびにマクロを動かすのもなんなので、Rを使って計算します。

エクセルなどの表計算ソフトでやったらもっと簡単ですが、出力したのをコピペできるようにしました。

必要な数値は「BXjscls パッケージソースコード説明書」に書いてありました。

```R
# pt: 文字サイズ(pt)  moji: １行あたり文字数　line: １ページの行数
# top,bottom,right,left: 各マージン(truemm)
# pw: 用紙幅(mm)  ph: 用紙高さ(mm)  
# usr: 和文フォントの実際の幅で0.925倍で希望の文字数にならない場合の微調整のため
#
kanjiline <- function(pt=12,moji=35,line=35,top=25,bottom=30,right=25,left=25,pw=210,ph=297,usr=0.92) {
	pt2mm=0.35 # 1pt=0.351459803514598≒0.35mm
	tw=pw-(right+left)
	th=ph-(top+bottom)
	# kanjiskip
	w925=pt*pt2mm*0.925
	w_usr=pt*pt2mm*usr
	skip925=round((tw-w925*moji)/(moji-1),3)
	skip_usr=round((tw-w_usr*moji)/(moji-1),3)
	skipJ=round((tw-pt*pt2mm*moji)/(moji-1),3)
	# linestretch
	baselineskip= round(th/line,3)
	hl1_6=round((th/line)/(pt*pt2mm*1.6),3)
	hl1_73=round((th/line)/(pt*pt2mm*1.73),3)
	#df=data.frame(fontsize=pt,base_linestretch=hl1_6,baseks925=skip925,baseks_usr=skip_usr,jbase_linestretch=hl1_73,jbaseks=skipJ)
	#return(df)
base925=paste0("\nbase=",pt,"ptのとき（和字0.925倍と想定）\n-----------------------------------
Quarto: linestretch: ",hl1_6,
"\n\\renewcommand{\\baselinestretch}{",hl1_6,"}
\\setkanjiskip{",skip925,"truemm plus.1\\jsZw minus.01\\jsZw}
\\setxkanjiskip{",skip925,"truemm + 0.25em plus 0.15em minus 0.06em}
\\setlength{\\parindent}{1\\jsZw+",skip925,"truemm} \n")
base_usr=paste0("\nbase=",pt,"ptのとき（和字",usr,"倍と想定）\n-----------------------------------
Quarto: linestretch: ",hl1_6,
"\n\\renewcommand{\\baselinestretch}{",hl1_6,"}
\\setkanjiskip{",skip_usr,"truemm plus.1\\jsZw minus.01\\jsZw}
\\setxkanjiskip{",skip_usr,"truemm + 0.25em plus 0.15em minus 0.06em}
\\setlength{\\parindent}{1\\jsZw+",skip_usr,"truemm} \n")
jbase=paste0("\njbase=",pt,"ptのとき \n--------------------
Quarto: linestretch: ",hl1_73,
"\n\\renewcommand{\\baselinestretch}{",hl1_73,"}
\\setkanjiskip{",skipJ,"truemm plus.1\\jsZw minus.01\\jsZw}
\\setxkanjiskip{",skipJ,"truemm + 0.25em plus 0.15em minus 0.06em}
\\setlength{\\parindent}{1\\jsZw+",skipJ,"truemm}\n")
baselineskip=paste0("\n\nlinestretch ではなく baselineskip で指定する場合  ",baselineskip,"mm （共通）\n\n") 
title="\n\npdf-engine に xelatex、documentclass\nbxjsarticle(whole-zw-lines=false,nomag*)とした場合
---------------------------------------------------------\n"
return(c(title,base925,base_usr,jbase,baselineskip))
}
# 計算し、出力
cat(kanjiline(pt=12,moji=35,line=35,top=25,bottom=30,right=25,left=25,pw=210,ph=297,usr=0.92))
```

[文字数と行数指定で余白も指定したい](https://okumuralab.org/tex/mod/forum/discuss.php?d=1206)の数値をdefaultにしました。

ただし、platex+jsクラスとxelatex+bsjsクラスの違いはあります。

#### 結果

```
pdf-engine に xelatex、documentclass
bxjsarticle(whole-zw-lines=false,nomag*)とした場合
---------------------------------------------------------
 
base=12ptのとき（和字0.925倍と想定）
-----------------------------------
Quarto: linestretch: 1.029
\renewcommand{\baselinestretch}{1.029}
\setkanjiskip{0.707truemm plus.1\jsZw minus.01\jsZw}
\setxkanjiskip{0.707truemm + 0.25em plus 0.15em minus 0.06em}
\setlength{\parindent}{1\jsZw+0.707truemm} 
 
base=12ptのとき（和字0.92倍と想定）
-----------------------------------
Quarto: linestretch: 1.029
\renewcommand{\baselinestretch}{1.029}
\setkanjiskip{0.728truemm plus.1\jsZw minus.01\jsZw}
\setxkanjiskip{0.728truemm + 0.25em plus 0.15em minus 0.06em}
\setlength{\parindent}{1\jsZw+0.728truemm} 
 
jbase=12ptのとき 
--------------------
Quarto: linestretch: 0.952
\renewcommand{\baselinestretch}{0.952}
\setkanjiskip{0.382truemm plus.1\jsZw minus.01\jsZw}
\setxkanjiskip{0.382truemm + 0.25em plus 0.15em minus 0.06em}
\setlength{\parindent}{1\jsZw+0.382truemm}
 

linestretch ではなく baselineskip で指定する場合  6.914mm （共通）
```

base=12ptのとき（和字0.925倍と想定）の箇所の数値を適切な位置に貼り付けます。

### Quartoの場合

行数変更

yamlに`linestretch: 1.029`もしくは、include-in-headerに`\renewcommand{\baselinestretch}{1.029}`

位置行あたり文字数変更

include-in-headerに

```
\setkanjiskip{0.707truemm plus.1\jsZw minus.01\jsZw}
\setxkanjiskip{0.707truemm + 0.25em plus 0.15em minus 0.06em}
```

本文に`\setlength{\parindent}{1\jsZw+0.707truemm}`

### Quarto、xelatex、bxjsarticle、xelatexja で雪だるま

`xelatexja` を使う場合は、`jafont`オプションは使わずに`\usepackage[haranoaji]{zxjafont}`とする。

#### yukidaruma.qmd

```
---
execute:
  echo: false
  eval: true
  message: false
  warning: false
  include: true
format:
  pdf:
    latex-tinytex: true
    pdf-engine: xelatex
    documentclass: bxjsarticle
    classoption: [a4,xelatex,ja=xelatexja,base=12pt,everyparhook=compat,whole-zw-lines=false,nomag*]
    keep-tex: false
    colorlinks: true
    number-sections: true
    #linestretch: 1.029
    indent: true
    lang: ja
    include-in-header:
      - text: |
           \setpagelayout*{truedimen,top=25truemm,bottom=30truemm,foot=15truemm,left=25truemm,right=25truemm}
           \usepackage{ascmac}
           %\usepackage{wrapfig}
           \usepackage{url}
           \usepackage[left]{lineno}
           \pagewiselinenumbers 
           \usepackage[haranoaji]{zxjafont}
           \setkanjiskip{0.707truemm plus 0.1\jsZw minus 0.01\jsZw}
           \setxkanjiskip{0.707truemm+0.25em plus 0.15em minus 0.06em}
           \renewcommand{\baselinestretch}{1.029}
---
\setlength{\parindent}{1\jsZw+0.707truemm}

\begin{center}\huge  雪だるま\end{center}
\begin{center}\large 小川未明\end{center}

いいお天気でありました。もはや、野にも山にも、雪が一面に真っ白くつもってかがやいています。ちょうど、その日は学校が休みでありましたから、次郎は、家の外に出て、となりの勇吉といっしょになって、遊んでいました。

「大きな、雪だるまを一つつくろうね。」

二人は、こういって、いっしょうけんめいに雪を一処《ひとところ》にあつめて、雪だるまをつくりはじめました。

そこは、人通りのない、家の前の圃の中でありました。梅の木も、かきの木も、すでに二、三尺も根もとのほうは雪にうずもれていました。そして、わらぐつをはきさえすれば、子供たちは圃の上を自由に、どこへでもゆくことができたのであります。

頭の上の空は、青々として、ちょうどガラスをふいたようにさえていました。あちらこちらには、たこがあがって、籐の鳴り音が聞こえていました。けれど、二人は、そんなことにわき見もせずに、せっせと雪を運んでは、だるまをつくっていました。昼前かかって、やっと半分ばかりしかできませんでした。

「昼飯を食べてから、またあとを造ろうね。」

二人は、こういって、昼飯を食べに、おのおのの家へ帰りました。そして、やがてまた二人は、そこにやってきて、せっせと、雪だるまを造っていました。

ほんとうに、その日は、いい天気でありましたから、小鳥も木の枝にきて鳴いていました。しかし、冬の日は短くて、じきに日は暮れかかりました。西の方の空は、赤くそまって、一面に雪の上はかげってしまいました。その時分にやっと、二人の雪だるまは、みごとにできあがったのであります。

「やあ、大きいだるまだなあ。」といって、二人は、自分たちのつくった、雪だるまを目をかがやかして賞歎《しょうたん》しました。次郎は、墨でだるまの目と鼻と口とをえがきました。だるまは、往来の方を向いてすわっていました。二人は、明日から、この路を通る人たちがこれを見て、どんなにかびっくりするだろうと思って喜びました。

「きっと、みんながびっくりするよ。」と、勇吉はいって、こおどりしました。そして、懐の中から自分のハーモニカを取り出して、だるまの口に押しつけました。ちょうど、だるまが夕陽の中に赤くいろどられて、ハーモニカを吹いているように見えたのであります。

空の色は、だんだん冷たく、暗くなりました。そして、雪の上をわたって吹いてくる風が、身にしみて寒さを感じさせました。

「もう、家へ帰ろう。そして、また、明日ここへきて遊ぼうよ。」こういって、その日の名残をおしみながら、別れて、二人は自分の家へ入ってゆきました。あとには、ただひとり大きな雪だるまが、円い目をみはって、あちらをながめていました。

次郎は、夕飯を食べるとじきに床の中に入りました。そして、いつのまにかぐっすりと眠ってしまいました。ちょうど、夜中時分《よなかじぶん》でありました。そばにねていられたおばあさんが、いつものように、

「次郎や、小便《しょうべん》にゆかないか。」といって、ゆり起こされましたので、次郎は、すぐに起きて目をこすりながら、はばかりにゆきました。そして、またもどってきて、暖かな床の中に入りました。家の外には、風が吹いています。寒い晩でありました。晴れていて、雲がないとみえて、月の光が、窓のすきまから、障子の上に明るくさしているのが見られました。

次郎は、どんなに、だれも人のいない家の外は寒かろうと思いました。それで、すぐにねつかれずに、床の中で、いろいろのことを考えていました。ちょうど、そのときでありました。圃のあちらで、だれか、ハーモニカを吹いているものがあったのであります。

「いまごろ、だれだろうか？隣の勇ちゃんかしらん。こんなに暗く遅いのに、そして寒いのに、独りで外へ出ているのだろうか……。ああ、きっとお化けにちがいない！」次郎は、こう思うと、頭からふとんをかむりました。そして、息の音を殺していました。翌日起きてから外に出てみますと、圃の中には、昨日つくった雪だるまが、そのままになっていました。雪だるまは、ハーモニカを口に、往来の方を見守っていました。そこへ、勇吉がやってきました。

「次郎ちゃん、おはよう、雪だるまは凍って光っているね。」

「夜中に、勇ちゃんは、外に出て、ハーモニカを吹いた？僕は、夜中に、ハーモニカの鳴るのを聞いたよ。」

「うそだい。だれが、そんな夜中に、ハーモニカを吹くものか？」

「そんなら、きっとお化けだよ。」

「お化けなんか、あるものか、次郎ちゃんは、夢を見たんだよ。」

「だって、僕は、ハーモニカの音を聞いたよ。」と、次郎はいいましたけれど、勇吉は、ほんとうにしませんでした。

その日の夜のことであります。次郎は、ふたたび夜中に、ハーモニカの音を聞きました。こんどは次郎は、だれが吹いているか、それを見ようと、勇気を出して、戸口まで出てのぞいてみました。外は昼間のように月の光が明るかったのです。脊の高い、黒いやせた男が、雪だるまと話をしていました。その男のようすは、どうしても魔物であって、人間とは見えませんでした。からだは全体が、細く黒かったけれど、目だけは、光っていました。

「明日の晩には、うんと雪を持ってきよう。」と、黒い魔物はいいました。次郎は、風の神だと思いました。その中に、黒い魔物は、かきの木の枝に飛び上がりました。そして、悲しい声で身にしみるような叫びをあげると、長い翼をひろげて、遠くへと飛んで消えました。

\vspace{3\zw}

\begin{screen}
底本：「定本小川未明童話全集2」講談社  

1976（昭和51）年12月10日第1刷  

1982（昭和57）年9月10日第7刷  

初出：「小学少年」  

1923（大正12）年1月  

※表題は底本では、「雪だるま」となっています。  

入力：ぷろぼの青空工作員チーム入力班  

校正：江村秀之  

2013年11月5日作成  

青空文庫作成ファイル：  

このファイルは、インターネットの図書館、青空文庫 \url{http://www.aozora.gr.jp/}で作られました。入力、校正、制作にあたったのは、ボランティアの皆さんです。
\end{screen}
```

### Quarto、xelatex、bxjsarticle、pandocオプション mojiparlineで雪だるま

```
---
execute:
  echo: false
  eval: true
  message: false
  warning: false
  include: true
format:
  pdf:
    latex-tinytex: true
    pdf-engine: xelatex
    documentclass: bxjsarticle
    classoption: [a4,pandoc,jafont=haranoaji,base=12pt,everyparhook=compat,whole-zw-lines=false,nomag*]
    geometry: 
        - truedimen
        - top=25truemm
        - bottom=30truemm
        - foot=15truemm
        - left=25truemm
        - right=25truemm
    keep-tex: false
    colorlinks: true
    number-sections: true
    #linestretch: 1.0
    indent: true
    lang: ja
    include-in-header:
      - text: |
           \usepackage{ascmac}
           \usepackage{wrapfig}
           \usepackage{url}
           \usepackage[left]{lineno}
           \pagewiselinenumbers 
           % mojiparline,xelatex,bxjs
           \makeatletter
           \def\mojiparline#1{
               \newcounter{mpl}
               \setcounter{mpl}{#1}
               \@tempdima=\textwidth
               \advance\@tempdima by-\value{mpl}\zw     % \zwに変更
               \addtocounter{mpl}{-1}
               \divide\@tempdima by \value{mpl}
               \@tempskipa=\getkanjiskip  % レジスタにkanjiskipを代入(\getkanjiskip)
               \advance\@tempskipa by \@tempdima        % レジスタに調整分を加算
               \setkanjiskip{\@tempskipa}  % レジスタをkanjiskipにセット(\setkanjiskip)
               \@tempskipa=\getxkanjiskip  % レジスタにxkanjiskipを代入(\getxkanjiskip)
               \advance\@tempskipa by \@tempdima        % レジスタに調整分を加算
               \setxkanjiskip{\@tempskipa}  % レジスタをxkanjiskipにセット(\setxkanjiskip)
               \advance\parindent by \@tempdima % インデントに調整分を加算
           }
           \makeatother
           \def\linesparpage#1{
               \baselineskip=\textheight
               \divide\baselineskip by #1
           }
---
\begin{center}\huge  雪だるま\end{center}
\begin{center}\large 小川未明\end{center}
\mojiparline{35}
\linesparpage{35}

いいお天気でありました。もはや、野にも山にも、雪が一面に真っ白くつもってかがやいています。ちょうど、その日は学校が休みでありましたから、次郎は、家の外に出て、となりの勇吉といっしょになって、遊んでいました。

「大きな、雪だるまを一つつくろうね。」

二人は、こういって、いっしょうけんめいに雪を一処《ひとところ》にあつめて、雪だるまをつくりはじめました。

そこは、人通りのない、家の前の圃の中でありました。梅の木も、かきの木も、すでに二、三尺も根もとのほうは雪にうずもれていました。そして、わらぐつをはきさえすれば、子供たちは圃の上を自由に、どこへでもゆくことができたのであります。

頭の上の空は、青々として、ちょうどガラスをふいたようにさえていました。あちらこちらには、たこがあがって、籐の鳴り音が聞こえていました。けれど、二人は、そんなことにわき見もせずに、せっせと雪を運んでは、だるまをつくっていました。昼前かかって、やっと半分ばかりしかできませんでした。

「昼飯を食べてから、またあとを造ろうね。」

二人は、こういって、昼飯を食べに、おのおのの家へ帰りました。そして、やがてまた二人は、そこにやってきて、せっせと、雪だるまを造っていました。

ほんとうに、その日は、いい天気でありましたから、小鳥も木の枝にきて鳴いていました。しかし、冬の日は短くて、じきに日は暮れかかりました。西の方の空は、赤くそまって、一面に雪の上はかげってしまいました。その時分にやっと、二人の雪だるまは、みごとにできあがったのであります。

「やあ、大きいだるまだなあ。」といって、二人は、自分たちのつくった、雪だるまを目をかがやかして賞歎《しょうたん》しました。次郎は、墨でだるまの目と鼻と口とをえがきました。だるまは、往来の方を向いてすわっていました。二人は、明日から、この路を通る人たちがこれを見て、どんなにかびっくりするだろうと思って喜びました。

「きっと、みんながびっくりするよ。」と、勇吉はいって、こおどりしました。そして、懐の中から自分のハーモニカを取り出して、だるまの口に押しつけました。ちょうど、だるまが夕陽の中に赤くいろどられて、ハーモニカを吹いているように見えたのであります。

空の色は、だんだん冷たく、暗くなりました。そして、雪の上をわたって吹いてくる風が、身にしみて寒さを感じさせました。

「もう、家へ帰ろう。そして、また、明日ここへきて遊ぼうよ。」こういって、その日の名残をおしみながら、別れて、二人は自分の家へ入ってゆきました。あとには、ただひとり大きな雪だるまが、円い目をみはって、あちらをながめていました。

次郎は、夕飯を食べるとじきに床の中に入りました。そして、いつのまにかぐっすりと眠ってしまいました。ちょうど、夜中時分《よなかじぶん》でありました。そばにねていられたおばあさんが、いつものように、

「次郎や、小便《しょうべん》にゆかないか。」といって、ゆり起こされましたので、次郎は、すぐに起きて目をこすりながら、はばかりにゆきました。そして、またもどってきて、暖かな床の中に入りました。家の外には、風が吹いています。寒い晩でありました。晴れていて、雲がないとみえて、月の光が、窓のすきまから、障子の上に明るくさしているのが見られました。

次郎は、どんなに、だれも人のいない家の外は寒かろうと思いました。それで、すぐにねつかれずに、床の中で、いろいろのことを考えていました。ちょうど、そのときでありました。圃のあちらで、だれか、ハーモニカを吹いているものがあったのであります。

「いまごろ、だれだろうか？隣の勇ちゃんかしらん。こんなに暗く遅いのに、そして寒いのに、独りで外へ出ているのだろうか……。ああ、きっとお化けにちがいない！」次郎は、こう思うと、頭からふとんをかむりました。そして、息の音を殺していました。翌日起きてから外に出てみますと、圃の中には、昨日つくった雪だるまが、そのままになっていました。雪だるまは、ハーモニカを口に、往来の方を見守っていました。そこへ、勇吉がやってきました。

「次郎ちゃん、おはよう、雪だるまは凍って光っているね。」

「夜中に、勇ちゃんは、外に出て、ハーモニカを吹いた？僕は、夜中に、ハーモニカの鳴るのを聞いたよ。」

「うそだい。だれが、そんな夜中に、ハーモニカを吹くものか？」

「そんなら、きっとお化けだよ。」

「お化けなんか、あるものか、次郎ちゃんは、夢を見たんだよ。」

「だって、僕は、ハーモニカの音を聞いたよ。」と、次郎はいいましたけれど、勇吉は、ほんとうにしませんでした。

その日の夜のことであります。次郎は、ふたたび夜中に、ハーモニカの音を聞きました。こんどは次郎は、だれが吹いているか、それを見ようと、勇気を出して、戸口まで出てのぞいてみました。外は昼間のように月の光が明るかったのです。脊の高い、黒いやせた男が、雪だるまと話をしていました。その男のようすは、どうしても魔物であって、人間とは見えませんでした。からだは全体が、細く黒かったけれど、目だけは、光っていました。

「明日の晩には、うんと雪を持ってきよう。」と、黒い魔物はいいました。次郎は、風の神だと思いました。その中に、黒い魔物は、かきの木の枝に飛び上がりました。そして、悲しい声で身にしみるような叫びをあげると、長い翼をひろげて、遠くへと飛んで消えました。

\vspace{2\zw}

\begin{screen}
底本：「定本小川未明童話全集2」講談社  

1976（昭和51）年12月10日第1刷  

1982（昭和57）年9月10日第7刷  

初出：「小学少年」  

1923（大正12）年1月  

※表題は底本では、「雪だるま」となっています。  

入力：ぷろぼの青空工作員チーム入力班  

校正：江村秀之  

2013年11月5日作成  

青空文庫作成ファイル：  

このファイルは、インターネットの図書館、青空文庫 \url{http://www.aozora.gr.jp/}で作られました。入力、校正、制作にあたったのは、ボランティアの皆さんです。
\end{screen}
```

