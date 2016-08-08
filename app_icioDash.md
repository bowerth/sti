---
title: ICIO Dashboards
layout: default
output: bookdown::html_chapter
---

# ICIO Dashboards

<img src="diagrams/icioDash_menu.png" alt="ICIO Dashboards Menu"/>

The application source code is available on
[GitHub](https://github.com/bowerth/desk/blob/master/inst/industry/tools/indic/icioDash.R)

The current setup is demand country = `WOR` (total world, i.e. all columns)

Additional information is available from the help pop-up within the application

# Examples

## Gross trade share by partner region

Chart type
:   `GRTRnoDomestic`

Exporting Country List
:   `CAN FRA DEU MEX USA CHN`

Plot Exporting Country
:   `CAN FRA`

Year
:   `2008`

calculate share in total exports
:   `true`

![icioDash_plot_grtr](figures/app_icioDash/icioDash_plot_grtr.png)

## Value-added by source industry

Chart type
:   `VAsource`

(other parameters as above)

![icioDash_plot_va](figures/app_icioDash/icioDash_plot_va.png)
