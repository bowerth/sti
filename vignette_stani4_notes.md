---
title: "STANi4 Notes"
layout: default
output: bookdown::html_chapter
---

# STAN Country Notes

The following includes:

 - Principal data source for National Accounts (usually national statistical offices);
 - Links to the appropriate website for National Accounts;
 - Local industrial classification used for National Accounts;
 - National reference year for volumes;
 - Units used for each variable presented;
 - Definitions of variables (e.g. valuation of output);
 - Departures from the STAN ISIC Rev.4 industry list. In other words, where sectors are included in others or excluded from aggregate sectors. Such occurrences are more frequent when a country does not use either ISIC Rev.4 or NACE Rev.2 breakdowns (for example, Canada uses NAICS);
 - Any other pertinent information concerning the data presented.


## Australia (AUS) {#aus}

source
:   Australian Bureau of Statistics (ABS)

url
:   http://www.abs.gov.au/AusStats

classification
:   ANZSIC 2006

availability
:   Aggregate data to fiscal year 2010/11. Any other figures, for earlier periods or more detailed activities (such as 3- or 4-digit ISIC), are Secretariat estimates - shaded grey in the tables. See also the data notes in STAN_AUS_M.XLS

VALU, VALK
:   At Basic prices

VALK
:   Single deflation (i.e. based on indices of production)

EMPN
:   Headcounts, average of quarterly data (Aug, Nov, Feb, May)

VALK, GFCK
:   Annually re-weighted chained Laspeyres aggregates

GFCF, GFCK
:   Total ownership transfer costs have been distributed proportionally across activities

- D50 'Water transport' including part of D49 ('Transport via pipelines')
- D68 'Real Estate Activities' including D77 'Rental and leasing activities'
- D69T75 'Professional, scientific and technical activities' including part of D62 'Computer programming, consultancy and related activities'
- D63 'Information service activities' including part of D91 ('Library and archives activities')
- D90T96 'Other Community and Personal Services' (90-96) including 'Private Households with Employed Persons' (97-98)

1. Data for fiscal years beginning on the 1st July of the year indicated (e.g. 2006 represents July 2006 to June 2007)



## Austria (AUT) {#aut}

source
:   Statistik Austria

url
:   http://www.statistik.at/web_en/statistics/national_accounts/index.html

classification
:   OENACE 2008 (NACE Rev. 2)

availability
:   1995-2012: 2-digit NACE Rev. 2 (ISIC Rev. 4).

PROD, PRDK
:   At basic prices

VALU, VALK
:   At basic prices

INTI, INTK
:   At producer's prices

EMPN, EMPE
:   Number of jobs

PRDK, INTK, VALK, GFCK
:   Annually re-weighted chained Laspeyres

CPGK, CPNK
:   Fixed base, 1995 prices

1. Mining and quarrying of energy producing materials (05-06) includes Mining of metal ores (07), Mining and quarrying except energy producing materials (07-08) excludes Mining of metal ores (07)



## Belgium (BEL) {#bel}

principal source
:   National Bank of Belgium (NBB): National Accounts Institute and Financial and Economic Statistics division

url
:   http://www.nbb.be/belgostat/DataAccesLinker?Lang=E&Code=Natrek

classification
:   NACE Rev. 2

availability
:   2-digit NACE / ISIC (A64) data for production, value added and components, employment and investment 1995-2010. Relatively aggregate data (A38 list) for all measures including hours worked and capital stock: 1995-2011.

PROD, PRDK, VALU, VALK
:   At basic prices

EMPN, EMPE
:   Headcounts

PRDK, INTK, VALK, GFCK
:   Annually re-weighted chained Laspeyres

1. For many sectors, Exports of Goods exceeds Production (even for total manufacturing). This reflects the particularly high volume of 'transit trade' (re-exports) included in the trade figures.



## Canada (CAN) {#can}

principal source
:   Statistics Canada

url
:   CANSIM Statistics by Subject http://www.statcan.gc.ca

classification
:   NAICS

availability
:   Detailed Canadian NAICS tables: Output 1970-2008; Employment and Hours worked 1997-2010; Value Added volumes, Investment and Capital Stock 1970-2010.

VALU, VALK
:   at basic prices

CPGK
:   Non-residential  (GFCF and GFCK  include residential investment - in ISIC 68)

EMPN
:   Number of jobs (see note 1. below)

EMPE
:   Number of employee jobs  (see note 1. below)

VALK, GFCK, CPGK
:   Annually re-weighted chained Laspeyres

