---
title: Quartoで日本語PDFファイルを作成する（その１）更新
date: 2023-12-05
tags: ["quarto", "xelatex","lualatex","xelatexja"]
excerpt: pdf-engine と documentclass の組み合わせを検証
---

# pdf-engine と documentclass の組み合わせを検証

Quarto 1.3.450

## Quartoのyamlから「lang: ja」を削除したら、結果が全く違った！！

BXjscls パッケージ（BXJS 文書クラス集）ユーザマニュアルによると、Pandocモードについて、

「入力文書が言語指定を含む場合（lang: ja とする）には Babel パッケージが読み込まれるが、この際に発生する可能性がある不整合」を回避する。

yamlから「lang: ja」は削除したほうがいいようです。

検証した日：2023/12/05　「tlmgr update --self --all」　を実行してから検証を始めた。

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2Fquarto01&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

**Quartoで日本語PDFファイルを作成**するときに使う`pdf-engine`と`documentclass`の組み合わせを検証してみました。

### `pdf-engine`と`documentclass`の組み合わせ

xelatexjaは、[日本語 LaTeX の新常識 2021 最終更新日 2021年06月21日](https://qiita.com/wtsnjp/items/76557b1598445a1fc9da)で知りました。

[xelatexja:XeLaTeX で和文する実験](https://github.com/h20y6m/xelatexja)にあります。

1. （左）lualatex + jlreq  と （右）Quarto + lualatex + jlreq

2. （左）lualatex + ltjsarticle  と （右）Quarto + lualatex + ltjsarticle

3. （左）lualatex + bxjsarticle  と （右）Quarto + lualatex + bxjsarticle + pandocモード

4. （左）xelatex + bxjsarticle + ja=standard  と （右）Quarto + xelatex + bxjsarticle + pandocモード

5. （左）xelatex + bxjsarticle + ja=xelatexja と （右）Quarto + xelatex + bxjsarticle + ja=xelatexja

## 結果

### 1. （左）lualatex + jlreq  と （右）Quarto + lualatex + jlreq

![jlreq01.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/jlreq01.png)

### 2. （左）lualatex + ltjsarticle  と （右）Quarto + lualatex + ltjsarticle

![ltjsarticle01.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/ltjsarticle01.png)

### 3. （左）lualatex + bxjsarticle  と （右）Quarto + lualatex + bxjsarticle + pandocモード

![lualatex_bxjsarticle01.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/lualatex_bxjsarticle01.png)

### 4. （左）xelatex + bxjsarticle + ja=standard  と （右）Quarto + xelatex + bxjsarticle + pandocモード

![xelatex_bxjsarticle01.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/xelatex_bxjsarticle01.png)

### 5. （左）xelatex + bxjsarticle + ja=xelatexja と （右）Quarto + xelatex + bxjsarticle + ja=xelatexja

![xelatex_xelatexja01.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/xelatex_xelatexja01.png)

なお、使用した例文はここからお借りしました。感謝です。

[zxjaﾅﾝﾁｬﾗの現状について語ってみる(1) 2020-02-09](https://zrbabbler.hatenablog.com/entry/2020/02/09/223244)  

[zxjaﾅﾝﾁｬﾗの現状について語ってみる(2) 2020-03-29](https://zrbabbler.hatenablog.com/entry/2020/03/29/234435)

[行頭で括弧が揃わないって](https://zrbabbler.hatenablog.com/entry/20120514/1336952639)

[行頭で括弧が揃うようにする](https://zrbabbler.hatenablog.com/entry/20120524/1337880639)

### texコード

pdf-engine と documentclass の組み合わせによってコメントアウトしたりしなかったりしています。

```
% xelatex  test.tex
\documentclass[autodetect-engine,ja=standard,a4paper,prefercjk]{bxjsarticle}
%\documentclass[autodetect-engine,ja=xelatexja,a4paper]{bxjsarticle}
%
% lualatextest.tex
%\documentclass[autodetect-engine,ja=standard,a4paper]{bxjsarticle}
%\documentclass[a4paper]{ltjsarticle}
%\documentclass[a4paper]{jlreq}
%
\pagestyle{empty}
\begin{document}

「どうして？」

「誠に残念な事だが、ここは現実世界だ」

「それは解っている！」

\vspace{\baselineskip}

ああである。（こうである。）\par
ああである。こうである。
\vspace{\baselineskip}

ベジエ（Bézier）曲線\par
ベジェ（Bézier）曲線\par
\vspace{\baselineskip}

①☀っ☁☂☀～っ？\par
❷☃っ☃☃☃～っ！\par
\vspace{\baselineskip}

\parbox{21\zw}{%
寿限無寿限無五劫の擦り切れ海砂利水魚の水行末雲来末風来末
食う寝る処に住む処藪ら柑子の藪柑子
パイポパイポパイポのシューリンガンシューリンガンのグーリンダイ
グーリンダイのポンポコピーのポンポコナーの長久命の長助
}

\end{document}
```

### qmdコード

pdf-engine と documentclass の組み合わせによってコメントアウトしたりしなかったりしています。

＊yamlから「lang: ja」は削除したほうがいいようです。lualatexを使ったときの結果が良くなりました。

```
---
format:
  pdf:
    latex-tinytex: true
    #
    #pdf-engine: lualatex
    #documentclass: jlreq
    #documentclass: ltjsarticle
    #classoption: [a4paper]
    #documentclass: bxjsarticle
    #classoption: [pandoc,a4paper]
    #
    pdf-engine: xelatex
    documentclass: bxjsarticle
    classoption: [xelatex,ja=xelatexja,a4paper]
    #classoption: [pandoc,a4paper,prefercjk]
    keep-tex: false
    linestretch: 1.0
    indent: true
    include-in-header:
      - text: |
           % QuartoでbxjsarticleのPandocモードを使わない場合の余白等変更
           % (Quartoで「xelatex,ja=xelatexja」とした場合)
           %\setpagelayout*{margin=15truemm}
           \pagestyle{empty}
---

「どうして？」

「誠に残念な事だが、ここは現実世界だ」

「それは解っている！」

\vspace{\baselineskip}

ああである。（こうである。）\par
ああである。こうである。
\vspace{\baselineskip}

ベジエ（Bézier）曲線\par
ベジェ（Bézier）曲線\par
\vspace{\baselineskip}

①☀っ☁☂☀～っ？\par
❷☃っ☃☃☃～っ！\par
\vspace{\baselineskip}

\parbox{21\zw}{%
寿限無寿限無五劫の擦り切れ海砂利水魚の水行末雲来末風来末
食う寝る処に住む処藪ら柑子の藪柑子
パイポパイポパイポのシューリンガンシューリンガンのグーリンダイ
グーリンダイのポンポコピーのポンポコナーの長久命の長助
}

```

