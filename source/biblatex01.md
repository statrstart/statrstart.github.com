---
title: BibLaTeXで日本語文献と英語文献の混在を扱う(2021年11月)
date: 2021-11-25
tags: ["BibLaTeX", "biblatex-gb7714-2015","xpatch"]
excerpt: biblatex-gb7714-2015（2021/09/11 v1.1a）を使ってみた。
---

# BibLaTeXで日本語文献と英語文献の混在を扱う(2021年)

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2Fbiblatex01&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com)

(参考)  
### 方法１
[つぶつぶなるままに BibLaTeX で日本語文献と英語文献の混在を扱う(2018年版)](http://granular.blog39.fc2.com/blog-entry-76.html)  
[Disabling the printing of language only, while using the macro based on language specification in biblatex-TeX-LaTeX Stack Exchange](https://tex.stackexchange.com/questions/498682/disabling-the-printing-of-language-only-while-using-the-macro-based-on-language)  

### 方法２
[biblatex-japanese](https://github.com/kmaed/biblatex-japanese)  

### biblatexでの出力をbibitemに変換して、pdfで出力。pdf->textは例えばlinuxなら「pdftotext」を使う。それを手作業で修正。
[biblatex2bibitem–Convert BibLaTeX-generated bibliography to bibitems](https://ctan.org/pkg/biblatex2bibitem) 

### 今回使用するパッケージ：biblatex-gb7714-2015（2021/09/11 v1.1a）  
github : [biblatex-gb7714-2015](https://github.com/hushidong/biblatex-gb7714-2015)  
CTAN : [biblatex-gb7714-2015: a biblatex style package](https://www.ctan.org/tex-archive/macros/latex/contrib/biblatex-contrib/biblatex-gb7714-2015)  

Ed. by -> (Ed.) or (Eds.)の方法はここ
[Move names of editors followed by (Ed./Eds.) and a comma before title in biblatex](https://newbedev.com/move-names-of-editors-followed-by-ed-eds-and-a-comma-before-title-in-biblatex)

OSはUBUNTU 20.04です。latexは、ライトユーザーですので詳しくはわかりませんがネットで調べながらやってみました。

### 出力 : default

#### style=gb7714-2015

![biblatex1_1](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/biblatex1_1.png)

#### style=gb7714-2015ay

![biblatex2_1](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/biblatex2_1.png)

### 出力 : オプション変更。日本語用マクロ適用

#### style=gb7714-2015

![biblatex1_2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/biblatex1_2.png)

#### style=gb7714-2015ay

![biblatex2_2](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/biblatex2_2.png)

## Latex code

### Main

一部コメントアウトをするかしないかだけなので一つにまとめた。

```latex
\documentclass[a4,pandoc,jafont=ipaex,everyparhook=compat,base=11pt]{bxjsarticle}
% defaultの gb7714-2015
%\usepackage[backend=biber,style=gb7714-2015]{biblatex}
% gb7714-2015:いくつかオプションを変更
%\usepackage[backend=biber,style=gb7714-2015,gbpunctin=false,gbtype=false,gbpub=false,maxbibnames=3,minbibnames=3,maxcitenames=1,mincitenames=1]{biblatex}
%
% defaultの gb7714-2015ay
%\usepackage[backend=biber,style=gb7714-2015ay]{biblatex}
% gb7714-2015ay:いくつかオプションを変更
\usepackage[backend=biber,style=gb7714-2015ay,gbpunctin=false,sorting=nyt,gbtype=false,gbpub=false,maxbibnames=3,minbibnames=3,maxcitenames=1,mincitenames=1]{biblatex}
%
\usepackage{filecontents}
%
\begin{filecontents}{hoge.bib}
@article{brezis93:_leapf_inter_compet,
  author       = {Brezis, Elise S. and Krugman, Paul R. and Tsiddon, Daniel},
  title	       = {Leapfrogging in International Competition: A Theory of Cycles
                  in National Technological Leadership},
  journaltitle      = {American Economic Review},
  year	       = 1993,
  volume       = 83,
  number       = 5,
  pages	       = {1211-1219}
}
@article{Hattori02,
  author       = {服部, 保 and 石田, 弘明 and 小舘, 誓治 and 南山, 典子},
  sortname	       = {Tamotsu Hattori and Hiroaki Ishida and Seiji Kodate and Noriko
                  Minamiyama},
  title	       = {照葉樹林フロラの特徴と絶滅のおそれのある照葉樹林構成種の現状},
  journaltitle      = {ランドスケープ研究},
  volume       = {65},
  pages	       = {609-614},
  year	       = {2002},
  sortname     = {はっとり, やすし},
  langid       = {japanese}
}
@book{markusen99jp:trade_vol_1,
% 外国人をカタカナで記述した場合はアルファベットも全角にすること。
  author       = {マークセン,Ｊ.Ｒ. and ケンプファー,Ｗ.Ｈ.  and メルヴィン,Ｊ.Ｒ.
                  and マスカス,Ｋ.Ｅ.},
  title	       = {国際貿易：理論と実証〈上〉},
  publisher    = {多賀出版},
  year	       = 1999,
  jauthor      = {松村, 敦子},
  sortname     = {まーくせん},
  langid       = {japanese}
}
@incollection{lucas76:_econom_polic_evaluat,
  author       = {Lucas, Jr., Robert E.},
  year	       = 1976,
  title	       = {Econometric Policy Evaluation: A Critique},
  booktitle    = {The Phillips Curve and Labor Markets},
  pages	       = {19-46},
  editor      = {Karl Brunner and Allan H. Meltzer},
  volume       = 1,
  series       = {Carnegie Rochester Conference Series on Public Policy},
  publisher    = {North-Holland},
  address      = {Amsterdam}
}
@incollection{oyama99:_mark_stru,
  author       = {大山, 道広},
  title	       = {市場構造・経済厚生・国際貿易},
  editor       = {岡田, 章 and 神谷, 和也 and 柴田, 弘文 and 伴, 金美},
  booktitle    = {現代経済学の潮流 1999},
  pages	       = {3-34},
  publisher    = {東洋経済新報社},
  year	       = 1999,
  sortname     = {おおやま, みちひろ},
  langid       = {japanese}
}
\end{filecontents}
\addbibresource{hoge.bib}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% 作成した日本語用の変換規則を読み込む(本文と同じディレクトリに置いておく。)
\input{japneseforGB7714.tex}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
\begin{document}
\textcite{brezis93:_leapf_inter_compet},\textcite{Hattori02},\textcite{markusen99jp:trade_vol_1},
\textcite{lucas76:_econom_polic_evaluat},\textcite{oyama99:_mark_stru}
\printbibliography
\end{document}
```

### japneseforGB7714.tex

```latex
\usepackage{xpatch}
%
%著者名とタイトルの間の区切り文字をコロンにする
\renewcommand{\labelnamepunct}{\addcolon\addspace} 
%文献末尾.削除
\renewcommand{\finentrypunct}{}
% タイトルにダブルクオーテーション(\mkbibquote)をつける.( 日本語の場合『』をつける)
\AtEveryBibitem{%
\iffieldequalstr{langid}{japanese}
      {\DeclareFieldFormat*{title}{『#1』}} % if true
      {\DeclareFieldFormat*{title}{\mkbibquote{#1\adddot}}} % if false
}
%booktitleをイタリック体へ( 日本語の場合「」をつける)
\AtEveryBibitem{%
\iffieldequalstr{langid}{japanese}
{\DeclareFieldFormat*{booktitle}{「#1」}}
{\DeclareFieldFormat*{booktitle}{\textit{#1}}}
}
%volumeを太字へ
\DeclareFieldFormat*{volume}{\textbf{#1}\addcolon\space}
% 等->他
\DefineBibliographyStrings{english}{%
	andotherscn = {他}
}
\DefineBibliographyStrings{english}{%
	andothersincitecn = {他}
}
%in: -> In:
\renewbibmacro{in:}{\space{In:}}
%年をカッコで囲む
\DeclareFieldFormat*{date}{(#1)}
%
%%%%% editor 英語:(Ed.)or(Eds.)  日本語:(編) %%%%%

\AtEveryBibitem{%
\iffieldequalstr{langid}{japanese}
      {\DeclareFieldFormat{editortype}{編}} % if true
      {} % if false
}

\renewbibmacro*{editorstrg}{%
  \ifnameundef{editor}{}{%
	\printtext[editortype]{%
		\iffieldundef{editortype}
		{\ifboolexpr{
				test {\ifnumgreater{\value{editor}}{1}}
				or
				test {\ifandothers{editor}}
			}
			{\bibstring{editors}}
			{\bibstring{editor}}}
		{\ifbibxstring{\thefield{editortype}}
			{\ifboolexpr{
					test {\ifnumgreater{\value{editor}}{1}}
					or
					test {\ifandothers{editor}}
				}
				{\bibstring{\thefield{editortype}s}}
				{\bibstring{\thefield{editortype}}}}
			{\thefield{editortype}}}}}}

\DeclareNameAlias{editorin}{first-last}

\newbibmacro*{byeditor:in}{%
  \ifnameundef{editor}
    {}
    {\printnames[editorin]{editor}%
     \addspace\bibsentence%
     \mkbibparens{\usebibmacro{editorstrg}}%
     \clearname{editor}%
     \printunit{\addcomma\space}}}

\DeclareBibliographyDriver{incollection}{%
  \usebibmacro{bibindex}%
  \usebibmacro{begentry}%
  \usebibmacro{author/translator+others}%
  \setunit{\printdelim{nametitledelim}}\newblock
  \usebibmacro{title}%
  \newunit
%  \printlist{language}%
  \newunit\newblock
  \usebibmacro{byauthor}%
  \newunit\newblock
  \usebibmacro{in:}%
  \usebibmacro{maintitle+booktitle}%
  \newunit\newblock
  \usebibmacro{byeditor+others}%
  \newunit\newblock
  \printfield{edition}%
  \newunit
  \iffieldundef{maintitle}
    {\printfield{volume}%
     \printfield{part}}
    {}%
  \newunit
  \printfield{volumes}%
  \newunit\newblock
  \usebibmacro{series+number}%
  \newunit\newblock
  \printfield{note}%
  \newunit\newblock
  \usebibmacro{publisher+location+date}%
  \newunit\newblock
  \usebibmacro{chapter+pages}%
  \newunit\newblock
  \iftoggle{bbx:isbn}
    {\printfield{isbn}}
    {}%
  \newunit\newblock
  \usebibmacro{doi+eprint+url}%
  \newunit\newblock
  \usebibmacro{addendum+pubstate}%
  \setunit{\bibpagerefpunct}\newblock
  \usebibmacro{pageref}%
  \newunit\newblock
  \iftoggle{bbx:related}
    {\usebibmacro{related:init}%
     \usebibmacro{related}}
    {}%
  \usebibmacro{finentry}}

% Ed. by -> (Ed.) or (Eds.)
\xpatchbibdriver{incollection}
  {\usebibmacro{in:}%
   \usebibmacro{maintitle+booktitle}%
   \newunit\newblock
   \usebibmacro{byeditor+others}}
  {\usebibmacro{in:}%
   \usebibmacro{byeditor:in}%
   \setunit{\labelnamepunct}\newblock
   \usebibmacro{maintitle+booktitle}%
   \newunit\newblock
   \usebibmacro{byeditor}}
  {}{}

% biblatex standard.bbx
\DeclareBibliographyDriver{inbook}{%
  \usebibmacro{bibindex}%
  \usebibmacro{begentry}%
  \usebibmacro{author/translator+others}%
  \setunit{\printdelim{nametitledelim}}\newblock
  \usebibmacro{title}%
  \newunit
  \printlist{language}%
  \newunit\newblock
  \usebibmacro{byauthor}%
  \newunit\newblock
  \usebibmacro{in:}%
  \usebibmacro{bybookauthor}%
  \newunit\newblock
  \usebibmacro{maintitle+booktitle}%
  \newunit\newblock
  \usebibmacro{byeditor+others}%
  \newunit\newblock
  \printfield{edition}%
  \newunit
  \iffieldundef{maintitle}
    {\printfield{volume}%
     \printfield{part}}
    {}%
  \newunit
  \printfield{volumes}%
  \newunit\newblock
  \usebibmacro{series+number}%
  \newunit\newblock
  \printfield{note}%
  \newunit\newblock
  \usebibmacro{publisher+location+date}%
  \newunit\newblock
  \usebibmacro{chapter+pages}%
  \newunit\newblock
  \iftoggle{bbx:isbn}
    {\printfield{isbn}}
    {}%
  \newunit\newblock
  \usebibmacro{doi+eprint+url}%
  \newunit\newblock
  \usebibmacro{addendum+pubstate}%
  \setunit{\bibpagerefpunct}\newblock
  \usebibmacro{pageref}%
  \newunit\newblock
  \iftoggle{bbx:related}
    {\usebibmacro{related:init}%
     \usebibmacro{related}}
    {}%
  \usebibmacro{finentry}}

\xpatchbibdriver{inbook}
  {\usebibmacro{in:}%
   \usebibmacro{bybookauthor}%
   \newunit\newblock
   \usebibmacro{maintitle+booktitle}%
   \newunit\newblock
   \usebibmacro{byeditor+others}}
  {\usebibmacro{in:}%
   \usebibmacro{bybookauthor}%
   \newunit\newblock
   \usebibmacro{byeditor:in}%
   \newunit\newblock
   \usebibmacro{maintitle+booktitle}%
   \newunit\newblock
   \usebibmacro{byeditor+others}}
  {}{}

\DeclareBibliographyDriver{inproceedings}{%
  \usebibmacro{bibindex}%
  \usebibmacro{begentry}%
  \usebibmacro{author/translator+others}%
  \setunit{\printdelim{nametitledelim}}\newblock
  \usebibmacro{title}%
  \newunit
%  \printlist{language}%
  \newunit\newblock
  \usebibmacro{byauthor}%
  \newunit\newblock
  \usebibmacro{in:}%
  \usebibmacro{maintitle+booktitle}%
  \newunit\newblock
  \usebibmacro{event+venue+date}%
  \newunit\newblock
  \usebibmacro{byeditor+others}%
  \newunit\newblock
  \iffieldundef{maintitle}
    {\printfield{volume}%
     \printfield{part}}
    {}%
  \newunit
  \printfield{volumes}%
  \newunit\newblock
  \usebibmacro{series+number}%
  \newunit\newblock
  \printfield{note}%
  \newunit\newblock
  \printlist{organization}%
  \newunit
  \usebibmacro{publisher+location+date}%
  \newunit\newblock
  \usebibmacro{chapter+pages}%
  \newunit\newblock
  \iftoggle{bbx:isbn}
    {\printfield{isbn}}
    {}%
  \newunit\newblock
  \usebibmacro{doi+eprint+url}%
  \newunit\newblock
  \usebibmacro{addendum+pubstate}%
  \setunit{\bibpagerefpunct}\newblock
  \usebibmacro{pageref}%
  \newunit\newblock
  \iftoggle{bbx:related}
    {\usebibmacro{related:init}%
     \usebibmacro{related}}
    {}%
  \usebibmacro{finentry}}

\xpatchbibdriver{inproceedings}
  {\usebibmacro{in:}%
   \usebibmacro{maintitle+booktitle}%
   \newunit\newblock
   \usebibmacro{event+venue+date}%
   \newunit\newblock
   \usebibmacro{byeditor+others}}
  {\usebibmacro{in:}%
   \usebibmacro{byeditor:in}%
   \setunit{\labelnamepunct}\newblock
   \usebibmacro{maintitle+booktitle}%
   \newunit\newblock
   \usebibmacro{event+venue+date}%
   \newunit\newblock
   \usebibmacro{byeditor+others}}
  {}{}
```

