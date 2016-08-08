---
title: ICIO FDDVA
layout: default
output: bookdown::html_chapter
---

# Foreign Demand Domestic Value-Added

<img src="diagrams/icioFddva_menu.png" alt="ICIO FDDVA Menu"/>

The application source code is available on
[GitHub](https://github.com/bowerth/desk/blob/master/inst/industry/tools/indic/icioFddva.R)

Indicators from the ICIO system
:   Input-Output calculations use linear algebra to obtain potentially large numbers of results. The calculations are fairly complex from the perspective of non-expert users and thus difficult to replicate. The [Trade in Value-Added](http://www.oecd.org/sti/ind/measuringtradeinvalue-addedanoecd-wtojointinitiative.htm) initiative has highlighted the importance of this type of indicators.

Reasons for implementation
:   With the popularity of Trade in Value-Added indicator results for Global Value Chain discussions, demand for specific calculations have been taking up expert resources that are also required in the development of data sources and methodologies. The application takes over the indicator calculation and dissemination part where user demands go beyond published core indicators. To observe the ceteris paribus effects of data modifications on indicator results, it is helpful to use a self-standing calculation system. Underlying data of relatively small size are the only inputs into the system.

Data sources
:   Numbers underlying the calculations have the form of coefficient and data matrices matrices. This data has been compiled by the Directorate for Science, Technology and Innovation. Initially, it will not be made available to users. We consider giving access to authenticated users in the future.

## Interactive World Map Visualisation

<!-- generated from C:\Users\Werthb\Dropbox\GitHub\desk\inst\industry\tools\indic\icioFddva.R -->
<iframe src="/figures/app_icioFddva/fddva_map" marginwidth="0" marginheight="0" scrolling="no" width="800" height="400" frameborder="0"></iframe>

This map was generated using [rMaps](https://github.com/ramnathv/rMaps/), [datamaps](http://datamaps.github.io/) and the parameters listed below:

Coefficients
:   Value-added

Year
:   2009

Demand Concept
:   Final demand

Export Region
:   East Asia

Demand Region
:   EU27

Source Region
:   OECD

Demand or Final Expenditure Industry
:   Total Manufacturing (C15T37)
