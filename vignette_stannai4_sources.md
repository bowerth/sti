---
title: "STANNAi4 Sources"
layout: default
output: bookdown::html_chapter
---

# National Accounts ISIC Rev. 4 Data Sources

This chapter summarizes various types of STAN-type National Accounts by economic activity data sources in ISIC Rev. 4.

## Eurostat Annual National Accounts detailed breakdowns NACE Rev. 2 {#DATA.EUNAMAR2}
### Description 

 National accounts are a coherent and consistent set of macroeconomic indicators, which provide an overall picture of the economic situation and are widely used for economic analysis and forecasting, policy design and policy making. Eurostat publishes annual and quarterly national accounts, annual and quarterly sector accounts as well as supply, use and input-output tables, which are each presented with associated metadata.

### Format 
  - A data frame with 383311 observations on the following 5 variables.

  - `cou`, a factor with levels AUT, BEL, BGR, CHE, CYP, CZE, DEU, DNK, ESP, EST, FIN, FRA, GBR, GRC, HUN, IRL, ISL, ITA, LIE, LTU, LUX, LVA, MKD, MLT, MNE, NLD, NOR, POL, PRT, ROU, SVK, SVN, SWE, TUR
  - `var`, a factor with levels PROD, PRDK, INTI, INTK, VALU, VALK, LABR, WAGE, NOPS, CFCC, OTXS, EMPN, EMPE, SELF, FTEN, FTEE, JOBN, JOBE, HRSN, HRSE
  - `ind`, a factor with levels DTOTAL, D01T03, D01, D02, D03, D05T09, D10T33, D10T12, D13T15, D16T18, D16, D17, D18, D19, D20, D21, D22T23, D22, D23, D24T25, D24, D25, D26, D27, D28, D29T30, D29, D30, D31T33, D31T32, D33, D35, D36T39, D36, D37T39, D41T43, D45T47, D45, D46, D47, D49T53, D49, D50, D51, D52, D53, D55T56, D58T63, D58T60, D58, D59T60, D61, D62T63, D64T66, D64, D65, D66, D68, D69T75, D69T71, D69T70, D71, D72, D73T75, D73, D74T75, D77T82, D77, D78, D79, D80T82, D84, D85, D86T88, D86, D87T88, D90T93, D90T92, D93, D94T96, D94, D95, D96, D97T98, D99
  - `year`, a numeric vector
  - `value`, a numeric vector

### Details 

 For details, see references

### References 

 http://ec.europa.eu/eurostat/web/national-accounts/overview

## OECD STructural ANalysis Database ISIC Rev. 4 {#DATA.STANi4}
### Description 

 The "STAN database for Industrial Analysis" provides analysts and researchers with a comprehensive tool for analysing industrial performance at a relatively detailed level of activity. It includes annual measures of output, labour input, investment and international trade that allow users to construct a wide range of indicators to focus on areas such as productivity growth, competitiveness and general structural change. Through the use of a standard industry list, comparisons can be made across countries. The industry list provides sufficient detail to enable users to highlight high-technology sectors and is compatible with those used in related OECD databases.

