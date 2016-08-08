---
title: "STANi4 Variables"
layout: default
output: bookdown::html_chapter
---

# Variables in STAN

To meet the basic requirements of international research and analysis in areas such as productivity, competitiveness and general structural change, STAN provides the variables presented below :

<!--
```{r kable, eval = FALSE, results = "asis", echo = FALSE, message = FALSE}
require(stan)
require(utils)
require(knitr)
data(stanDim)
stan_vars <- STAN.VARLABEL
ls()
stan_vars$sna <- "      "
stan_vars <- subset(stan_vars, select = c("sna", "var", "label"))
kable(stan_vars)
```
-->

|transact |measure |var  |label                                                 |
|:--------|:-------|:----|:-----------------------------------------------------|
|P1       |V       |PROD |Production (gross output), current prices             |
|P1       |L       |PRDK |Production (gross output), volumes                    |
|P1       |Y       |PKPY |Production (gross output), volumes, previous year     |
|         |        |PKOT |Production (gross output), volumes, other measure     |
|         |        |PRDP |Production (gross output), deflators                  |
|P2       |V       |INTI |Intermediate inputs, current prices                   |
|P2       |L       |INTK |Intermediate inputs, volumes                          |
|P2       |Y       |IKPY |Intermediate inputs, volumes, previous year           |
|         |        |IKOT |Intermediate inputs, volumes, other measure           |
|         |        |INTP |Intermediate inputs, deflators                        |
|B1G      |V       |VALU |Value added, current prices                           |
|B1G      |L       |VALK |Value added, volumes                                  |
|B1G      |Y       |VKPY |Value added, volumes, previous year                   |
|         |        |VKOT |Value added, volumes, other measure                   |
|         |        |VALP |Value added, deflators                                |
|         |        |VAFC |Value added at factor costs, current prices           |
|D1       |V       |LABR |Labour costs (compensation of employees)              |
|D11      |V       |WAGE |Wages and salaries                                    |
|B2N_B3N  |        |GOPS |Gross operating surplus and mixed income              |
|         |        |NOPS |Net operating surplus and mixed income                |
|K1       |V       |CFCC |Consumption of fixed capital                          |
|D29X39   |V       |OTXS |Other taxes less subsidies on production              |
|EETO     |M       |EMPN |Number of persons engaged (total employment)          |
|EEEM     |M       |EMPE |Number of employees                                   |
|EESE     |M       |SELF |Self-employed                                         |
|EETO     |T       |FTEN |Full-time equivalents - total engaged                 |
|EEEM     |T       |FTEE |Full-time equivalents - employees                     |
|EETO     |O       |JOBN |Total employment - number of jobs                     |
|EEEM     |O       |JOBE |Employees - number of jobs                            |
|EETO     |H       |HRSN |Hours worked - total engaged                          |
|EEEM     |H       |HRSE |Hours worked - employees                              |
|P51      |V       |GFCF |Gross fixed capital formation, current prices         |
|P51      |L       |GFCK |Gross fixed capital formation, volumes                |
|P51      |Y       |GKPY |Gross fixed capital formation, volumes, previous year |
|         |        |GKOT |Gross fixed capital formation, volumes, other measure |
|         |        |GFCP |Gross fixed capital formation, deflators              |
|N11_U    |        |CAPG |Gross capital stock, current prices                   |
|N11_O    |        |CPGK |Gross capital stock, volumes                          |
|         |        |CGPY |Gross capital stock , volumes, previous year          |
|         |        |CGOT |Gross capital stock , volumes, other measure          |
|         |        |CPGP |Gross capital stock , deflators                       |
|T11_U    |        |CAPN |Net capital stock, current prices                     |
|T11_O    |        |CPNK |Net capital stock, volumes                            |
|         |        |CNPY |Net capital stock, volumes, previous year             |
|         |        |CNOT |Net capital stock, volumes, other measure             |
|         |        |CPNP |Net capital stock, deflators                          |
|         |        |EXPO |Exports of goods at current prices                    |
|         |        |IMPO |Imports of goods at current prices                    |
|         |        |MFPI |Multi-factor productivity, growth rate                |
|         |        |RDNC |Rd expenditures                                       |