- 'Agriculture, hunting, forestry and fishing' (ISIC 01-02) includes 'aquaculture'
- 'Fishing' (ISIC 03) includes 'hunting and trapping'
- 'Electronic and optical products and scientific instruments' (ISIC 26X) includes NAICS-97 3346 'Manufacturing and Reproducing Magnetic and Optical Media' (ISIC 18)
- 'Electricity, Gas and Water supply' (ISIC 40-41) includes 'Recycling' (ISIC 37) and 'Sanitary and similar services' (ISIC 90)
- Telecommunications' (ISIC 61) includes 'Pay specialty television'



## Switzerland (CHE) {#che}

principal source
:   Swiss Federal Statistical Office (BFS)

url
:   http://www.bfs.admin.ch/bfs/portal/fr/index/themen/04/02.html

classification
:   NACE Rev. 2

availability
:   Detailed activities (mainly 2-digit NACE): 1997-2011 for production and value added;  1991-2012 employment from Statistique de la population active occuppee' (SPAO);
Aggregate activities: 1990-2012 for production and value added.

PROD, PRDK
:   at basic prices

VALU, VALK
:   at basic prices

PRDK, VALK, INTK
:   Annually re-weighted chained Laspeyres



## Czech Republic (CZE) {#cze}

principal source
:   Czech Statistical Office (CZSO)

url
:   http://www.czso.cz/eng/redakce.nsf/i/gdp_national_accounts_ekon

classification
:   NACE Rev. 2

availability
:   1995-2012 : 2-digit NACE (ISIC)

PROD, PRDK
:   At basic prices

VALU, VALK
:   At basic prices

INTI, INTK
:   At producer's prices

PRDK, INTK, VALK, GFCK
:   Annually re-weighted chained Laspeyres

1. Significant extraordinary revisions of the Annual national accounts of the Czech Republic 1995 - 2009



## Germany (DEU) {#deu}

principal source
:   Statistisches Bundesamt

url
:   http://www.destatis.de

classification
:   NACE Rev. 2

availability
:   1991-2011 (detailed sectors to 2010)

PROD, PRDK
:   At basic prices

VALU, VALK
:   At basic prices

EMPN, EMPE
:   Headcounts

GFCF, GFCK
:   Acquisitions of new assets. Net sales of used assets (about 2.5% of new assets) available at total economy level only

PRDK, VALK, INTK, GFCK
:   Annually re-weighted chained Laspeyres

CPGK, CPNK
:   Fixed-weight Laspeyres, 2000 prices

EXPO, IMPO
:   Data prior to 1991 are for western Germany only

1. Figures for the last three years are provisional



## Denmark (DNK) {#dnk}

principal source
:   Statistics Denmark

url
:   http://www.statbank.dk/statbank5a/selecttable/omrade0.asp?SubjectCode=14&PLanguage=1&ShowNews=OFF

classification
:   NACE Rev. 2

availability
:   1966-2009 detailed (2-digit) industries, 1966-2011: A64 industry list. Except for GFCF, GFCK: 1993-2011.

PROD, PRDK
:   At basic prices

VALU, VALK
:   At basic prices

EMPN, EMPE
:   Headcounts, excluding people on leave.

PRDK, INTK, VALK, GFCK
:   Annually re-weighted chained Laspeyres

- 'Aircraft and Spacecraft' (303) is included in 'Railroad equipment and transport equipment n.e.c.' (302 + 309)



## Spain (ESP) {#esp}

principal source
:   Instituto Nacional de Estadistica (INE)

url
:   http://www.ine.es/jaxi/menu.do?type=pcaxis&path=%2Ft35/p008&file=inebase&L=1

classification
:   NACE Rev. 2

availability
:   2-digit NACE for 2000-2009; aggregate (A38 list) data for 2000-2011 (see notes 1 and 2 below)

PROD, VALU, VALK
:   At basic prices

EMPN, EMPE
:   Headcounts

VALK, GFCK
:   Annually re-weighted chained Laspeyres

1.  Latest revised official national accounts, compiled according to ESA95 (SNA93), are currently available from 2000 only - although very aggregate data are available from 1980 based on quarterly National Accounts. Output and employment estimates for 1995 to 1999 are primarily based on previous STAN estimates converted from ISIC Rev. 3. These in turn were based on INE 'base 1995' SNA93 data, while estimates for 1986 to 1994 are based on INE's 'base 1986' SNA68 data and estimates for 1980 to 1985 are based on INE's 'base 1980' SNA68 data.



## Estonia (EST) {#est}

principal source
:   Statistics Estonia

url
:   http://pub.stat.ee/px-web.2001/I_Databas/Economy/23NATIONAL_ACCOUNTS/23NATIONAL_ACCOUNTS.asp

