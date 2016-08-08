#source("C:/temp/dropbox/2015sut-io/0_LookupFiles/0_Initializations.R")
#library(Hmisc)
#library(reshape)
#library(abind)

## ## moved to global.R
## library(ggplot2)
## library(grid)

## thispath <- "C:/Temp/Dropbox/2015sut-io/6_Application_CO2_ENVstringency/"
## thisanalysis <- paste0(thispath,"countryanalysis/")

## ## moved to global.R
## load("C:/Temp/Dropbox/2015sut-io/1_datasources/10_IEA/CO2/Consumptionbased/Rdata/FDCO2_byemind_MtCO2.Rdata")
## ## dim(FDCO2_byemind_MtCO2)
## ## sum(FDCO2_byemind_MtCO2[17,1:62,1,11])
## load("C:/Temp/Dropbox/2015sut-io/1_datasources/10_IEA/CO2/Consumptionbased/Rdata/FDCO2_BSCI.Rdata")
## ## dim(FDCO2_BSCI)
## ## sum(FDCO2_BSCI[17,1:62,1,11,1:34])

## ## move to globa.R and prepend "barchart_"
## years <- dimnames(FDCO2_byemind_MtCO2)[[1]]; noyears <- length(years)
## countries <- dimnames(FDCO2_byemind_MtCO2)[[2]]; nocou <- length(countries)
## industries <- dimnames(FDCO2_byemind_MtCO2)[[3]]; noind <- length(industries)

## moved to global.R
## temp <- read.table(paste0(thisanalysis,"AnnexIcountries.csv"),sep=",")
## AnnexI <- as.matrix(temp[,2])
## rownames(AnnexI) <- temp[,1]
## regions <- c("non-Annex I","Annex I","domestic")


######################################################################
# Analysis of individual countries
######################################################################

barchart_cou <- 11 # USA 34, China 39

par(mfrow=c(2,2))
COUanalysis <- emindcou_totdomFD(data = data_barchart$FDCO2_byemind_MtCO2, cou = barchart_cou, noyears = barchart_noyears) # Germany
## str(COUanalysis)
lapply(COUanalysis, barplot)

##============================
## Germany
##============================
## c=11
# after visual analysis of the graphs, we have
# individual industries of interest
manufserv <- c(2,8,10,11,12,21,23)
energy <- c(7,19)
# remaining industries
othmanuf <- c(1,3:6,9,13:18)
othserv <- c(20,22,24:34)
Farben <-c("darkblue","turquoise","lightblue","darkgreen","green","lightgreen","darkred","red","pink",
           "chocolate4","orange","sandybrown","darkorchid4","darkorchid1","plum","seagreen4","seagreen2","paleturquoise",
           "sienna","sienna1","sienna3")

## COUanalysis <- DEUanalysis

## filename <- paste0(thisanalysis,countries[c],"_byemitreg_ind_dynamic.pdf")
## pdf(filename, width=11.69, height=8.27) # A4 landscape

par(mfrow=c(1,2))
i=2;
graphsdata <-
    cbind(
        COUanalysis[[3]][,energy[i]],
        COUanalysis[[2]][,energy[i]],
        COUanalysis[[1]][,energy[i]]
        )

i=1;
graphsdata <-
    cbind(
        graphsdata,
        COUanalysis[[3]][,energy[i]],
        COUanalysis[[2]][,energy[i]],
        COUanalysis[[1]][,energy[i]]
        )

barplot(
    t(graphsdata),
    col=Farben[7:12],
    legend=
        paste0(
            rep(
                barchart_industries[energy[2:1]],
                each=length(regions)
                ), " ",
            rep(regions,length(energy))
            )
    )

## dev.off()


######################################################################
# Analysis of FD industries in individual countries
######################################################################

barchart_selind <- "TOT"
## total final demand FDCO2_byemind_MtCO2
COUanalysis <- emindcou_totdomFD(data = data_barchart$FDCO2_byemind_MtCO2, cou = barchart_cou, noyears = barchart_noyears) # Germany

COUanalysisTOT <-
    emindcou_inddomFD(
        data = data_barchart$FDCO2_byemind_MtCO2
       ,
        cou = barchart_cou
       ,
        selind = barchart_selind
       ,
        noyears = barchart_noyears
       ,
        nocou = barchart_nocou
       ,
        noind = barchart_noind
       ,
        countries = barchart_countries
       ,
        industries = barchart_industries
        )

## DEUanalysisTOT <- emindcou_inddomFD(11,FDCO2_byemind_MtCO2,selind)
## USAanalysisTOT <- emindcou_inddomFD(34,FDCO2_byemind_MtCO2,selind)
## CHNanalysisTOT <- emindcou_inddomFD(39,FDCO2_byemind_MtCO2,selind)
## POLanalysisTOT <- emindcou_inddomFD(25,FDCO2_byemind_MtCO2,selind)
## FRAanalysisTOT <- emindcou_inddomFD(10,FDCO2_byemind_MtCO2,selind)
## KORanalysisTOT <- emindcou_inddomFD(19,FDCO2_byemind_MtCO2,selind)

