---
title: "STANNAi3 Sources"
layout: default
output: bookdown::html_chapter
---

# National Accounts ISIC Rev. 3 Data Sources

This chapter summarizes various types of STAN-type National Accounts by economic activity data sources in ISIC Rev. 3.

## Eurostat National Accounts IO tables in NACE Rev. 1 {#EUNAIOR1}
### Description 

 Supply, use and input-output tables provide detailed information for a given year on production activities, the supply and demand of goods and services, intermediate consumption, primary inputs and foreign trade.

### Format 
  - A data frame with 47040 observations on the following 5 variables.

  - `cou`, a factor with levels AUT, BEL, BGR, CYP, CZE, DEU, DNK, ESP, EST, FIN, FRA, GBR, GRC, HUN, IRL, ITA, LTU, LVA, MLT, NLD, NOR, POL, PRT, ROU, SVK, SVN, SWE, TUR
  - `var`, a character vector
  - `year`, a numeric vector
  - `ind`, a factor with levels C01, C02, C05, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, C26, C27, C28, C29, C30, C31, C32, C33, C34, C35, C36, C37, C40, C41, C45, C50, C51, C52, C55, C60, C61, C62, C63, C64, C65, C66, C67, C70, C71, C72, C73, C74, C75, C80, C85, C90, C91, C92, C93, C95, CTOTAL, C01T02, C01T05, C10T12, C13T14, C10T14, C15T16, C17T18, C17T19, C21T22, C20T22, C23T25, C23T26, C27T28, C30T33, C29T33, C34T35, C36T37, C15T37, C40T41, C50T52, C50T55, C60T63, C60T64, C65T67, C71T74, C70T74, C65T74, C90T93, C75T99, C20A36, C10T41, C27T35, C50T64, C50T74X, C50T74, C50T99, C10T74X, LOTECH, HMHTECH, ENERGYP, NONMAN
  - `value`, a numeric vector

### Details 

 For details, see references

### References 

 http://epp.eurostat.ec.europa.eu/portal/page/portal/esa95_supply_use_input_tables/methodology/supply_and_use_tables

## Eurostat Annual National Accounts detailed breakdowns NACE Rev. 1.1 {#EUNAMAR1}
### Description 

 National accounts are a coherent and consistent set of macroeconomic indicators, which provide an overall picture of the economic situation and are widely used for economic analysis and forecasting, policy design and policy making. Eurostat publishes annual and quarterly national accounts, annual and quarterly sector accounts as well as supply, use and input-output tables, which are each presented with associated metadata.

### Format 
  - A data frame with 235514 observations on the following 5 variables.

  - `cou`, a factor with levels AUT, BEL, BGR, CHE, CYP, CZE, DEU, DNK, ESP, EST, FIN, FRA, GBR, GRC, HUN, IRL, ISL, ITA, LIE, LTU, LUX, LVA, MKD, MLT, MNE, NLD, NOR, POL, PRT, ROU, SVK, SVN, SWE, TUR
  - `var`, a factor with levels PROD, PRDK, INTI, INTK, VALU, VALK, LABR, WAGE, NOPS, CFCC, OTXS, EMPN, EMPE, SELF, FTEN, FTEE, JOBN, JOBE, HRSN, HRSE
  - `ind`, a factor with levels CTOTAL, C01T02, C01, C02, C05, C10T14, C10T12, C10, C11, C12, C13T14, C13, C14, C15T37, C15T16, C15, C16, C17T18, C17, C18, C19, C20, C21T22, C21, C22, C23, C24, C25, C26, C27T28, C27, C28, C29, C30T33, C30, C31, C32, C33, C34T35, C34, C35, C36T37, C36, C37, C40T41, C40, C41, C45, C50T52, C50, C51, C52, C55, C60T64, C60, C61, C62, C63, C64, C65T67, C65, C66, C67, C70T74, C70, C71, C72, C73, C74, C75, C80, C85, C90T93, C90, C91, C92, C93, C95, C99
  - `year`, a numeric vector
  - `value`, a numeric vector

