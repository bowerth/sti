---
title: "STANi4 Updating"
layout: default
output: bookdown::html_chapter
---

# Updating STAN

## Criteria for updates {#criteria}

Updates of STAN take place according to availability of data from NSOs.

### Timing

STAN is updated on a country-by-country basis. The first step is to ensure that the maximum amount of publicly available National Accounts by activity data has been obtained to act as the *primary source*. For countries that don't use ISIC Rev.4 or NACE Rev.2, the data are then converted from the national industrial classification to ISIC Rev.4 using a country-specific conversion key. Almost all countries use annually re-weighted chained methodology. Volumes are aggregated to STAN industries following national practice - for example, chained Fisher aggregates are calculated for the United States, chained Laspeyres aggregates for France.

### Secondary Sources

The next step is to ensure that the latest available ISIC Rev.4 business survey data (from SSIS and SBS) has been loaded into the STAN system together with data from earlier versions of STAN and ANA, approximately converted to ISIC Rev.4. These are the *secondary sources*. For each variable, if (i) more industry detail is available from the *secondary sources* than latest (SNA93) National Accounts, and/or (ii) any of the *secondary sources* extend further back in time than the latest National Accounts, a general estimation program is then run to fill in as many gaps as possible.

## Estimation Routine {#estimation}

Using the __hierarchical structure__ of the industry list, the estimation program performs the following:

  - At all levels of industry where data are available for the primary source (e.g. ISIC 13-15), the time-series correlations between the primary source and the secondary sources are calculated to chose best secondary source (such as industrial survey data or old National Accounts series) for filling in further detail (e.g. ISICs 13, 14 and 15) and where necessary extending the series backwards;
to estimate missing detail, the chosen secondary source data are adjusted for each year according to the relationship between the primary source and secondary source data at the lowest level that they coincide (e.g. ISIC 13-15). The implicit assumption being that the relative distribution of the secondary source data within the subgroup is valid for the primary source (i.e. National Accounts). In general, extra detail is only estimated for current price measures and for manufacturing industries only
  - To extend series backwards, the chosen secondary source data are linked to the primary source data at the first available year for the primary source data
  - Dinally, further adjustments to the estimates may be made to ensure that data in each level of the hierarchy of the industry list sums to the data at the superior level of the hierarchy

### Quality Checks

Following the estimation procedure, quality control checks are made using graphs and summary statistics. Ratios of variables are checked for consistency, while taking account of why some anomalies may occur, and comparisons are made with earlier versions of STAN. Consistency with other OECD National Accounts based data sets is also verified.