## selind <- 16 # Motor vehicles
## FDCO2_byemind_MtCO2_ind34 <- FDCO2_BSCI[,,,,selind]/1000
## DEUanalysis34 <- emindcou_inddomFD(11,FDCO2_byemind_MtCO2_ind34,selind) # Germany
## USAanalysis34 <- emindcou_inddomFD(34,FDCO2_byemind_MtCO2_ind34,selind) #
## CHNanalysis34 <- emindcou_inddomFD(39,FDCO2_byemind_MtCO2_ind34,selind) #
## POLanalysis34 <- emindcou_inddomFD(25,FDCO2_byemind_MtCO2_ind34,selind) #
## FRAanalysis34 <- emindcou_inddomFD(10,FDCO2_byemind_MtCO2_ind34,selind) #
## KORanalysis34 <- emindcou_inddomFD(19,FDCO2_byemind_MtCO2_ind34,selind) #

## selind <- 4 # Textiles
## FDCO2_byemind_MtCO2_ind34 <- FDCO2_BSCI[,,,,selind]/1000
## DEUanalysis34 <- emindcou_inddomFD(11,FDCO2_byemind_MtCO2_ind34,selind) # Germany
## USAanalysis34 <- emindcou_inddomFD(34,FDCO2_byemind_MtCO2_ind34,selind) #
## CHNanalysis34 <- emindcou_inddomFD(39,FDCO2_byemind_MtCO2_ind34,selind) #
## POLanalysis34 <- emindcou_inddomFD(25,FDCO2_byemind_MtCO2_ind34,selind) #
## FRAanalysis34 <- emindcou_inddomFD(10,FDCO2_byemind_MtCO2_ind34,selind) #
## KORanalysis34 <- emindcou_inddomFD(19,FDCO2_byemind_MtCO2_ind34,selind) #

## selind <- 24 # Post and Telecommunication
## FDCO2_byemind_MtCO2_ind34 <- FDCO2_BSCI[,,,,selind]/1000
## DEUanalysis64 <- emindcou_inddomFD(11,FDCO2_byemind_MtCO2_ind34,selind) # Germany
## USAanalysis64 <- emindcou_inddomFD(34,FDCO2_byemind_MtCO2_ind34,selind) #
## CHNanalysis64 <- emindcou_inddomFD(39,FDCO2_byemind_MtCO2_ind34,selind) #
## POLanalysis64 <- emindcou_inddomFD(25,FDCO2_byemind_MtCO2_ind34,selind) #
## FRAanalysis64 <- emindcou_inddomFD(10,FDCO2_byemind_MtCO2_ind34,selind) #
## KORanalysis64 <- emindcou_inddomFD(19,FDCO2_byemind_MtCO2_ind34,selind) #

## selind <- 14 # Computer, electronic and optical equipment
## FDCO2_byemind_MtCO2_ind34 <- FDCO2_BSCI[,,,,selind]/1000
## DEUanalysis14 <- emindcou_inddomFD(11,FDCO2_byemind_MtCO2_ind34,selind) # Germany
## USAanalysis14 <- emindcou_inddomFD(34,FDCO2_byemind_MtCO2_ind34,selind) #
## CHNanalysis14 <- emindcou_inddomFD(39,FDCO2_byemind_MtCO2_ind34,selind) #
## POLanalysis14 <- emindcou_inddomFD(25,FDCO2_byemind_MtCO2_ind34,selind) #
## FRAanalysis14 <- emindcou_inddomFD(10,FDCO2_byemind_MtCO2_ind34,selind) #
## KORanalysis14 <- emindcou_inddomFD(19,FDCO2_byemind_MtCO2_ind34,selind) #

## selind <- 28 # Computer and related activities
## FDCO2_byemind_MtCO2_ind34 <- FDCO2_BSCI[,,,,selind]/1000
## DEUanalysis28 <- emindcou_inddomFD(11,FDCO2_byemind_MtCO2_ind34,selind) # Germany
## USAanalysis28 <- emindcou_inddomFD(34,FDCO2_byemind_MtCO2_ind34,selind) #
## CHNanalysis28 <- emindcou_inddomFD(39,FDCO2_byemind_MtCO2_ind34,selind) #
## POLanalysis28 <- emindcou_inddomFD(25,FDCO2_byemind_MtCO2_ind34,selind) #
## FRAanalysis28 <- emindcou_inddomFD(10,FDCO2_byemind_MtCO2_ind34,selind) #
## KORanalysis28 <- emindcou_inddomFD(19,FDCO2_byemind_MtCO2_ind34,selind) #


## load("C:/Temp/Dropbox/2015sut-io/1_datasources/10_IEA/CO2/Rdata/DATA.co2inttotal.Rdata")
## dim(DATA.co2inttotal)
## #[1] 17 69 34
## barplot(DATA.co2inttotal[c(1,17),c("DEU","USA","CHN"),"40T41"],beside=TRUE)

