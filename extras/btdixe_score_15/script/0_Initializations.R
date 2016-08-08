library(reshape2)

####################################################################################
# CONTENTS
####################################################################################
# 0. useful functions
# 1. initialization of ICIO
# 2. getting icio matrices from econ to cou dimension
# 3. indicator dimension definition

####################################################################################

setwd("I:/I-O/2015sut-io/");
path = getwd();
path0function <- paste0(path,"/0_functions/")
path0lookup <- paste0(path,"/0_LookupFiles/")
path5 <- paste0(path,"/5_ICIO_model/")
path6TIVA <- paste0(path,"/6_Application_TIVA/")
path6functions <- paste0(path,"/6_calculatingindicatorfunctions/")
pathicio <- "c:/temp/Dropbox/ICIO2015/RDATA/"


####################################################################################
# 0. useful functions
####################################################################################
source(paste0(path,"/0_functions/AGGR_icioaggregationfunctions.R"))
source(paste0(path,"/0_functions/I2M_indicatormatrixconversions.R"))
source(paste0(path,"/0_functions/PO_PartnerofOrigin.R"))


# write flat files
# source(paste0(path,"/0_functions/CSV_generateFlatFile.R"))

source(paste0(path,"/0_functions/dotstatGetData.R"))


####################################################################################
# 1. initialization of ICIO
####################################################################################
setwd(path);


# Years
years = read.csv("0_LookupFiles/years.csv",header=FALSE); # read year list;
noyears = dim(years)[1];
years <- as.vector(years[,1])
before <- years[1]-1

# Economies in the icio (including multiple economies within one country)
econ = as.matrix(read.csv("0_LookupFiles/icioeconomies.csv",header=FALSE)); # read country list
noecon = dim(econ)[1];
econlist<-as.character(econ)


# Countries in the icio
cou = read.csv("0_LookupFiles/iciocountries.csv",header=FALSE); # read country list
nocou = dim(cou)[1];
coulist = cou[1:nocou,]
coulistchar = as.character(coulist)
OECDBRIICS <- c(1:34,37,39,45,46,54,61)
G20countries <- c("AUS","CAN","FRA","DEU","ITA","JPN","MEX","KOR","TUR","GBR","USA",
                  "ARG","BRA","CHN","IDN","IND","RUS","SAU","ZAF",
                  "EU28")

# Regions
#For partner 17 aggregation 
 
Reg_Label<-as.matrix(read.csv(paste0(path0lookup,'Regions+Cou.csv'),header=F))
noaggre_cou <- dim(Reg_Label)[1] - nocou
RegGrouping= read.csv("I:/I-O/2015sut-io/0_LookupFiles/Reggrp_ones.csv", row.names=1, header=1); # read aggreagating list list
RegGrouping<-as.matrix(RegGrouping)
noptn <-nocou+noaggre_cou



# Industries in the icio
ind = as.matrix(read.csv("0_LookupFiles/icioindustries.csv",header=FALSE)); # read industry list
noind = dim(ind)[1];
namesect34<-ind
Ind_Label<-as.matrix(read.csv(paste0(path0lookup,'Ind+aggrInd.csv'),header=F)) 
IndAggrIndchar <- as.character(Ind_Label)

ind3DGTlabel = as.matrix(read.csv("0_LookupFiles/icioindustries3DGTlabel.csv",header=FALSE)); # read industry list

# Industry aggregates
IndGrouping= read.csv("0_LookupFiles/IndGrouping.csv", row.names=1, header=1); # read aggreagating list list
IndGrouping<-as.matrix(IndGrouping)
noaggrind <- dim(IndGrouping)[1]
noInd_group<-noaggrind+noind
nonoservices <- 19

# Final demand columns
FDvar = read.csv("0_LookupFiles/icioFD.csv",header=FALSE); # read FD variable list
noFDvar = dim(FDvar)[1]; # check with Nori


# Value added rows
VAvar = read.csv("0_LookupFiles/icioVA.csv",header=FALSE); # read VA variable list
noVAvar = dim(VAvar)[1]; # check with Nori


# Price concepts of rawdata
priceconcepts = read.csv("0_LookupFiles/iciopriceconcepts.csv",header=FALSE); # read priceconcepts / valuations list

#We retrieve/Create the conversion matrices for aggregate of industries and aggregate of parnter countries
noaggre_ind <- noaggrind
source(paste0(path,"/0_LookupFiles/CONV_CreationOfGroupings.R"))


# list of dimension names for matrix including industry aggregates
#Creating the corresponding labels to the matrix and creating the aggregation into the matrix
namecouind<-paste0(coulist[1],"_",Ind_Label)
namecouregind<-paste0(coulist[1],"_",Ind_Label)
for(i in 2:nocou){
  namecouind<-c(namecouind,paste0(coulist[i],"_",Ind_Label))
  namecouregind<-c(namecouregind,paste0(coulist[i],"_",Ind_Label))
}
for(i in 1:noaggre_cou){
  namecouregind<-c(namecouregind,paste0(Reg_Label[i+nocou],"_",Ind_Label))
}

nameeconind<-paste0(econlist[1],"_",namesect34)
for(i in 2:noecon){  
  nameeconind<-c(nameeconind,paste0(econlist[i],"_",namesect34))
}


##################################
#! population data
##################################
POPUt = read.csv(paste0(path,"/1_datasources/7_UN/Population/ICIOcountriesPopulation.csv"),header=FALSE);rownames(POPUt) <- POPUt[,1];POPUt <- POPUt[,-1];colnames(POPUt) <- years
POPU <- t(POPUt)
rm(POPUt)


