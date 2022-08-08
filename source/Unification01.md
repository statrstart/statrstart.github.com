---
title: 家庭連合（旧 統一教会）の所在地(準備：データセット作成)
date: 2022-08-08
tags: ["R","rvest"]
excerpt: 最寄りの家庭教会のデータ
---

# 家庭連合（旧 統一教会）の所在地(準備：データセット作成)

[![Hits](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgitpress.io%2F%40statrstart%2FUnification01&count_bg=%2379C83D&title_bg=%23555555&icon=&icon_color=%23E7E7E7&title=hits&edge_flat=false)](https://hits.seeyoufarm.com) 

(使用するデータ)  
[最寄りの家庭教会：https://ffwpu.jp/admission/church/nearest](https://ffwpu.jp/admission/church/nearest)  

[作成したデータセット:Unification.csv](https://raw.githubusercontent.com/statrstart/statrstart.github.com/master/source/data/Unification.csv)  
(注意)  
- 文字コードはUTF-8です。
- データ項目は、所在地の県番号、都道府県名、郵便番号、住所、緯度、経度です。
- 電話番号は地図上にプロットにするのに必要ないので取り除きました。
- サイトに載っている家庭教会（2022/8/7現在：２９０件）のみで関連団体の所在地はわかりません。
- データセット上の緯度、経度と施設の位置とは若干のずれがあるようです。

(データセット作成の手順)  
「R」、「表計算ソフト(LibreOffice Calcを使用)」、「google スプレッドシートの拡張機能Apps Script」を使いました。

### 1. Rのrvestパッケージを使って必要な部分を取り出す。

```R
library(rvest)
url <- "https://ffwpu.jp/admission/church/nearest"  # 最寄りの家庭教会
html <- read_html(url)
# タグで指定する
dl<- html_nodes(html, "dl")
dat<- as.character(dl)
xx<-html_text(dl)
xxx<- sub("〒","",gsub(" \t","\\,",gsub("\r","",gsub("\n","",sub("　","\\,",gsub("\n\t","\\,",xx))))))
tel<- sub("\n","",sub("</a></span></span></dd>\n</dl>","",sub("^.*<br><span class=\"icon icon-phone\"><a class=\"js-tel\" href=\"tel:.*\">","",dat)))
adress<- NULL
for(i in 1:length(xxx)){
	tmp<- sub(tel[i],paste0("\\,",tel[i]),xxx[i])
	adress<- rbind(adress,tmp)
}
Unification<- read.csv(text=adress,h=F)
colnames(Unification)<- c("名称","郵便番号","住所","電話番号")
write.csv(Unification,file="Unification.csv",row.names = F)
```

Unification.csv を作成した。

### 2. Unification.csvを表計算ソフトで開いて

- 「本部」の住所と電話番号がくっついているのを手直しする。
- 「東海」のセルがずれているのを手直しする。

### 3. Rを使って、県番号、都道府県名を付与。

```R
p <- read.csv("Unification.csv")
kenmei = c("北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県", "茨城県",
           "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県", "新潟県", "富山県",
           "石川県", "福井県", "山梨県", "長野県", "岐阜県", "静岡県", "愛知県", "三重県",
           "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県", "鳥取県", "島根県",
           "岡山県", "広島県", "山口県", "徳島県", "香川県", "愛媛県", "高知県", "福岡県",
           "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県")
num<- rep(NA,nrow(p))
pref<- rep(NA,nrow(p))
for (i in 1:47){
	nn<- grep(pattern = kenmei[i],x = as.character(p$住所))
	num[nn] <- i
	pref[nn] <- kenmei[i]
}
p$県番号 <- num
p$都道府県 <- pref
# 電話番号は必要ないので削除しておく。（必要な場合は、p<-p[,c(5,6,1:4)]  とする。）
p<-p[,c(5,6,1:3)]
write.csv(p,file="Unification.csv",row.names = F)
```

### 4. 表計算ソフトで開いて,県番号、都道府県がついていない箇所を手直し。
- 大阪２箇所(大阪市で始まっている)
- 佐賀１箇所（佐賀市で始まっている））

### 5. google スプレッドシート に住所部分を貼り付け。拡張機能のApps Script を使って緯度、経度を付与する。

うまく緯度、経度が付与できなかった部分を２箇所見つけた。以下のように変更しておく。  
- 「阿南」(変更前)徳島県阿南市羽ノ浦町中庄原の内34-1　->　(変更後)徳島県阿南市羽ノ浦町中庄原ノ内34-1
- 「都城」(変更前)宮崎県都城市妻ケ丘町8街区1号　      ->　(変更後)宮崎県都城市妻ケ丘町8-1　

(参考)  
[施設名称から緯度経度、住所を取得する【GASとMAP Service利用】](https://note.com/yuickomori/n/nb0436d365d82)

### 6. csvファイルに上で得た緯度、経度をUnification.csvに付け加える。

データは県番号順にはなっていないので必要なら（Rもしくは表計算ソフトの機能を使って）並び替える。