classification
:   Estonian Classification of Economic Activities (EMTAK 2003) based on NACE Rev. 1

availability
:   2-digit NACE data from official OECD/EuroStat SNA93/ESA95 questionnaire - 1995-2011 for employment, production, value added and components; 2000-2011 for hours worked. Investment: A17 aggregates, 1995-2010. Supply-Use tables 2000-2007.

PROD, VALU, VALK
:   At basic prices

VALK
:   Annually re-weighted chained Laspeyres

EMPN, EMPE
:   Persons

- For employment data only, 'Arts, entertainment and recreation; other service activities' (ISIC 90-96) includes 'Private households with employed persons' (ISIC 97-98)

1. Estonia joined the eurozone on 1st January 2011 hence STAN data are now presented in euros with data converted from EEK using the irrevocable exchange rate of 15.6466 Kroon per Euro. In general, to present data covering years prior to a country's accession to the EMU, data in 'old' national denomination are converted into 'national euro' by applying the irrevocable conversion rate established in the year of accession. This preserves the time profile of all historical national series. The recommended label for such data is '[year of accession] [ISO currency code] euro', in this case 2011 EEK euro. Note that since this method is conceptually equivalent to changing the denomination of the national currency, generating Euro area aggregates of data for periods prior to countries' accession years - on the basis of the fixed conversion rates - has little economic meaning.  See OECD Statistics Newsletter no.4. , page 6, for more discussion: http://www.oecd.org/dataoecd/38/32/50531189.pdf.



## Finland (FIN) {#fin}

principal source
:   Statistics Finland

url
:   http://www.stat.fi/til/kan_en.html

classification
:   NACE Rev. 2

availability
:   1975-2012, 2-digit NACE (see note 1. below)

PROD, PRDK
:   At basic prices

VALU, VALK
:   At basic prices

EMPN, EMPE
:   Headcounts

PRDK, INTK, VALK, GFCK
:   Annually re-weighted chained Laspeyres

- 'Military fighting vehicles' (304) is included elsewhere in 'Other transport equipment' (30)

1. More detailed information for SNA statistics published in 2011 by Statistics Finland can be found at http://www.stat.fi/til/vtp/2011/vtp'2011'2011-07-14'men'001'en.html.



## France (FRA) {#fra}

principal source
:   INSEE, Comptes nationaux

url
:   http://www.insee.fr/fr/themes/theme.asp?theme=16&sous_theme=5&nivgeo=0&type=2

classification
:   NAF rev. 2 (compatible with NACE Rev. 2) - see notes below

availability
:   Aggregate industries (INSEE 'F-level') - production and value added: 1959-2011; value added components (labour costs, GOPS), employment and hours worked: 1959-2010; (investment: 1999-2010; and capital stock: 1978-2010 not included); Detailed activties (INSEE 'G-level', 111 activities) - 1999-2010 - see notes below

PROD, PRDK
:   At basic prices

VALU, VALK
:   At basic prices

EMPN, EMPE
:   Headcounts

PRDK, VALK, INTK, GFCK
:   Annually re-weighted chained Laspeyres

1. INSEE present National Accounts by activity in tables with a hierarchy of 4 levels (D,E,F,G), based on their NAF classification, the most detailed (G) comprising of 111 activities.



## United Kingdom (GBR) {#gbr}

principal source
:   Office of National Statistics (ONS)

url
:   http://www.ons.gov.uk/ons/taxonomy/index.html?nscl=Economy

classification
:   UK SIC 2007 (fully compatible with NACE Rev. 2)

national reference year
:   2010

availability
:   Detailed Production, Value Added and Labour Costs from latest Supply-Use Tables (SUTs): 2003-2011 and converted earlier series 1997-2002 ;   Detailed Total and Employee jobs compatible with A10 data from the 'Blue Book' come from the Eurostat National Accounts Questionnaire ;   Value Added, current prices and volumes: 1997-2011 (see note 3.) coming from the 'Blue Book' GVA.   Publication of GFCF is scheduled by ONS for 2013 (see note 4.)

PROD, VALU
:   At basic prices

EMPN, EMPE
:   Number of Jobs, annual averages of seasonally adjusted quarterly series  (see note 2. below)

VALK
:   Annually re-weighted chained Laspeyres aggregation. Single deflation (see note 3. below)

- 'Extraction of crude petroleum and natural gas' (ISIC 06) includes 'Mining of metal ores' (ISIC 07)
- 'Railroad equipment and transport equipment n.e.c.' (ISIC 302A9) includes 'Military fighting vehicles' (ISIC 304)
- 'Telecommunications' (ISIC 61) includes 'Programming and broadcasting activities' (ISIC 60)

