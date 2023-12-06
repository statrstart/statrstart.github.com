---
title: Quartoで日本語PDFファイルを作成する（その２）
date: 2023-12-06
tags: ["quarto", "lualatex","ltjsarticle"]
excerpt: Quartoのpdf option 「lang: ja」
---

# Quartoのpdf option 「lang: ja」

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2Fquarto02&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

- Quarto 1.3.450

- pdf-engine: lualatex

- documentclass: ltjsarticle

(参考) 

[Quarto: Document Language](https://quarto.org/docs/authoring/language.html)

[Quarto: PDF Options](https://quarto.org/docs/reference/formats/pdf.html)

### lang: ja あり

![langja.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/langja.png)

### lang: ja なし

![nolangja.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/nolangja.png)

### lang: ja なし & crossref option 設定

![crossref.png](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/images/crossref.png)

## Quarto コード

コメントアウトは適当につけたり外したりする。


```
---
format:
  pdf:
    latex-tinytex: true
    pdf-engine: lualatex
    documentclass: ltjsarticle
    classoption: [a6paper]
    keep-tex: false
    linestretch: 0.9
    indent: true
    #lang: ja
    crossref:
         tbl-title: "表"
         tbl-prefix: "表"
    include-in-header:
      - text: |
           \pagestyle{empty}
---
ああである。（こうである。）\par
ああである。こうである。
\vspace{\baselineskip}

ベジエ（Bézier）曲線\par
ベジェ（Bézier）曲線\par
\vspace{\baselineskip}

\parbox{21\zw}{%
寿限無寿限無五劫の擦り切れ海砂利水魚の水行末雲来末風来末
食う寝る処に住む処藪ら柑子の藪柑子
パイポパイポパイポのシューリンガンシューリンガンのグーリンダイ
グーリンダイのポンポコピーのポンポコナーの長久命の長助
}

|果物| 値段|
|-----|-----:|
|りんご|150|
|桃|200|
|みかん|120|

: 果物の値段 {#tbl-price}

@tbl-price を見てね。
```
