# wcsファイルの必要なヘッダー部分だけ取り出す関数を定義する
read.wcs=function(file){
	fcon = file(file, "rb")
# 80文字で一つのバラメータ(50あればよいが、10余分にとった)
	ll<-readChar(fcon, 80*60)
	close(fcon)
# 最初のHISTORY以降は削除
	ll<- gsub("HISTORY.*","",ll)
	key = NULL ; value = NULL
	for(i in 1:(nchar(ll)/80)){
		row = substr(ll,((80*(i-1))+1),(80*i))
		k = paste(strsplit(substr(row,1,8)," +")[[1]],collapse="",sep="")
		key = c(key, k) ; value=c(value,row)
	}
# value : /以降削除
	value = gsub("/.*","",value)
# value : =まで(key部分)削除
	value = gsub("^.*=","",value)
# hdr作成
	hdr = data.frame(key=key,value=value)
	return(hdr)
}

# エリア内にあるデータだけを抽出する関数を定義する
### R : sf -180 <= RA <= 180
## area内外の判断する。RAは -180<=RA<=180に変換したものを用意しなければならない。
inarea<- function(data,area,RA="RA",Dec="Dec"){
	require(sf)
	# RAは -180<=RA<=180に変換(元のデータは書き換えないこと)
	temp <- data
	temp[temp[,RA]>180,RA] <- temp[temp[,RA]>180,RA]-360
	df<-st_as_sfc(st_as_sf(data.frame(RA=temp[,RA],Dec=temp[,Dec]),coords=c("RA","Dec"),crs=4326))
	# polygon
	s <- st_as_sfc(st_as_binary(st_sfc(st_polygon(list(area))))[[1]] ,crs=4326)
	indata <- st_intersects(df,s,sparse = FALSE)
	# RAは変換前の値をかえす。
	return(data[indata,])
}

# [The SIP Convention for Representing Distortion in FITS Image Headers](https://irsa.ipac.caltech.edu/data/SPITZER/docs/files/spitzer/shupeADASS.pdf)
# (5)(6)式
# celestialパッケージのradec2xyに少し変更を加えるだけでよい。

rdsip2xy <- function (RA, Dec, header) {
	if (length(dim(RA)) == 2) {
		Dec = RA[, 2]
		RA = RA[, 1]
	}
	CRVAL1 = as.numeric(header[header[, 1] == "CRVAL1", 2])
	CRVAL2 = as.numeric(header[header[, 1] == "CRVAL2", 2])
	CRPIX1 = as.numeric(header[header[, 1] == "CRPIX1", 2])
	CRPIX2 = as.numeric(header[header[, 1] == "CRPIX2", 2])
	CD1_1 = as.numeric(header[header[, 1] == "CD1_1", 2])
	CD1_2 = as.numeric(header[header[, 1] == "CD1_2", 2])
	CD2_1 = as.numeric(header[header[, 1] == "CD2_1", 2])
	CD2_2 = as.numeric(header[header[, 1] == "CD2_2", 2])
	AP_0_0 = as.numeric(header[header[, 1] == "AP_0_0", 2])
	AP_0_1 = as.numeric(header[header[, 1] == "AP_0_1", 2])
	AP_0_2 = as.numeric(header[header[, 1] == "AP_0_2", 2])
	AP_1_0 = as.numeric(header[header[, 1] == "AP_1_0", 2])
	AP_1_1 = as.numeric(header[header[, 1] == "AP_1_1", 2])
	AP_2_0 = as.numeric(header[header[, 1] == "AP_2_0", 2])
	BP_0_0 = as.numeric(header[header[, 1] == "BP_0_0", 2])
	BP_0_1 = as.numeric(header[header[, 1] == "BP_0_1", 2])
	BP_0_2 = as.numeric(header[header[, 1] == "BP_0_2", 2])
	BP_1_0 = as.numeric(header[header[, 1] == "BP_1_0", 2])
	BP_1_1 = as.numeric(header[header[, 1] == "BP_1_1", 2])
	BP_2_0 = as.numeric(header[header[, 1] == "BP_2_0", 2])
	RA0 = CRVAL1 * (pi/180)
	Dec0 = CRVAL2 * (pi/180)
	RA = as.numeric(RA) * (pi/180)
	Dec = as.numeric(Dec) * (pi/180)
	scalemat = matrix(c(CD1_1, CD1_2, CD2_1, CD2_2), 2) * (pi/180)
	cosc = sin(Dec0) * sin(Dec) + (cos(Dec0) * cos(Dec) * cos(RA - RA0))
	XX = (cos(Dec) * sin(RA - RA0))/cosc
	YY = ((cos(Dec0) * sin(Dec)) - (sin(Dec0) * cos(Dec) * cos(RA - RA0)))/cosc
	raw = cbind(XX, YY)
	output = raw %*% solve(scalemat)
	U = output[, 1] 
	V = output[, 2]
	# [The SIP Convention for Representing Distortion in FITS Image Headers](https://irsa.ipac.caltech.edu/data/SPITZER/docs/files/spitzer/shupeADASS.pdf)
	# (5)(6)式
	u = U + AP_0_0*U^0*V^0 + AP_0_1*U^0*V^1 + AP_0_2*U^0*V^2 + AP_1_0*U^1*V^0 + AP_1_1*U^1*V^1 + AP_2_0*U^2*V^0 
	v = V + BP_0_0*U^0*V^0 + BP_0_1*U^0*V^1 + BP_0_2*U^0*V^2 + BP_1_0*U^1*V^0 + BP_1_1*U^1*V^1 + BP_2_0*U^2*V^0 
	output[, 1] = u + CRPIX1
	output[, 2] = v + CRPIX2
	colnames(output) = c("x", "y")
	return(output)
}