1. Latest ONS Supply-Use tables, 2003-2011, cover an identical set of industries compared with earlier SUTs (1997-2002).
2. Employment and employee jobs (EMPN and EMPE) in STAN differ from the aggregates published in the ONS Blue Book (Table 2.5) which are figures as at June each year (not seasonally adjusted) rather than annual averages of seasonally adjusted quarterly series.  Detailed UK employee jobs estimated with GB data.   Level of detail for estimates of EMPN constrained by availability of self-employed data.
3. UK Value Added volumes (VALK) for mining, manufacturing and utilities are based on indices of production (IOPs).  For other activities, such as services, the 'Output index' is derived by deflating estimates of turnover coming from a range of ONS enquiries. Volumes for aggregate industries are calculated using annually re-weighted chained Laspeyres methodology (i.e. current price value added data for the previous year are used as weights). To preserve historical growth rates, earlier series (based on previous base years) have been linked for all activities, including aggregates.
4. GFCF and Capital Stocks source: 'A redevelopment of the ONS production process for both Inventories and GFCF estimates is already underway. The current time frame includes a target date for full implementation of Blue Book 2013 to allow sufficient time for thorough testing and integration within the core national accounts' see link below



## Greece (GRC) {#grc}

principal source
:   Statistics Greece

url
:   http://www.statistics.gr/portal/page/portal/ESYE/PAGE-themes?p_param=A0702

classification
:   NACE Rev. 2

availability
:   1995-2011:  2-digit NACE Rev. 2 (A64 list).  See note 1. below

PROD, PRDK
:   At basic prices

VALU, VALK
:   At basic prices

EMPN, EMPE
:   Headcounts

PRDK, VALK, GFCK
:   Annually re-weighted chained Laspeyres (see note 2. below)

1. The GDP (and components) data for 2005-2011 have been revised with 2005 as benchmark year. The revision works for 2000-2004 have not yet been completed (except from the implementation of the new classification NACE Rev.2) and thus there is a break in the series, between the unrevised data of 2000-2004 provided here and the revised data of 2005-2011 shown in the same table.
2. Pre-1995 estimates of value added volumes (VALK) are based on old fixed weight Laspeyres indices



## Hungary (HUN) {#hun}

principal source
:   Hungarian Central Statistical Office (HCSO)

url
:   http://portal.ksh.hu/portal/page?_pageid=38,253388&_dad=portal&_schema=PORTALa

classification
:   NACE Rev. 2

availability
:   A*64 data 1995-2012 to OECD in reply to official OECD/EuroStat SNA93/ESA95 data request.

PROD, PRDK
:   At basic prices

VALU, VALK
:   At basic prices

EMPN, EMPE
:   Headcounts

VALK, GFCK
:   Annually re-weighted chained Laspeyres



## Ireland (IRL) {#irl}

principal source
:   Central Statistics Office (CSO)

url
:   http://www.cso.ie/releasespublications/pr_natacc.htm

classification
:   NACE Rev. 1

availability
:   SNA latest revision: aggregate (A31) data 1995-2009 for current price Value Added and components and GFCF; Employment data from 1998.  Value Added volumes are available only for a very aggregate (A6) breakdown of activities.  Also, see note 1.  below.

VALU, VALK
:   At basic prices

PROD
:   At basic prices. See note 1. below

- For all variables except exports and imports:
- 'Manufacturing n.e.c.' (ISIC 36-37) includes 'Coke, refined petroleum products and nuclear fuel' (ISIC 23)
- 'Aircraft and Spacecraft' (ISIC 353) is included in 'Railroad equipment and transport equipment n.e.c.' (ISIC 352 + 359)

1. CSO Ireland publish estimates of production (gross output) and value added, 2002-2007, for 2-digit NACE activities (A60) but these 'estimates of GDP using the Output Method should be considered to be experimental'. To estimate Production (gross output) in STAN we have applied the Production / Value Added ratios from this dataset to the latest official SNA Value Added and extended the series with production data coming from Structural Business Statistics (SBS).



## Iceland (ISL) {#isl}

principal source
:   Statistics Iceland

url
:   http://www.statice.is/Statistics/National-accounts-and-public-fin/Productional-approach

classification
:   ISAT 95 - Icelandic Classification of Economic Activities

availability
:   1997-2010.  Data based on earlier methodology: 1990-1997.

PROD
:   at factor costs

VALU, VALK
:   at factor costs

VALK
:   Annually re-weighted chained Laspeyres

1. Exports of petroleum products (ISIC 19) are only re-exports - fuels sold to foreign ships and aircrafts. There is no production in this industry in Iceland.



