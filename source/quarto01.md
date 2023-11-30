---
title: Quartoで日本語PDFファイルを作成する（その１）
date: 2023-11-30
tags: ["quarto", "xelatex","lualatex","xelatexja"]
excerpt: pdf-engine と documentclass の組み合わせを検証
---

# pdf-engine と documentclass の組み合わせを検証

検証した日：2023/11/28　「tlmgr update --self --all」　を実行してから検証を始めた。

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2Fquarto01&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

**Quartoで日本語PDFファイルを作成**するときに使う`pdf-engine`と`documentclass`の組み合わせを検証してみました。

もちろん使うフォント、パッケージによって結果は異なると思うので、あくまで参考にすぎません。

**Quarto**は、defaultでいろんなパッケージを読み込みます。documentclassによって相性の良し悪しがあってなかなかおもしろい結果となりました。

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

あくまで、このサンプルだけの結果ですが次のことは言えると思います。

- jlreqはQuartoとの相性が悪い。

- Quartoを通すと、lualatexの小書き仮名で禁則が効かなくなる。(jlreq,ltjsarticle,bxjsarticle)

- Quartoを通して、出力した結果が良好だったのは[xelatexja](https://github.com/h20y6m/xelatexja)を使用したもの

最後に、検証に使ったtexコードとqmdコードを載せときます。

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
    lang: ja
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