### Details 

 For details, see references

### References 

 http://epp.eurostat.ec.europa.eu/cache/ITY_SDDS/en/nama_esms.htm

## UNIDO Industrial Statistics Database (INDSTAT) ISIC Rev. 3 {#INDSTAT32}
### Description 

 The UNIDO Industrial Statistics Database at the 2-digit level of ISIC (INDSTAT2) contains time series data on the manufacturing sector for the period 1963 onwards. INDSTAT2 is the largest industrial statistics database of its kind. Unlike others presented by different classification standards for different time periods, INDSTAT2 provides data by a single classification standard for more than 40 years, which makes it particularly valuable for long-term structural analysis. The database contains eight principle indicators of industrial statistics, including the index numbers of industrial production, which show the real growth of the volume of production by 2-digit of ISIC Rev. 3. The data are arranged at the 2-digit level of the International Standard Industrial Classification of All Economic Activities (ISIC) Revision 3 pertaining to the manufacturing sector, which comprises 23 industries.

### Format 
  - A data frame with 171216 observations on the following 5 variables.

  - `cou`, a factor with levels ABW, AFG, ALB, ARE, ARG, ARM, AUS, AUT, AZE, BDI, BEL, BEN, BFA, BGD, BGR, BHS, BIH, BLR, BLZ, BMU, BOL, BRA, BRB, BWA, CAF, CAN, CHE, CHL, CHN, CIV, CMR, COG, COK, COL, CRI, CUB, CUW, CYP, CZE, DEU, DNK, DOM, DZA, ECU, EGY, ERI, ESP, EST, ETH, FIN, FJI, FRA, GAB, GBR, GEO, GHA, GMB, GRC, GTM, HKG, HND, HRV, HTI, HUN, IDN, IND, IRL, IRN, IRQ, ISL, ISR, ITA, JAM, JOR, JPN, KAZ, KEN, KGZ, KHM, KOR, KWT, LAO, LBN, LBR, LBY, LCA, LKA, LSO, LTU, LUX, LVA, MAC, MAR, MDA, MDG, MEX, MKD, MLT, MMR, MNG, MOZ, MUS, MWI, MYS, NER, NGA, NIC, NLD, NOR, NPL, NZL, OMN, PAK, PER, PHL, PNG, POL, PRI, PRT, PRY, PSE, QAT, ROU, RUS, RWA, SAU, SEN, SGP, SLV, SOM, SRB, SUR, SVK, SVN, SWE, SWZ, SYR, THA, TJK, TON, TTO, TUN, TUR, TZA, UGA, UKR, URY, USA, VEN, VNM, YEM, ZAF, ZMB
  - `var`, a factor with levels EMPE, EMPN, GFCF, PROD, VALU, WAGE
  - `ind`, a character vector
  - `year`, a numeric vector
  - `value`, a numeric vector

### Details 

 For details, see references

### References 

 http://www.unido.org/en/resources/statistics/statistical-databases/indstat2-2014-edition.html

## National Statistics Office's Annual National Accounts {#NSONAPATCHi3}
### Description 

 Data collected and harmonised from Annual National Accounts published by National Statistics Offices. Variables compatible with STAN definitions identified by OECD STI.

