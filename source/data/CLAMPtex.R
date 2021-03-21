setwd("./144")
require(knitr)
require(rmarkdown)
library(vegan)
library(xtable)
library(RcmdrMisc)
# 信頼区間、予測区間つきグラフ作成に必要
#install.packages("investr")
library(investr)

# 半角スペースで区切った葉化石スコアデータ
# Konan.txt , Sakipenpetsu.txt , Shanahuchi.txt , Rubeshibe.txt
# BanPaKha.txt , MaeLai.txt

site<- "MaeLai"
#
# ここからは変更しない
file<- "CLAMP02tex2"
FossilLeaves<- paste0(site,".txt")
#
input<- paste0(file,".Rmd")
output<- paste0(site,".pdf")
# pdfに変換
render(input,output_format ="pdf_document",output_file =output)


# ここからは変更しない
file<- "CLAMP02tex3"
FossilLeaves<- paste0(site,".txt")
#
input<- paste0(file,".Rmd")
output<- paste0(site,"boot.pdf")
# pdfに変換
render(input,output_format ="pdf_document",output_file =output)


##########################################

#拡張子.logのデータを削除
system("rm *.log")

##########################################

setwd("./144")
require(knitr)
require(rmarkdown)
library(vegan)
library(xtable)
library(RcmdrMisc)
# 信頼区間、予測区間つきグラフ作成に必要
#install.packages("investr")
library(investr)

# 半角スペースで区切った葉化石スコアデータ
# Konan.txt , Sakipenpetsu.txt , Shanahuchi.txt , Rubeshibe.txt
# BanPaKha.txt , MaeLai.txt

# ここからは変更しない
file<- "CLAMPmodel"
#
input<- paste0(file,".Rmd")
output<- paste0(file,".pdf")
# pdfに変換
render(input,output_format ="pdf_document",output_file =output)