Variable __coverage__ for each country depends on:

  - whether national statistical offices compile the measures by industrial activity in the context of Annual National Accounts;
  - the extent of *'back estimates'* made by national statistical offices after revisions of National Accounts -- most recently, to comply with the recommendations of the international manual *A System of National Accounts, 1993 (SNA93)* or the European equivalent *European System of Accounts, 1995 (ESA95)*. See INSERT LINK for additional information on the versions of SNA
  - the availability of business survey/census data (for detailed sectors).

An Excel file giving full details of current data coverage by country, variable and industry is provided in the [__related files__](http://www.oecd.org/document/34/0,3746,en_2649_34173_48603810_1_1_1_1,00.html) download section of the STAN database on [OECD.Stat](http://stats.oecd.org/Index.aspx?DataSetCode=STAN08BIS) and on the [STAN homepage](http://www.oecd.org/sti/stan).

The notes below provide general descriptions of the variables in STAN based on SNA93 definitions. Where national practices are known to differ, appropriate information is provided in the STAN Country Notes.

## Data Units {#units}

  - Current price data (PROD, INTI, VALU, GFCF, LABR, EXPO etc.): millions or billions of national currency, i.e. euro for EMU countries (see Annex INSERT LINK)
  - Volumes (PRDK, INTK, VALK and GFCK) and capital stock data (CPGK, CPNK): index number with the national reference year = 100 (commonly 2000, though more countries are moving towards using 2005 as the reference year)
  - Employment data (EMPN, EMPE, FTEN, FTEE): hundreds or thousands
  - Hours worked (HRSN, HRSE): thousands or millions

Further details of units used for each country are provided in the STAN Country Notes.

## Gross Output and Intermediate inputs {#prod-inti}
*Production (PROD)* represents the value of goods and/or services produced in a year, whether sold or stocked. The related measure *Turnover* (not present in STAN) corresponds to the actual sales in the year and can be greater than *Production* in a given year if all production is sold together with stocks from previous years. While *Production* and *Turnover* will be different in a year, their averages over a long period of time should converge (depending on how perishable the stock is).

*Intermediate inputs (INTI)* of consumption represents the value of inputs into processes of production that are used up within the accounting period -- these include energy, materials, services (including any rentals for machinery and equipment but not capital services from own machinery and equipment, which are included within *Value Added*).

National statistical agencies typically derive constant price data or volume indices by applying detailed deflators based on *Producer Price indices (PPIs)* or *Consumer Price indices (CPIs)* coming from detailed surveys. Volumes for activity groups are either fixed-weight Laspeyres aggregates (e.g. Germany and Italy) or annually re-weighted chained aggregates (e.g. USA, France, Australia) of the volumes of detailed sectors.

Some care should be taken with the interpretation of *Production* since it includes *Intermediate Inputs*. Any output of intermediate goods consumed within the same sector is also recorded as output -- the impact of such intra-sector flows depending on the coverage of the sector. For this reason, *Value Added* is often considered a better measure of output.

*STAN codes:* PROD, PRDK, INTI, INTK


## Value Added {#valu}

Gross *Value Added* (VALU) for a particular industry represents its contribution to national GDP. It is sometimes referred to as GDP by industry. It is not directly measured. In general, it is calculated as the difference between *Production* and *Intermediate inputs*. *Value Added* comprises *Labour Costs* (see *Compensation of Employees (LABR)*), *Consumption of Fixed Capital*, *Taxes less Subsidies* (the nature of which depends on the valuation used -- see below) and *Net Operating Surplus and Mixed Income* (see *Consumption of Fixed Capital (CFCC)*).

The type of *Value Added* measure presented in STAN varies across countries depending on the extent to which taxes and subsidies are included. The following outline summarises different *Valuations of Value Added* and the relationships between them.

Value added at __Market Prices__ includes:

  - Trade and trasport costs
  - Non-deductible VAT
  - Taxes, less subsidies, *on imports*
  - Value added at __Producer's Prices__, including:

	  - Taxes, less subsidies, *on products*
	  - Value added at __Basic Prices__, including:

		- Other taxes, less subsidies, *on production*
		- Value added at __Factor Costs__.

In STAN, the variable VALU (and VALK) represents *Value Added* at the valuation most commonly presented in national publications (particularly for volumes/constant price data) and/or officially submitted to OECD's Annual National Accounts (ANA) database. For most countries, in line with SNA93 (or in Europe, ESA95) recommendations, *Value Added* at *Basic Prices* are presented. Other valuations used include factor costs in Canada and *Producer's Prices* in USA. Note that while total intermediate consumption by an industry is valued at Purchaser's Prices, in an input-output framework the separate transactions by type of product can be valued at Basic and Producer's Prices for example.

National statistical offices calculate *Value Added volumes* (VALK) by using either a *single-* or *double-deflation* method. In double-deflation *Production* and *Intermediate Inputs* are deflated at the most detailed level and *Value Added volumes* calculated as the difference. In single deflation, deflators for gross output are applied directly to *Value Added*. Volumes for the broader activity groups are either fixed-weight Laspeyres aggregates (for example, Germany and Italy) or annually re-weighted chained aggregates (for example, USA, France and Sweden) of the volumes of detailed sectors\footnote{All European countries have adopted a chained, annually re-based Laspeyres method.}. Chained indices are preferable when quality-adjusted or *hedonic* deflators have been used in IT sectors as is the case in USA. See OLIS link ["Computer Price Indices and International Growth and Productivity Comparisons", OECD May 2001](http://www.olis.oecd.org/olis/2001doc.nsf/LinkTo/STD-DOC(2001)1) for further details. Double-deflation is recommended by SNA93 as it allows prices of inputs to deviate from prices of output. However, the data requirements are more extensive and since *Value Added* is derived as a residual it can lead to biased results from relatively small errors in the accuracy of deflation.

__Volume series__ (PRDK, INTK, GFCK as well as VALK) are presented as indices in STAN. For all countries except the United States, the national reference/base year equals 100 (commonly 2000, though more countries are moving towards using 2005 as the reference year) -- no attempt is made to re-index series to a common reference year to avoid giving users the misleading impression that the volumes have actually been re-based (for example, volume series for Canada and Mexico are shown as 2007=100 and 2003=100 respectively, reflecting national practice). For countries that use annually re-weighted chained methodology for calculating volumes, the indices can be legitimately transformed to a new reference year if required.

*Financial Intermediation Services Indirectly Measured* (__FISIM__ -- formerly known as *Imputed Bank Service Charges*) are generally allocated\footnote{Note that according to EU Council Regulation 448/98, EU Member States are required to allocate FISIM in their National Accounts from 2005. See [http://eur-lex.europa.eu/LexUriServ/LexUriServ.do?uri=OJ:L:1998:058:0001:0014:EN:PDF](http://eur-lex.europa.eu/LexUriServ/LexUriServ.do?uri=OJ:L:1998:058:0001:0014:EN:PDF) to intermediate inputs by activity and deducted from *Value Added* at the total economy level to arrive at total GDP.

Finally, the STAN industry list includes an alternative aggregate for use when comparing *Value Added*, *Employment* or *Gross Fixed Capital Formation* or derived indicators (such as productivity) across countries. *"Non-agriculture business sector"* (STAN code 05-82) does not include the following activities:

  - *"Agriculture, Hunting, Forestry and Fishing"* (ISIC 01-03). Problems measuring *Employment* can occur in some countries where familiy members are involved in activities but not registered accordingly.
  - *"Real Estate Activities"* (ISIC 68) contributes over 10\% to total OECD area *Value Added*. Even though some residential investment included in this sector, a significant proportion of its *Value Added* consists of *"Imputed rent of owner-occupied dwellings"*. Since this is a pure National Accounts imputation with neither buyers and sellers nor any associated labour input, the inclusion of *"Real Estate Activities"* can distort productivity measures; particularly, as volume growth of *Owner-occupied dwellings* differs from that for *Other Business Services*. Also, most residential investment is allocated to this sector so excluding this activity (along with *Agriculture, Hunting, Forestry and Fishing*) provides an aggregate of non-residential investment and capital stock;
  - *"Community, Social and Personal Services"* (ISIC 84-99). This mainly consists of non-market activities such as *"Public Administration"*, *"Education"* and *"Health Services"*. Measurement of output of public services is challenging and varies across countries. Many countries use labour input growth (such as *Employment*) to estimate output volume growth which may undermine the validity of indicators such as productivity. Also, the extent to which these services are public varies across countries. (In this context one should note that this is not the only area where some assumptions are made regarding productivity. Some countries for example use wage-based indices adjusted for (estimated) productivity changes as deflators in service industries. And in Italy, for example, significant assumptions about *Value Added per Employee* rates are used in estimating the output of unregistered employees.)

Further discussion on the measurement of output can be found in Chapter 3 of [*OECD's Manual on Productivity Measurement*](http://www.oecd.org/dataoecd/59/29/2352458.pdf) and in [*Comparing Labour Productivity Growth in the OECD Area: The Role of Measurement*](http://www.oecd.org/officialdocuments/displaydocument/?doclanguage=en\&cote=std/doc(2003)5).

*STAN codes:* VALU, VALK

## Labour Costs {#labr}

*Labour Costs* or *Compensation of Employees* (LABR), the major component of *Value Added*, comprises of wages and salaries of employees paid by producers as well as supplements such as contributions to social security, private pensions, health insurance, life insurance and similar schemes. When available, *Wages and Salaries* (WAGE) are given separately in STAN.

Note that *Labour Costs* can exceed *Value Added* in certain cases. For example, when heavy losses are incurred within a sector or, more generally, when a sector's *Gross Operating Surplus* (see below) is negative and/or it receives significant subsidies.

*STAN codes:* LABR, WAGE

## Consumption of Fixed Capital, Operating Surplus and Mixed Income {#cfcc}

*Consumption of Fixed Capital* (CFCC) represents the reduction in the value of fixed assets used in production resulting from physical deterioration, normal foreseen obsolescence or normal accidental damage.

*Operating Surplus and Mixed Income* (GOPS, NOPS) measures the surplus or deficit accruing from production before taking account of any interest, rent or similar charges payable on financial or tangible non-produced assets borrowed or rented by the enterprise and/or interest, rent or similar receipts receivable on assets owned by the enterprise. It implicitly includes remuneration of the self-employed (owners and family members).

Some countries only provide *__Gross__ Operating Surplus and Mixed Income* which includes CFCC. Otherwise, CFCC and *__Net__ Operating Surplus and Mixed Income* are provided separately.

When *__Gross__ Operating Surplus and Mixed Income* only is provided this is indicated in the STAN Country Notes.

*STAN codes:* CFCC, GOPS, NOPS

## Employment {#empn}

Measures of employment differ across countries with variants of some of the following being provided:

  - *Headcounts* - actual number engaged, number of employees (full- and part-time);
  - *Number of Jobs* - those with more than one job (full- or part-time) are counted more than once;
  - *Full-time Equivalent Jobs* (FTE) - where adjustments are made for part-time employment.

For most countries, headline total employment by activity tables are based on headcounts. However, number of jobs is used by some (e.g. Canada, Japan and UK) while others use some notion of full-time equivalence (e.g. USA and Italy). Also, while many countries use 12-month averages for annual employment data, some countries use mid-year estimates (employment for a particular day, week or month each year). For the latter, whether or not the underlying time series have been seasonally adjusted or not can make a notable difference to the levels.

SNA93 recommends *Number of Jobs* as it is deemed more useful in indicating how industry-specific needs for labour shape the production process than *Headcounts*. For the purposes of productivity measurement SNA93 also recommends providing *Hours Worked* (actually worked, not just paid for) and/or *Full-time Equivalent Jobs* (which is defined as total hours worked divided by average annual hours worked in full-time jobs).

For many countries the ultimate source for employment data are establishment surveys and/or labour force surveys with adjustments being made to make them more relevant in a National Accounts context.

In STAN, the variables EMPN and EMPE usually represent *Headcounts*, in some cases *Number of Jobs* while FTEN and FTEE contain *Full-time Equivalent Jobs* whenever available. HRSN and HRSE contain *Hours Worked* data if available (ideally hours actually worked per person per year). Exact definitions are provided in the STAN Country Notes.

*Total employment* (EMPN and FTEN) includes all persons engaged in domestic production while *Number of Employees* (EMPE and FTEE) excludes the self-employed and unpaid family workers. The domestic concept of employment (recommended in SNA93) is generally used by OECD countries - all persons engaged in the domestic production of a country are included whether or not they are resident in that country.

Comprehensive discussion on the measurement of labour inputs can be found in Chapter 4 of \href{http://www.oecd.org/dataoecd/59/29/2352458.pdf}{*OECD's Manual on Productivity Measurement*}, in [*Comparing Labour Productivity Growth in the OECD Area: The Role of Measurement*](http://www.olis.oecd.org/olis/2003doc.nsf/43bb6130e5e86e5fc12569fa005d004c/9e23dddd1f809458c1256dfa004b846b/\$FILE/JT00155826.PDF) and in the work of the [Paris Group Bureau on the measurement of labour inputs](http://www.insee.fr/en/insee-statistique-publique/default.asp?page=colloques/citygroup/citygroup.htm).

*STAN codes:* EMPN, EMPE, FTEN, FTEE, HRSN, HRSE

## Investment, Capital Stock {#gfcf}

*Gross Fixed Capital Formation* (GFCF) consists of acquisitions, less disposals, of tangible assets (such as machinery and equipment, transport equipment, livestock, constructions) and new intangible assets (such as mineral exploration and computer software) to be used for more than one year.\footnote{Assets used up in less than one year are generally considered to be intermediate inputs} Excluded are acquisitions of land, mineral deposits, timber tract etc (although their improvement and development are included) and government outlays primarily for military purposes.

Note that certain intangible assets, such as computer software, now considered investment goods under SNA93, were previously treated as *Intermediate Inputs*. See [Report of the OECD Task Force on Software Measurement in the National Accounts](http://www.olis.oecd.org/olis/2003doc.nsf/43bb6130e5e86e5fc12569fa005d004c/d8f1806485a1962dc1256cdf004c8bc8/\$FILE/JT00140251.PDF) and STI working paper [*"Measuring Investment in Software"*](http://www.olis.oecd.org/olis/2003doc.nsf/linkto/dsti-doc(2003)6).

*Gross Capital Stock* (GFCK) represents the volume of existing physical capital assets available to producers and is the sum of all past investments in assets with each vintage valued at prices "as new" - regardless of the age and condition of the assets. It is a gross measure in the sense that it neither accounts for depreciation nor physical efficiency losses of capital goods - it reflects only retirement of goods.

*Net Capital Stock* (CPNK) is the value of all vintages of assets to owners where valuation reflects market prices for *new and used* assets. It is also referred to as Wealth Capital Stock as it reflects current monetary values of capital goods rather than continuing utility.

An alternative measure, preferred by some countries, is *Productive Capital Stock* which attempts to measure more accurately the level of services provided by the assets in question by taking into account reduction in utility (or *efficiency decline*), rather than depreciation in value, before retirement.

Comprehensive discussion on the measurement of capital inputs can be found in chapter 5 of [*OECD's Manual on Productivity Measurement*](http://www.oecd.org/dataoecd/59/29/2352458.pdf), in [*OECD's manual on Measuring Capital*](http://www.oecd.org/dataoecd/61/57/1876369.pdf), and in [*OECD Capital Services Estimates: Methodology and a First Set of Results*](http://www.olis.oecd.org/olis/2003doc.nsf/43bb6130e5e86e5fc12569fa005d004c/8b6d471e7782b046c1256e01005ab375/\$FILE/JT00156193.PDF).

As a simple illustration of one of the differences between capital stock measures - a particular asset may have the following decay patterns before retirement at time *t*, depending on which measure of capital stock is being considered:

<!--
```{r data_stan_variables_depreciation, eval = FALSE, fig.width = 7, fig.height = 2.5, echo = FALSE, message = FALSE}
# x <- c(1:100)
# limits <- c(0, 1.2 * max(x))
# y1 <- c(rep(100, length(x)-1), 0)
# y2 <- 100 * x^(-1/2); y2[length(x)] <- 0
# y3 <- 100 - 100 * rev(x)^(-1/2); y3[length(x)] <- 0
# par(mfrow = c(1, 3), mgp = c(1, 1, 0))
# plot(x, y1, type = "l", xlim = limits, ylim = limits, xaxt = "n", yaxt = "n", xlab = "time", ylab = "value", cex.lab = 1.5, main = "Gross Capital Stock")
# plot(x, y2, type = "l", xlim = limits, ylim = limits, xaxt = "n", yaxt = "n", xlab = "", ylab = "", main = "Net (or Wealth) Capital Stock")
# plot(x, y3, type = "l", xlim = limits, ylim = limits, xaxt = "n", yaxt = "n", xlab = "", ylab = "", main = "Productive Capital Stock")
```
 -->

<img src="diagrams/capital_stock_depreciation.svg" alt="Capital Stock Depreciation" style="width: 650px"/>

Currently, only capital stock data by activity that are provided by national authorities are presented in STAN. No attempt is made to make estimates for other countries (based on the perpetual inventory model, for example) since the required underlying SNA93 investment volumes by industry are often not available.

Non-residential investment by industry is the preferred measure in STAN. However, some countries' tables of investment by activity include residential investment. For this reason, it is useful to exclude activities such as *"Agriculture, Hunting, Forestry and Fishing"* (ISIC 01-03) and *"Real Estate Activities"* (ISIC 68) when comparing across countries, making use of the alternative STAN aggregate *"Non-agriculture business sector"* (STAN code 05-82).

*STAN codes:* GFCF, GFCK, CPGK, CPNK

## Exports and Imports of goods {#expo-impo}

In the absence of National Accounts compatible tables of international trade in goods by industry, estimates of exports and imports at current prices in STAN are derived from detailed trade in commodities statistics using a standard conversion from the product-based classification Harmonised System Rev.1 (HS1) to ISIC Rev.4 (details of the conversion key used can be found in the Variable Notes for exports and imports in the STAN application). This conversion regime provides estimates by industry from 2005. For earlier years, old STAN ISIC Rev.3 estimates (as well as contained ISIC Rev.2 estimates converted from SITC Rev.2) are linked after being approximately mapped to ISIC Rev.4.
Note that Balance of Payments accounts only show exports and imports for total goods. In most countries, no attempts are made to perform the necessary Balance of Payments adjustments by product-group nor by industrial activity.

Note that *Exports* can exceed *Production* for the following reasons:
  - *Exports* may include re-exports;
  - Production data are often based on industrial surveys which allocate establishments to ISIC according to their primary activity. Therefore, activities that are mainly secondary may be understated in terms of production by not being allocated to the relevant ISIC activity while exports of the related commodities are recorded;
  - For many countries *Exports* are valued at Purchaser's Prices at the frontier (or f.o.b., *"free on board"*) while *Production* is often valued at Basic Prices;
  - A bias may be introduced by the standard conversion from product-based trade statistics to activity-based industry statistics for certain sectors for certain countries.

*STAN codes:* EXPO, IMPO