### Format 
  - A data frame with 36563 observations on the following 5 variables.

  - `cou`, a character vector
  - `var`, a factor with levels EMPE, EMPN, EXPO, GOPS, HRSE, HRSN, IKOT, IKPY, IMPO, INTI, INTK, LABR, OTXS, PKOT, PKPY, PRDK, PROD, SELF, VAFC, VALK, VALP, VALU, VKOT, VKPY, WAGE, GFCF,  NOPS, CFCC, FTEE, FTEN, GFCK, GFCP, INTP, PRDP, OPSM, RDNC
  - `ind`, a factor with levels C01, C01T02, C01T05, C02, C05, C10, C10T12, C10T14, C10T41, C10T74X, C11, C12, C13, C13T14, C14, C15, C15T16, C15T37, C16, C17, C17T18, C17T19, C18, C19, C20, C20A36, C21, C21T22, C22, C23, C23T25, C24, C2423, C24X, C25, C26, C27, C271T31, C272T32, C27T28, C27T35, C28, C29, C29T33, C30, C30T33, C31, C313, C31X, C32, C321, C322, C323, C33, C3312, C33X, C34, C34T35, C35, C351, C352A9, C353, C36, C36T37, C37, C40T41, C45, C50, C50T52, C50T55, C50T64, C50T74, C50T74X, C50T99, C51, C52, C55, C60, C60T63, C60T64, C61, C62, C63, C64, C65T67, C65T74, C70, C70T74, C71T74, C74, C75, C75T99, C80, C85, C90T93, C95, CTOTAL, ENERGYP, HITECH, HMHTECH, ICTMAN, LOTECH, MHTECH, MLTECH, NONMAN, C65T99, C71, C72,  C40, C41, C90, C65, C66, C67, C73, C91, C92, C93, C99, C3313, C515, C51X, C641, C642, C7123, C71X, C991, C992, ICTSER
  - `year`, a numeric vector
  - `value`, a numeric vector

### Details 

 For details, see references

### References 

 not available

## OECD STructural ANalysis Database ISIC Rev. 3 {#STANi3}
### Description 

 The "STAN database for Industrial Analysis" provides analysts and researchers with a comprehensive tool for analysing industrial performance at a relatively detailed level of activity. It includes annual measures of output, labour input, investment and international trade that allow users to construct a wide range of indicators to focus on areas such as productivity growth, competitiveness and general structural change. Through the use of a standard industry list, comparisons can be made across countries. The industry list provides sufficient detail to enable users to highlight high-technology sectors and is compatible with those used in related OECD databases.

### Format 
  - A data frame with 388677 observations on the following 5 variables.

  - `cou`, a factor with levels AUS, AUT, BEL, CAN, CHE, CHL, CZE, DEU, DNK, ESP, EST, FIN, FRA, GBR, GRC, HUN, IRL, ISL, ISR, ITA, JPN, KOR, LUX, MEX, NLD, NOR, NZL, POL, PRT, SVK, SVN, SWE, USA
  - `var`, a factor with levels CFCC, CPGK, CPNK, EMPE, EMPN, EXPO, FTEE, FTEN, GFCF, GFCK, GFCP, GOPS, HRSE, HRSN, IMPO, INTI, INTK, INTP, LABR, NOPS, OTXS, PRDK, PRDP, PROD, SELF, VAFC, VALK, VALP, VALU, WAGE
  - `ind`, a factor with levels C01, C01T02, C01T05, C02, C05, C10, C10T12, C10T14, C10T41, C10T74X, C11, C12, C13, C13T14, C14, C15, C15T16, C15T37, C16, C17, C17T18, C17T19, C18, C19, C20, C20A36, C21, C21T22, C22, C23, C23T25, C24, C2423, C24X, C25, C26, C27, C271T31, C272T32, C27T28, C27T35, C28, C29, C29T33, C30, C30T33, C31, C313, C31X, C32, C321, C322, C323, C33, C3312, C3313, C33X, C34, C34T35, C35, C351, C352A9, C353, C36, C36T37, C37, C40, C40T41, C41, C45, C50, C50T52, C50T55, C50T64, C50T74, C50T74X, C50T99, C51, C515, C51X, C52, C55, C60, C60T63, C60T64, C61, C62, C63, C64, C641, C642, C65, C65T67, C65T74, C66, C67, C70, C70T74, C71, C71T74, C72, C73, C74, C75, C75T99, C80, C85, C90, C90T93, C91, C92, C93, C95, C99, CTOTAL, ENERGYP, HITECH, HMHTECH, ICTMAN, LOTECH, MHTECH, MLTECH, NONMAN
  - `year`, a numeric vector
  - `value`, a numeric vector