# [The SIP Convention for Representing Distortion in FITS Image Headers](https://irsa.ipac.caltech.edu/data/SPITZER/docs/files/spitzer/shupeADASS.pdf)
# (1)(2)(3)式
xysip2rd <- function(x, y, header) {
	if (length(dim(x)) == 2) {
		y = x[, 2]
		x = x[, 1]
	}
	CRVAL1 = as.numeric(header[header[, 1] == "CRVAL1", 2])
	CRVAL2 = as.numeric(header[header[, 1] == "CRVAL2", 2])
	CRPIX1 = as.numeric(header[header[, 1] == "CRPIX1", 2])
	CRPIX2 = as.numeric(header[header[, 1] == "CRPIX2", 2])
	CD1_1 = as.numeric(header[header[, 1] == "CD1_1", 2])
	CD1_2 = as.numeric(header[header[, 1] == "CD1_2", 2])
	CD2_1 = as.numeric(header[header[, 1] == "CD2_1", 2])
	CD2_2 = as.numeric(header[header[, 1] == "CD2_2", 2])
	A_0_0 = as.numeric(header[header[, 1] == "A_0_0", 2])
	A_0_1 = as.numeric(header[header[, 1] == "A_0_1", 2])
	A_0_2 = as.numeric(header[header[, 1] == "A_0_2", 2])
	A_1_0 = as.numeric(header[header[, 1] == "A_1_0", 2])
	A_1_1 = as.numeric(header[header[, 1] == "A_1_1", 2])
	A_2_0 = as.numeric(header[header[, 1] == "A_2_0", 2])
	B_0_0 = as.numeric(header[header[, 1] == "B_0_0", 2])
	B_0_1 = as.numeric(header[header[, 1] == "B_0_1", 2])
	B_0_2 = as.numeric(header[header[, 1] == "B_0_2", 2])
	B_1_0 = as.numeric(header[header[, 1] == "B_1_0", 2])
	B_1_1 = as.numeric(header[header[, 1] == "B_1_1", 2])
	B_2_0 = as.numeric(header[header[, 1] == "B_2_0", 2])
	u = CRPIX1
	v = CRPIX2
	CRVAL1=CRVAL1*(pi/180)
	CRVAL2=CRVAL2*(pi/180)
	scalemat=matrix(c(CD1_1,CD1_2,CD2_1,CD2_2),2)*(pi/180)
	fu = A_0_0*u^0*v^0 + A_0_1*u^0*v^1 + A_0_2*u^0*v^2 + A_1_0*u^1*v^0 + A_1_1*u^1*v^1 + A_2_0*u^2*v^0 
	fv = B_0_0*u^0*v^0 + B_0_1*u^0*v^1 + B_0_2*u^0*v^2 + B_1_0*u^1*v^0 + B_1_1*u^1*v^1 + B_2_0*u^2*v^0 
	xytran=cbind(x-u+fu,y-v+fv) %*% scalemat
	x = xytran[,1]
	y = xytran[,2]
	rad = sqrt(x^2+y^2)
	radproj1=atan(rad)
	radproj2=atan(rad)
	rafunc = function(CRVAL1,CRVAL2,x,y){
		CRVAL1 + atan2(x*sin(radproj1),rad*cos(CRVAL2)*cos(radproj1) - y*sin(CRVAL2)*sin(radproj1))
	}
	decfunc = function(CRVAL2,x,y){
		asin(cos(radproj2)*sin(CRVAL2) + (y*sin(radproj2)*cos(CRVAL2) / rad)) 
	}
	RA = rafunc(CRVAL1,CRVAL2,x,y)*180/pi %% 360
	Dec = decfunc(CRVAL2,x,y)*180/pi %% 90
	Dec[which(is.nan(Dec))] = CRVAL2*180/pi
	output=cbind(as.numeric(RA),as.numeric(Dec))
	colnames(output)=c('RA','Dec')
	return(output)
}

