# source("C:/Users/cimper_a/Dropbox/BTDIxE/R/script/ScoreboardChapter5.r")

# source("I:/I-O/2015sut-io/0_LookupFiles/0_Initializations.R")
# pathindicdata <- "C:/Temp/Dropbox/ICIO2015/indicators/Rdata/"
# pathgraphs <- "//FS-CH-1.main.oecd.org/Users4/Wiebe_K/Scoreboard 2015/Rfiles/TiVAChapter/"

if (tolower(Sys.info()[["user"]])=="cimper_a") {
  dbpath <- file.path("C:", "Users", "cimper_a", "Dropbox")
} else if (Sys.info()[["user"]]=="yamano_n") {
  dbpath <- file.path("C:", "Temp", "Dropbox")
}

## replace with dbpath:
## - C:/Users/cimper_a/LocalData/
## setwd("I:/I-O/2015sut-io/");
## setwd(file.path("//ASAP5", "STI", "Progs", "STAN", "I-O"))

## system(paste("sublime_text", file.path(dbpath, "BTDIxE", "R", "script", "0_Initializations.R")))
source(file.path(dbpath, "BTDIxE", "R", "script", "0_Initializations.R"))
## pathindicdata <- "C:/Users/cimper_a/Dropbox/ICIO2015/indicators/Rdata/"
pathgraphs <- file.path(dbpath, "BTDIxE", "R", "chart", "TiVAChapter")
## pathgraphs <- file.path("C:", "Users", "yamano_n", "Downloads", "chart_test")
pathlists <-  file.path(dbpath, "BTDIxE", "R", "list")


# selcou <- c(OECDBRIICS,nocou+1)
# counamescharts <- Reg_Label[selcou]
# partner_reg <- Reg_Label[73:77]


# 5.5.1 Trade linkages in global value chains, 2011
# Chord Network
# Chords represent bi-directional trade flows.
# install.packages("circlize")
library(circlize)
#http://cran.r-project.org/web/packages/circlize/circlize.pdf

## preset palettes
#install.packages("RColorBrewer")
# library(RColorBrewer)
# display.brewer.all()
#detach("package:RColorBrewer", unload = TRUE)
## interpolate colors




## get information for debug
#sessionInfo()

## ## add colors to new countries in bilat data (2014 countries)
## countryorder <- read.table(file.path(pathlists, "coutryorderchordchart.csv"),header=TRUE,sep=",")
## ## chartdata.csv <- read.csv(file.path("C:", "Users", "cimper_a", "LocalData", "R", "data", paste0("bilat2014.csv")))
## ## chartdata.csv <- read.csv(file.path(dbpath, "BTDIxe", "R", "data", paste0("bilat2014.csv")))
## ## chose file with more rowcountries
## chartdata.csv <- read.csv(file.path(dbpath, "BTDIxe", "R", "data", paste0("bilat2000_AC.csv")))
## ## chartdata.csv <- read.csv(file.path(dbpath, "BTDIxe", "R", "data", paste0("bilat2014_AC.csv")))
## rownames(chartdata.csv) <- chartdata.csv[ , 1]
## chartdata.csv <- chartdata.csv[ , -1]
## chartdata.csv.mat <- as.matrix(chartdata.csv)
## chartdata.csv.mat[is.na(chartdata.csv.mat)] <- 0
## chorddata.csv <- chartdata.csv.mat
## ##
## namecou <- sort(union(rownames(chorddata.csv), colnames(chorddata.csv)))
## missingcou <- setdiff(namecou, countryorder$cou)
## missingcou.df <-
## data.frame(cou=missingcou,
##            ZEUR = rep(0, length(missingcou)),
##            ZASI = rep(0, length(missingcou)),
##            NAFTA = rep(0, length(missingcou)),
##            ZOTH = rep(0, length(missingcou)),
##            ZSCA = rep(0, length(missingcou)),
##            farben = rep("grey", length(missingcou))
##           )
## write.csv(missingcou.df, file = file.path(pathlists, "coutryorderchordchart_add.csv"), row.names = FALSE)
## ## append to xlsx file by hand, save, save as csv, reload color after change

countryorder <- read.table(file.path(pathlists, "coutryorderchordchart.csv"),header=TRUE,sep=",")

## ## Excel colors - or color hex codes: http://www.w3schools.com/tags/ref_colormixer.asp
## ## obtain Excel colors: 1) save as html 2) open [bookname]_files folder 3) open stylesheet.css
## ## 4) find background color in cell reference
## ## OECD.Graph w:\office2010\OECDGraph\OECD.Graph.xlam
## color.excel <-
## list(blue="#4F81BD",
##      red="#C0504D", # this is dark red
##      green="#9BBB59",
##      purple="#62388C", # call yellow orange
##      grey="grey")