### Details 

 For details, see references

### References 

 http://www.oecd.org/sti/stan

## OECD STD/NAD Annual National Accounts Value added and its components by activity ISIC Rev. 3 {#STDSNAi3}
### Description 

 Its presents output, intermediate consumption and the gross value added and its components, in particular compensation of employees and gross operating surplus and mixed income, broken down by detailed industries according to the classification ISIC Rev. 4. It has been prepared from statistics reported to the OECD by Member countries in their answers to annual national accounts questionnaire. This questionnaire is designed to collect internationally comparable data according to the 1993 SNA.

### Format 
  - A data frame with 189744 observations on the following 5 variables.

  - `cou`, a factor with levels AUS, CHL, COL, DEU, DEW, EMU, ESP, EST, FIN, FRA, HUN, IRL, ISL, ITA, JPN, LUX, NLD, NOR, NZL, POL, RUS, SVK, SVN, SWE, TUR, USA, ZAF
  - `year`, a numeric vector
  - `var`, a factor with levels CAPG, CAPN, CFCC, CFCK, CPGK, CPNK, EMPE, EMPN, FTEE, FTEN, GFCF, GFCK, GOPS, HRSE, HRSN, INTI, JOBE, JOBN, LABR, NOPS, OTXS, PRDK, PROD, VAK2, VALK, VALU, WAGE
  - `ind`, a factor with levels CTOTAL, C01T02, C01, C02, C05, C10T14, C10T12, C10, C11, C12, C13T14, C13, C14, C15T37, C15T16, C15, C16, C17T18, C17, C18, C19, C20, C21T22, C21, C22, C23, C24, C25, C26, C27T28, C27, C28, C29, C30T33, C30, C31, C32, C33, C34T35, C34, C35, C36T37, C36, C37, C40T41, C40, C41, C45, C50T52, C50, C51, C52, C55, C60T64, C60, C61, C62, C63, C64, C65T67, C65, C66, C67, C70T74, C70, C71, C72, C73, C74, C75, C80, C85, C90T93, C90, C91, C92, C93, C95, C99
  - `value`, a numeric vector

### Details 

 For details, see references

### References 

 http://www.oecd.org/std/na/

## National Accounts Official Country Data, Connected Series 100-500 {#UNDATA203CON}
### Description 

 This dataset is linking the UNSD Main Aggregates and Detailed Tables, series 100-500 backwards across revisions. The algorithm orders series for each country according to the latest year available. If few cases, a lower series number for one country contains more recent years than a higher series number.

### Format 
  - A data frame with 89075 observations on the following 5 variables.

  - `cou`, a factor with levels ABW, ALB, ARE, ARG, ARM, AUS, AUT, AZE, BDI, BEL, BFA, BGD, BGR, BHR, BHS, BIH, BLR, BLZ, BMU, BRA, BTN, BWA, CAN, CHE, CHL, CMR, COD, COL, CRI, CUB, CYM, CYP, CZE, DEU, DMA, DNK, DOM, ECU, EGY, ESP, EST, FIN, FRA, FSM, GAB, GBR, GEO, GIN, GRC, GRL, GTM, HKG, HND, HRV, HUN, IND, IRL, IRN, ISL, ISR, ITA, JAM, JPN, KAZ, KEN, KGZ, KNA, KOR, LBN, LIE, LKA, LSO, LTU, LUX, LVA, MAC, MAR, MCO, MDA, MEX, MLT, MNE, MNG, MOZ, MRT, MSR, MUS, NAM, NCL, NER, NGA, NIC, NLD, NOR, NZL, OMN, PAK, PAN, PER, PHL, PNG, POL, PRT, PRY, PSE, QAT, ROU, RUS, SAU, SEN, SGP, SLE, SRB, SUR, SVK, SVN, SWE, SYC, TCA, TCD, THA, TJK, TTO, TUN, TUR, TZA, UKR, URY, USA, VCT, VEN, VGB, YEM, ZAF
  - `var`, a factor with levels VALU, INTI, LABR, PROD, GOPS, GFCF, OTXS, NOPS, CFCC, EMPN
  - `ind`, a factor with levels C60T64, C01T05, CTOTAL, C80T93, C65T74, C75, C15T37, C50T55, C40T41, C45, C01, C10T14, C05, C95, C02
  - `year`, a numeric vector
  - `value`, a numeric vector