# locatorの出力をコピペしやすいようにコンマで区切って表示する関数
# 星座名を書くときに使う。
locator2<- function(n=1){
	xy=locator(n)
	xvec = paste0(round(xy$x,2) ,collapse=",")
	yvec = paste0(round(xy$y,2) ,collapse=",")
	print (xvec) ; print (yvec)
	return(xy)
}

##### plotAstro関数 #####
#
# (注意) あらかじめ入力するjpgファイル名、wcsファイル名を同じにすること。（例）ohoshisama.jpg 、ohoshisama.wcs
# starM : 星名を表示する星の最も暗い視等級
# ngcM : NGC名を表示するNGCの最も暗いB.Mag
#	ngcM = 100 : NA も含めてすべて表示する場合
#	ngcM = 0 : 表示したくない場合
# Const : 星座線を表示する星座(略符)
#	Const = c("Cas","Cep","UMi") : 指定する場合 
#	Const = "" : 描かない場合 
#	Const = "All" : すべて（星座線の線分のどちらかに端が画像上にある）描く場合 
# prn : messierPlusJ.csv に記入している天体の名称の表示数 1 or 2 or 3
#	prn = 3 : 天体名（例"Andromeda Galaxy"）、2.メシエ番号、3.NGC等の番号 上位3つまで
# 	prn = 2 : 天体名（例"Andromeda Galaxy"）、2.メシエ番号、3.NGC等の番号　上位2つまで
# 	prn = 1 : 天体名（例"Andromeda Galaxy"）、2.メシエ番号、3.NGC等の番号　上位1つ
# el : 楕円を描くNGCの最も暗いB.Mag
# boundary : 星座境界線
#	boundary=FALSE : 星座境界線を描かない
#	boundary=TRUE : 星座境界線を描く
# condata : 星座線
#	condata=FALSE : 洋風
#	condata=TRUE : 日本風
#   星座名はlocator関数もしくは上で定義したlocator2関数を使って座標をした位置に書く。
#
plotAstro <- function(image,starM=4,ngcM=14,Const="All",prn=1,el=12,boundary=FALSE,condata=FALSE){
require(sf)
require(jpeg) 
######################## 必要なデータの読み込み(csvファイルをダウンロードした場合) ########################
# メシエ天体と比較的見やすい天体のデータ
#messierPlusJ<- read.csv(file = "messierPlusJ.csv", header = T)
# 星(Hipparchus_major)
#hip_majorJ<- read.csv(file = "hip_majorJ.csv", header = T)
# NGC/IC
#NGC_lite <- read.csv(file = "NGC_lite.csv", header = T)
# 星座線
#constellation_lineJ <- read.csv(file = "constellation_lineJ.csv", header = T)
#constellation_lineJF <- read.csv(file = "constellation_lineJF.csv", header = T)
# 星座境界線
#boundaryline<- read.csv(file = "boundaryline.csv", header = T)
######################## 地図上にプロットする天体を抽出する ########################
# astroパッケージのread.fitshdrでwcsを読み込み、データフレームに変換。
hdr<- read.wcs(paste0(image,".wcs"))
width=as.numeric(hdr[hdr$key=="IMAGEW",2])
height=as.numeric(hdr[hdr$key=="IMAGEH",2])
# 画像範囲
area<- xysip2rd(x=c(0,width,width,0), y=c(0,0,height,height), header=hdr)
area<- rbind(area,area[1,])
# メシエ天体 プラスアルファ
messier<- inarea(messierPlusJ,area)
# hip_majorJ 
hip<- inarea(hip_majorJ,area)
# 指定した等級に関係なく表示する星（アルビレオなどにはPrn項に1を入れている。!is.na()）
hip <- hip[hip$Mag<=starM | !is.na(hip$Prn) ,]
# NGC
ngc<- inarea(NGC_lite,area)
if (ngcM != 100){
	ngc <- ngc[!is.na(ngc[,9]),]
	ngc <- ngc[ngc$B.Mag<=ngcM,]
}
# 星座線
if (!condata){
	line<- constellation_lineJ
} else {
	line<- constellation_lineJF
}
line<- unique(rbind(inarea(line,area,RA="RA1",Dec="Dec1"),inarea(line,area,RA="RA2",Dec="Dec2")))
if ("All" %in% Const){
	pline<- line
	} else {
	pline<- line[is.element(line$Constellation,Const),]
}
# 楕円を描く天体
# 中心部が画像上にないものは表示しない
plNGC<- inarea(NGC_lite,area)
plNGC<- plNGC[!is.na(plNGC[,6]),]
plNGC<- plNGC[!is.na(plNGC[,9]),]
plNGC <- plNGC[plNGC$B.Mag<=el,]
# 星座境界線
if (boundary){
# http://astro.starfree.jp/commons/constellation/boundary.html
	bline<- unique(rbind(inarea(boundaryline,area,RA="RA1",Dec="Dec1"),inarea(boundaryline,area,RA="RA2",Dec="Dec2")))
	posBD<- matrix(c(rdsip2xy(RA=bline$RA1,Dec=bline$Dec1, header=hdr),rdsip2xy(RA=bline$RA2,Dec=bline$Dec2, header=hdr)),nrow=nrow(bline))
}
######################## rd -> ピクセルxy ########################

posM<- rdsip2xy(RA=messier$RA,Dec=messier$Dec, header=hdr)
posN<- rdsip2xy(RA=ngc$RA,Dec=ngc$Dec, header=hdr)
posH<- rdsip2xy(RA=hip$RA,Dec=hip$Dec, header=hdr)
posZ<- matrix(c(rdsip2xy(RA=pline$RA1,Dec=pline$Dec1, header=hdr),rdsip2xy(RA=pline$RA2,Dec=pline$Dec2, header=hdr)),nrow=nrow(pline))
#
img <- readJPEG(paste0(image,".jpg")) 
#################### プロット ####################

# png("astro%02d.png",width=width,height=height,type = "cairo")
par(mar=rep(0,4),mfrow=c(1,1)) # 余白なしの設定
# (注意) ylim=c(height,0)
plot( 0,0, xlim=c(0,width), ylim=c(height,0), type="n", asp=1,axes=F,xlab="",ylab="",xaxs="i",yaxs="i")
# (注意) ybottom=height ytop=0
rasterImage(img, xleft=0, ybottom=height, xright=width, ytop=0)
#
#### メシエ天体＆その他登録した天体
if (nrow(messier) >= 1){
for (i in 1:nrow(messier)){
	if (prn >= 3){
		# 通称（common name ）ありの場合
		if (messier$CommonName[i]!=""){
			text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$CommonName[i],"  ",messier$Name[i],"(",messier$NGC[i],")"),
				col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
		}
		# 通称（common name ）なしの場合
		if (messier$CommonName[i]==""){
			text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$Name[i],"(",messier$NGC[i],")"),
				col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
			}
		}
	if (prn == 2){
		# 通称（common name ）ありの場合
		if (messier$CommonName[i]!=""){
			# メシエ番号あり
			if (messier$Name[i]!=""){
				text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$CommonName[i],"  ",messier$Name[i]),
					col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
				}
			# メシエ番号なし
			if (messier$Name[i]==""){
				text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$CommonName[i],"(",messier$NGC[i],")"),
					col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
				}
			}
		# 通称（common name ）なしの場合
		if (messier$CommonName[i]==""){
			text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$Name[i],"(",messier$NGC[i],")"),
				col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
			}
		}
	if (prn == 1){
		# 通称（common name ）ありの場合
		if (messier$CommonName[i]!=""){
			text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$CommonName[i]),
				col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
			}
		# 通称（common name ）なしの場合
		if (messier$CommonName[i]==""){
			# メシエ番号あり
			if (messier$Name[i]!=""){
				text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$Name[i]),
					col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
				}
			# メシエ番号なし
			if (messier$Name[i]==""){
				text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$NGC[i]),
				col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
				}
			}
		}
	}
  }