### Format 
  - A data frame with 749628 observations on the following 5 variables.

  - `cou`, a factor with levels AUS, AUT, BEL, CAN, CHE, CHL, CZE, DEU, DNK, ESP, EST, FIN, FRA, GBR, GRC, HUN, IRL, ISL, ITA, JPN, KOR, LUX, MEX, NLD, NOR, NZL, POL, PRT, SVK, SVN, SWE, USA
  - `var`, a factor with levels CAPG, CAPN, CFCC, CPGK, CPNK, EMPE, EMPN, EXPO, FTEE, FTEN, GFCF, GFCK, GFCP, GOPS, HRSE, HRSN, IMPO, INTI, INTK, INTP, LABR, NOPS, OTXS, PRDK, PRDP, PROD, SELF, VAFC, VALK, VALP, VALU, WAGE
  - `ind`, a factor with levels D01, D01T02, D01T03, D02, D03, D05, D05T06, D05T09, D05T39, D05T82X, D06, D07, D07T08, D08, D09, D10, D10T11, D10T12, D10T33, D11, D12, D13, D13T14, D13T15, D14, D15, D16, D16A31, D16T18, D17, D18, D181, D182, D18A58, D19, D19T23, D20, D20T21, D21, D22, D22T23, D23, D24, D241T31, D242T32, D24T25, D24T33X, D25, D252, D25X, D26, D261, D262, D263, D264, D265, D266, D267, D268, D26T27, D26T28, D26X, D27, D28, D29, D29T30, D30, D301, D302A9, D303, D304, D31, D31T32, D31T33, D32, D325, D33, D35, D35T39, D36, D36T39, D37, D37T39, D38, D39, D41, D41T43, D42, D43, D45, D45T47, D45T56, D45T82, D45T82X, D45T99, D46, D465, D466, D46X, D47, D49, D49T53, D50, D51, D52, D53, D53A61, D55, D55T56, D56, D58, D581, D582, D58T60, D58T63, D59, D59T60, D60, D61, D62, D62T63, D63, D631, D639, D64, D64T66, D65, D66, D68, D68T82, D69, D69T70, D69T71, D69T75, D69T82, D70, D71, D72, D73, D73T75, D74, D74T75, D75, D77, D77T82, D78, D79, D80, D80T82, D81, D82, D84, D84T88, D84T99, D85, D86, D86T88, D87, D87T88, D88, D90, D90T92, D90T93, D90T96, D90T99, D91, D92, D93, D94, D94T96, D95, D951, D96, D97, D97T98, D98, D99, DTOTAL, ENERGYP, NONMAN
  - `year`, a numeric vector
  - `value`, a numeric vector

### Details 

 For details, see references

### References 

 http://www.oecd.org/sti/stan

## OECD STD/NAD Annual National Accounts Value added and its components by activity ISIC Rev. 4 {#DATA.STDSNAi4}
### Description 

 Its presents output, intermediate consumption and the gross value added and its components, in particular compensation of employees and gross operating surplus and mixed income, broken down by detailed industries according to the classification ISIC Rev. 4. It has been prepared from statistics reported to the OECD by Member countries in their answers to annual national accounts questionnaire. This questionnaire is designed to collect internationally comparable data according to the 1993 SNA.

### Format 
  - A data frame with 95881 observations on the following 5 variables.

  - `cou`, a factor with levels AUS, AUT, BEL, CAN, CHL, CZE, DEU, EST, FIN, FRA, GBR, ISL, JPN, KOR, MEX, NLD, NOR, NZL, POL, RUS, SWE, USA
  - `year`, a numeric vector
  - `var`, a factor with levels CAPG, CAPN, CFCC, CFCK, CPGK, CPNK, EMPE, EMPN, FTEE, FTEN, GFCF, GFCK, GOPS, HRSE, HRSN, INTI, JOBE, JOBN, LABR, NOPS, OTXS, PRDK, PROD, VAK2, VALK, VALU, WAGE
  - `ind`, a factor with levels DTOTAL, D01, D02, D03, D05T09, D05, D06, D07, D08, D09, D10T33, D10T12, D10, D11, D12, D13T15, D13, D14, D15, D16T18, D16, D17, D18, D19, D20, D21, D22T23, D22, D23, D24T25, D24, D25, D26, D27, D28, D29T30, D29, D30, D31T33, D31T32, D31, D32, D33, D35, D36T39, D36, D37T39, D37, D38, D39, D41T43, D41, D42, D43, D45T47, D45, D46, D47, D49T53, D49, D50, D51, D52, D53, D55T56, D55, D56, D58T63, D58T60, D58, D59T60, D59, D60, D61, D62T63, D62, D63, D64T66, D64, D65, D66, D68, D69T75, D69T71, D69T70, D69, D70, D71, D72, D73T75, D73, D74T75, D74, D75, D77T82, D77, D78, D79, D80T82, D80, D81, D82, D84, D85, D86T88, D86, D87T88, D87, D88, D90T93, D90T92, D90, D91, D92, D93, D94T96, D94, D95, D96, D97T98, D97, D98, D99
  - `value`, a numeric vector

### Details 

 For details, see references

### References 

 http://www.oecd.org/std/na/

## Data Packaging

![STANNAi4.rda](diagrams/stannai4.svg)