### Details 

 The Economic Statistics Branch of the United Nations Statistics Division (UNSD) maintains and annually updates the National Accounts Official Country Data database. This work is carried out in accordance with the recommendation of the Statistical Commission at its first session that the Statistics Division of the United Nations should publish regularly the most recent available data on national accounts for as many countries and areas as possible. The database contains detailed official national accounts statistics in national currencies as provided by the National Statistical Offices.

### References 

 UNSD Main Aggregates and Detailed Tables (MADT)

## UNSD Main Aggregates {#UNSDSNA2013}
### Description 

 The National Accounts Main Aggregates Database presents a series of analytical national accounts tables from 1970 onwards for more than 200 countries and areas of the world. It is the product of a global cooperation effort between the Economic Statistics Branch of the United Nations Statistics Division, international statistical agencies and the national statistical services of these countries and is developed in accordance with the recommendation of the Statistical Commission at its first session in 1947 that the Statistics Division should publish regularly the most recent available data on national accounts for as many countries and areas as possible. The database is updated in December of each year with newly available national accounts data for all countries and areas.

### Format 
  - A data frame with 40039 observations on the following 5 variables.

  - `cou`, a factor with levels ABW, AFG, AGO, AIA, ALA, ALB, AND, ARE, ARG, ARM, ASM, ATG, AUS, AUT, AZE, BDI, BEL, BEN, BES, BFA, BGD, BGR, BHR, BHS, BIH, BLM, BLR, BLZ, BMU, BOL, BRA, BRB, BRN, BTN, BWA, CAF, CAN, CHE, CHL, CHN, CIV, CMR, COD, COG, COK, COL, COM, CPV, CRI, CUB, CUW, CYM, CYP, CZE, DEU, DJI, DMA, DNK, DOM, DZA, ECU, EGY, ERI, ESH, ESP, EST, ETH, FIN, FJI, FLK, FRA, FRO, FSM, GAB, GBR, GEO, GGY, GHA, GIB, GIN, GLP, GMB, GNB, GNQ, GRC, GRD, GRL, GTM, GUF, GUM, GUY, HKG, HND, HRV, HTI, HUN, IDN, IMN, IND, IRL, IRN, IRQ, ISL, ISR, ITA, JAM, JEY, JOR, JPN, KAZ, KEN, KGZ, KHM, KIR, KNA, KOR, KWT, LAO, LBN, LBR, LBY, LCA, LIE, LKA, LSO, LTU, LUX, LVA, MAC, MAF, MAR, MCO, MDA, MDG, MDV, MEX, MHL, MKD, MLI, MLT, MMR, MNE, MNG, MNP, MOZ, MRT, MSR, MTQ, MUS, MWI, MYS, MYT, NAM, NCL, NER, NFK, NGA, NIC, NIU, NLD, NOR, NPL, NRU, NZL, OMN, PAK, PAN, PCN, PER, PHL, PLW, PNG, POL, PRI, PRK, PRT, PRY, PSE, PYF, QAT, REU, ROU, RUS, RWA, SAU, SDN, SEN, SGP, SHN, SJM, SLB, SLE, SLV, SMR, SOM, SPM, SRB, SSD, STP, SUR, SVK, SVN, SWE, SWZ, SXM, SYC, SYR, TCA, TCD, TGO, THA, TJK, TKL, TKM, TLS, TON, TTO, TUN, TUR, TUV, TZA, UGA, UKR, URY, USA, UZB, VAT, VCT, VEN, VGB, VIR, VNM, VUT, WLF, WSM, YEM, ZAF, ZMB, ZWE
  - `var`, a factor with levels EXPO, FDDE, FGGE, FHHE, GCFI, GDPR, GFCF, IMPO, INVC, VALU
  - `ind`, a factor with levels C01T05, C10T41, C15T37, C45, C50T55, C60T64, C65T99, CTOTAL
  - `year`, a numeric vector
  - `value`, a numeric vector