#### 星座線
if (nrow(posZ) >= 1){
for (i in 1:nrow(posZ)){
	segments(x0=posZ[i,1], y0=posZ[i,2], x1 =posZ[i,3], y1=posZ[i,4], col = "cyan",lwd=2)
  }
 }
#### NGC,IC
if (nrow(ngc) >= 1){
for (i in 1:nrow(ngc)){
	# messier表示した天体との２重表示を防ぐ
	if (!is.element(ngc$Name[i],messier$NGC)){
		text(x=posN[i,1],y=posN[i,2],labels=ngc$Name[i],col="green",pos=3,offset=0.5,cex=0.8)
	}
    }
  }
#### 星(hip)
if (nrow(hip) >= 1){
for (i in 1:nrow(hip)){
	# 星の通称ありの場合
	if (hip$Name[i] != ""){
		text(x=posH[i,1],y=posH[i,2],labels=hip$Name[i],col="yellow",pos=3,offset=0.5,cex=0.8)
		}
	# 星の通称なしの場合
	if (hip$Name[i] == ""){
		text(x=posH[i,1],y=posH[i,2],labels=paste(hip$Num[i],hip$Constellation[i]),col="yellow",pos=3,offset=0.5,cex=0.8)
		}
	}
  }
#### 楕円
# postAngがNAの場合も描きたい場合0を代入
# plNGC$PosAng[is.na(plNGC$PosAng)] <- 0	# NAのときには描かない場合はコメントアウトする
if (nrow(plNGC)!=0){
	theta=seq(-pi,pi,length=200)
	for (i in 1:nrow(plNGC)){
		cx=plNGC$RA[i]
		cy=plNGC$Dec[i]	
		a= plNGC$MajAx[i]/60	# MajAx
		b= plNGC$MinAx[i]/60	# MinAx
		t= plNGC$PosAng[i]*(pi/180)	# PosAng
		x=a*cos(theta)*cos(t)-b*sin(theta)+cx
		y=a*cos(theta)*sin(t)+b*cos(theta)+cy
		ellipse<- rdsip2xy(RA=x,Dec=y, header=hdr)
		lines(x=ellipse[,1],y=ellipse[,2],col="white")
	}
}
#### 星座境界線
if (boundary){
if (nrow(posBD) >= 1){
	for (i in 1:nrow(posBD)){
		segments(x0=posBD[i,1], y0=posBD[i,2], x1 =posBD[i,3], y1=posBD[i,4], col = "red",lwd=1,lty=2)
	}
    }
  }
}