## Israel (ISR) {#isr}

principal source
:   Central Bureau of Statistics (CBS)

url
:   http://www1.cbs.gov.il/reader/?MIval=cw_usr_view_Folder&ID=141

classification
:   ISIC rev. 3.1

availability
:   Data provided to OECD in reply to official OECD/EuroStat SNA93 data request: A31 list for production and value added (2001-2008); A17 aggregates for VA components e.g. labor costs and operating surplus (2001-2008); A17 for GFCF and capital stock (1995-2008); Employment data: A17, 1995-2008. See also note 2. below. Detailed (2-digit ISIC) VA data received from CBS: 2004-2008.

PROD, VALU, VALK
:   At basic prices

VALK, GFCK, CPGK, CPNK
:   Annually re-weighted chained Laspeyres (reference year=2000)

EMPN, EMPE
:   persons

- For GFCF, capital stock and empoyment data only: 'Mining and quarrying' (ISIC 10-14) is included in 'Manufacturing' (ISIC 15-37)
- 'Chemicals' (ISIC 24) includes 'Coke, refined petroleum products and nuclear fuel' (ISIC 23)
- 'Machinery and equipment, n.e.c.' (ISIC 29) includes 'Office, accounting and computing machinery' (ISIC 30)

1. The statistical data for Israel are supplied by and under the responsibility of the relevant Israeli authorities. The use of such data by the OECD is without prejudice to the status of the Golan Heights, East Jerusalem and Israeli settlements in the West Bank under the terms of international law.
2. Data by activities don't add up to the total because it is based on the Labour force survey and other sources while detailed data are based in some cases on other sources
3. The financial intermediation services indirectly measured (FISIM) are not allocated to industries.



## Italy (ITA) {#ita}

principal source
:   ISTAT

url
:   http://www.istat.it/it/conti-nazionali

classification
:   NACE Rev. 2

availability
:   1970-2011 (detail from 1992)

PROD, PRDK
:   At basic prices

VALU, VALK
:   At basic prices

INTI, INTK
:   At producer's prices

EMPN, EMPE
:   Headcounts

PRDK, INTK, VALK, GFCK
:   Annually re-weighted chained Laspeyres

CFCC
:   Current replacement cost



## Japan (JPN) {#jpn}

principal source
:   Economic and Social Research Institute (ESRI), Cabinet Office, Government of Japan

url
:   http://www.esri.cao.go.jp/en/sna/menu.html

classification
:   Japan SIC 2002

availability
:   SNA93 tables: 43 activities for Value Added (current and constant prices), other measures - 26 activities; Value added, employment, hours worked - 1980-2009, other measures - 1990-2009.   SNA68 tables: 43 activities, 1970-1998;  Input-Output Tables: 88 activities for current price Production, Value added and components, 1996-2008. Also, note 2. below concerning the JIP 2010 database.

PROD, PRDK
:   at producer's prices

VALU, VALK
:   at producer's prices

EMPN, EMPE
:   Number of jobs

PRDK, VALK, INTK
:   Annually re-weighted chained Laspeyres

- Printing and publishing (22) does not include publishing/reproduction of recorded media
- Motor vehicles; trailers and semi-trailers (ISIC 34) includes Motorcycles (ISIC 3591)
- Agriculture (01-03) includes Veterinary Medicine (75)

1. Earlier vintages of SNA data  were used to generate estimates for earlier years - including old SNA68 data, available for 1970-1998 with a base year of 1990.  Information from I-O tables and the 2010 edition of the JIP database were used to provide estimates for detailed activities not present in SNA93 tables - particularly for services. Results from METI's annual manufacturing census (2007-08 results in JSIC 2007; 2002-07 in JSIC 2002; and 1985-2003 in JSIC 1993) were used to estimate additional detail for manufactures for current price output and employment measures.
2. The Japan Industrial Productivity (JIP) Database, compiled in a collaboration between the Research Institute of Economy, Trade and Industry (RIETI) and Hitotsubashi University, was used for certain measures as an input source into STAN estimation procedures with the kind permission of the authors: Professor Kyoji Fukao et al. The database covers 107 economic activities for the period 1970-2007 and can be downloaded at http://www.rieti.go.jp/en/database/index.html.
3. Investment and Capital Stock tables by activity are not yet available from official SNA93 sources.



## Republic of Korea (KOR) {#kor}

principal source
:   Bank of Korea;  Korean National Statistical Office

url
:   http://ecos.bok.or.kr/EIndex_en.jsp

classification
:   KSIC Rev. 9 (see note 1 below)

availability
:   Production account: 81 activities, 1994-2009, 56 activities (i.e. with aggregated manufactures) back to 1970

