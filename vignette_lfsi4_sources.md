---
title: "LFS Data Sources"
layout: default
output: bookdown::html_chapter
---

# Annual Labour Force Survey Data

Most countries carry out annual labour force surveys, many supplementing them with less frequent population censuses. Relevant data sources from international organisations as well as national statistical offices are listed below.

## OECD PIAAC {#piaac}

source
:   [PIAAC Data Pub](\\asap4\Edu\PIAAC\PIAAC Data Pub)

url
:   http://www.oecd.org/site/piaac/publicdataandanalysis.htm

classification
:   Occupation:

    - ISCO08

    Industry:

    - ISIC4

## Eurostat {#eurostat}

source
:   NACE Rev. 1 (1996-2008):

    - [OECDpmar_2Abis_100630.csv](H:\ELSHARE\SID\LFS\European Labour Force Survey\Dataextraction\2010\Michael&Thomas\OECDpmar_2Abis_100630.csv)

    NACE Rev. 2 (2008-2011):

    - [OECD_120419.zip](H:\ELSHARE\SID\LFS\European Labour Force Survey\Dataextraction\STI\2012\Cristina\OECD_120419.zip)

    NACE Rev. 2 (2008-2012):

    - [OECD_130603_2.zip](H:\ELSHARE\SID\LFS\European Labour Force Survey\Dataextraction\STI\2013\Elif\OECD_130603_2.zip)

url
:   http://epp.eurostat.ec.europa.eu/portal/page/portal/microdata/lfs

variables
:   NACE Rev. 1:

    - country
    - year
    - quarter: "\_A","\_S" (Annual, Seasonal)
    - hatlev1d: "1. Low","2. Medium",..
    - ilostat: "1.Employed"
    - isco3d
    - na112d
    - stapro: "Employee","No answer",..
    - value
    - Flag: "","a","b","c"
    - country_order


## International Labour Organisation (ILO) {#ilo}

source
:   From ILO database, in ISCO2008:

    - Argentina
    - Australia
    - Mexico
    - South Africa
    - Turkey

    From ILO database, in ISCO1988:

    - Canada
    - Chile
    - Indonesia
    - Israel
    - Russian Federation

url
:   http://www.ilo.org/ilostat

classification
:   Occupation:

    - Mapping National Occupational Classifications into ISCO-88


## Australia {#aus}

source
:   Statistics by catalogue number - [62. Labour force](http://www.abs.gov.au/AUSSTATS/abs%40.nsf/ViewContent?readform&view=productsbyCatalogue&Action=Expand&Num=7.2)

	- 6291.0.55.003 Labour Force, Australia, Detailed, Quarterly, May 2013
	- E09_aug96 - Employed Persons by Sex, Industry, Occupation, State, August 1996 onwards

classification
:   Occupation:

    - [ANZSCO Version 1.2](http://www.abs.gov.au/AUSSTATS/abs%40.nsf/productsbyCatalogue/4AF138F6DB4FFD4BCA2571E200096BAD?OpenDocument): Statistics by catalogue number
	- 12. Classifications and work manuals [ANZSCO Version1.2 - Structure](http://www.abs.gov.au/AUSSTATS/abs%40.nsf/ViewContent?readform&view=productsbyCatalogue&Action=Expand&Num=1.3)


## Canada {#can}

source
:   Received file: G1111\_14\_Tab1\_07-12.prn (*LFS in CANSIM tables 282-... do not contain combinations of industry (NAICS) and occupation dimension (NOC-S)*)

classification
:   Industry:

    - NAICS 2012: NAICS Canada 2012 to ISIC Rev. 4
    - NAICS 2007: NAICS Canada 2007 to ISIC Rev. 4

	Occupation:

    - NOC 2011 to ISCO 2008
    - NOC-S 2006


## New Zealand {#nzl}

source
:   Linked Employer-Employee Dataset LEED: http://www.stats.govt.nz/infoshare/Default.aspx (`total jobs` *up to 3-digit industry detail*)


## United States {#usa}

source
:   Basic Monthly CPS (household survey - certain group overrepresented, e.g. managers; more comparable with EULFS than OES)

    1. Download the US data through the FTP site http://thedataweb.rm.census.gov/ftp/cps_ftp.html
    2. Identify start and end position of required variables using the Data Dictionary
    3. Use program 1\_USA\_dl\_unpack\_extract\_CPS.R

    OES (employer survey - more reliable)

    - http://www.bls.gov/oes/

classification
:   Industry:

    - CPS\_INDUSTRY\_CLASSIFICATION (2002 Census code and NAICS code)

    Occupation:

	- CPS\_OCCUPATION\_CLASSIFICATION (2002 Census code and 2000 SOC code)

The latest version of the ANSKILL tables are based on the March CPS extractions with the following tabulation:

  - Industry: PEIO1ICD
  - Occupation: PEIO1OCD
  - Class of worker: PEIO1COW
    - Government Federal
    - Government State
    - Government Local
    - Private, for Profit
    - Private, non Profit
  - *Caution: If you are using the EU tabulations for total employed, you need to add to the selection:*
    - Self-employed, incorporated
    - Self-employed, unincorporated
  - Current status: PEMLR
    - Employed at work
    - Employed absent
  - Weight used: PWCMPWGT