## ## custom palette of 6 blues
## blue1 = rgb(red = 94, green = 169, blue = 222, maxColorValue = 255)
## blue2 = rgb(red = 131, green = 210, blue = 227, maxColorValue = 255)
## blue3 = rgb(red = 0, green = 170, blue = 204, maxColorValue = 255)
## blue4 = rgb(red = 127, green = 168, blue = 217, maxColorValue = 255)
## blue5 = rgb(red = 31, green = 73, blue = 125, maxColorValue = 255)
## blue6 = rgb(red = 0, green = 137, blue = 208, maxColorValue = 255)
## color.excel <-
## list(blue = blue1,
##      red = blue3, # this is dark red
##      green = blue5,
##      purple = blue6, # call yellow orange
##      grey = "grey")

## theme colors
blue = rgb(red = 0, green = 32, blue = 96, maxColorValue = 255)
# red = rgb(red = 222, green = 25, blue = 32, maxColorValue = 255)
# cyan = rgb(red = 0, green = 176, blue = 204,  maxColorValue = 255)
 orange = rgb(red = 245, green = 130, blue = 33,  maxColorValue = 255)
#brown = rgb(red = 150, green = 60, blue = 45,  maxColorValue = 255)
green = rgb(red = 73, green = 185, blue = 88, maxColorValue = 255)
purple = rgb(red = 139, green = 115, blue = 179, maxColorValue = 255)

color.excel <-
list(blue = blue,
     red = orange, # this is dark red
     green = green,
     purple = purple, # call yellow orange
     grey = "grey")


# farben <- c(as.character(countryorder$farben),'darkgrey')
# names(farben) <- rownames(chorddata)

# farben <- c(as.character(countryorder$farben),'darkgrey')\
# f <- 8
countryorder$farben <- as.character(countryorder$farben)
for (f in seq(along=countryorder$farben)) {
  countryorder$farben[f] <- color.excel[[countryorder$farben[f]]]
}
farben <- c(as.character(countryorder$farben))
# names(farben) <- rownames(chorddata.csv)
names(farben) <- as.character(countryorder$cou)
## length(farben)


#rowrow <- list("RoW",0,0,0,0,0,"darkgrey")
#countryorder <- rbind(countryorder,rowrow)

#indicname <- "EXGR"
#load(paste0(pathindicdata,indicname,".Rdata"))
#chartdata <- array(data=0,dim=c(length(OECDBRIICS)+1,length(OECDBRIICS)+1)) # empty array
#dimnames(chartdata) <- list(c(Reg_Label[OECDBRIICS],"RoW"),c(Reg_Label[OECDBRIICS],"RoW")) # naming
#chartdata[1:length(OECDBRIICS),1:length(OECDBRIICS)] <- indic.EXGR["2011",OECDBRIICS, "CTOTAL",OECDBRIICS] # select 2011 and countries and industry
#tempdata <- indic.EXGR["2011",1:nocou, "CTOTAL",1:nocou]
#chartdata[1:length(OECDBRIICS),length(OECDBRIICS)+1] <- rowSums(tempdata)[OECDBRIICS] - rowSums(chartdata)[1:length(OECDBRIICS)]
#chartdata[length(OECDBRIICS)+1,1:length(OECDBRIICS)] <- colSums(tempdata)[OECDBRIICS] - colSums(chartdata)[1:length(OECDBRIICS)]
#write.table(chartdata,paste0(pathgraphs,"551_EXGR.csv"))
#chorddata1 <- chartdata[c(as.character(countryorder$cou),'RoW'),]
#chorddata <- chorddata1[,c(as.character(countryorder$cou),'RoW')]
# write.table(chorddata,paste0(pathgraphs,"551_EXGR_order.csv"))

## ############# ##
## load csv data ##
## ############# ##

# yr <- 2014

nameyear <- c(2000, 2014)
# nameyear <- c(2000)
couhubs <- c("DEU", "USA", "CHN", "JPN")
## dropcou <- c("MAR", "KAZ", "SVN", "TUN", "UKR", "BLR")
dropcou <- c("MAR", "KAZ", "SVN", "TUN", "UKR", "BLR", "NGA", "PAK", "ROU", "CRI", "GRC", "PRT", "TUR", "LUX", "ISR", "CHL")
# couhubs <- c("DEU", "USA", "CHN")
# couhubs <- c("CHN", "USA")
output.format <- "svg"
## output.format <- "html"
## output.format <- "pdf"
## write.data <- TRUE
write.data <- FALSE
## pathgraphs <- file.path(dbpath, "GitHub", "jekyll", "industry", "_includes", "rmarkdown_fragment")
## pathgraphs <- file.path(dbpath, "GitHub", "jekyll", "industry", "figures", "report_btdixe_score15")
## pathgraphs <- file.path(dbpath, "GitHub", "jekyll", "industry", "_site", "figures", "report_btdixe_score15")
## list.files(pathgraphs)
source(file.path(dbpath, "BTDIxE", "R", "script", "chord_bilat_source.R"))