### Details 

 For details, see references

### References 

 United Nations Statistics Division National Accounts Main Aggregates Database

## World Input-Output Tables, released 04/2012 {#WIOT042012}
### Description 

 World Input-output tables (WIOT) in current prices, denoted in millions of dollars. The database covers 27 EU countries and 13 other major countries in the world for the period from 1995 to 2011.

### Format 
  - A data frame with 95940 observations on the following 5 variables.

  - `cou`, a factor with levels 0, AUS, AUT, BEL, BGR, BRA, CAN, CHN, CYP, CZE, DEU, DNK, ESP, EST, FIN, FRA, GBR, GRC, HUN, IDN, IND, IRL, ITA, JPN, KOR, LTU, LUX, LVA, MEX, MLT, NLD, POL, PRT, ROM, RoW, RUS, SVK, SVN, SWE, TUR, TWN, USA
  - `var`, a factor with levels EXPO, IMPO, PROD, TBAL, VALU
  - `year`, a numeric vector
  - `ind`, a factor with levels C01T05, C10T14, C15T16, C17T18, C19, C20, C21T22, C23, C24, C25, C26, C27T28, C29, C30T33, C34T35, C36T37, C40T41, C45, C50, C51, C52, C55, C60, C61, C62, C63, C64, C65T67, C70, C71T74, C75, C80, C85, C90T93, C95, C23T26, C50T52, C60T63, C20T22, C50T55, C60T64, C80T93, C50T64, C50T74X
  - `value`, a numeric vector

### Details 

 For details, see references

### References 

 Marcel P. Timmer (ed) (2012), "The World Input-Output Database (WIOD): Contents, Sources and Methods", WIOD Working Paper Number 10

## World Input-Output Tables, released 11/2013 {#WIOT112013}
### Description 

 World Input-output tables (WIOT) in current prices, denoted in millions of dollars. The database covers 27 EU countries and 13 other major countries in the world for the period from 1995 to 2011.

### Format 
  - A data frame with 108732 observations on the following 5 variables.

  - `cou`, a factor with levels AUS, AUT, BEL, BGR, BRA, CAN, CHN, CYP, CZE, DEU, DNK, ESP, EST, FIN, FRA, GBR, GRC, HUN, IDN, IND, IRL, ITA, JPN, KOR, LTU, LUX, LVA, MEX, MLT, NLD, POL, PRT, ROM, RoW, RUS, SVK, SVN, SWE, TUR, TWN, USA
  - `var`, a factor with levels EXPO, IMPO, PROD, TBAL, VALU
  - `year`, a numeric vector
  - `ind`, a factor with levels C01T05, C10T14, C15T16, C17T18, C19, C20, C21T22, C23, C24, C25, C26, C27T28, C29, C30T33, C34T35, C36T37, C40T41, C45, C50, C51, C52, C55, C60, C61, C62, C63, C64, C65T67, C70, C71T74, C75, C80, C85, C90T93, C95, C23T26, C50T52, C60T63, C20T22, C50T55, C60T64, C80T93, C50T64, C50T74X
  - `value`, a numeric vector

### Details 

 For details, see references

### References 

 Marcel P. Timmer (ed) (2012), "The World Input-Output Database (WIOD): Contents, Sources and Methods", WIOD Working Paper Number 10

