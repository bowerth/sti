## install.packages("brew")
## install.packages("xlsx")

require(brew)
require(knitr)
require(markdown)
require(xlsx)
require(ggplot2)
require(reshape2)
library(RColorBrewer)
library(gridExtra)

########################################
## prepare EXGR_VS_BSCI data in sqlite
########################################
## data from OECD.Stat
########################################
path.data <- file.path("~", "Downloads")
filename <- "OECD-WTO_TiVA_"

## ## install.packages('RSQLite')
## library(RSQLite)
## ##
## unlink(dbfile.bsci) # deletes files
## dbfile.bsci <- file.path(path.data, "EXGR_VS_BSCI.db")
## diskdb <- dbConnect(SQLite(), dbname = dbfile.bsci)
## ##
## data.bsci.all <- NULL
## for (year in c(1995, 2009)) {
##   data.bsci.year <- read.csv(file.path(path.data, paste0("OECD-WTO_Origin_of_Value_Added_", year, '.csv')), header=F, sep='|')
##   names(data.bsci.year) <- c("indic", "year", "srcreg4", "srcindgrp1", "cou", "ind", "value")
##   data.bsci.year <- data.bsci.year[data.bsci.year$indic=="EXGR_VA_BSCI_SH",]
##   ## data.bsci.year <- data.bsci.year[data.bsci.year$ind=="34T35",]
##   data.bsci.year$year <- as.numeric(data.bsci.year$year)
##   data.bsci.year$value <- as.numeric(data.bsci.year$value)
##   data.bsci.all <- rbind(data.bsci.all, data.bsci.year)
## }
## ##
## ok <- dbWriteTable(diskdb, "TIVAPUB_CUBEB_EXPINDwtSH", data.bsci.all, row.names = FALSE, overwrite = TRUE)
## ## cleanup
## dbDisconnect(diskdb)
## ##
## ind <- "30T33"
## query <- paste0('SELECT cou, ind, indic, SUM(value) AS value, srcindgrp1, srcreg4, year FROM TIVAPUB_CUBEB_EXPINDwtSH WHERE ind = \'', ind, '\' AND indic = \'EXGR_VA_BSCI_SH\' AND year IN (1995,2009) GROUP BY cou, ind, indic, srcindgrp1, srcreg4, year')
##
## EXGR_VA_BSCI <- dbGetQuery(dbConnect("SQLite", dbname=dbfile.bsci), query)

## load(file.path(path, "data", "EXGR_VA_BSCI.R"))
## ##
## indic <- "EXGR_VA_BSCI"
## nameyear <- c(1995, 2009)
## ind <- "30T33"
## ##
## names(EXGR_VA_BSCI) <- tolower(names(EXGR_VA_BSCI))
## EXGR_VA_BSCI_ind <- EXGR_VA_BSCI[EXGR_VA_BSCI$indic==indic &
##                                  EXGR_VA_BSCI$year%in%nameyear &
##                                  EXGR_VA_BSCI$ind==ind,]
## ## EXGR_VA_BSCI_ind <- EXGR_VA_BSCI_ind[,colnames(EXGR_VA_BSCI_ind)!="value"] # not necessary because aggregate "share" below
## EXGR_VA_BSCI_ind <- aggregate(EXGR_VA_BSCI_ind$share, by = list(EXGR_VA_BSCI_ind$cou, EXGR_VA_BSCI_ind$srcindgrp1, EXGR_VA_BSCI_ind$srcreg4, EXGR_VA_BSCI_ind$year), "sum")
## names(EXGR_VA_BSCI_ind) <- c("cou", "srcindgrp1", "srcreg4", "year", "share")

########################################
## data from ASAP5 and SQL Server
########################################

path.data <- 'I:/I-O/2013sut-io/icio/indic2013-05-17/'
filename <- 'indic_oecdwto_cubeAC'