####################################################################################
# 2. getting icio matrices from econ to cou dimension
####################################################################################

# to do when adding a country
# i)   add country codes in 2.0
# ii)  add function call in 2.1.2


# 2.0 country lists
China <- c("CHN","CN1","CN2","CN3","CN4")
Mexico <- c("MEX","MX1","MX2","MX3")
splitcountrylist <- list(China, Mexico)

splitcountries <- c(splitcountrylist[[1]][1])
for(s in 2:length(splitcountrylist)) splitcountries <- c(splitcountries,splitcountrylist[[s]][1])


source(paste0(path,"/0_functions/findsplitcountries.r"))


# 2.1 concordance matrix conexc (# of economies x # number of actual countries)

# 2.1.1 create basic matrix
conexc <- array(data = 0, dim = c(noecon,nocou))
rownames(conexc) <- t(econ)
colnames(conexc) <- t(cou)
conexc[1:nocou,1:nocou] <- diag(nocou)

# 2.1.2 adapt basic matrix
conexc <- AGGR_adaptconexc(conexc,China)
conexc <- AGGR_adaptconexc(conexc,Mexico)


# 2.2 concordance matrix concixc (# of countries * industries x # number of economies * industries)

# 2.2.1 create basic matrix
rownumber <- nocou*noind
colnumber <- noecon*noind
concixei <- array(data = 0, dim = c(rownumber,colnumber))
concixei[1:rownumber,1:rownumber] <- diag(rownumber)

# 2.2.2 adapt basic matrix
concixei <- AGGR_adaptconcixei(concixei,China)
concixei <- AGGR_adaptconcixei(concixei,Mexico)

# 2.3 creating the result matrix for indocators for the actual number of countries 
#     based on the matrix including the split countries that is the result of the icio
# 
# indicmicio   is a matrix of size nocou*noind x nocou 
#              (i.e. country number including the split economies)
# indicmfinal  is a matrix of size nocounos*noind x nocounos 
#              (i.e. country number of actual number of countries)
# 
# for FD matrix and all indicator matrices: indicmfinal  <- AGGR_icioresult_noecon2nocou(indicmicio)
# for intermediate flow matrix:             iciofinal    <- AGGR_icio_noecon2nocou(icio)
# for primary inputs matrix:                iciopimfinal <- AGGR_iciopi_noecon2nocou(iciopim)

# 2.4 concordance ci by ci to ci by c
rownumber <- nocou*noind
colnumber <- nocou
concixc <- array(data = 0, dim = c(rownumber,colnumber))
for(c in 1:nocou) concixc[((c-1)*noind+1):(c*noind),c] <- 1 


####################################################################################
# 3. indicator dimension definition
####################################################################################
# the indicators are stored in *.Rdata files with the following dimensions
# c("year","countries + regions","industry + industry aggregates","partnercountries + regions","industry + industry aggregates")
#     t        C        I                     P                      PI
temparray = array(data = NA,  c(nocou+noaggre_cou,noind+noaggrind,nocou+noaggre_cou,noind+noaggrind,noyears))
                                
               


dimnames(temparray)[[1]]<- Reg_Label
dimnames(temparray)[[2]]<- Ind_Label
dimnames(temparray)[[3]]<- Reg_Label
dimnames(temparray)[[4]]<- Ind_Label
dimnames(temparray)[[5]]<-c(1995:2011)
#dimnames(temparray)[[6]]<- c("WOR",0)


#-----------------------------------------------
# 3.1 Calculation procedure and storing results
#-----------------------------------------------
# calculations are done at the number of economies basis
# the results are first aggregated to the country level using
#   concixei and conexc to pre and postmultiply the resultmatrices
#   of size (noecon*noind) x noecon
# the resulting matrices are then converted to include region and 
#   industry aggregates using the function 
#   GenerateIndRegAggr(INDICc, years[t],"INDICname")
# the final indicator matrices then have the size 
#   row dimension: (countries+regions) x (industries+industry aggregates)
#   col dimension: (countries+regions)
indictemplate <- array(data = 0, dim = c(noyears, (nocou+noaggre_cou)*(noind+noaggrind),(nocou+noaggre_cou)))
dimnames(indictemplate) <- list(as.character(years), namecouregind,Reg_Label)
indicfinal <- array(data = 0, dim = c(noyears, (nocou+noaggre_cou),(noind+noaggrind),(nocou+noaggre_cou)))
dimnames(indicfinal) <- list(as.character(years), Reg_Label, Ind_Label,Reg_Label)

# function for indictemplate in indicfinal
indictemplatefinal <- function(indicorig){
  indic <- indicfinal
  for(c in 1:(nocou+noaggre_cou)){
    c1=(c-1)*(noind+noaggrind)+1;
    c2=c*(noind+noaggrind);
    indic[,c,,]<-indicorig[,c1:c2,]
  }
  return(indic)
}
# and the inverse
indicfinaltemplate <- function(indic){
  indicorig <- indictemplate
  for(c in 1:(nocou+noaggre_cou)){
    c1=(c-1)*(noind+noaggrind)+1;
    c2=c*(noind+noaggrind);
    indicorig[,c1:c2,] <- indic[,c,,]
  }
  return(indicorig)
}

indicatoryears <- c(1995,2000,2005,2008:2011)
indicatoryearsnames <- as.character(indicatoryears)

# the indicators are stored in Rdata files and csv files
# the Rdata files store the indicators in matrices of size across years