#
# plotAstroの表示に日本語（NameJ列）を使うようにした関数
#
plotAstroJ <- function(image,starM=4,ngcM=14,Const="All",prn=1,el=12,boundary=FALSE,condata=FALSE){
require(sf)
require(jpeg) 
######################## 必要なデータの読み込み(csvファイルをダウンロードした場合) ########################
# メシエ天体と比較的見やすい天体のデータ
#messierPlusJ<- read.csv(file = "messierPlusJ.csv", header = T)
# 星(Hipparchus_major)
#hip_majorJ<- read.csv(file = "hip_majorJ.csv", header = T)
# NGC/IC
#NGC_lite <- read.csv(file = "NGC_lite.csv", header = T)
# 星座線
#constellation_lineJ <- read.csv(file = "constellation_lineJ.csv", header = T)
#constellation_lineJF <- read.csv(file = "constellation_lineJF.csv", header = T)
# 星座境界線
#boundaryline<- read.csv(file = "boundaryline.csv", header = T)
######################## 地図上にプロットする天体を抽出する ########################
# astroパッケージのread.fitshdrでwcsを読み込み、データフレームに変換。
hdr<- read.wcs(paste0(image,".wcs"))
width=as.numeric(hdr[hdr$key=="IMAGEW",2])
height=as.numeric(hdr[hdr$key=="IMAGEH",2])
# 画像範囲
area<- xysip2rd(x=c(0,width,width,0), y=c(0,0,height,height), header=hdr)
area<- rbind(area,area[1,])
# メシエ天体 プラスアルファ
messier<- inarea(messierPlusJ,area)
# hip_majorJ 
hip<- inarea(hip_majorJ,area)
# 指定した等級に関係なく表示する星（アルビレオなどにはPrn項に1を入れている。!is.na()）
hip <- hip[hip$Mag<=starM | !is.na(hip$Prn) ,]
# NGC
ngc<- inarea(NGC_lite,area)
if (ngcM != 100){
	ngc <- ngc[!is.na(ngc[,9]),]
	ngc <- ngc[ngc$B.Mag<=ngcM,]
}
# 星座線
if (!condata){
	line<- constellation_lineJ
} else {
	line<- constellation_lineJF
}
line<- unique(rbind(inarea(line,area,RA="RA1",Dec="Dec1"),inarea(line,area,RA="RA2",Dec="Dec2")))
if ("All" %in% Const){
	pline<- line
	} else {
	pline<- line[is.element(line$Constellation,Const),]
}
# 楕円を描く天体
# 中心部が画像上にないものは表示しない
plNGC<- inarea(NGC_lite,area)
plNGC<- plNGC[!is.na(plNGC[,6]),]
plNGC<- plNGC[!is.na(plNGC[,9]),]
plNGC <- plNGC[plNGC$B.Mag<=el,]
# 星座境界線
if (boundary){
# http://astro.starfree.jp/commons/constellation/boundary.html
	bline<- unique(rbind(inarea(boundaryline,area,RA="RA1",Dec="Dec1"),inarea(boundaryline,area,RA="RA2",Dec="Dec2")))
	posBD<- matrix(c(rdsip2xy(RA=bline$RA1,Dec=bline$Dec1, header=hdr),rdsip2xy(RA=bline$RA2,Dec=bline$Dec2, header=hdr)),nrow=nrow(bline))
}
######################## rd -> ピクセルxy ########################
posM<- rdsip2xy(RA=messier$RA,Dec=messier$Dec, header=hdr)
posN<- rdsip2xy(RA=ngc$RA,Dec=ngc$Dec, header=hdr)
posH<- rdsip2xy(RA=hip$RA,Dec=hip$Dec, header=hdr)
posZ<- matrix(c(rdsip2xy(RA=pline$RA1,Dec=pline$Dec1, header=hdr),rdsip2xy(RA=pline$RA2,Dec=pline$Dec2, header=hdr)),nrow=nrow(pline))
#
img <- readJPEG(paste0(image,".jpg")) 
#################### プロット ####################
# png("astro%02d.png",width=width,height=height,type = "cairo")
par(mfrow=c(1,1),mar=rep(0,4)) # 余白なしの設定
# (注意) ylim=c(height,0)
plot( 0,0, xlim=c(0,width), ylim=c(height,0), type="n", asp=1,axes=F,xlab="",ylab="",xaxs="i",yaxs="i")
# (注意) ybottom=height ytop=0
rasterImage(img, xleft=0, ybottom=height, xright=width, ytop=0)
#### メシエ天体＆その他登録した天体
if (nrow(messier) >= 1){
for (i in 1:nrow(messier)){
	if (prn >= 3){
		# 通称（common name ）ありの場合
		if (messier$CommonNameJ[i]!=""){
			text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$CommonNameJ[i],"  ",messier$Name[i],"(",messier$NGC[i],")"),
				col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
		}
		# 通称（common name ）なしの場合
		if (messier$CommonNameJ[i]==""){
			text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$Name[i],"(",messier$NGC[i],")"),
				col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
			}
		}
	if (prn == 2){
		# 通称（common name ）ありの場合
		if (messier$CommonNameJ[i]!=""){
			# メシエ番号あり
			if (messier$Name[i]!=""){
				text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$CommonNameJ[i],"  ",messier$Name[i]),
					col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
				}
			# メシエ番号なし
			if (messier$Name[i]==""){
				text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$CommonNameJ[i],"(",messier$NGC[i],")"),
					col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
				}
			}
		# 通称（common name ）なしの場合
		if (messier$CommonNameJ[i]==""){
			text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$Name[i],"(",messier$NGC[i],")"),
				col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
			}
		}
	if (prn == 1){
		# 通称（common name ）ありの場合
		if (messier$CommonNameJ[i]!=""){
			text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$CommonNameJ[i]),
				col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
			}
		# 通称（common name ）なしの場合
		if (messier$CommonNameJ[i]==""){
			# メシエ番号あり
			if (messier$Name[i]!=""){
				text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$Name[i]),
					col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
				}
			# メシエ番号なし
			if (messier$Name[i]==""){
				text(x=posM[i,1],y=posM[i,2],labels=paste0(messier$NGC[i]),
				col="green",cex=messier$Size[i],pos=messier$Position[i],offset=messier$Offset[i])
				}
			}
		}
      }
}
#### 星座線
if (nrow(posZ) >= 1){
for (i in 1:nrow(posZ)){
	segments(x0=posZ[i,1], y0=posZ[i,2], x1 =posZ[i,3], y1=posZ[i,4], col = "cyan",lwd=2)
  }
}
#### NGC,IC
if (nrow(ngc) >= 1){
for (i in 1:nrow(ngc)){
# messier表示した天体との２重表示を防ぐ
	if (!is.element(ngc$Name[i],messier$NGC)){
		text(x=posN[i,1],y=posN[i,2],labels=ngc$Name[i],col="green",pos=3,offset=0.5,cex=0.8)
	}
  }
}
#### 星(hip)
if (nrow(hip) >= 1){
for (i in 1:nrow(hip)){
# 星の通称ありの場合
	if (hip$NameJ[i] != ""){
		text(x=posH[i,1],y=posH[i,2],labels=hip$NameJ[i],col="yellow",pos=3,offset=0.5,cex=0.8)
		}
# 星の通称なしの場合
	if (hip$NameJ[i] == ""){
		text(x=posH[i,1],y=posH[i,2],labels=paste(hip$Num[i],hip$Constellation[i]),col="yellow",pos=3,offset=0.5,cex=0.8)
		}
  }
}
#### 楕円
# postAngがNAの場合も描きたい場合0を代入
# plNGC$PosAng[is.na(plNGC$PosAng)] <- 0	# NAのときには描かない場合はコメントアウトする
if (nrow(plNGC)!=0){
	theta=seq(-pi,pi,length=200)
	for (i in 1:nrow(plNGC)){
		cx=plNGC$RA[i]
		cy=plNGC$Dec[i]	
		a= plNGC$MajAx[i]/60	# MajAx
		b= plNGC$MinAx[i]/60	# MinAx
		t= plNGC$PosAng[i]*(pi/180)	# PosAng
		x=a*cos(theta)*cos(t)-b*sin(theta)+cx
		y=a*cos(theta)*sin(t)+b*cos(theta)+cy
		ellipse<- rdsip2xy(RA=x,Dec=y, header=hdr)
		lines(x=ellipse[,1],y=ellipse[,2],col="white")
	}
}
#### 星座境界線
if (boundary){
if (nrow(posBD) >= 1){
	for (i in 1:nrow(posBD)){
		segments(x0=posBD[i,1], y0=posBD[i,2], x1 =posBD[i,3], y1=posBD[i,4], col = "red",lwd=1,lty=2)
	}
    }
  }
}