## Load data for chart 4 from SQL
connection <- odbcDriverConnect(connection = "SERVER=VS-GEN-SQL-5;DRIVER=SQL Server;DATABASE=STANBTD", readOnlyOptimize = TRUE)

EXGR_VA_BSCI_ind <- sqlQuery(connection, "SELECT Cou, Ind, Indic, SUM(SHARE) AS SHARE, SrcIndgrp1, srcreg4, Year FROM TIVAPUB_CUBEB_EXPINDwtSH WHERE Ind = '30T33' AND Indic = 'EXGR_VA_BSCI' AND Year IN (1995,2009) GROUP BY Cou, Ind, Indic, SrcIndgrp1, srcreg4, Year")
## EXGR_VA_BSCI <- bcpRead(table = "STANBTD.dbo.TIVAPUB_CUBEB_EXPINDwtSH", server = "VS-GEN-SQL-5")
## save(EXGR_VA_BSCI, file = "C:\\Users\\werth_b\\Downloads\\EXGR_VA_BSCI.R")
names(EXGR_VA_BSCI_ind) <- tolower(names(EXGR_VA_BSCI_ind))

################
## begin
################

path <- file.path(dbpath, "GitHub", "jekyll", "industry", "extras", "brew_report_icio_tiva")
path.Rmd <- file.path(path, "Rmd") # Rnw and tex files are created here
path.rmd <- file.path(path, "md")
## path.html <- file.path(path, "html")
setwd(path)

nameind <- read.csv(file.path(path, "data", "nameind.csv"))
namereg <- read.csv(file.path(path, "data", "namereg.csv"))
oecd <- namereg$cou[namereg$inoecd==1]; oecd <- as.character(oecd[order(oecd)])
eu27 <- namereg$cou[namereg$region=='EU27']; eu27 <- as.character(eu27[order(eu27)])
americas <- namereg$cou[namereg$region=='Americas']; americas <- as.character(americas[order(americas)])
eastasia <- namereg$cou[namereg$region=='East Asia']; eastasia <- as.character(eastasia[order(eastasia)])
asean <- namereg$cou[namereg$region=='ASEAN']; asean <- as.character(asean[order(asean)])
asiapacific <- namereg$cou[namereg$region=='Ot.ASIA-PACIFIC']; asiapacific <- as.character(asiapacific[order(asiapacific)])
othereu27 <- namereg$cou[namereg$region=='OtherEUR']; othereu27 <- as.character(othereu27[order(othereu27)])
restofworld <- namereg$cou[namereg$region=='Rest of the World']; restofworld <- as.character(restofworld[order(restofworld)])

year <- 1995
## load data for country notes
if(!'data1995'%in%ls()) {
    data1995 <- read.csv(file.path(path.data, paste0(filename, 1995, '.csv')), header=F, sep='|')
    names(data1995) <- c('indic','year','cou','par','ind','value')
    data1995$year <- as.numeric(data1995$year)
    data1995$value <- as.numeric(data1995$value)
    data1995 <- data1995[data1995$cou%in%namereg$cou & data1995$par%in%union('Total',namereg$cou),]    ## data1995 <- data1995[data1995$cou%in%namereg$cou[namereg$in40==1] & data1995$par%in%union('Total',namereg$cou[namereg$in40==1]),]
}

year <- 2009
## load data for country notes
if(!'data2009'%in%ls()) {
  data2009 <- read.csv(file.path(path.data, paste0(filename, 2009, '.csv')), header=F, sep='|')
  names(data2009) <- c('indic','year','cou','par','ind','value')
  data2009$year <- as.numeric(data2009$year)
  data2009$value <- as.numeric(data2009$value)
  data2009 <- data2009[data2009$cou%in%namereg$cou & data2009$par%in%union('Total',namereg$cou),]
  ## data2009 <- data2009[data2009$cou%in%namereg$cou[namereg$in40==1] & data2009$par%in%union('Total',namereg$cou[namereg$in40==1]),]
}

cntext <- read.xlsx(file = file.path(path, "text", "CN_custom_text.xlsx"), sheetIndex=1, header=T)

