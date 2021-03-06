
## setwd(file.path(dbpath, "GitHub", "jekyll", "industry", "rmarkdown", "CO2tradeviz"))

## data linechart / co2tradeviz

## load packages
library(shiny)
library(shinydashboard)
library(ggplot2)

## load R data files
data_linechart <- new.env()                    # define new environment for data
## data_files <- list.files(file.path("data"))
data_files <- c("indic.EXGR_DCO2.Rdata", "indic.EXGR_DoverDFCO2.Rdata", "indic.EXGR_FCO2.Rdata", "indic.EXGR_netCO2.Rdata", "indic.FDCO2.Rdata")
## data_files <- data_files[!data_files %in% c("indic.EXGR_FCO2SH.Rdata", "indic.EXGR_DCO2SH.Rdata")]
sapply(file.path("data", data_files), load, envir = data_linechart)

data_linechart$indic.EXGR_DCO2_EXGR_FCO2 = data_linechart$indic.EXGR_DCO2 + data_linechart$indic.EXGR_FCO2

ui_dimnames <- dimnames(data_linechart[["indic.EXGR_DoverDFCO2"]])
names(ui_dimnames) <- c("year", "cou", "ind", "ptn")

indicatorlist <-
  list(
    "Share of domestic emissions in total emissions embodied in exports, %" = "indic.EXGR_DoverDFCO2",
    "Domestic emissions embodied in exports, million t" = "indic.EXGR_DCO2"
    ,
    "Foreign emissions embodied in exports, million t" = "indic.EXGR_FCO2",
    "Total emissions embodied in exports, million t" = "indic.EXGR_DCO2_EXGR_FCO2",
    "Emissions embodied in exports, net-exports, million t" = "indic.EXGR_netCO2",
    "Emissions embodied in domestic final demand, million t" = "indic.FDCO2"
    )

indicatortext <-
  list(
    "indic.EXGR_DCO2" = "EXGR_DCO2: country = exporter, industry = exporting industry, partner = importing country",
    "indic.EXGR_DoverDFCO2" = "EXGR_DoverDFCO2: country = exporter, industry = exporting industry, partner = importing country",
    "indic.EXGR_FCO2" = "EXGR_FCO2: country = exporter, industry = exporting industry, partner = importing country",
    "indic.EXGR_DCO2_EXGR_FCO2" = "EXGR_DCO2+EXGR_FCO2: country = exporter, industry = exporting industry, partner = importing country",
    "indic.EXGR_netCO2" = "EXGR_netCO2, country = exporter, industry = exporting industry, partner = importing country",
    "indic.FDCO2" = "FDCO2: country = emitting country, industry = emitting industry, partner = final demand country"
    )


## barchart (countryanalysis)

## load packages
library(grid)
library(scales)

## load Rdata

##   https://www.dropbox.com/s/zpbqds591d9h322/FDCO2_BSCI.Rdata?dl=0
## Dropbox/2015sut-io/1_datasources/10_IEA/CO2/Consumptionbased/Rdata/FDCO2_byemind_MtCO2.Rdata
##   https://www.dropbox.com/s/kqsrhpw2sp0ewxh/FDCO2_byemind_MtCO2.Rdata?dl=0
## Dropbox/2015sut-io/1_datasources/10_IEA/CO2/Consumptionbased/Rdata/FDCO2_BSCI.Rdata

data_barchart <- new.env()           # define new environment for data
data_files <- c("FDCO2_byemind_MtCO2.Rdata")
sapply(file.path("data", data_files), load, envir = data_barchart)

barchart_years <- dimnames(data_barchart$FDCO2_byemind_MtCO2)[[1]];
barchart_noyears <- length(barchart_years)
barchart_countries <- dimnames(data_barchart$FDCO2_byemind_MtCO2)[[2]];
barchart_nocou <- length(barchart_countries)
barchart_industries <- dimnames(data_barchart$FDCO2_byemind_MtCO2)[[3]];
barchart_noind <- length(barchart_industries)

## load csv tables
##   https://www.dropbox.com/s/2xixf003exddcjm/AnnexIcountries.csv?dl=0
## Dropbox/2015sut-io/6_Application_CO2_ENVstringency/countryanalysis/AnnexIcountries.csv
temp <- read.table(file.path("inst", "extdata", "AnnexIcountries.csv"), sep=",")
AnnexI <- as.matrix(temp[,2])
rownames(AnnexI) <- temp[,1]
regions <- c("non-Annex I","Annex I","domestic")

## source functions
function.list <- c("countryanalysis_fct.R")
sapply(file.path("R", function.list), source)