PROD, VALU
:   At basic prices

PRDK, INTK, VALK
:   Annually re-weighted chained Laspeyres

- Manufacturing of computers and peripheral equipment (262) includes Manufacturing of office machinery
- Furniture; other manufacturing; repair and installation of machinery and equipment (31-33) does not include Repair and installation of machinery (33)
- Telecommunications (61) includes Postal services (53)
- Veterinary activities (75) included in Human health activities (86)
- 'Other Community and Personal Services' (ISIC Rev. 4 94-96) includes 'Private households with employed persons' (ISIC Rev. 4 97-98)

1. The Bank of Korea made significant revisions to National Accounts throughout 2009.  Volumes are now aggregated using annually re-weighted chained Laspeyres methodology with a national reference year of 2005 (rather than 2000 fixed base Laspeyres).  Also, new industry breakdown was introduced based on 9th revision of Korean SIC which includes an Information sector similar to those in NAICS and ISIC Rev.4. Changes also reflect the results of the 2008 Census on Establishments (which used KSIC 9) and improvements in inter-industry relation tables and estimation methodologies.
2. Production, Value Added, Labour Costs and other VA components provided by Bank of Korea. Aggregate employment data originate from the Korean Statistical Office (namely the Economically Active Population Survey). Estimates of employment (EMPN and EMPE) for detailed manufacturing activities are based on monthly business survey data.



## Luxembourg (LUX) {#lux}

principal source
:   Service central de la statistique et des etudes economiques (STATEC)

url
:   http://www.statistiques.public.lu/stat

classification
:   NACE Rev. 2

availability
:   1995-2011

PROD, PRDK
:   At basic prices

VALU, VALK
:   At basic prices

EMPN, EMPE
:   Headcounts

PRDK, VALK
:   Annually re-weighted chained Laspeyres



## Mexico (MEX) {#mex}

principal source
:   Instituto Nacional de Estadistica, Geografia e Informatica (INEGI)

url
:   http://www.inegi.org.mx/Sistemas/temasV2/Default.aspx?s=est&c=23824

classification
:   NAICS 2002

availability
:   2003-2011: Detailed (3- and 4-digit) NAICS for PROD, INTI, VALU, LABR, GOPS (see notes below)

PROD, PRDK
:   at basic prices

VALU, VALK
:   at basic prices

PRDK, VALK
:   Fixed-weight Laspeyres (2003 prices)

- 'Electricity, gas, steam and air conditioning supply' (35) does not include 'gas and air conditioning supply'
- 'Water collection, treatment and supply' (36) includes 'gas supply'

1. INEGI substantially revised its National Accounts in 2008 publishing new results from 2003 onwards.  The revisions were made in order to better conform to recommendations of SNA93, make use of a richer set of basic statistics coming from 2004 economic census, ensure consistency with new 2003 benchmark Input-Output tables and to introduce NAICS 2002 as the industry classification (previously CMAP).  More details in the link below (in Spanish).  The revision resulted in major changes to the industry composition of value added (and other measures). For example, during the period 1995-2004, Oil and gas extraction (ISIC 11) previously accounted for about 1% of total value added, now for 2004 it accounts for 6.6% rising to 9.3% in 2008.  This is due to a new treatment of the extraction rights of PEMEX (the state-owned petroleum company) - they are now treated as 'other taxes on production' of the activity 'Oil and Gas extraction' (NAICS 211) whereas previously, they were treated as 'taxes on products' and were recorded as such in the 'tax less subsidies on products' item in the aggregate 'GDP (output approach)' account.  For 2004, this revision shifted about 360 billion pesos (or 4.2% of total GDP) to ISIC 11 Value Added. Also, the value added share for 'Community, Social and Personal Services' (ISIC 75-99)  has dropped from 17-20% for 1995-2004 before the revision to about 13.5% for 2004, 12.7% by 2008.
2. Discussions are ongoing with INEGI and they will endeavour to produce SNA by industry estimates for earlier years (back to 1993) based on the new definitions.



## Netherlands (NLD) {#nld}

principal source
:   Centraal Bureau voor de Statistiek, CBS

url
:   http://www.cbs.nl/en-GB/menu/themas/macro-economie/nieuws/default.htm

classification
:   NACE Rev. 2

availability
:   Relatively aggregate manufactures, 2-digit NACE (ISIC) services for 1970-2011.

PROD, VALU, VALK
:   At basic prices

EMPN, EMPE
:   Headcounts

VALK, GFCK
:   Annually re-weighted chained Laspeyres

HRSN, HRSE
:   Actual hours worked

Figures for 2010-2011 are provisional.