## x='CHN'
create.report <- function(x
                          ,
                          prepend = "report_icio_tiva_"
                          ){
  ## rnw.file <- paste0(path.temp, prepend, x, ".Rnw")
  Rmd.file <- file.path(path.Rmd, paste0(prepend, x, ".Rmd"))
  rmd.file <- file.path(path.rmd, paste0(prepend, x, ".rmd")) # .md doesn't convert hash tags
  brew(file = file.path(path, "report_icio_tiva.brew"), output = Rmd.file)
  ## knit(input=rnw.file, output=paste0(path.temp, prepend, x, ".tex"))
  knit(input = Rmd.file, output = rmd.file)
  ## markdownToHTML(file = md.file, output = file.path(path, paste0(prepend, x, ".html")))
  ## latex.file <- paste0(path.temp, prepend, x, ".tex")
  ## texi2pdf(latex.file, clean = TRUE, quiet = TRUE)
  ## out.file <- paste0(prepend, x, ".pdf")
  out.file <- paste0(prepend, x, ".rmd")
  return(out.file)
}


Leiden
Anxiety
item response theory
computer assisted testing
mobile app developer
scientific proof
patient response measurement
USA federal health
item banks
anxiety, depression, pain, living satisfaction, sleep disturbance
put into shadowcat (random set of questions) 20-40 questions 
1000 
1000 control

## modify scientific notation
options(scipen=8)
axis.text.size=12
legend.text.size=14

## coulist <- c("NLD")
coulist <- sample(STAN.COU[["OECD"]], 5)
coulist <- c("AUT", "DEU", "ESP", "IRL", "USA")
seeds <- as.character(coulist)

## ## package data
## ## ls()
## ## h(data2009)
## ## h(data1995)
## icioIndic_data <- rbind(data2009, data1995)
## ## nrow(icioIndic_data)
## icioIndic_data_bsci <- EXGR_VA_BSCI_ind

## ## h(coulist)
## ## h(namereg)
## ## h(cntext)
## ## end package data

results <- sapply(seeds, create.report)
##
for (file in list.files(file.path(path, "rmd"))) {
  file.copy(from = file.path(path, "rmd", file), to = file.path(dbpath, "GitHub", "jekyll", "industry", file), overwrite = TRUE)
}
##
if (Sys.info()["sysname"]=="Windows") {
    system(paste0('xcopy "', file.path(path, "figures", "report_icio_tiva"), '" "', file.path(dbpath, "GitHub", "jekyll", "industry", "figures", "report_icio_tiva"), '" /e /Y'))
} else {
    system(paste('cp -r', file.path(path, "figures", "report_icio_tiva"), file.path(dbpath, "GitHub", "jekyll", "industry", "figures")))
}


#########################
## include menus
#########################
cou.label <- STAN.COUEN[STAN.COUEN$cou%in%coulist,]
cat(paste0('<li><a href="report_icio_tiva_', cou.label[,1], '.html">', cou.label[,2], '</a></li>', '\n'))


## #########################
## ## test code scripts
## #########################
## cat(paste0('source(file.path( path, "code", "', list.files(file.path(path, "code")), '"))\n'))
## source(file.path( path, "code", "figure1.R"))
## source(file.path( path, "code", "figure2b.R"))
## ##
## source(file.path( path, "code", "figure3.R")) # Error in Ops.factor(nameind$ind, data3$ind[!data3$ind == "Total"][i]) (from figure3.R#44) : level sets of factors are different
## source(file.path( path, "code", "figure4.R")) # Error in eval(expr, envir, enclos) (from figure4.R#1) : object 'EXGR_VA_BSCI' not found
## source(file.path( path, "code", "figure5b.R"))
## source(file.path( path, "code", "figure6b.R"))
## source(file.path( path, "code", "figure7.R"))
## source(file.path( path, "code", "figure8.R"))
## source(file.path( path, "code", "figure9b.R"))
