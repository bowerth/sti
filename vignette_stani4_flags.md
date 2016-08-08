---
title: "STANi4 Data Flags"
layout: default
output: bookdown::html_chapter
---

# Data flags in the STAN application

Where data points have been estimated, this is highlighted in the STAN tables with grey-shaded font colour and additionally in the corresponding M-file. In these, each cell represents a flag value and corresponds to a data point. Estimates carry a flag beginning with capital "E" whereas official values commence with a "\*" followed by the abbreviation of the official source (mainly *NSO* standing for *National Statistical Office* or *ANA* for data submitted to the OECD, see section on Annual National Accounts below. Additionally, data notes distinct by the type of estimate, identifying the type of data on which specific estimates (such as *backcasts*) are based. A summary is given in table below. Additional information concerning estimates in STAN can be found in the section on earlier versions of STAN.

<!-- 
|Flag  |Explanation                                         |
|:-----|:---------------------------------------------------|
|E1    |Estimates based on (a) ISIC Rev.3 business survey/census results officially submitted to OECD's Structural Statistics for Industry and Services (SSIS) database; (b) Structural Business Statistics available from Eurostat's "New Cronos" online service; or (c) business survey/census results obtained directly from NSOs and converted from national SIC to ISIC Rev.3. |
|E2    |(Aggregate sectors only) Estimates based on old SNA68 / ISIC Rev.2 ANA (or ISDB) data |
|E3    |Estimates based on figures from last ISIC Rev.2 version of STAN; for exports and imports these were conversions from SITC Rev.2 trade data |
|E4    |Other estimates: (a) estimates of detailed sectors based on detail from closely related variables; (b) for exports and imports, HS1 converted data with further adjustments |
|E5    |(Nowcast, latest years only) estimates based on short-term indices officially submitted to OECD's Indicators of Industry and Services  (IIS) database |
 -->

E1
:   Estimates based on (a) ISIC Rev.3 business survey/census results officially submitted to OECD's Structural Statistics for Industry and Services (SSIS) database; (b) Structural Business Statistics available from Eurostat's "New Cronos" online service; or (c) business survey/census results obtained directly from NSOs and converted from national SIC to ISIC Rev.3.

E2
:   (Aggregate sectors only) Estimates based on old SNA68 / ISIC Rev.2 ANA (or ISDB) data

E3
:   Estimates based on figures from last ISIC Rev.2 version of STAN; for exports and imports these were conversions from SITC Rev.2 trade data

E4
:   Other estimates: (a) estimates of detailed sectors based on detail from closely related variables; (b) for exports and imports, HS1 converted data with further adjustments

E5
:   (Nowcast, latest years only) estimates based on short-term indices officially submitted to OECD's Indicators of Industry and Services  (IIS) database