## Norway (NOR) {#nor}

principal source
:   Statistics Norway (SSB)

url
:   http://www.ssb.no/english/subjects/09/01/nr_en

classification
:   NACE Rev. 2

availability
:   On SSB website: A38 : 1970-2011; A64 : 1970-2009

PROD, PRDK
:   At basic prices

VALU, VALK
:   At basic prices

EMPN
:   Headcounts

PRDK, INTK, VALK, GFCK
:   Annually re-weighted chained Laspeyres

- 'Mining and quarrying except energy producing materials' (ISIC 07-09) includes 'Mining of coal and lignite' (ISIC 05)
- 'Tobacco products' (ISIC 12) and 'Coke, refined petroleum products and nuclear fuel' (ISIC 19) are confidential in Norway, therefore not shown separately.

1.  Data for the last two years are provisional.



## New Zealand (NZL) {#nzl}

principal source
:   Statistics New Zealand

url
:   http://search.stats.govt.nz/nav/ct2/economicindicators_nationalaccounts/ct1/economicindicators/0

classification
:   ANZSIC

availability
:   FY 1986/87 to FY 2009/10; to FY 2010/11 for value added volumes and employment aggregates.

VALU, VALK
:   At Basic prices

VALK
:   Chained Laspeyres, reference year 2005 (FY 2005/06) in STAN

EMPN, EMPE
:   Number of Jobs - see further notes below

CPNK
:   Productive Capital Stock, chained Laspeyres, reference year 2005 (FY 2005/06) in STAN

- Wholesale Trade (46) includes wholesale trade of motor vehicles and motorcycles (45 part)
- Retail Trade (47) includes retail trade of motor vehicles and motorcycles (45 part)
- Other Community and Personal Services (90-96) includes Private Households with Employed Persons (97-98)

1. For Production, Intermediate inputs, Value added and components, GFCF and Capital Stock,  data are for fiscal years beginning on the 1st April of the year indicated  (e.g. 1998 represents April 1998 to March 1999)
2. Employment (EMPN, EMPE) data are from Quarterly Employment Survey (QES) and refer to the middle week of February each year. The survey does not cover agriculture and services to agriculture (01), commercial fishing (03), international sea transport (50 part), private households employing staff (97-98), residential property operators (68 part), foreign government representation and non-civilian staff in Defence.  The survey was redesigned in the August 1999 quarter and now covers all business locations with 0.5 or more full-time equivalent employees - previously, the survey included business employing more than 2.5 full-time equivalent employees.



## Poland (POL) {#pol}

principal source
:   Polish Central Statistical Office

url
:   http://www.stat.gov.pl/english/index.htm

classification
:   PKD - Polska Klasyfikacja Dzialalnosci (NACE Rev. 2)

availability
:   2000-2011: A64 NACE Rev. 2 for Production, Value Added and components; 2000-2011: A64 NACE Rev. 2 for GFCF and GFCK

PROD, VALU, VALK
:   At basic prices

VALK, GFCK
:   Annually re-weighted chained Laspeyres

