---
title: "STAN API Data"
layout: default
output: bookdown::html_chapter
---

# API Data in STAN

## Integration Steps

### Harmonization

- harmonize `ind` and `var` dimensions
- harmonize data units (monetary: units of national currency, employment numbers: thousands)
- transform chain-linked series into previous-year-price series
- add STAN industry aggregates and variables

## Checks on Input Data

### Completeness of industry conversion

list aggregates with partially missing industries (do not list if all
parts are missing)

listMissInd
:   `stan::listMissInd(data = pxweb_data_conv, isic = 4, drop = TRUE)``

```
$D49T53
[1] "D53"
$D84T88
[1] "D84"
$D69T75
[1] "D72"
$D90T96
[1] "D94T96"
$D45T56
[1] "D49T53"
$D69T82
[1] "D69T75"
```

## Further Reading

### [Managing the Data Revolution](http://www.statcan.gc.ca/eng/about/speech/mdr)

> we need to learn how to exploit new opportunities to increase our efficiency, in order to meet emerging data needs

> we need to know when not to do something or to stop doing something that can be done equally well by others in order to concentrate on those things that only we can do. Leaving work to others creates default partnerships.