- 'Other Services' (ISIC Rev. 4 90'99) includes 'Private households with employed persons' (ISIC Rev. 4 97-98)



## Portugal (PRT) {#prt}

principal source
:   Instituto Nacional de Estatistica (INE)

url
:   http://www.ine.pt/xportal

classification
:   NACE Rev. 2

availability
:   Aggregate ISIC (A38 list) data for 1995-2011.  2-digit ISIC detail, 2006-2011, from Supply-Use tables for current price production, value added and intermediate inputs

PROD, VALU, VALK
:   at basic prices

EMPN, EMPE
:   Headcounts

VALK, PRDK, INTK
:   Annually re-weighted chained Laspeyres



## Slovakia (SVK) {#svk}

principal source
:   Statistical Office of the Slovak Republic

url
:   http://portal.statistics.sk/showdoc.do?docid=7548

classification
:   NACE Rev. 2

availability
:   1995-2011: 2-digit NACE (A64).  See notes below.

PROD, VALU
:   At basic prices

VALK
:   Annually re-weighted chained Laspeyres

1. Data now expressed in 'Euros' rather than Slovak Korunas (SKK).  The Slovak Republic joined the European Monetary Union on 1st January 2009 applying a final conversion rate of 30.126 SKK/EUR
2. Data for 2009-11 are preliminary



## Slovenia (SVN) {#svn}

principal source
:   Statistical Office of the Republic of Slovenia

url
:   http://www.stat.si/eng/tema_ekonomsko_nacionalni_bdp1.asp

classification
:   NACE Rev. 2

availability
:   1995-2012: 2-digit NACE Rev. 2 (A88, except detail for B Mining and Quarrying)

PROD, VALU
:   At basic prices

PRDK, INTK, VALK
:   Annually re-weighted chained Laspeyres



## Sweden (SWE) {#swe}

principal source
:   Statistics Sweden (SCB)

url
:   http://www.scb.se/NR0103-EN

classification
:   NACE Rev. 2

availability
:   Detailed (2-digit NACE) annual data: 1993-2010; More aggregate (A38), compatible quarterly data: 1993-2011 for value added, labour costs, gross capital formation, employment and hours worked

PROD, PRDK
:   At basic prices

VALU, VALK
:   At basic prices

EMPN, EMPE
:   Headcounts, annual average; EMPN corresponding to "Average number of persons employed"

PRDK, INTK, VALK, GFCK, CPNK
:   Annually re-weighted chained Laspeyres aggregation

- Architectural and engineering activities, technical testing (71) includes Scientific research and development (72)
- Water collection, treatment and supply (36) includes Sewerage (37)



## Turkey (TUR) {#tur}

principal source
:   Statistics Sweden (SCB)

url
:   http://www.scb.se/NR0103-EN

classification
:   NACE Rev. 2

availability
:   Detailed (2-digit NACE) annual data: 1993-2010; More aggregate (A38), compatible quarterly data: 1993-2011 for value added, labour costs, gross capital formation, employment and hours worked

PROD, PRDK
:   At basic prices

VALU, VALK
:   At basic prices

EMPN, EMPE
:   Headcounts, annual average

PRDK, INTK, VALK, GFCK, CPNK
:   Annually re-weighted chained Laspeyres aggregation

- Architectural and engineering activities, technical testing (71) includes Scientific research and development (72)
- Water collection, treatment and supply (36) includes Sewerage (37)



## United States (USA) {#usa}

principal source
:   Bureau of Economic Analysis (BEA)

url
:   http://www.bea.gov/industry

classification
:   North American Industry Classification (NAICS 2007)

availability
:   NAICS based estimates of Production, Value Added, Labour Costs, Gross Operating Surplus : 1987-2011; Employment  measures: 1998-2011; GFCF and Net Capital Stock: 1970-2011. BEA provides additional NAICS based estimates back to 1947 for Value Added and number of employees.

PROD, PRDK
:   At market prices

VALU, VALK
:   At market prices

PRDK, VALK, INTK, GFCK
:   Annually re-weighted chained Fisher indices

EMPE
:   BEA's Full-Time and Part-Time Employees (FTPT). Number of Jobs - underlying source is BLS's CES establishment survey.

FTEN
:   BEA's Persons Engaged in Production (PEP = FTE + number of self-employed)

FTEE
:   BEA's Full-Time Equivalent Employees (FTE)

EMPN
:   FTPT + (PEP - FTE)

- For all variables (except exports and imports):
- 'Printing and reproduction of recorded media' (ISIC 18) does not include 'Software reproduction'
- 'Electrical and optical equipment' (ISIC 26-27) includes 'Software reproduction' (ISIC 182)
- 'Electrical equipment' (ISIC 27) includes 'Household appliances'
- 'Railroad equipment and transport equipment n.e.c.' (ISIC 302A9) includes 'Military fighting vehicles' (ISIC 304)
- 'Publishing' (ISIC 58) includes 'Software publication'
- 'Other Business activities' (ISIC 69-75) includes 'Research and development' (ISIC 72) and 'Veterinary activities' (ISIC 75)
- 'Arts, entertainment and recreation; other service activities' (ISIC 90-96) includes 'Private households with employed persons' (ISIC 97-98)
- 'Other service activities' (ISIC 94-96) includes 'Maintenance and repairs' (ISIC 45part and 47part)
- For Investment, Post (ISIC 53) is not included, see note 4. below

1. Measuring the Nation's Economy: An Industry Perspective A Primer on BEA's Industry Accounts (2011) http://www.bea.gov/industry/pdf/industry'primer.pdf.
2. BEA Annual Industry Accounts underwent major revisions during 2009 and 2010. For further details concerning the revisions see the BEA article http://www.bea.gov/scb/pdf/2010/03%20March/0310'indy'accts.pdf.
3. Where there is a many-to-one mapping from BEA NAICS activities to STAN ISIC Rev.4 activities, volumes (PRDK, VALK, INTK and GFCK) have been aggregated using annually re-weighed chained Fisher methodology to be consistent with US practice.
4. Investment data (GFCF and GFCK) include investment in software. 'Public Administration and Defence' (ISIC 84) includes public investment in hospitals as well as investment in the U.S. postal service (ISIC 53).


